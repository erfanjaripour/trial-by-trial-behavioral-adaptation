# Data Loading

load_raw_data <- function(
                path = here::here("data", "raw", "DataAllSubjectsRewards.csv")
) {
        
        stopifnot(file.exists(path))
        
        readr::read_csv(
                path,
                show_col_types = FALSE
        )
}

load_processed_data <- function(
                path = here::here("data", "processed", "processed_data.csv")
) {
        
        stopifnot(file.exists(path))
        
        readr::read_csv(
                path,
                show_col_types = FALSE
        )
}

save_processed_data <- function(
                data,
                path = here::here("data", "processed", "processed_data.csv")
) {
        
        readr::write_csv(data, path)
        
        invisible(data)
}

# Preprocessing

clean_invalid_rt <- function(data) {
        
        data |>
                dplyr::mutate(
                        rt = dplyr::if_else(
                                rt <= 0,
                                NA_real_,
                                rt
                        )
                )
}

remove_nonresponse_trials <- function(data) {
        
        data |>
                dplyr::filter(
                        !is.na(choice),
                        !is.na(reward),
                )
}

nonresponse_trial_summary <- function(data) {
        
        tibble::tibble(
                total_trials = nrow(data),
                removed_trials = sum(
                        is.na(data$choice) |
                                is.na(data$reward)
                ),
                retained_trials = sum(
                        !is.na(data$choice) &
                                !is.na(data$reward)
                )
        )
}

create_trial_index <- function(data) {
        
        data |>
                dplyr::group_by(id) |>
                dplyr::mutate(
                        trial = dplyr::row_number()
                ) |>
                dplyr::ungroup()
}

create_optimal_choice <- function(data) {
        
        data |>
                dplyr::rowwise() |>
                dplyr::mutate(
                        
                        max_reward = max(
                                dplyr::c_across(reward_c1:reward_c4),
                                na.rm = TRUE
                        ),
                        
                        optimal_choice = dplyr::case_when(
                                choice == 1 ~ reward_c1 == max_reward,
                                choice == 2 ~ reward_c2 == max_reward,
                                choice == 3 ~ reward_c3 == max_reward,
                                choice == 4 ~ reward_c4 == max_reward
                        )
                ) |>
                dplyr::ungroup() |>
                dplyr::select(-max_reward)
}

create_choice_switch <- function(data) {
        
        data |>
                dplyr::group_by(id) |>
                dplyr::mutate(
                        choice_switch =
                                dplyr::if_else(
                                        dplyr::row_number() == 1,
                                        NA,
                                        choice != dplyr::lag(choice)
                                )
                ) |>
                dplyr::ungroup()
}

preprocess_data <- function(data = load_raw_data()) {
        
        data |>
                clean_invalid_rt() |>
                remove_nonresponse_trials() |>
                create_trial_index() |>
                create_optimal_choice() |>
                create_choice_switch()
                
}

inspect_invalid_values <- function(data) {
        
        tibble::tibble(
                negative_rt = sum(data$rt < 0, na.rm = TRUE),
                zero_rt = sum(data$rt == 0, na.rm = TRUE),
                missing_choice = sum(is.na(data$choice)),
                missing_reward = sum(is.na(data$reward)),
                missing_rt = sum(is.na(data$rt))
        )
}

# Dataset Overview

get_dimensions <- function(data) {
        dim(data)
}

get_structure <- function(data) {
        dplyr::glimpse(data)
}

get_variable_names <- function(data) {
        names(data)
}

get_head <- function(data, n = 6) {
        head(data, n)
}

get_tail <- function(data, n = 6) {
        tail(data, n)
}

get_summary <- function(data) {
        summary(data)
}

# Missing Data

missing_by_variable <- function(data) {
        colSums(is.na(data))
}

total_missing <- function(data) {
        sum(is.na(data))
}

# Participants

participant_count <- function(data) {
        
        dplyr::summarise(
                data,
                participants = dplyr::n_distinct(id)
        )
}

participant_trial_summary <- function(data) {
        
        data |>
                dplyr::count(id, name = "n_trials") |>
                dplyr::summarise(
                        min_trials = min(n_trials),
                        max_trials = max(n_trials),
                        mean_trials = mean(n_trials),
                        sd_trials = stats::sd(n_trials)
                )
}

participant_trial_distribution <- function(data) {
        
        data |>
                dplyr::count(id, name = "n_trials") |>
                dplyr::count(n_trials)
}

# Variables

variable_types <- function(data) {
        purrr::map(data, class)
}

unique_value_counts <- function(data) {
        purrr::map_int(data, dplyr::n_distinct)
}

payoff_groups <- function(data) {
        table(data$payoff_group)
}

choice_values <- function(data) {
        sort(unique(stats::na.omit(data$choice)))
}

# Descriptive Statistics

behavioural_summary <- function(data) {
        
        dplyr::summarise(
                data,
                mean_rt = mean(rt, na.rm = TRUE),
                sd_rt = stats::sd(rt, na.rm = TRUE),
                mean_reward = mean(reward, na.rm = TRUE),
                sd_reward = stats::sd(reward, na.rm = TRUE)
        )
}

# Data Integrity

duplicate_rows <- function(data) {
        sum(duplicated(data))
}

missing_participant_ids <- function(data) {
        sum(is.na(data$id))
}

reward_range <- function(data) {
        range(data$reward, na.rm = TRUE)
}

reaction_time_range <- function(data) {
        range(data$rt, na.rm = TRUE)
}

# Inspection Summary

inspection_summary <- function(data) {
        
        participant_stats <- participant_trial_summary(data)
        reward_rng <- reward_range(data)
        rt_rng <- reaction_time_range(data)
        
        tibble::tibble(
                observations = nrow(data),
                variables = ncol(data),
                participants = dplyr::n_distinct(data$id),
                min_trials = participant_stats$min_trials,
                max_trials = participant_stats$max_trials,
                mean_trials = participant_stats$mean_trials,
                sd_trials = participant_stats$sd_trials,
                total_missing = total_missing(data),
                duplicate_rows = duplicate_rows(data),
                missing_participant_ids = missing_participant_ids(data),
                reward_min = reward_rng[1],
                reward_max = reward_rng[2],
                rt_min = rt_rng[1],
                rt_max = rt_rng[2]
        )
}

# Processed Dataset Verification

verify_dataset <- function(data) {
        
        required_variables <- c(
                "id",
                "trial",
                "choice",
                "reward",
                "rt",
                "payoff_group",
                "optimal_choice",
                "choice_switch"
        )
        
        tibble::tibble(
                observations = nrow(data),
                variables = ncol(data),
                participants = dplyr::n_distinct(data$id),
                duplicate_rows = duplicate_rows(data),
                missing_participant_ids = missing_participant_ids(data),
                
                required_variables_present =
                        all(required_variables %in% names(data)),
                
                valid_choice =
                        all(stats::na.omit(data$choice) %in% 1:4),
                
                valid_payoff_group =
                        all(data$payoff_group %in% c(2, 3, 4)),
                
                valid_optimal_choice =
                        all(stats::na.omit(data$optimal_choice) %in% c(TRUE, FALSE)),
                
                valid_choice_switch =
                        all(stats::na.omit(data$choice_switch) %in% c(TRUE, FALSE)),
                
                first_trial_switch_missing =
                        data |>
                        dplyr::group_by(id) |>
                        dplyr::summarise(
                                valid = is.na(choice_switch[trial == 1]),
                                .groups = "drop"
                        ) |>
                        dplyr::pull(valid) |>
                        all(),
                
                trial_range =
                        paste(range(data$trial), collapse = "–"),
                
                consecutive_trials =
                        data |>
                        dplyr::group_by(id) |>
                        dplyr::summarise(
                                valid = all(trial == seq_len(dplyr::n())),
                                .groups = "drop"
                        ) |>
                        dplyr::pull(valid) |>
                        all()
        )
}
# Participant Summary

participant_summary <- function(data) {
        
        data |>
                dplyr::group_by(id) |>
                dplyr::summarise(
                        n_trials = dplyr::n(),
                        mean_reward = mean(reward, na.rm = TRUE),
                        mean_rt = mean(rt, na.rm = TRUE),
                        .groups = "drop"
                )
}

payoff_group_summary <- function(data) {
        
        data |>
                dplyr::count(payoff_group)
}

# Behavioural Variables

variable_summary <- function(data, variable) {
        
        x <- dplyr::pull(data, {{ variable }})
        
        tibble::tibble(
                min = min(x, na.rm = TRUE),
                q1 = stats::quantile(x, 0.25, na.rm = TRUE),
                median = stats::median(x, na.rm = TRUE),
                mean = mean(x, na.rm = TRUE),
                q3 = stats::quantile(x, 0.75, na.rm = TRUE),
                max = max(x, na.rm = TRUE),
                sd = stats::sd(x, na.rm = TRUE)
        )
}

# Missing Data

missing_by_participant <- function(data) {
        
        data |>
                dplyr::group_by(id) |>
                dplyr::summarise(
                        missing_values =
                                sum(is.na(as.matrix(dplyr::pick(dplyr::everything())))),
                        .groups = "drop"
                )
}

missing_by_variable_percent <- function(data) {
        
        tibble::tibble(
                variable = names(data),
                missing = colSums(is.na(data)),
                percent = 100 * colSums(is.na(data)) / nrow(data)
        )
}

# Outliers

reaction_time_outliers <- function(data) {
        
        q1 <- stats::quantile(data$rt, 0.25, na.rm = TRUE)
        q3 <- stats::quantile(data$rt, 0.75, na.rm = TRUE)
        
        iqr <- q3 - q1
        
        data |>
                dplyr::filter(
                        rt < (q1 - 1.5 * iqr) |
                                rt > (q3 + 1.5 * iqr)
                )
}

reward_outliers <- function(data) {
        
        q1 <- stats::quantile(data$reward, 0.25, na.rm = TRUE)
        q3 <- stats::quantile(data$reward, 0.75, na.rm = TRUE)
        
        iqr <- q3 - q1
        
        data |>
                dplyr::filter(
                        reward < (q1 - 1.5 * iqr) |
                                reward > (q3 + 1.5 * iqr)
                )
}

# Correlations

continuous_correlations <- function(data) {
        
        data |>
                dplyr::select(
                        reward,
                        rt,
                        dplyr::starts_with("reward_c")
                ) |>
                stats::cor(
                        use = "pairwise.complete.obs"
                )
}

# Model Readiness

model_readiness <- function(data) {
        
        tibble::tibble(
                observations = nrow(data),
                participants = dplyr::n_distinct(data$id),
                missing = total_missing(data),
                duplicate_rows = duplicate_rows(data),
                min_trials = min(dplyr::count(data, id)$n),
                max_trials = max(dplyr::count(data, id)$n)
        )
}