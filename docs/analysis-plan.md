\# Analysis Plan



\## Overview



This project investigates trial-by-trial reinforcement learning performance using mixed-effects analysis. The analysis follows a fully reproducible workflow from raw data to statistical inference.



\## Workflow



1. Data acquisition
2. Data inspection
3. Data integrity validation
4. Data preprocessing
5. Variable engineering
6. Exploratory data analysis
7. Frequentist mixed-effects analysis
8. Model diagnostics and validation
9. Robustness analyses
10. Visualisation and interpretation



\## Principles



\* Preserve raw data unchanged.

\* Perform all preprocessing using scripted, reproducible workflows.

\* Separate exploratory and confirmatory analyses.

\* Pre-specify primary analyses where possible.

\* Document all analytical decisions.

\* Ensure all figures, tables, and results are reproducible from the source data.



The project uses R, Quarto, Git, and renv to ensure computational reproducibility.



\## Primary Analysis



The primary analysis fits a logistic mixed-effects model to examine changes in the probability of selecting the objectively payoff-maximizing choice across trials while accounting for participant-level variability.



Choice-switch models excluded the first trial of each participant because switching requires a previous choice.



\### Primary Outcome



A payoff-maximizing choice is defined as selecting an option whose reward value equals the maximum reward value available on that trial. When two options share the maximum reward value, selecting either option is classified as a payoff-maximizing choice.



\## Secondary Analyses



Secondary analyses examine obtained reward, reaction time, and exploratory behavioural measures using appropriate mixed-effects models.



Bayesian multilevel models were considered as an additional robustness analysis but were not included in the final workflow due to computational constraints.



\## Primary Model Specification



The primary analysis uses a generalized linear mixed-effects model:



payoff\\\_maximizing\\\_choice \\sim trial\_c \* payoff\\\_group + (1 + trial\_c || id)



The model estimates how the probability of selecting the currently highest-payoff option changes across trials and payoff environments.



Model components:



\- Fixed effects estimate population-level changes in payoff-maximizing choice over experience and differences between payoff groups.

\- Random intercepts capture individual differences in baseline choice tendencies.

\- Random slopes capture individual differences in adaptation across trials.



The random-slope structure was selected because participants may differ not only in their baseline tendency to choose high-payoff options but also in how their behaviour changes with experience. The uncorrelated random-effects specification was retained because it provided participant-level trajectory variation while avoiding unnecessary estimation of the intercept-slope correlation.



A quadratic trial model was evaluated as a robustness analysis to assess potential nonlinear changes across experience. The primary linear trajectory model was retained for confirmatory interpretation because it provides a more interpretable estimate of behavioural change over trials.

