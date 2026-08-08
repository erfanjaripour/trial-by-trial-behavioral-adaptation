\# Data Dictionary



\## Dataset



\*\*Name:\*\* 4 Arm Bandit Task Dataset

\*\*Source:\*\* OSF project f3t2a

\*\*URL:\*\* https://osf.io/f3t2a/overview

\*\*Checksum:\*\* `ad5acb1d3206d5302e2233f9d7aa3cb2eb1d7eb59fdc2c9090710944daec1f0d`



\## Dataset Structure



The raw dataset contains one row per participant per trial.



\* Participants: 975

\* Trials per participant: 150

\* Task: four-arm restless bandit

\* Raw observations: 144,750



\## Variables



| Variable                   | Type             | Description                                                                                                                                          |

| -------------------------- | ---------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------- |

| `id`                       | integer          | Participant identifier.                                                                                                                              |

| `choice`                   | integer          | Option selected on the trial (1–4).                                                                                                                  |

| `reward`                   | numeric          | Reward obtained following the participant's choice.                                                                                                  |

| `rt`                       | numeric          | Reaction time in milliseconds.                                                                                                                       |

| `payoff\_group`             | integer / factor | Participant payoff-schedule group. Coded as 2, 3, or 4 and treated as a categorical predictor in the models, with group 2 as the reference category. |

| `reward\_c1`                | numeric          | Trial-specific payoff value associated with option 1.                                                                                                |

| `reward\_c2`                | numeric          | Trial-specific payoff value associated with option 2.                                                                                                |

| `reward\_c3`                | numeric          | Trial-specific payoff value associated with option 3.                                                                                                |

| `reward\_c4`                | numeric          | Trial-specific payoff value associated with option 4.                                                                                                |

| `trial`                    | integer          | Sequential trial number within participant.                                                                                                          |

| `payoff\_maximizing\_choice` | integer          | Whether the selected option had the highest available payoff on that trial.                                                                          |

| `choice\_switch`            | integer          | Whether the participant selected a different option from the previous trial. `NA` on the first trial.                                                |



\## Derived Variables



`payoff\_maximizing\_choice` is derived by comparing the selected option's payoff with the maximum of `reward\_c1`–`reward\_c4`.



`choice\_switch` is derived by comparing each choice with the participant's previous choice. The first trial is coded `NA`.



`trial\_c` is the centered trial number used in mixed-effects models.



`trial\_c2` is the squared centered trial number used only in the quadratic robustness analysis.



\## Processing Notes



\* Raw data are preserved unchanged.

\* Trials without recorded behavioural responses are excluded from analyses requiring those outcomes.

\* Observations with missing reaction time are retained for choice-based analyses but excluded from reaction-time analyses.

\* `payoff\_group` is converted to a categorical factor with group 2 as the reference category.

\* The processed dataset contains 965 participants after the required preprocessing and response-based exclusions.



\## Provenance



\*\*Original filename:\*\* `DataAllSubjectsRewards`



\*\*Raw location:\*\* `data/raw/DataAllSubjectsRewards.csv`



The raw dataset is preserved unchanged and checksum-verified.

