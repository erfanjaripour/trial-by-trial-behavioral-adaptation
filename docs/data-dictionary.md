\# Data Dictionary



\## Dataset



\*\*Name:\*\* 4 Arm Bandit Task Dataset

\*\*Source:\*\* OSF project f3t2a

\*\*URL:\*\* https://osf.io/f3t2a/overview

\*\*Citation:\*\* Bahrami, B., Navajas, J., Wang, Y., \& Wang, S. (2025, July 17). \*4 Arm Bandit Task Dataset\*. https://doi.org/10.17605/OSF.IO/F3T2A

\*\*Checksum:\*\* ad5acb1d3206d5302e2233f9d7aa3cb2eb1d7eb59fdc2c9090710944daec1f0d



\## Dataset structure



The dataset contains one row per trial per participant.



\* \*\*Participants:\*\* 975

\* \*\*Trials per participant:\*\* 150

\* \*\*Task:\*\* 4-arm restless bandit

\* \*\*Missing trial rule:\*\* trials with no response within 4 seconds are recorded as missed and carry no reward



\## Variables



| Variable       |             Type | Description                                                                               |

| -------------- | ---------------: | ----------------------------------------------------------------------------------------- |

| id             |          integer | Participant identifier.                                                                   |

| choice         |          integer | Option selected on the trial. Values: 1–4.                                                |

| reward         |          numeric | Reward obtained on the trial following the participant’s choice.                          |

| rt             |          numeric | Choice reaction time in milliseconds.                                                     |

| payoff\_group   | integer / factor | Reward schedule group assigned to the participant.                                        |

| reward\_c1      |          numeric | Reward value for option 1 under the predefined reward schedule.                           |

| reward\_c2      |          numeric | Reward value for option 2 under the predefined reward schedule.                           |

| reward\_c3      |          numeric | Reward value for option 3 under the predefined reward schedule.                           |

| reward\_c4      |          numeric | Reward value for option 4 under the predefined reward schedule.                           |

| trial          |          integer | Sequential trial number within each participant in the analysis-ready dataset.                                                         |

| payoff\_maximizing\_choice |          integer | Binary indicator of whether the participant selected an option with the highest reward value according to the predefined trial-specific reward schedule. When multiple options shared the maximum reward value, selecting any of those options was coded as payoff-maximizing.                                       |

| choice\_switching  |          integer | Whether the participant switched from the previous choice. Values: NA = first trial, 0 = No, 1 = Yes. |



\## Notes



\* The dataset is anonymised and contains no direct participant identifiers.

\* choice records the participant’s actual decision.

\* reward records the obtained outcome after the decision.

\* reward\_c1 to reward\_c4 represent the per-trial reward values provided in the dataset. These variables may permit reconstruction of the task's reward schedule or derivation of an payoff-maximizing choice, subject to verification against the original dataset documentation.

\* Raw data are stored unchanged in data/raw/.

\* Trials without recorded responses (missing choice and reward) are excluded during preprocessing because behavioural outcomes cannot be calculated.

\* Trials with missing reaction time (rt) values are retained in the processed dataset because they remain valid for choice-based analyses. These observations are excluded only from reaction-time-specific analyses.



\## Provenance



\* \*\*Original filename:\*\* DataAllSubjectsRewards

\* \*\*Raw data location:\*\* data/raw/DataAllSubjectsRewards.csv

\* \*\*Raw data policy:\*\* unchanged, immutable, and version preserved

