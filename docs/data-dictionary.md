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



| Variable       |             Type | Description                                                      |

| -------------- | ---------------: | ---------------------------------------------------------------- |

| id           |          integer | Participant identifier.                                          |

| choice       |          integer | Option selected on the trial. Values: 1–4.                       |

| reward       |          numeric | Reward obtained on the trial following the participant’s choice. |

| rt           |          numeric | Choice reaction time in milliseconds.                            |

| payoff\_group | integer / factor | Reward schedule group assigned to the participant.               |

| reward\_c1    |          numeric | Reward value for option 1 under the predefined reward schedule.  |

| reward\_c2    |          numeric | Reward value for option 2 under the predefined reward schedule.  |

| reward\_c3    |          numeric | Reward value for option 3 under the predefined reward schedule.  |

| reward\_c4    |          numeric | Reward value for option 4 under the predefined reward schedule.  |



\## Notes



\* The dataset is anonymised and contains no direct participant identifiers.

\* choice records the participant’s actual decision.

\* reward records the obtained outcome after the decision.

\* reward\_c1 to reward\_c4 represent the per-trial reward values provided in the dataset. These variables may permit reconstruction of the task's reward schedule or derivation of an optimal choice, subject to verification against the original dataset documentation.

\* Raw data are stored unchanged in data/raw/.



\## Provenance



\* \*\*Original filename:\*\* DataAllSubjectsRewards

\* \*\*Raw data location:\*\* data/raw/DataAllSubjectsRewards.csv

\* \*\*Raw data policy:\*\* unchanged, immutable, and version preserved



