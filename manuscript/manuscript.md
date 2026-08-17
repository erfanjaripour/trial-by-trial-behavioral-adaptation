# Title

Trial-by-Trial Behavioral Adaptation in a Restless Bandit Task: A Mixed-Effects Modeling Approach

# Abstract

*Adaptive decision-making requires individuals to modify behavior as reward environments change over time. Restless bandit tasks provide a framework for studying behavioral adaptation under dynamic conditions, although observable changes do not necessarily reveal latent cognitive mechanisms. The present study examined trial-by-trial behavioral adaptation in a four-arm restless bandit task using a publicly available dataset of 965 participants and 139,816 analyzed trials. Rather than estimating latent reinforcement-learning parameters, the study examined observable outcomes, trial-related change, differences across payoff environments, and individual differences in baseline behavior and adaptation. Mixed-effects models were fitted to payoff-maximizing choice, obtained reward, log-transformed reaction time, and choice switching. The primary analysis used a quadratic trial trajectory with payoff-environment interactions and participant-specific random intercepts, linear slopes, and quadratic slopes. The quadratic model provided substantially better AIC fit than the corresponding linear interaction model. Payoff-maximizing choice showed distinct linear and quadratic trajectories across payoff environments, while participants varied in baseline performance and trial-related change. Secondary analyses showed different reward trajectories across payoff environments, decreasing reaction times across trials without clear payoff-group differences, and decreasing choice switching, with evidence that this trajectory differed for Group 3 but not Group 4 relative to the reference environment. These findings indicate nonlinear changes in observable decision behavior during repeated decisions in a dynamic reward environment. Because latent values, beliefs, and learning parameters were not estimated, the findings do not identify the mechanisms underlying these changes. Instead, they provide a quantitative characterization of observable behavioral adaptation and a basis for future computational investigations of decision-making in dynamic environments.*

**Keywords:** restless bandit, behavioral adaptation, decision-making, mixed-effects models, payoff-maximizing choice

# Introduction

Adaptive decision-making requires individuals to repeatedly choose among alternatives while responding to information from previous outcomes. In many real-world situations, the value of available options changes over time, requiring continuous adjustment of behavior rather than reliance on fixed decision rules. Understanding how people adapt their choices under these dynamic conditions has been a central objective of research on learning and decision-making in cognitive psychology, neuroscience, and reinforcement learning (Rescorla \& Wagner, 1972; Sutton \& Barto, 2018).

The multi-armed bandit paradigm is one of the most widely used experimental frameworks for studying adaptive decision-making under uncertainty. In these tasks, individuals repeatedly select among several alternatives whose reward values may differ and, depending on the task, may change over time. Effective performance requires participants to use information from previous outcomes while adjusting their choices to the current reward environment. Restless bandit tasks provide a particularly demanding version of this paradigm because the values of multiple options change over time, requiring ongoing behavioral adjustment as the environment evolves (Daw et al., 2006; Speekenbrink \& Konstantinidis, 2015).

A substantial body of research has used bandit tasks to investigate the computational mechanisms underlying human learning and decision-making. Reinforcement-learning models have been applied extensively to estimate latent processes such as value updating, prediction errors, learning rates, and exploration strategies (Frank et al., 2004; Collins \& Frank, 2014; Gershman, 2018; Schultz et al., 1997; Zhang \& Yu, 2013). These computational approaches have substantially advanced understanding of the mechanisms supporting adaptive behavior. However, questions about behavioral adaptation can also be addressed at the level of observable trial-by-trial behavior without estimating latent computational parameters. Characterizing how observable behavior changes across repeated decisions provides a complementary descriptive perspective and can establish empirical patterns that subsequent computational models may seek to explain.

Repeated observations obtained from decision-making tasks also require statistical methods that account for the hierarchical structure of behavioral data. Mixed-effects models provide a framework for analyzing trial-level observations while accounting for both population-level effects and participant-level variation in behavioral trajectories (Baayen et al., 2008; Barr et al., 2013; Bates et al., 2015; Bolker et al., 2009). By modeling participant-specific random effects, these approaches account for the dependence among repeated observations within individuals and allow heterogeneity in behavioral responses to be incorporated directly into the analysis.

The present study investigates trial-by-trial behavioral adaptation using the publicly available Bahrami2020 four-arm restless bandit dataset. Rather than estimating latent reinforcement-learning mechanisms, the study focuses on observable behavioral outcomes. Specifically, it examines whether the probability of selecting the currently payoff-maximizing option changes across repeated trials, whether its nonlinear trajectory differs across payoff environments, and whether participants differ in their baseline behavior and in the linear and quadratic components of trial-related change. Trial-level mixed-effects models are used to examine payoff-maximizing choice as the primary outcome, with obtained reward, reaction time, and choice switching examined as secondary outcomes. This approach provides a reproducible statistical characterization of observable behavioral change in a dynamic decision-making environment while deliberately separating empirical behavioral patterns from claims about the latent computational mechanisms that generate them (Bahrami \& Navajas, 2020).

# Methods

## Study Design and Analytical Approach

This study examined trial-by-trial behavioral adaptation in a four-arm restless bandit task using mixed-effects statistical models. The analysis focused on observable behavioral outcomes and did not estimate latent reinforcement-learning parameters, such as learning rates, exploration parameters, or value representations. The objective was to characterize how behavioral performance changed across trials and how these trajectories varied across payoff conditions and participants.

The dataset comprised 965 participants completing a four-arm bandit task over repeated trials. The task included three payoff conditions (payoff groups 2, 3, and 4), which were treated as a trial-level categorical predictor. All analyses accounted for the repeated-measures structure of the data by including participant-level random effects.

## Behavioral Outcomes

Four behavioral outcomes were examined. The primary outcome was payoff-maximizing choice, defined as a binary indicator of whether the participant selected the option with the highest available payoff on a given trial. When multiple options shared the maximum payoff, a selection of any maximizing option was classified as a payoff-maximizing choice.

Three secondary outcomes were analyzed. Obtained reward was treated as a continuous outcome. Reaction time was log-transformed before analysis to reduce skewness and was modeled as log reaction time. Choice switching was defined as a binary indicator of whether the participant selected a different option from the preceding trial. Because switching requires a preceding observed choice, observations without a preceding choice were excluded from the choice-switching analysis.

The analyzed dataset contained 139,816 trials from all 965 participants. Ten participants were removed during preprocessing, leaving 965 participants in the analyzed dataset. There were no missing reward observations and no missing values for payoff-maximizing choice. One reaction-time observation was missing. Choice switching was structurally undefined whenever no preceding observed choice was available, resulting in 4,022 structurally missing choice-switch observations. No additional missing choice-switch observations were observed.

## Predictors and Coding

Trial number was mean-centered before analysis to improve interpretability and numerical stability. The centered trial variable was defined as:

t\_c = t - \\bar{t},

where t denotes the original trial number and t̄ denotes the mean trial number in the analytic dataset. For the primary payoff-maximizing-choice analysis, a quadratic trial term was included:

t\_c^2 = (t-\\bar{t})^2,

to allow for nonlinear changes in performance across the task.

Payoff group was modeled as a categorical predictor, with payoff group 2 serving as the reference category. Interactions between trial and payoff group were evaluated to determine whether behavioral trajectories differed across payoff conditions. For the primary outcome, both the linear and quadratic trial terms were interacted with payoff group.

## Mixed-Effects Model Specification

Generalized linear mixed-effects models with a binomial distribution and logit link were used for the two binary outcomes: payoff-maximizing choice and choice switching. Linear mixed-effects models were used for obtained reward and log-transformed reaction time.

Model development proceeded hierarchically. For each outcome, candidate model structures were compared by progressively adding participant-level random slopes and trial-by-payoff-group interactions. AIC and BIC were used as the principal criteria for model selection, with log-likelihood used as a complementary measure of relative fit. Likelihood-ratio tests were used as supplementary comparisons for nested models where appropriate. For the primary payoff-maximizing-choice outcome, the linear trial model was additionally compared with a quadratic specification to assess whether a nonlinear trial trajectory provided substantially better fit.

The final primary model for payoff-maximizing choice was:

logit\[P(Yij​=1)]=​β0​+β1​tc,ij​+β2​tc,ij2​+β3​Gij​+β4​tc,ij​Gij​+β5​tc,ij2​Gij​+b0j​+b1j​tc,ij​+b2j​tc,ij2​.​

where t\_c denotes centered trial number and G denotes the categorical payoff-group predictor, represented by indicator contrasts for payoff groups 3 and 4 relative to payoff group 2. The participant-specific random intercept, linear trial slope, and quadratic trial slope were allowed to covary.

The final reward model was:

Yij​=β0​+β1​tc,ij​+β2​Gij​+β3​tc,ij​Gij​+b0j​+b1j​tc,ij​+εij​.

The final log-reaction-time model was:

Yij​=β0​+β1​tc,ij​+β2​Gij​+b0j​+b1j​tc,ij​+εij​.

The final choice-switching model was:

logit\[P(Yij​=1)]=β0​+β1​tc,ij​+β2​Gij​+β3​tc,ij​Gij​+b0j​+b1j​tc,ij​.

For the reward, log-reaction-time, and choice-switching models, the participant-level random intercept and random trial slope were specified with the intercept–slope covariance constrained to zero. In contrast, the primary payoff-maximizing-choice model used a correlated random-effects structure in which the random intercept, linear trial slope, and quadratic trial slope were allowed to covary. This specification provided better fit according to both AIC and BIC than the corresponding uncorrelated structure, without evidence of singularity.

## Model Selection and Robustness

Model selection was based primarily on comparative fit statistics, including AIC, BIC, and log-likelihood, with likelihood-ratio tests used as supplementary comparisons for nested models where appropriate. Lower AIC and BIC values and higher log-likelihood indicated better relative fit.

For the primary outcome, linear and quadratic trial specifications were compared directly. The quadratic specification provided substantially better fit than the linear interaction model (ΔAIC = 3225.4) and was therefore retained for the primary analysis.

Random-effects specifications were also evaluated by comparing correlated and uncorrelated participant-level random intercept and slope structures. These models were assessed using AIC, BIC, log-likelihood, likelihood-ratio comparisons, convergence status, and singularity diagnostics. The correlated specification was retained for the primary payoff-maximizing-choice model because it provided better fit according to both AIC and BIC, while both specifications converged without evidence of singularity. For the secondary outcomes, the final random-effects and fixed-effects structures were retained based on the corresponding AIC and BIC model comparisons.

## Model Diagnostics

All final models were evaluated for estimation validity and model adequacy. Convergence status and singularity were examined for mixed-effects models. For generalized linear mixed-effects models, simulated residual diagnostics were assessed using DHARMa. For linear mixed-effects models, residual and quantile-quantile diagnostics were used to evaluate residual structure, homoscedasticity, and departures from residual normality.

Estimated fixed effects are reported with their standard errors, test statistics, and corresponding p-values where applicable. For binary outcomes, effects are additionally reported as odds ratios with 95% confidence intervals. For continuous outcomes, fixed-effect estimates and 95% confidence intervals are reported.

All analyses were conducted using reproducible computational workflows in R. The complete analysis code, model specifications, diagnostic procedures, and generated results were retained as part of the project repository.

# Results

## Sample and descriptive statistics

The dataset contained 965 participants and 139,816 trials after preprocessing. No participants were excluded. There were no missing reward observations or missing payoff-maximizing-choice observations. Choice switching was structurally undefined for observations without a preceding observed choice, and these observations were excluded from the choice-switching analysis. The analyzed sample sizes for each outcome are reported in Table 1.

The mean obtained reward was 58.53 (SD = 18.17), and the mean log-transformed reaction time was 6.94 (SD = 0.39). Participants selected the payoff-maximizing option on 61.35% of trials. The overall choice-switch rate, calculated over trials for which switching was defined, was 39.41%. The three payoff conditions contributed 47,442, 45,386, and 46,988 observations for Groups 2, 3, and 4, respectively. Descriptive statistics are summarized in Table 1.

## Model selection

For each outcome, candidate mixed-effects models were compared using Akaike's information criterion (AIC), Bayesian information criterion (BIC), and log-likelihood, with likelihood-ratio tests used for nested comparisons where appropriate. For payoff-maximizing choice, adding a participant-specific random trial slope substantially improved model fit relative to the fixed-effects model. Adding payoff-group interactions provided a further improvement, with the linear interaction model yielding AIC = 172,736.5. Adding a quadratic trial term produced a further substantial improvement, with the uncorrelated quadratic model yielding AIC = 169,511.1, corresponding to ΔAIC = 3,225.4 relative to the linear interaction model.

The quadratic specification was therefore retained for the primary payoff-maximizing-choice analysis. Comparison of the uncorrelated and correlated quadratic random-effects specifications favored the correlated specification according to both AIC and BIC. The correlated model yielded AIC = 169,205.6 and BIC = 169,353.3, compared with AIC = 169,511.1 and BIC = 169,629.3 for the uncorrelated model, corresponding to ΔAIC = 305.55 and ΔBIC = 276.0. Both models converged successfully and neither was identified as singular. The correlated quadratic model was therefore selected as the primary model.

For the secondary outcomes, the final models were selected according to their respective AIC comparisons. The obtained-reward analysis retained the linear trial-by-payoff-group interaction model (AIC = 1,186,822). The log-reaction-time analysis retained the random-slope model (AIC = −3,694.7), which provided slightly better fit than the interaction model (AIC = −3,691.18; ΔAIC = 3.51). The choice-switching analysis retained the linear trial-by-payoff-group interaction model (AIC = 146,464.7). The selected models and comparative fit statistics are summarized in Table 2.

## Primary outcome: payoff-maximizing choice

The final primary model included linear and quadratic effects of centered trial number, payoff group, and their interactions, with correlated participant-specific random intercepts, linear trial slopes, and quadratic trial slopes.

The fixed-effects estimates indicated a nonlinear change in the probability of selecting the payoff-maximizing option across trials. The linear trial coefficient was positive (β = 0.492, p < .001), as was the quadratic trial coefficient (β = 0.327, p < .001). Because the model contained both linear and quadratic trial terms, these coefficients describe components of the overall trajectory rather than constant per-trial changes in the odds of selecting the payoff-maximizing option.

Relative to the reference payoff condition (Group 2), Group 3 showed a positive main effect (β = 0.600, p < .001), whereas the Group 4 main effect was not statistically distinguishable from zero (β = 0.081, p = .106). The interaction between trial and Group 3 was negative (β = −0.447, p < .001), as was the corresponding interaction for Group 4 (β = −0.447, p < .001). The quadratic interaction was negative for Group 3 (β = −0.416, p < .001) and positive for Group 4 (β = 0.168, p < .001). Thus, both payoff groups differed from the reference condition in the linear and quadratic components of their trial trajectories.

Exponentiated coefficients for the quadratic model are reported as odds ratios for completeness, but they are not interpreted as constant multiplicative changes in odds per trial because the effect of trial depends jointly on the linear, quadratic, and interaction terms. The model-implied trajectories therefore provide the more direct interpretation of changes in payoff-maximizing-choice probability across the trial sequence (Figure 1). Fixed-effects estimates are reported in Table 3.

The correlated random-effects structure indicated between-participant heterogeneity in baseline performance and trial-related change. The participant-specific random intercept, linear trial slope, and quadratic trial slope were modeled jointly, allowing their covariance structure to capture individual differences in baseline performance and nonlinear trial trajectories.

## Secondary outcomes

For obtained reward, the final model showed a negative linear trial effect (β = −0.981, p < .001). Relative to Group 2, mean reward was lower in Group 3 (β = −1.441, p < .001) and Group 4 (β = −5.274, p < .001). However, the trial-by-payoff-group interactions were positive for both Group 3 (β = 7.482, p < .001) and Group 4 (β = 5.301, p < .001), indicating that the trial-related reward trajectory differed across payoff conditions (Figure 2).

For log reaction time, the final random-slope model showed a negative trial effect (β = −0.0257, p < .001). Neither payoff Group 3 (β = −0.0269, p = .267) nor Group 4 (β = −0.0111, p = .644) differed significantly from the reference condition. Thus, reaction time decreased across trials, with no evidence of a payoff-group difference in the fitted main effects (Figure 3).

For choice switching, the final interaction model showed a negative trial effect (β = −0.625, p < .001). Relative to Group 2, switching was lower in Group 3 (β = −0.384, p < .001) and Group 4 (β = −0.608, p < .001). The trial-by-Group 3 interaction was positive (β = 0.230, p < .001), whereas the trial-by-Group 4 interaction was not statistically distinguishable from zero (β = 0.071, p = .097) (Figure 4).

The secondary models used uncorrelated participant-specific random intercepts and trial slopes. The estimated standard deviations were 4.517 and 2.987 for the reward intercept and slope, respectively; 0.306 and 0.051 for the log-RT intercept and slope; and 1.321 and 0.495 for the choice-switch intercept and slope. Fixed-effects estimates for all secondary outcomes are reported in Table 4.

## Robustness analyses

The nonlinear trial specification was strongly supported by comparison with the linear interaction model. The uncorrelated quadratic model had AIC = 169,511.1 compared with AIC = 172,736.5 for the linear interaction model, corresponding to ΔAIC = 3,225.4.

The random-effects specification was also examined by comparing the uncorrelated and correlated quadratic models. The correlated model provided lower AIC and BIC (AIC = 169,205.6; BIC = 169,353.3) than the uncorrelated model (AIC = 169,511.1; BIC = 169,629.3), corresponding to ΔAIC = 305.55 and ΔBIC = 276.0. Both models converged successfully and neither exhibited singularity. The correlated specification was therefore retained for the primary model.

Overall, the model-comparison analyses supported the selected quadratic trial specification and correlated random-effects structure for the primary payoff-maximizing-choice analysis.

# Discussion

The present study examined trial-by-trial behavioral adaptation in a four-arm restless bandit task using a large trial-level dataset and mixed-effects modeling. The primary objective was to determine whether the probability of selecting the currently payoff-maximizing option changed across repeated decisions, whether this change differed across payoff environments, and whether participants differed in their baseline behavior and trial-related adaptation. The primary model indicated a nonlinear relationship between trial number and payoff-maximizing choice, with the linear and quadratic components of the trajectory differing across payoff environments. The model also indicated participant-level variability in baseline performance and in the linear and quadratic components of trial-related change.

The primary finding was that the probability of selecting the currently payoff-maximizing option changed nonlinearly across trials. This finding indicates that participants' observed choices changed systematically relative to the payoff structure of the experimental environment. However, the pattern should not be interpreted as evidence that participants necessarily became progressively better at the task across the entire trial sequence. Because the primary model included both linear and quadratic trial terms and their interactions with payoff group, the direction and curvature of the trajectory depended on the payoff environment. Moreover, payoff-maximizing choice was an externally defined behavioral measure rather than a direct measure of participants' internal beliefs, values, or learning processes.

The payoff-group interactions indicated that the temporal trajectory differed across environments. In the reference group (Group 2), the estimated quadratic component was positive. For Group 3, the implied quadratic component was negative (0.327 − 0.416 ≈ −0.089), whereas for Group 4 it was more strongly positive (0.327 + 0.168 ≈ 0.495). Thus, the payoff environments were associated not simply with different levels of payoff-maximizing choice, but with materially different forms of trial-related change. These differences are consistent with previous research showing that decision behavior in dynamic environments can depend on uncertainty, environmental structure, and the demands of adapting behavior to changing reward contingencies (Wilson et al., 2014; Speekenbrink \& Konstantinidis, 2015). However, the present analysis identifies differences in observable behavioral trajectories and does not establish the cognitive mechanisms responsible for those differences.

The primary model also revealed participant-level heterogeneity. Participants varied in their baseline probability of selecting the payoff-maximizing option and in both the linear and quadratic components of trial-related change. The model included participant-specific random intercepts, linear trial slopes, and quadratic trial slopes, with these random effects allowed to covary. Therefore, the results support individual differences not only in baseline behavior and the linear component of adaptation, but also in the curvature of the trial-related trajectory. Accounting for this heterogeneity is important in repeated-measures decision-making data because population-level effects may otherwise obscure systematic differences between individuals. Mixed-effects models provide an appropriate framework for separating population-level associations from participant-level variation (Baayen et al., 2008; Barr et al., 2013).

The secondary analyses further demonstrated that different behavioral measures captured different aspects of task performance. Obtained reward showed a distinct trajectory across payoff environments, with positive trial-by-payoff-group interactions indicating that reward changed differently across the environments. This pattern illustrates why obtained reward and payoff-maximizing choice should not be treated as interchangeable measures. In a restless bandit task, reward values change over time according to the experimental payoff schedules; consequently, selecting the currently highest-payoff option does not necessarily imply that obtained reward will increase over trials. The two outcomes therefore characterize different properties of behavior within the dynamic environment.

Reaction-time analysis showed a negative association between centered trial number and log-transformed reaction time, indicating faster responses over the course of the task. There was no statistical evidence that the fitted reaction-time levels differed between payoff groups at the centered trial reference point. These results provide evidence of trial-related change in response latency, but they do not establish the cognitive process responsible for faster responding.

Choice switching also decreased as a function of trial number, with a significant trial-by-Group 3 interaction but no statistically reliable trial-by-Group 4 interaction. Thus, switching behavior changed over trials, and the magnitude of this change differed between at least some payoff environments. As with the other secondary outcomes, these results describe observable changes in behavior rather than demonstrating the adoption of a particular exploration or exploitation strategy.

An important limitation concerns the interpretation of payoff-maximizing choice. The measure was constructed from the experimentally available payoff values and therefore provides an externally defined index of whether a participant selected the option with the highest currently available payoff. It does not necessarily reflect the information available to participants at the moment of choice. Participants may have been uncertain about the underlying reward dynamics and may not have had direct access to the complete payoff structure used to construct the measure. Accordingly, payoff-maximizing choice should be interpreted as behavioral correspondence with the experimentally defined payoff structure rather than as a direct measure of participants' internal knowledge or learning.

A second limitation is that the analysis does not identify a reinforcement-learning mechanism. The observed trial-related changes could arise from multiple processes, including learning, changes in uncertainty, heuristic adjustment, exploration-exploitation trade-offs, or other strategic adaptations. Because the present study estimated mixed-effects associations between behavioral outcomes and trial number rather than latent value, belief, or learning parameters, the results cannot distinguish among these mechanisms. Computational reinforcement-learning models would be required to test competing mechanistic explanations directly.

A third limitation concerns the functional form of the primary trajectory. Model comparison strongly favoured the quadratic specification over the linear interaction model, indicating that a constant linear change was inadequate to characterize the observed payoff-maximizing-choice trajectory. Importantly, however, the quadratic model should not be interpreted as demonstrating a single common nonlinear pattern across all payoff environments. The estimated curvature differed substantially between groups, and participant-specific quadratic slopes were included in the final model. The model therefore captures population-level differences in nonlinear trial trajectories while also allowing participants to differ in baseline performance and in the linear and quadratic components of trial-related change. Future work could extend this approach by examining more flexible trajectory specifications or alternative participant-level nonlinear structures if theoretically justified and statistically supported.

A further limitation is that the study used a previously collected dataset and was therefore constrained by the available experimental design and recorded variables. Measures of participants' expectations, uncertainty, beliefs, subjective values, or explicit decision strategies were not available for the present analysis. These omissions limit the ability to determine why behavioral trajectories differed across payoff environments or individuals. Finally, generalizability may be limited by the specific characteristics of the four-arm restless bandit task, its predefined payoff schedules, and its participant sample. Whether the observed behavioral patterns extend to other dynamic decision environments, reward structures, or forms of uncertainty remains an empirical question.

In conclusion, the present study provides a mixed-effects analysis of observable behavioral adaptation in a dynamic four-arm restless bandit environment. The probability of selecting the currently payoff-maximizing option showed a nonlinear trial-related pattern whose curvature differed across payoff environments. Participants also differed in baseline performance and in the linear and quadratic components of trial-related change. Secondary outcomes revealed distinct patterns for obtained reward, response latency, and choice switching, demonstrating that different behavioral measures capture different aspects of adaptation. These findings characterize how observable behavior changes during repeated decisions while remaining agnostic about the latent cognitive mechanisms generating those changes. Future computational modeling can build on these results by testing explicit hypotheses about the learning and decision processes underlying adaptation in dynamic environments.

# Conclusion

This study characterized trial-by-trial behavioral adaptation in a four-arm restless bandit task using mixed-effects modeling. The primary analysis identified a nonlinear trial-related trajectory in the probability of selecting the currently payoff-maximizing option, with the linear and quadratic components of this trajectory differing across payoff environments. The analysis also revealed participant-level heterogeneity in baseline performance and in the linear and quadratic components of trial-related change. Secondary analyses showed distinct patterns for obtained reward, reaction time, and choice switching, indicating that different behavioral measures capture different aspects of adaptation during repeated decision-making.

These findings provide evidence for systematic changes in observable choice behavior across repeated decisions, but they do not establish the cognitive or computational mechanisms underlying those changes. In particular, payoff-maximizing choice should be interpreted as a behavioral correspondence measure rather than as direct evidence of reinforcement learning, optimal strategy use, or knowledge of latent reward values. Overall, the study provides a quantitative description of behavioral adaptation in a dynamic decision environment and establishes a basis for future work using computational models to test the mechanisms that generate these observed trajectories.

# Acknowledgements

This study used publicly available data from the Bahrami2020 Four-Arm Restless Bandit Dataset. I thank the original authors for making the dataset available for secondary analysis and for supporting open and reproducible research practices. I also acknowledge the open-source scientific computing community and the developers of the R packages used in this project.

# Data and Code Availability

The dataset analyzed in this study is publicly available through the Open Science Framework project associated with the Bahrami2020 Four-Arm Restless Bandit Dataset. The raw data used in this analysis were preserved unchanged, and all preprocessing was performed through scripted, reproducible workflows.

All analysis scripts, preprocessing code, model specifications, generated figures, summary tables, and reproducibility materials are available in the project repository ([https://github.com/erfanjaripour/trial-by-trial-behavioral-adaptation](https://github.com/erfanjaripour/trial-by-trial-behavioral-adaptation)). The repository also includes the computational environment information required to reproduce the analyses. Processed data and derived outputs were generated directly from the raw dataset using the documented analysis pipeline.

# References

Baayen, R. Harald, Douglas J. Davidson, and Douglas M. Bates. 2008. “Mixed-effects modeling with crossed random effects for subjects and items.” *Journal of Memory and Language* 59 (4): 390–412. [https://doi.org/10.1016/j.jml.2007.12.005](https://doi.org/10.1016/j.jml.2007.12.005)

Barr, Dale J., Roger Levy, Christoph Scheepers, and Harry J. Tily. 2013. “Random effects structure for confirmatory hypothesis testing: Keep it maximal.” *Journal of Memory and Language* 68 (3): 255–278. [https://doi.org/10.1016/j.jml.2012.11.001](https://doi.org/10.1016/j.jml.2012.11.001)

Bates, Douglas, Martin Mächler, Ben Bolker, and Steve Walker. 2015. “Fitting linear mixed-effects models using lme4.” *Journal of Statistical Software* 67 (1): 1–48. [https://doi.org/10.18637/jss.v067.i01](https://doi.org/10.18637/jss.v067.i01)

Bahrami, Bahador, and Joaquin Navajas. 2020. “4 Arm Bandit Task Dataset.” OSF. [https://doi.org/10.17605/OSF.IO/F3T2A](https://doi.org/10.17605/OSF.IO/F3T2A)

Bolker, Benjamin M., Mollie E. Brooks, Connie J. Clark, Shane W. Geange, John R. Poulsen, M. Henry H. Stevens, and Jada-Simone S. White. 2009. “Generalized linear mixed models: A practical guide for ecology and evolution.” *Trends in Ecology \& Evolution* 24 (3): 127–135. [https://doi.org/10.1016/j.tree.2008.10.008](https://doi.org/10.1016/j.tree.2008.10.008)

Collins, Anne G. E., and Michael J. Frank. 2014. “Opponent actor learning (OpAL): Modeling interactive effects of striatal dopamine on reinforcement learning and choice incentive.” *Psychological Review* 121 (3): 337–366. [https://doi.org/10.1037/a0037015](https://doi.org/10.1037/a0037015)

Daw, Nathaniel D., John P. O'Doherty, Peter Dayan, Ben Seymour, and Raymond J. Dolan. 2006. “Cortical substrates for exploratory decisions in humans.” *Nature* 441 (7095): 876–879. [https://doi.org/10.1038/nature04766](https://doi.org/10.1038/nature04766)

Frank, Michael J., Lauren C. Seeberger, and Randall C. O'Reilly. 2004. “By carrot or by stick: Cognitive reinforcement learning in parkinsonism.” *Science* 306 (5703): 1940–1943. [https://doi.org/10.1126/science.1102941](https://doi.org/10.1126/science.1102941)

Gershman, Samuel J. 2018. “Deconstructing the human algorithms for exploration.” *Cognition* 173: 34–42. [https://doi.org/10.1016/j.cognition.2017.12.014](https://doi.org/10.1016/j.cognition.2017.12.014)

Rescorla, Robert A., and Allan R. Wagner. 1972. “A theory of Pavlovian conditioning: Variations in the effectiveness of reinforcement and nonreinforcement.” In *Classical Conditioning II: Current Research and Theory*, edited by A. H. Black and W. F. Prokasy, 64–99. New York: Appleton-Century-Crofts.

Schultz, Wolfram, Peter Dayan, and P. Read Montague. 1997. “A neural substrate of prediction and reward.” *Science* 275 (5306): 1593–1599. [https://doi.org/10.1126/science.275.5306.1593](https://doi.org/10.1126/science.275.5306.1593)

Speekenbrink, Maarten, and Emmanouil Konstantinidis. 2015. “Uncertainty and exploration in a restless bandit problem.” *Topics in Cognitive Science* 7 (2): 351–367. [https://doi.org/10.1111/tops.12145](https://doi.org/10.1111/tops.12145)

Sutton, Richard S., and Andrew G. Barto. 2018. *Reinforcement Learning: An Introduction*. 2nd ed. Cambridge, MA: MIT Press.

Wilson, Robert C., Andra Geana, John M. White, Elliot A. Ludvig, and Jonathan D. Cohen. 2014. “Humans Use Directed and Random Exploration to Solve the Explore–Exploit Dilemma.” *Journal of Experimental Psychology: General* 143 (6): 2074–2081. [https://doi.org/10.1037/a0038199](https://doi.org/10.1037/a0038199)

Zhang, Shunan, and Angela J. Yu. 2013. “Forgetful Bayes and myopic planning: Human learning and decision-making in a bandit setting.” *Advances in Neural Information Processing Systems* 26: 2607–2615. [https://proceedings.neurips.cc/paper/2013/file/6c14da109e294d1e8155be8aa4b1ce8e-Paper.pdf](https://proceedings.neurips.cc/paper/2013/file/6c14da109e294d1e8155be8aa4b1ce8e-Paper.pdf)

