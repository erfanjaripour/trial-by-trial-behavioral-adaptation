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