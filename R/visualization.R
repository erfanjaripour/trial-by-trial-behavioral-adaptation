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

plot_log_rt_distribution <- function(data) {
        
        plot_histogram(
                data = data,
                variable = "log_rt",
                x_label = "Log Reaction Time"
        )
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

plot_switch_distribution <- function(data) {
        
        data |>
                dplyr::filter(
                        !is.na(choice_switch)
                ) |>
                dplyr::mutate(
                        choice_switch = factor(
                                choice_switch,
                                levels = c(0, 1),
                                labels = c(
                                        "No switch",
                                        "Switch"
                                )
                        )
                ) |>
                dplyr::count(
                        choice_switch
                ) |>
                ggplot2::ggplot(
                        ggplot2::aes(
                                x = choice_switch,
                                y = n
                        )
                ) +
                ggplot2::geom_col() +
                ggplot2::labs(
                        x = "Choice switching",
                        y = "Number of trials"
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
                                         y_label) {
        
        summary_data <-
                data |>
                dplyr::group_by(
                        .data[[group]],
                        trial
                ) |>
                dplyr::summarise(
                        n = dplyr::n(),
                        mean = mean(.data[[variable]], na.rm = TRUE),
                        sd = stats::sd(.data[[variable]], na.rm = TRUE),
                        se = sd / sqrt(n),
                        ci = stats::qt(0.975, df = n - 1) * se,
                        .groups = "drop"
                )
        
        ggplot2::ggplot(
                summary_data,
                ggplot2::aes(
                        x = trial,
                        y = mean,
                        colour = factor(.data[[group]]),
                        fill = factor(.data[[group]])
                )
        ) +
                ggplot2::geom_ribbon(
                        ggplot2::aes(
                                ymin = mean - ci,
                                ymax = mean + ci
                        ),
                        alpha = 0.20,
                        colour = NA
                ) +
                ggplot2::geom_line(
                        linewidth = 0.8
                ) +
                ggplot2::labs(
                        x = "Trial",
                        y = y_label,
                        colour = "Payoff Group",
                        fill = "Payoff Group"
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

# Model Fixed Effects

plot_fixed_effects <- function(model) {
        
        broom.mixed::tidy(
                model,
                effects = "fixed",
                conf.int = TRUE
        ) |>
                ggplot2::ggplot(
                        ggplot2::aes(
                                x = term,
                                y = estimate,
                                ymin = conf.low,
                                ymax = conf.high
                        )
                ) +
                ggplot2::geom_pointrange() +
                ggplot2::coord_flip() +
                ggplot2::labs(
                        x = NULL,
                        y = "Fixed Effect Estimate"
                ) +
                ggplot2::theme_minimal()
}

plot_odds_ratios <- function(model) {
        
        broom.mixed::tidy(
                model,
                effects = "fixed",
                conf.int = TRUE,
                exponentiate = TRUE
        ) |>
                ggplot2::ggplot(
                        ggplot2::aes(
                                x = term,
                                y = estimate,
                                ymin = conf.low,
                                ymax = conf.high
                        )
                ) +
                ggplot2::geom_hline(
                        yintercept = 1
                ) +
                ggplot2::geom_pointrange() +
                ggplot2::coord_flip() +
                ggplot2::labs(
                        x = NULL,
                        y = "Odds Ratio"
                ) +
                ggplot2::theme_minimal()
}

# Marginal Predictions using emmeans

plot_predictions_by_group <- function(model,
                                      trial_values = seq(-75, 75, by = 5),
                                      y_label = "Predicted probability") {
        
        predictions <-
                emmeans::emmeans(
                        model,
                        ~ payoff_group * trial_c,
                        at = list(
                                trial_c = trial_values
                        ),
                        type = "response"
                ) |>
                as.data.frame()
        
        predictions <- predictions |>
                dplyr::rename(
                        predicted = prob,
                        conf.low = asymp.LCL,
                        conf.high = asymp.UCL
                )
        
        ggplot2::ggplot(
                predictions,
                ggplot2::aes(
                        x = trial_c,
                        y = predicted,
                        colour = payoff_group,
                        fill = payoff_group,
                        group = payoff_group
                )
        ) +
                ggplot2::geom_ribbon(
                        ggplot2::aes(
                                ymin = conf.low,
                                ymax = conf.high
                        ),
                        alpha = 0.20,
                        colour = NA
                ) +
                ggplot2::geom_line(
                        linewidth = 1
                ) +
                ggplot2::labs(
                        x = "Centered trial",
                        y = y_label,
                        colour = "Payoff Group",
                        fill = "Payoff Group"
                ) +
                ggplot2::theme_minimal()
}

# Predictions by Group using emmeans

plot_predictions_by_group <- function(model,
                                      trial_values = seq(-75, 75, by = 5),
                                      y_label = "Predicted value") {
        
        predictions <-
                emmeans::emmeans(
                        model,
                        ~ payoff_group * trial_c,
                        at = list(
                                trial_c = trial_values
                        )
                ) |>
                as.data.frame()
        
        # Rename confidence intervals consistently
        if ("asymp.LCL" %in% names(predictions)) {
                
                predictions <- predictions |>
                        dplyr::rename(
                                conf.low = asymp.LCL,
                                conf.high = asymp.UCL
                        )
                
        } else {
                
                predictions <- predictions |>
                        dplyr::rename(
                                conf.low = lower.CL,
                                conf.high = upper.CL
                        )
        }
        
        # Rename outcome column
        if ("prob" %in% names(predictions)) {
                
                predictions <- predictions |>
                        dplyr::rename(
                                predicted = prob
                        )
                
        }
        
        if ("emmean" %in% names(predictions)) {
                
                predictions <- predictions |>
                        dplyr::rename(
                                predicted = emmean
                        )
        }
        
        
        ggplot2::ggplot(
                predictions,
                ggplot2::aes(
                        x = trial_c,
                        y = predicted,
                        group = payoff_group,
                        colour = payoff_group,
                        fill = payoff_group
                )
        ) +
                ggplot2::geom_ribbon(
                        ggplot2::aes(
                                ymin = conf.low,
                                ymax = conf.high
                        ),
                        alpha = 0.20,
                        colour = NA
                ) +
                ggplot2::geom_line(
                        linewidth = 1
                ) +
                ggplot2::scale_x_continuous(
                        breaks = seq(-80, 80, by = 20)
                ) +
                ggplot2::labs(
                        x = "Centered trial",
                        y = y_label,
                        colour = "Payoff Group",
                        fill = "Payoff Group"
                ) +
                ggplot2::theme_minimal()
}

# Random Effects

plot_random_intercepts <- function(model) {
        
        random_effects <-
                lme4::ranef(
                        model
                )$id |>
                tibble::rownames_to_column(
                        "participant"
                )
        
        ggplot2::ggplot(
                random_effects,
                ggplot2::aes(
                        x = `(Intercept)`
                )
        ) +
                ggplot2::geom_histogram(
                        bins = 30
                ) +
                ggplot2::labs(
                        x = "Participant Random Intercept",
                        y = "Count"
                ) +
                ggplot2::theme_minimal()
}

plot_random_slopes <- function(model) {
        
        random_effects <-
                lme4::ranef(model)$id |>
                tibble::rownames_to_column("participant")
        
        if (!"trial_c" %in% names(random_effects)) {
                stop("Model does not contain a trial_c random slope.")
        }
        
        ggplot2::ggplot(
                random_effects,
                ggplot2::aes(
                        x = trial_c
                )
        ) +
                ggplot2::geom_histogram(
                        bins = 30
                ) +
                ggplot2::labs(
                        x = "Participant Trial Slope",
                        y = "Count"
                ) +
                ggplot2::theme_minimal()
}

# Linear Mixed Model Residual Visualization

plot_lmm_residuals <- function(model) {
        
        residual_data <- tibble::tibble(
                fitted = fitted(model),
                residuals = residuals(model)
        )
        
        ggplot2::ggplot(
                residual_data,
                ggplot2::aes(
                        x = fitted,
                        y = residuals
                )
        ) +
                ggplot2::geom_point(
                        alpha = 0.3
                ) +
                ggplot2::geom_hline(
                        yintercept = 0
                ) +
                ggplot2::labs(
                        x = "Fitted Values",
                        y = "Residuals"
                ) +
                ggplot2::theme_minimal()
}

plot_lmm_qq <- function(model) {
        
        qq_data <- tibble::tibble(
                theoretical = stats::qqnorm(
                        residuals(model),
                        plot.it = FALSE
                )$x,
                sample = stats::qqnorm(
                        residuals(model),
                        plot.it = FALSE
                )$y
        )
        
        ggplot2::ggplot(
                qq_data,
                ggplot2::aes(
                        x = theoretical,
                        y = sample
                )
        ) +
                ggplot2::geom_point() +
                ggplot2::geom_abline(
                        intercept = 0,
                        slope = 1
                ) +
                ggplot2::labs(
                        x = "Theoretical Quantiles",
                        y = "Sample Quantiles"
                ) +
                ggplot2::theme_minimal()
}

# Logistic Mixed Model Diagnostics Visualization

plot_glmm_diagnostics <- function(model) {
        
        simulation <-
                DHARMa::simulateResiduals(
                        fittedModel = model
                )
        
        plot(simulation)
}

# Model Comparison

add_delta_aic <- function(comparison_table) {
        
        comparison_table |>
                dplyr::mutate(
                        delta_AIC = AIC - min(AIC)
                )
}

plot_model_comparison <- function(comparison_table) {
        
        comparison_table |>
                ggplot2::ggplot(
                        ggplot2::aes(
                                x = reorder(model, delta_AIC),
                                y = delta_AIC
                        )
                ) +
                ggplot2::geom_col() +
                ggplot2::coord_flip() +
                ggplot2::labs(
                        x = NULL,
                        y = expression(Delta * " AIC")
                ) +
                ggplot2::theme_minimal()
}

# Model Performance Summary

plot_model_performance <- function(model) {
        
        performance::check_model(model)
}

# Descriptive Results

descriptive_statistics_table <- function(data) {
        
        tibble::tibble(
                
                participants =
                        dplyr::n_distinct(data$id),
                
                trials =
                        nrow(data),
                
                missing_reward =
                        sum(is.na(data$reward)),
                
                missing_log_rt =
                        sum(is.na(data$log_rt)),
                
                missing_payoff_maximizing_choice =
                        sum(is.na(data$payoff_maximizing_choice)),
                
                missing_choice_switch =
                        sum(is.na(data$choice_switch)),
                
                mean_reward =
                        mean(data$reward, na.rm = TRUE),
                
                sd_reward =
                        stats::sd(data$reward, na.rm = TRUE),
                
                mean_log_rt =
                        mean(data$log_rt, na.rm = TRUE),
                
                sd_log_rt =
                        stats::sd(data$log_rt, na.rm = TRUE),
                
                payoff_maximizing_choice_rate =
                        mean(data$payoff_maximizing_choice, na.rm = TRUE),
                
                choice_switch_rate =
                        mean(data$choice_switch, na.rm = TRUE)
        )
}