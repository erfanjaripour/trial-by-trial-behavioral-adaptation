# Helper Functions

center_trial <- function(data) {
        
        data |>
                dplyr::mutate(
                        trial_c = (
                                trial - mean(trial, na.rm = TRUE)
                        ) / sd(trial, na.rm = TRUE)
                )
}

add_trial_quadratic <- function(data) {
        
        data |>
                center_trial() |>
                dplyr::mutate(
                        trial_c2 = trial_c^2
                )
}

# Model Formulas

payoff_maximizing_null_formula <-
        payoff_maximizing_choice ~ 1 +
        (1 | id)

payoff_maximizing_fixed_formula <-
        payoff_maximizing_choice ~ trial_c + payoff_group +
        (1 | id)

payoff_maximizing_random_slope_uncorrelated_formula <-
        payoff_maximizing_choice ~ trial_c + payoff_group +
        (1 + trial_c || id)

payoff_maximizing_random_slope_correlated_formula <-
        payoff_maximizing_choice ~ trial_c + payoff_group +
        (1 + trial_c | id)

payoff_maximizing_interaction_formula <-
        payoff_maximizing_choice ~ trial_c * payoff_group +
        (1 + trial_c || id)

payoff_maximizing_quadratic_uncorrelated_formula <-
        payoff_maximizing_choice ~ (trial_c + trial_c2) * payoff_group +
        (1 + trial_c + trial_c2 || id)

payoff_maximizing_quadratic_correlated_formula <- 
        payoff_maximizing_choice ~ (trial_c + trial_c2) * payoff_group +
        (1 + trial_c + trial_c2 | id)

reward_null_formula <-
        reward ~ 1 +
        (1 | id)

reward_fixed_formula <-
        reward ~ trial_c + payoff_group +
        (1 | id)

reward_random_slope_formula <-
        reward ~ trial_c + payoff_group +
        (1 + trial_c || id)

reward_interaction_formula <-
        reward ~ trial_c * payoff_group +
        (1 + trial_c || id)


log_rt_null_formula <-
        log_rt ~ 1 +
        (1 | id)

log_rt_fixed_formula <-
        log_rt ~ trial_c + payoff_group +
        (1 | id)

log_rt_random_slope_formula <-
        log_rt ~ trial_c + payoff_group +
        (1 + trial_c || id)

log_rt_interaction_formula <-
        log_rt ~ trial_c * payoff_group +
        (1 + trial_c || id)


choice_switch_null_formula <-
        choice_switch ~ 1 +
        (1 | id)

choice_switch_fixed_formula <-
        choice_switch ~ trial_c + payoff_group +
        (1 | id)

choice_switch_random_slope_formula <-
        choice_switch ~ trial_c + payoff_group +
        (1 + trial_c || id)

choice_switch_interaction_formula <-
        choice_switch ~ trial_c * payoff_group +
        (1 + trial_c || id)

# Primary Outcome: Payoff Maximizing Choice

fit_payoff_maximizing_choice_null <- function(data) {
        
        lme4::glmer(
                formula = payoff_maximizing_null_formula,
                data = center_trial(data),
                family = binomial(link = "logit")
        )
}

fit_payoff_maximizing_choice_fixed <- function(data) {
        
        lme4::glmer(
                formula = payoff_maximizing_fixed_formula,
                data = center_trial(data),
                family = binomial(link = "logit")
        )
}

fit_payoff_maximizing_choice_random_slope_uncorrelated <- function(data){
        
        lme4::glmer(
                formula = payoff_maximizing_random_slope_uncorrelated_formula,
                data = center_trial(data),
                family = binomial(link = "logit")
        )
        
}

fit_payoff_maximizing_choice_random_slope_correlated <- function(data){
        
        lme4::glmer(
                formula = payoff_maximizing_random_slope_correlated_formula,
                data = center_trial(data),
                family = binomial(link = "logit")
        )
        
}

fit_payoff_maximizing_choice_interaction <- function(data) {
        
        lme4::glmer(
                formula = payoff_maximizing_interaction_formula,
                data = center_trial(data),
                family = binomial(link = "logit")
        )
}

# Secondary Outcome: Reward

fit_reward_null <- function(data) {
        
        lmerTest::lmer(
                formula = reward_null_formula,
                data = center_trial(data),
                REML = FALSE
        )
}

fit_reward_fixed <- function(data) {
        
        lmerTest::lmer(
                formula = reward_fixed_formula,
                data = center_trial(data),
                REML = FALSE
        )
}

fit_reward_random_slope <- function(data) {
        
        lmerTest::lmer(
                formula = reward_random_slope_formula,
                data = center_trial(data),
                REML = FALSE
        )
}

fit_reward_interaction <- function(data) {
        
        lmerTest::lmer(
                formula = reward_interaction_formula,
                data = center_trial(data),
                REML = FALSE
        )
}

# Secondary Outcome: Reaction Time

fit_log_rt_null <- function(data) {
        
        lmerTest::lmer(
                formula = log_rt_null_formula,
                data = center_trial(data),
                REML = FALSE
        )
}

fit_log_rt_fixed <- function(data) {
        
        lmerTest::lmer(
                formula = log_rt_fixed_formula,
                data = center_trial(data),
                REML = FALSE
        )
}

fit_log_rt_random_slope <- function(data) {
        
        lmerTest::lmer(
                formula = log_rt_random_slope_formula,
                data = center_trial(data),
                REML = FALSE
        )
}

fit_log_rt_interaction <- function(data) {
        
        lmerTest::lmer(
                formula = log_rt_interaction_formula,
                data = center_trial(data),
                REML = FALSE
        )
}

# Secondary Outcome: Choice Switch

fit_choice_switch_null <- function(data) {
        
        lme4::glmer(
                formula = choice_switch_null_formula,
                data = center_trial(data),
                family = binomial(link = "logit")
        )
}

fit_choice_switch_fixed <- function(data) {
        
        lme4::glmer(
                formula = choice_switch_fixed_formula,
                data = center_trial(data),
                family = binomial(link = "logit")
        )
}

fit_choice_switch_random_slope <- function(data) {
        
        lme4::glmer(
                formula = choice_switch_random_slope_formula,
                data = center_trial(data),
                family = binomial(link = "logit")
        )
}

fit_choice_switch_interaction <- function(data) {
        
        lme4::glmer(
                formula = choice_switch_interaction_formula,
                data = center_trial(data),
                family = binomial(link = "logit")
        )
}

# Model Comparison

compare_models <- function(...) {
        
        models <- list(...)
        
        purrr::map_dfr(
                models,
                function(model) {
                        
                        tibble::tibble(
                                AIC = AIC(model),
                                BIC = BIC(model),
                                logLik = as.numeric(logLik(model)),
                                df_aic = attr(logLik(model), "df")
                        )
                },
                .id = "model"
        )
}

compare_nested_models <- function(model1, model2, ...) {
        
        stats::anova(
                model1,
                model2,
                test = "Chisq"
        ) |>
                tibble::as_tibble()
}

# Robustness Analyses

fit_payoff_maximizing_interaction_quadratic_data <- function(data) {
        
        lme4::glmer(
                formula = payoff_maximizing_interaction_formula,
                data = add_trial_quadratic(data),
                family = binomial(link = "logit")
        )
}

fit_payoff_maximizing_choice_quadratic_uncorrelated <- function(data) {
        
        lme4::glmer(
                formula = payoff_maximizing_quadratic_uncorrelated_formula,
                data = add_trial_quadratic(data),
                family = binomial(link = "logit")
        )
}

fit_payoff_maximizing_choice_quadratic_correlated <- function(data) {
        
        lme4::glmer(
                formula = payoff_maximizing_quadratic_correlated_formula,
                data = add_trial_quadratic(data),
                family = binomial(link = "logit")
        )
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

choice_switch_missingness_summary <- function(data) {
        
        switch_audit <-
                data |>
                dplyr::group_by(id) |>
                dplyr::arrange(trial, .by_group = TRUE) |>
                dplyr::mutate(
                        previous_trial_present =
                                dplyr::coalesce(
                                        dplyr::lag(trial) == trial - 1,
                                        FALSE
                                ),
                        
                        switch_structurally_missing =
                                is.na(choice_switch) &
                                !previous_trial_present,
                        
                        switch_additionally_missing =
                                is.na(choice_switch) &
                                previous_trial_present
                ) |>
                dplyr::summarise(
                        n_trials = dplyr::n(),
                        
                        has_trial_1 =
                                any(trial == 1, na.rm = TRUE),
                        
                        n_structural_missing_switch =
                                sum(
                                        switch_structurally_missing,
                                        na.rm = TRUE
                                ),
                        
                        n_additional_missing_switch =
                                sum(
                                        switch_additionally_missing,
                                        na.rm = TRUE
                                ),
                        
                        .groups = "drop"
                )
        
        switch_audit
}


audit_choice_switch_missingness <- function(data) {
        
        summary <-
                choice_switch_missingness_summary(data)
        
        tibble::tibble(
                participants = nrow(summary),
                
                participants_with_trial_1 =
                        sum(summary$has_trial_1),
                
                participants_without_trial_1 =
                        sum(!summary$has_trial_1),
                
                participants_with_structural_missing =
                        sum(
                                summary$n_structural_missing_switch > 0
                        ),
                
                participants_with_additional_missing =
                        sum(
                                summary$n_additional_missing_switch > 0
                        ),
                
                total_structural_missing =
                        sum(
                                summary$n_structural_missing_switch
                        ),
                
                total_additional_missing =
                        sum(
                                summary$n_additional_missing_switch
                        )
        )
}

# Model Reporting

model_r2 <- function(model) {
        
        performance::r2_nakagawa(model)
}

model_fixed_effects <- function(model) {
        
        broom.mixed::tidy(
                model,
                effects = "fixed",
                conf.int = TRUE,
                conf.method = "Wald"
        ) |>
                dplyr::select(
                        term,
                        estimate,
                        std.error,
                        statistic,
                        p.value,
                        conf.low,
                        conf.high
                )
}

model_confidence_intervals <- function(model) {
        
        broom.mixed::tidy(
                model,
                effects = "fixed",
                conf.int = TRUE,
                conf.method = "Wald"
        ) |>
                dplyr::select(
                        term,
                        conf.low,
                        conf.high
                )
}

model_odds_ratios <- function(model) {
        
        broom.mixed::tidy(
                model,
                effects = "fixed",
                conf.int = TRUE,
                exponentiate = TRUE,
                conf.method = "Wald"
        ) |>
                dplyr::select(
                        term,
                        estimate,
                        conf.low,
                        conf.high,
                        p.value
                )
}

extract_random_effects <- function(model, model_name) {
        
        lme4::VarCorr(model) |>
                as.data.frame() |>
                dplyr::mutate(
                        model = model_name
                ) |>
                dplyr::select(
                        model,
                        grp,
                        var1,
                        var2,
                        vcov,
                        sdcor
                )
}

model_convergence <- function(model) {
        
        opt_ok <-
                is.null(model@optinfo$conv$opt) ||
                isTRUE(model@optinfo$conv$opt == 0)
        
        lme4_ok <-
                is.null(model@optinfo$conv$lme4)
        
        opt_ok && lme4_ok
}

model_singularity <- function(model) {
        
        lme4::isSingular(model, tol = 1e-4)
}

model_summary <- function(model) {
        
        tibble::tibble(
                observations = stats::nobs(model),
                participants = nrow(lme4::ranef(model)$id),
                convergence = model_convergence(model),
                singularity = model_singularity(model)
        )
}

export_model_summary <- function(model) {
        
        list(
                formula = formula(model),
                
                fixed_effects = broom.mixed::tidy(model, effects = "fixed"),
                
                random_effects = lme4::VarCorr(model),
                
                observations = stats::nobs(model),
                
                participants = length(lme4::ranef(model)$id)
        )
}