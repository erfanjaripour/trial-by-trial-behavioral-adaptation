# Helper Functions

center_trial <- function(data) {
        
        data |>
                dplyr::mutate(
                        trial_c = trial - mean(trial, na.rm = TRUE)
                )
}

add_trial_quadratic <- function(data) {
        
        data |>
                center_trial() |>
                dplyr::mutate(
                        trial_c2 = as.numeric(
                                scale(trial_c^2)
                        )
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
        (1 | id)


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
        
        glmer(
                formula = payoff_maximizing_random_slope_uncorrelated_formula,
                data = center_trial(data),
                family = binomial(link = "logit")
        )
        
}

fit_payoff_maximizing_choice_random_slope_correlated <- function(data){
        
        glmer(
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
        
        lme4::lmer(
                formula = reward_null_formula,
                data = center_trial(data),
                REML = FALSE
        )
}

fit_reward_fixed <- function(data) {
        
        lme4::lmer(
                formula = reward_fixed_formula,
                data = center_trial(data),
                REML = FALSE
        )
}

fit_reward_random_slope <- function(data) {
        
        lme4::lmer(
                formula = reward_random_slope_formula,
                data = center_trial(data),
                REML = FALSE
        )
}

fit_reward_interaction <- function(data) {
        
        lme4::lmer(
                formula = reward_interaction_formula,
                data = center_trial(data),
                REML = FALSE
        )
}

# Secondary Outcome: Reaction Time

fit_log_rt_null <- function(data) {
        
        lme4::lmer(
                formula = log_rt_null_formula,
                data = center_trial(data),
                REML = FALSE
        )
}

fit_log_rt_fixed <- function(data) {
        
        lme4::lmer(
                formula = log_rt_fixed_formula,
                data = center_trial(data),
                REML = FALSE
        )
}

fit_log_rt_random_slope <- function(data) {
        
        lme4::lmer(
                formula = log_rt_random_slope_formula,
                data = center_trial(data),
                REML = FALSE
        )
}

fit_log_rt_interaction <- function(data) {
        
        lme4::lmer(
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
                                parameters = attr(logLik(model), "df")
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
        )
}

# Robustness Analyses

fit_payoff_maximizing_choice_quadratic <- function(data) {
        
        data <- add_trial_quadratic(data)
        
        lme4::glmer(
                payoff_maximizing_choice ~
                        trial_c +
                        trial_c2 +
                        payoff_group +
                        (1 + trial_c || id),
                data = data,
                family = binomial(link = "logit")
        )
}

fit_reward_quadratic <- function(data) {
        
        lme4::lmer(
                reward ~ trial_c + trial_c2 +
                        payoff_group +
                        (1 + trial_c || id),
                data = add_trial_quadratic(data),
                REML = FALSE
        )
}

fit_log_rt_quadratic <- function(data) {
        
        data <- add_trial_quadratic(data)
        
        lme4::lmer(
                log_rt ~ trial_c + trial_c2 +
                        payoff_group +
                        (1 + trial_c || id),
                data = data,
                REML = FALSE
        )
}

fit_choice_switch_quadratic <- function(data) {
        
        lme4::glmer(
                choice_switch ~ trial_c + trial_c2 +
                        payoff_group +
                        (1 + trial_c || id),
                data = add_trial_quadratic(data),
                family = binomial(link = "logit")
        )
}

# Model Reporting

model_r2 <- function(model) {
        
        performance::r2_nakagawa(model)
}

model_confidence_intervals <- function(model) {
        
        confint(
                model,
                method = "Wald"
        )
}

model_odds_ratios <- function(model) {
        
        broom.mixed::tidy(
                model,
                effects = "fixed",
                conf.int = TRUE,
                exponentiate = TRUE
        )
}

model_summary <- function(model) {
        
        tibble::tibble(
                observations = stats::nobs(model),
                participants = nrow(lme4::ranef(model)$id),
                singular = lme4::isSingular(model)
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