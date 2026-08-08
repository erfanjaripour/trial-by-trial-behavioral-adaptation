\# Reproducibility



\## Overview



This document describes the computational workflow required to reproduce the analyses reported in this project.



The project investigates trial-by-trial behavioural adaptation in a four-arm restless bandit task using frequentist mixed-effects models as the primary analysis.



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



4 Arm Bandit Task Dataset



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
7. Tables and publication figures (results/)



\## Primary Statistical Analysis



The primary analysis uses a frequentist logistic mixed-effects model:



`payoff\_maximizing\_choice ~ trial\_c \* payoff\_group + (1 + trial\_c || id)`



The primary outcome indicates whether the participant selected an option with the highest trial-specific payoff.



The `reward\_c1`–`reward\_c4` variables provide the trial-specific payoff values used to determine the payoff-maximizing option. The outcome therefore measures behavioural selection of the highest-payoff option and does not represent a latent reinforcement-learning value estimate.



`payoff\_group` is treated as a categorical predictor with group 2 as the reference category.



Secondary analyses use linear mixed-effects models for reward and log reaction time and logistic mixed-effects models for choice switching.



Model diagnostics and robustness analyses are reported in `results/`.



\## Reproduction Steps



1. Clone the repository.
2. Restore the R environment: renv::restore()
3. Verify the raw dataset checksum.
4. Run preprocessing: R/preprocessing.R
5. Generate exploratory analyses: notebooks/02-exploratory-analysis.qmd
6. Run modelling and results preparation: notebooks/03-modeling.qmd
7. Generated outputs are stored in: results/



\## Repository Structure



├── .gitignore

├── CITATION.cff

├── LICENSE

├── README.md

├── reinforcement-learning-trajectories.Rproj

├── renv.lock

│

├── R/

│   ├── preprocessing.R

│   ├── models.R

│   └── visualization.R

│

├── data/

│   ├── raw/

│   └── processed/

│

├── docs/

│   ├── data\_dictionary.md

│   ├── analysis\_plan.md

│   └── reproducibility.md

│

├── manuscript/

│   ├── manuscript.tex

│   └── references.bib

│

├── notebooks/

│   ├── 01\_data\_inspection.qmd

│   ├── 02\_exploratory\_analysis.qmd

│   └── 03\_modeling.qmd

│

├── renv/

│   ├── .gitignore

│   ├── activate.R

│   └── settings.json

│

└── results/

    ├── figures/

    ├── tables/

    └── models/

