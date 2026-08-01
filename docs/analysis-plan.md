\# Analysis Plan



\## Overview



This project investigates trial-by-trial reinforcement learning performance using mixed-effects analysis. The analysis follows a fully reproducible workflow from raw data to statistical inference.



\## Workflow



1\. Data acquisition

2\. Data inspection

3\. Data integrity validation

4\. Data preprocessing

5\. Variable engineering

6\. Exploratory data analysis

7\. Frequentist mixed-effects analysis

8\. Bayesian multilevel replication

9\. Model diagnostics and validation

10\. Robustness analyses

11\. Visualisation and interpretation



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



Secondary analyses examine obtained reward, reaction time, and exploratory behavioural measures using appropriate mixed-effects models. Bayesian multilevel analyses replicate the primary analysis to evaluate the robustness of the findings.

