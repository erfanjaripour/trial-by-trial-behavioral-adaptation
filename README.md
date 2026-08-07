\# Trial-by-Trial Behavioural Adaptation in a Restless Bandit Task



A reproducible analysis pipeline investigating how behavioural performance changes across repeated decision-making trials in a dynamic reward environment using mixed-effects modelling.



\## Overview



This project examines trial-by-trial behavioural adaptation in a four-arm restless bandit task. The primary goal is to investigate how participants' decision behaviour changes across repeated trials and how individuals differ in their behavioural trajectories.



The study uses frequentist mixed-effects models to analyse behavioural outcomes while accounting for repeated observations within participants.



This repository contains:



\* data preprocessing scripts,

\* exploratory analysis notebooks,

\* mixed-effects modelling workflows,

\* robustness analyses,

\* reproducible statistical outputs,

\* computational environment specifications.



The project focuses on behavioural adaptation and does not estimate latent reinforcement-learning parameters or computational learning mechanisms.



\## Research Question



How does behavioural performance evolve across repeated decision-making trials, and to what extent do individuals differ in their behavioural trajectories?



\## Dataset



This project uses the publicly available:



\*\*Bahrami2020 Four-Arm Restless Bandit Dataset\*\*



Source:



https://osf.io/f3t2a/



The dataset contains:



\* 975 participants,

\* 150 trials per participant,

\* a four-arm restless bandit decision-making task,

\* trial-specific reward values provided for all four options,

\* participant choices,

\* obtained rewards,

\* reaction times.



The raw dataset is stored in:



```

data/raw/DataAllSubjectsRewards.csv

```



The raw file is preserved unchanged.



The processed analysis dataset is generated through the preprocessing pipeline and stored in:



```

data/processed/processed-data.csv

```



\## Data Availability



The dataset used in this project is publicly available through the OSF repository.



No original data collection was performed as part of this project.



All analyses are based on the publicly available dataset described above.



\## Statistical Analysis



The primary analysis uses a logistic mixed-effects model predicting the probability of selecting the currently highest-payoff option.



Primary model:



```

payoff\_maximizing\_choice ~ trial\_c \* payoff\_group +

(1 + trial\_c || id)

```



The model includes:



\* fixed effects for trial progression, payoff environment, and their interaction,

\* random intercepts capturing individual differences in baseline behaviour,

\* random slopes capturing individual differences in behavioural change across trials.



Secondary analyses examine:



\* obtained reward,

\* reaction time,

\* choice switching behaviour.



\## Repository Structure



```

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

```



\## Reproducibility



The computational environment is managed using `renv`.



To reproduce the analysis:



\### 1. Clone the repository



```bash

git clone <repository-url>

```



\### 2. Restore the R environment



Open R and run:



```r

renv::restore()

```



\### 3. Verify the dataset



The raw dataset checksum is:



```

ad5acb1d3206d5302e2233f9d7aa3cb2eb1d7eb59fdc2c9090710944daec1f0d

```



\### 4. Run preprocessing



Execute:



```

R/preprocessing.R

```



\### 5. Run exploratory analyses



Execute:



```

notebooks/02-exploratory-analysis.qmd

```



\### 6. Run modelling workflow



Execute:



```

notebooks/03-modeling.qmd

```



Generated outputs are stored in:



```

results/

```



\## Reproducibility Principles



This repository follows the following principles:



\* Raw data are preserved unchanged.

\* Data processing is performed through scripted workflows.

\* Exploratory and confirmatory analyses are separated.

\* Analytical decisions are documented.

\* Figures, tables, and model outputs are generated reproducibly.

\* Package versions are recorded using `renv.lock`.



\## Citation



If you use this repository, please cite it according to the information provided in:



```

CITATION.cff

```



The original dataset should also be cited according to the dataset authors' recommended citation format.



\## License



This repository is released under the MIT License.

