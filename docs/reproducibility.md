\# Reproducibility



\## Overview



This document describes the computational workflow required to reproduce the analyses reported in this project.



The project investigates trial-by-trial behavioural adaptation in a four-arm restless bandit task using frequentist mixed-effects models as the primary analysis and Bayesian multilevel models as secondary methodological support.



\## Computational Environment



\- Operating system: Windows 11

\- Programming language: R

\- R version: 4.6.1

\- Package management: renv



All package versions are recorded in:



renv.lock



To restore the computational environment:



renv::restore()



\## Dataset



Dataset:



Bahrami2020 Four-Arm Restless Bandit Dataset



Source:



OSF repository:



https://osf.io/f3t2a/



Raw dataset:



data/raw/



Processed dataset:



data/processed/processed-data.csv



The raw dataset should be preserved unchanged. All preprocessing steps are implemented in:



R/preprocessing.R



\## Data Integrity



The raw dataset checksum should be recorded here:



SHA256: ad5acb1d3206d5302e2233f9d7aa3cb2eb1d7eb59fdc2c9090710944daec1f0d



\## Analysis Pipeline



The complete analysis workflow is:



1. Raw dataset
2. R/preprocessing.R
3. Processed analysis dataset
4. Exploratory data analysis (notebooks/02-exploratory-analysis.qmd)
5. Frequentist mixed-effects models (notebooks/03-modeling.qmd)
6. Model diagnostics and robustness analyses
7. Bayesian multilevel robustness models
8. Tables and publication figures (results/)



\## Primary Statistical Analysis



The primary analyses use frequentist mixed-effects models.



Models include:



\- Generalized linear mixed-effects models for binary outcomes.

\- Linear mixed-effects models for continuous outcomes.



The primary behavioural outcome is:



payoff\_maximizing\_choice



This represents whether participants selected the currently highest-payoff option based on the predefined reward schedule.



It does not represent a latent reinforcement-learning optimum or estimated participant value function.



\## Secondary Bayesian Analysis



Bayesian multilevel models are used as secondary methodological support.



The purpose of Bayesian analyses is to evaluate whether posterior estimates are consistent with the conclusions obtained from the primary frequentist models.



Bayesian models provide full posterior uncertainty estimates and are used to assess the robustness of conclusions under an alternative inferential framework.



Bayesian models are not treated as separate primary analyses.



\## Reproduction Steps



1. Clone the repository.
2. Restore the R environment: renv::restore()
3. Verify the raw dataset checksum.
4. Run preprocessing: R/preprocessing.R
5. Generate exploratory analyses: notebooks/02-exploratory-analysis.qmd
6. Run modelling and results preparation: notebooks/03-modeling.qmd
7. Generated outputs are stored in: results/



\## Repository Structure



data/

├── raw/

└── processed/



R/

├── preprocessing.R

├── models.R

└── visualization.R



notebooks/

├── 01-data-inspection.qmd

├── 02-exploratory-analysis.qmd

└── 03-modeling.qmd



results/

├── figures/

├── tables/

└── models/



docs/

├── data-dictionary.md

├── analysis-plan.md

└── reproducibility.md

