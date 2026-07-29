# Helper Functions

sample_participants <- function(data,
                                n_participants = 12,
                                seed = 123) {
        
        set.seed(seed)
        
        sample(
                unique(data$id),
                min(n_participants, dplyr::n_distinct(data$id))
        )
}

plot_histogram <- function(data,
                           variable,
                           x_label,
                           bins = 30) {
        
        ggplot2::ggplot(
                data,
                ggplot2::aes(x = .data[[variable]])
        ) +
                ggplot2::geom_histogram(bins = bins) +
                ggplot2::labs(
                        x = x_label,
                        y = "Count"
                ) +
                ggplot2::theme_minimal()
}

plot_boxplot <- function(data,
                         variable,
                         y_label) {
        
        ggplot2::ggplot(
                data,
                ggplot2::aes(y = .data[[variable]])
        ) +
                ggplot2::geom_boxplot() +
                ggplot2::labs(
                        y = y_label
                ) +
                ggplot2::theme_minimal()
}

plot_learning_curve <- function(data,
                                variable,
                                y_label) {
        
        summary_data <-
                data |>
                dplyr::group_by(trial) |>
                dplyr::summarise(
                        value = mean(.data[[variable]], na.rm = TRUE),
                        .groups = "drop"
                )
        
        ggplot2::ggplot(
                summary_data,
                ggplot2::aes(
                        x = trial,
                        y = value
                )
        ) +
                ggplot2::geom_line() +
                ggplot2::geom_smooth(
                        method = "loess",
                        se = FALSE
                ) +
                ggplot2::labs(
                        x = "Trial",
                        y = y_label
                ) +
                ggplot2::theme_minimal()
}

plot_individual_trajectories <- function(data,
                                         variable,
                                         y_label,
                                         participants = NULL,
                                         n_participants = 12,
                                         seed = 123) {
        
        if (is.null(participants)) {
                participants <- sample_participants(
                        data,
                        n_participants = n_participants,
                        seed = seed
                )
        }
        
        ggplot2::ggplot(
                dplyr::filter(data, id %in% participants),
                ggplot2::aes(
                        x = trial,
                        y = .data[[variable]],
                        group = id,
                        colour = factor(id)
                )
        ) +
                ggplot2::geom_smooth(
                        method = "loess",
                        se = FALSE,
                        show.legend = FALSE
                ) +
                ggplot2::labs(
                        x = "Trial",
                        y = y_label
                ) +
                ggplot2::theme_minimal()
}

plot_participant_distribution <- function(data,
                                          variable,
                                          x_label) {
        
        data |>
                dplyr::group_by(id) |>
                dplyr::summarise(
                        value = mean(.data[[variable]], na.rm = TRUE),
                        .groups = "drop"
                ) |>
                ggplot2::ggplot(
                        ggplot2::aes(value)
                ) +
                ggplot2::geom_histogram(
                        bins = 30
                ) +
                ggplot2::labs(
                        x = x_label,
                        y = "Participants"
                ) +
                ggplot2::theme_minimal()
}

plot_scatter <- function(data,
                         x,
                         y,
                         x_label,
                         y_label,
                         smoother = "loess") {
        
        ggplot2::ggplot(
                data,
                ggplot2::aes(
                        x = .data[[x]],
                        y = .data[[y]]
                )
        ) +
                ggplot2::geom_point(
                        alpha = 0.05
                ) +
                ggplot2::geom_smooth(
                        method = smoother,
                        se = FALSE
                ) +
                ggplot2::labs(
                        x = x_label,
                        y = y_label
                ) +
                ggplot2::theme_minimal()
}

# Participant-Level Figures

plot_payoff_groups <- function(data) {
        
        ggplot2::ggplot(
                dplyr::distinct(data, id, payoff_group),
                ggplot2::aes(
                        x = factor(payoff_group)
                )
        ) +
                ggplot2::geom_bar() +
                ggplot2::labs(
                        x = "Payoff Group",
                        y = "Participants"
                ) +
                ggplot2::theme_minimal()
}

plot_trial_counts <- function(data) {
        
        data |>
                dplyr::count(id) |>
                ggplot2::ggplot(
                        ggplot2::aes(n)
                ) +
                ggplot2::geom_histogram(
                        bins = 20
                ) +
                ggplot2::labs(
                        x = "Trials per Participant",
                        y = "Participants"
                ) +
                ggplot2::theme_minimal()
}

# Behavioural Variable Distributions

plot_reward_distribution <- function(data) {
        
        plot_histogram(
                data,
                variable = "reward",
                x_label = "Reward"
        )
}

plot_rt_distribution <- function(data) {
        
        plot_histogram(
                data,
                variable = "rt",
                x_label = "Reaction Time (ms)"
        )
}

plot_choice_distribution <- function(data) {
        
        ggplot2::ggplot(
                data,
                ggplot2::aes(
                        x = factor(choice)
                )
        ) +
                ggplot2::geom_bar() +
                ggplot2::labs(
                        x = "Choice",
                        y = "Count"
                ) +
                ggplot2::theme_minimal()
}

# Boxplots

plot_reward_boxplot <- function(data) {
        
        plot_boxplot(
                data,
                variable = "reward",
                y_label = "Reward"
        )
}

plot_rt_boxplot <- function(data) {
        
        plot_boxplot(
                data,
                variable = "rt",
                y_label = "Reaction Time (ms)"
        )
}

# Learning Curves

plot_reward_learning_curve <- function(data) {
        
        plot_learning_curve(
                data,
                variable = "reward",
                y_label = "Mean Reward"
        )
}

plot_rt_learning_curve <- function(data) {
        
        plot_learning_curve(
                data,
                variable = "rt",
                y_label = "Mean Reaction Time (ms)"
        )
}

plot_learning_curve_by_group <- function(data,
                                         variable,
                                         group,
                                         y_label,
                                         summary_fun = mean) {
        
        summary_data <-
                data |>
                dplyr::group_by(
                        .data[[group]],
                        trial
                ) |>
                dplyr::summarise(
                        value = summary_fun(.data[[variable]], na.rm = TRUE),
                        .groups = "drop"
                )
        
        ggplot2::ggplot(
                summary_data,
                ggplot2::aes(
                        x = trial,
                        y = value,
                        colour = factor(.data[[group]])
                )
        ) +
                ggplot2::geom_line() +
                ggplot2::geom_smooth(
                        method = "loess",
                        se = FALSE
                ) +
                ggplot2::labs(
                        x = "Trial",
                        y = y_label,
                        colour = group
                ) +
                ggplot2::theme_minimal()
}

plot_reward_by_payoff_group <- function(data) {
        
        plot_learning_curve_by_group(
                data = data,
                variable = "reward",
                group = "payoff_group",
                y_label = "Mean Reward"
        )
}

# Individual Trajectories

plot_individual_reward_trajectories <- function(
                data,
                participants = NULL,
                n_participants = 12,
                seed = 123
) {
        
        plot_individual_trajectories(
                data = data,
                variable = "reward",
                y_label = "Reward",
                participants = participants,
                n_participants = n_participants,
                seed = seed
        )
}

plot_individual_rt_trajectories <- function(
                data,
                participants = NULL,
                n_participants = 12,
                seed = 123
) {
        
        plot_individual_trajectories(
                data = data,
                variable = "rt",
                y_label = "Reaction Time (ms)",
                participants = participants,
                n_participants = n_participants,
                seed = seed
        )
}

# Participant-Level Distributions

plot_participant_mean_reward <- function(data) {
        
        plot_participant_distribution(
                data = data,
                variable = "reward",
                x_label = "Participant Mean Reward"
        )
}

plot_participant_mean_rt <- function(data) {
        
        plot_participant_distribution(
                data = data,
                variable = "rt",
                x_label = "Participant Mean Reaction Time (ms)"
        )
}

# Relationships

plot_reward_vs_trial <- function(data) {
        
        plot_scatter(
                data,
                x = "trial",
                y = "reward",
                x_label = "Trial",
                y_label = "Reward"
        )
}

plot_rt_vs_trial <- function(data) {
        
        plot_scatter(
                data,
                x = "trial",
                y = "rt",
                x_label = "Trial",
                y_label = "Reaction Time (ms)"
        )
}

plot_reward_vs_rt <- function(data) {
        
        plot_scatter(
                data,
                x = "reward",
                y = "rt",
                x_label = "Reward",
                y_label = "Reaction Time (ms)"
        )
}

plot_correlation_matrix <- function(data, variables) {
        
        cor_matrix <-
                data |>
                dplyr::select(dplyr::all_of(variables)) |>
                stats::cor(use = "pairwise.complete.obs")
        
        cor_df <- as.data.frame(
                as.table(cor_matrix)
        )
        
        ggplot2::ggplot(
                cor_df,
                ggplot2::aes(
                        x = Var1,
                        y = Var2,
                        fill = Freq
                )
        ) +
                ggplot2::geom_tile() +
                ggplot2::scale_fill_gradient2(
                        limits = c(-1, 1),
                        midpoint = 0
                ) +
                ggplot2::labs(
                        x = NULL,
                        y = NULL,
                        fill = "Correlation"
                ) +
                ggplot2::theme_minimal()
}

# Missing Data

plot_missing_values <- function(data) {
        
        missing <-
                tibble::tibble(
                        variable = names(data),
                        missing = colSums(is.na(data))
                )
        
        ggplot2::ggplot(
                missing,
                ggplot2::aes(
                        x = reorder(variable, missing),
                        y = missing
                )
        ) +
                ggplot2::geom_col() +
                ggplot2::coord_flip() +
                ggplot2::labs(
                        x = NULL,
                        y = "Missing Values"
                ) +
                ggplot2::theme_minimal()
}

# Outlier Visualisation

plot_rt_outliers <- function(data) {
        
        ggplot2::ggplot(
                data,
                ggplot2::aes(
                        y = rt
                )
        ) +
                ggplot2::geom_boxplot() +
                ggplot2::labs(
                        y = "Reaction Time (ms)"
                ) +
                ggplot2::theme_minimal()
}