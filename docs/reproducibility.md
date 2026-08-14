# Reproducibility

## Overview

This document describes the computational workflow used to reproduce the analyses reported in the project.

The project investigates trial-by-trial behavioral adaptation in a four-arm restless bandit task using frequentist mixed-effects models.

## Computational Environment

* Operating system: Windows 11
* Programming language: R
* R version: 4.6.1
* Package management: `renv`

Package versions are recorded in `renv.lock`.

To restore the computational environment:

renv::restore()

## Dataset

The analysis uses the publicly available Bahrami2020 Four-Arm Restless Bandit Dataset.

**Source:** [https://osf.io/f3t2a/overview](https://osf.io/f3t2a/overview)

The raw dataset is stored at:

data/raw/DataAllSubjectsRewards.csv

The processed analysis dataset is:

data/processed/processed-data.csv

The raw dataset is preserved unchanged. All preprocessing functions are implemented in:

R/preprocessing.R

## Data Integrity

The SHA-256 checksum of the raw dataset is:

ad5acb1d3206d5302e2233f9d7aa3cb2eb1d7eb59fdc2c9090710944daec1f0d

The checksum should be verified before analysis.

## Analysis Pipeline

The reproducible pipeline is:

1. Raw dataset
2. `R/preprocessing.R`
3. Processed analysis dataset
4. `notebooks/01-data-inspection.qmd`
5. `notebooks/02-exploratory-analysis.qmd`
6. `notebooks/03-modeling.qmd`
7. Model diagnostics and robustness analyses
8. Figures, tables, and model objects in `results/`

Model definitions and reusable statistical functions are maintained in:

R/models.R

Reusable plotting functions are maintained in:

R/visualization.R

## Statistical Analysis

The primary analysis uses a logistic mixed-effects model predicting payoff-maximizing choice:

payoff_maximizing_choice ~ (trial_c + trial_c2) * payoff_group +
    (1 + trial_c + trial_c2 | id)

Secondary analyses model obtained reward, log-transformed reaction time, and choice switching using appropriate linear or logistic mixed-effects models.

Model comparison uses AIC, BIC, and log-likelihood, with likelihood-ratio tests used only for nested model comparisons. Robustness analyses evaluate alternative random-effects and trial-trajectory specifications.

Model diagnostics assess convergence, singularity, and outcome-appropriate residual behavior.

## Reproduction Steps

1. Clone the repository.
2. Restore the computational environment:

renv::restore()

3. Verify the raw-data checksum.
4. Source `R/preprocessing.R`; preprocessing is executed through the analysis notebooks.
5. Render the data-inspection notebook:

notebooks/01-data-inspection.qmd

6. Render the exploratory analysis:

notebooks/02-exploratory-analysis.qmd

7. Render the modeling workflow:

notebooks/03-modeling.qmd

Generated figures, tables, and model objects are stored in:

results/

## Reproducibility Principles

* Raw data are preserved unchanged.
* Data processing is scripted and reproducible.
* Exploratory analysis is separated from statistical modeling.
* Analytical decisions and model specifications are documented.
* Figures, tables, and model outputs are generated from the analysis pipeline.
* Package versions are recorded using `renv.lock`.
