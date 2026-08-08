\# Analysis Plan



\## Overview



This project investigates trial-by-trial behavioural adaptation in a reinforcement-learning task environment using mixed-effects analysis. The analysis follows a fully reproducible workflow from raw data to statistical inference.



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



\# Primary Analysis



The primary analysis uses a logistic mixed-effects model to examine trial-by-trial changes in the probability of selecting an option with the highest available payoff.



\## Primary Outcome



`payoff\_maximizing\_choice` is a binary indicator of whether the participant selected an option with the highest trial-specific payoff among the four available options. If multiple options share the maximum payoff, selecting any of them is classified as payoff-maximizing.



The payoff values are taken from the trial-specific `reward\_c1`–`reward\_c4` variables provided in the dataset. These variables represent the predefined payoff values for the four options on each trial. The outcome is therefore a behavioural measure of selecting the currently highest-payoff option; it is not an estimate of a latent reinforcement-learning value function.



Choice-switch analyses exclude the first trial of each participant because switching requires a previous choice.



\## Primary Model Specification



The primary model is:



`payoff\_maximizing\_choice ~ trial\_c \* payoff\_group + (1 + trial\_c || id)`



`trial\_c` is the centered trial number. `payoff\_group` is treated as a categorical predictor with payoff group 2 as the reference category.



The model includes:



\* Fixed effects of trial, payoff group, and their interaction.

\* Participant-specific random intercepts.

\* Participant-specific uncorrelated random slopes for trial.



The random-slope structure allows participants to differ in their behavioural trajectories across trials. The uncorrelated specification avoids estimating an additional intercept-slope correlation parameter.



A quadratic trial specification was evaluated as a robustness analysis to assess possible nonlinear trajectories. The linear model was retained as the primary model because it provides a simpler and directly interpretable estimate of behavioural change across trials.



\## Secondary Analyses



Secondary models examine obtained reward, log-transformed reaction time, and choice switching using linear or logistic mixed-effects models as appropriate.



Robustness analyses assess the sensitivity of the primary results to alternative random-effects and trial-trajectory specifications.



