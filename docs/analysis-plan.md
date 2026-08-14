# Analysis Plan

## Overview

This project investigates trial-by-trial behavioral adaptation in a four-arm restless bandit task using reproducible mixed-effects modeling. The workflow proceeds from raw-data validation and preprocessing through exploratory analysis, model fitting, diagnostics, robustness analyses, and reproducible results generation.

## Workflow

1. Data acquisition and provenance verification
2. Data inspection and integrity checks
3. Data preprocessing and variable engineering
4. Exploratory data analysis
5. Frequentist mixed-effects modeling
6. Model comparison and selection
7. Model diagnostics and validation
8. Robustness analyses
9. Visualization and results generation
10. Manuscript preparation

## Principles

* Preserve the raw dataset unchanged.
* Perform preprocessing through scripted, reproducible code.
* Separate exploratory analysis from statistical modeling.
* Document analytical decisions and model specifications.
* Generate figures, tables, and model outputs reproducibly.
* Manage the computational environment with `renv`.

The project uses R, Quarto, Git, and `renv`.

# Primary Analysis

The primary analysis examines trial-by-trial changes in the probability of selecting the currently highest-payoff option.

## Primary Outcome

`payoff_maximizing_choice` is a binary indicator of whether the participant selected an option with the highest trial-specific payoff among the four available options. If multiple options share the maximum payoff, selecting any of them is classified as payoff-maximizing.

The outcome is derived from the trial-specific `reward_c1`–`reward_c4` variables, which represent the trial-specific payoff values associated with the four options provided in the trial-level payoff variables. The outcome therefore measures behavioral selection of the currently highest-payoff option and does not estimate a latent reinforcement-learning value.

## Primary Model

The final primary model is a logistic mixed-effects model:

payoff_maximizing_choice ~ (trial_c + trial_c2) * payoff_group +
    (1 + trial_c + trial_c2 | id)

`trial_c` is the centered trial number and `trial_c2` is its squared term. `payoff_group` is a categorical predictor with payoff group 2 as the reference category.

The model includes:

* linear and quadratic trial effects;
* payoff-group effects;
* trial-by-group interactions for both trial terms;
* participant-specific random intercepts;
* participant-specific random slopes for linear and quadratic trial effects;
* correlated random effects.

The quadratic specification was selected based on comparative model fit and robustness analyses. The correlated random-effects specification was retained based on comparative model fit (AIC, BIC, and log-likelihood), provided that convergence and singularity criteria were satisfied.

## Secondary Analyses

Secondary models examine:

* obtained reward using a linear mixed-effects model;
* log-transformed reaction time using a linear mixed-effects model;
* choice switching using a logistic mixed-effects model.

The final model specifications are documented in the modeling workflow and reproduced in `results/tables/final-model-specifications.csv`.

Choice switching is undefined when no preceding observed choice is available. The first trial is therefore structurally missing for participants with an observed first choice. Additional missingness is assessed separately; no additional choice-switching missingness was identified.

## Model Comparison and Robustness

Candidate models are compared using AIC, BIC, and log-likelihood. Likelihood-ratio tests are used only for nested model comparisons. Model selection also considers model complexity, convergence, and singularity.

Robustness analyses evaluate:

* alternative random-effects specifications;
* linear versus quadratic trial trajectories.

Model diagnostics assess convergence, singularity, residual behavior, and distributional assumptions as appropriate for each outcome.

Convergence and singularity are assessed for all final models and reported with the model-selection results.
