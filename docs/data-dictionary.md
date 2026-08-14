# Data Dictionary

## Dataset

**Name:** 4 Arm Bandit Task Dataset
**Source:** OSF project f3t2a
**URL:** [https://osf.io/f3t2a/overview](https://osf.io/f3t2a/overview)
**Original filename:** `DataAllSubjectsRewards.csv`
**SHA-256:** `ad5acb1d3206d5302e2233f9d7aa3cb2eb1d7eb59fdc2c9090710944daec1f0d`

The raw dataset is preserved unchanged.

## Dataset Structure

The dataset contains trial-level observations nested within participants.

* Participants: 975
* Trials per participant: 150
* Task: four-arm restless bandit
* Maximum observations: 144,750

## Variables

| Variable                   | Type    | Description                                                                                                                                                                   |
| -------------------------- | ------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `id`                       | Integer | Participant identifier.                                                                                                                                                       |
| `choice`                   | Integer | Option selected on each trial (1–4).                                                                                                                                          |
| `reward`                   | Numeric | Reward obtained following the participant's choice.                                                                                                                           |
| `rt`                       | Numeric | Reaction time in milliseconds.                                                                                                                                                |
| `payoff_group`             | Factor  | Participant payoff-schedule group (2, 3, or 4); group 2 is the reference category in the models.                                                                              |
| `reward_c1`                | Numeric | Trial-specific payoff value associated with option 1.                                                                                                                         |
| `reward_c2`                | Numeric | Trial-specific payoff value associated with option 2.                                                                                                                         |
| `reward_c3`                | Numeric | Trial-specific payoff value associated with option 3.                                                                                                                         |
| `reward_c4`                | Numeric | Trial-specific payoff value associated with option 4.                                                                                                                         |
| `trial`                    | Integer | Sequential trial number within participant.                                                                                                                                   |
| `payoff_maximizing_choice` | Binary  | Whether the selected option had the highest available payoff on that trial.                                                                                                   |
| `choice_switch`            | Binary  | Whether the participant selected a different option from the preceding observed choice from the immediately preceding trial; undefined when no preceding choice is available. |
| `trial_c`                  | Numeric | Standardized trial number (mean 0, SD 1) used in the mixed-effects models.                                                                                                    |
| `trial_c2`                 | Numeric | Squared standardized trial number used in the quadratic trial specification.                                                                                                  |

## Derived Variables

`payoff_maximizing_choice` is derived by comparing the payoff associated with the selected option with the maximum of `reward_c1`–`reward_c4`. If multiple options share the maximum payoff, selecting any maximum-payoff option is coded as 1.

`choice_switch` is derived by comparing each participant's current choice with their preceding observed choice from the immediately preceding trial. It is structurally missing when no preceding choice is available.

`trial_c` is the standardized trial number used in the model specifications.

`trial_c2` is the squared standardized trial number used for the quadratic trial specification.

## Processing

* Raw data are preserved unchanged.
* Data processing is implemented in `R/preprocessing.R`.
* `payoff_group` is treated as a categorical predictor with group 2 as the reference category.
* Observations with missing outcome-specific variables are excluded only from analyses requiring those variables.
* Reaction-time analyses use log-transformed reaction time.
* Choice-switching analyses exclude structurally undefined switching observations.
* The processed analysis dataset is stored as `data/processed/processed-data.csv`.

## Provenance

**Raw data:** `data/raw/DataAllSubjectsRewards.csv`
**Preprocessing:** `R/preprocessing.R`
**Processed data:** `data/processed/processed-data.csv`

The raw dataset is checksum-verified before analysis.