# Task 4 | Extrapolation of i-Tree Eco values

The i-Tree Eco model provides valuable insights into the benefits of urban trees, including air pollution removal, stormwater infiltration, carbon storage and carbon sequestration. However, accurate modelling of these benefits requires detailed tree-level information, such as species information and diameter at breast height (DBH). This information is available for selected subset of trees, but it is not feasible to gather this data for every tree in a city. 

Within **[Task 1](../01_tree_detection/README.md)** of this project LiDAR data is used to detect tree crowns for the municipalities building zone extent. These tree crowns, in particular their tree height and crown area information, can be used to infer other relevant parameters, such as species and DBH. Prior studies have employed Bayesian networks to predict i-Tree Eco values for trees within Oslo’s building zone extent (Barton et al., 2022; Cimburova and Barton, 2020). These studies found that tree height, crown area, and air pollution variables were most important for predicting carbon storage, carbon sequestration, air pollution reduction, and water runoff reduction. To predict the total benefits of trees, Cimburova and Barton (2020) added tree species and diameter at breast height (DBH) as predictors to the Bayesian network. In this study, we use a regression model approach. Regression models offer several advantages, they are simpler to implement in an automated workflow and more computationally efficient.  

## Installation

The workflow is integrated into the [itree-support-tools](https://github.com/NINAnor/itree-support-tools) GitHub repository. Python envionment setup and project configuration infomation can be found **[HERE](../installation_manuals/02_itree_support_tools_installation.md)**.

```{note}
The entrypoint to the extrapolation workflow is the [extrapolate_data.py](https://github.com/NINAnor/itree-support-tools/blob/main/src/extrapolate_data.py) script located in the `src` folder of the itree-support-tools repository. It is important to check the data paths and parameters in the files `catalog.yaml` and `parameters.yaml` located in the `config` folder before running the workflow.

**github-repo**: [itree-support-tools](https://github.com/NINAnor/itree-support-tools)
```

## Data 

**Table 1.** Data sources used within this project task.

|Data|Description|Source|File name|
|---|---|---|---|
|**Reference Data**|Municipal tree inventory with ecosystem service values calculated using i-Tree Eco|**[Task 2](../02_support_tools/README_integration.md)**|%municipality%_registered_trees|
|**Target Data**|Tree crowns extracted from LiDAR point cloud with crown area and height information. |**[Task 1](../01_tree_detection/README.md)**|%municipality%_tree_crowns|

```{note}
The data files are delivered to the municpalities using SharePoint. They can also be downloaded in CSV or PARQUET format from the data folder of the [itree-support-tools](https://github.com/NINAnor/itree-support-tools).
```

## Methods

The following physical values calculated using the i-Tree Eco model are extrapolated to the municipality's building zone extent: 
- carbon storage (kg)
- carbon sequestration (kg/year)
- air pollution reduction (g/year)
- water runoff reduction

For Oslo and Bærum also individual air pollution reduction values are predicted: NO2 (g/year), PM2.5 (g/year) and O3 (g/year). 

First, we prepared the reference and target datasets. Then, we tested different regression models using different predictor combinations. Next, we selected the optimal model for each ecosystem service and municipality. After that, we aggregated the values to the municipality's building zone extent using the selected models. Finally, we calculated the monetary value of the ecosystem services using benefit prices. 

### Data Preparation

**Reference Dataset**

We use the in situ municipal tree inventory with i-Tree Eco values as reference data. First, we verify that each in situ tree stem contains the following predictor variables: species, dbh, height, crown_area, crown_diameter and pollution zone. In cases where DBH or height values are missing, we employ the following equations to impute them:

- **Equation 1:** dbh = 4.04 * height^0.82
- **Equation 2:** dbh = (crown diameter^2.63)/(3.48^2.63)
- **Equation 3:** height = (dbh*1.22)/(4.04^1.22)

If other predictor values are missing, we fill them using the median value of the respective variable. We opt for the median value instead of the mean value due to its robustness against outliers. The categorical variables tree species and pollution zone are encoded. Bærum municipality lacks sufficient DBH and species information, additionally, the data is skewed towards Large Oaks since the field data was not specifically collected for i-Tree Eco modelling but rather for identifying nature types with a special interest for management purposes. We assume that the tree species distribution is similar to Oslo and employ Oslo's municipal tree inventory as reference dataset for Bærum.

**Target Dataset**

The target dataset comprises the tree crowns extracted from the LiDAR point cloud. This dataset includes the following variables: tree height, crown area, crown diameter, and pollution zone. Tree species is inferred from the tree species distribution of the reference dataset, while DBH is estimated using tree height (Equation 1). Missing values are imputed using the median value of the respective variable. Categorical variables are encoded, and the optimal model is then employed to predict the i-Tree Eco values for each tree crown.

###	Regression modelling: Random Forest versus Linear Regression

The choice between Random Forest Regressor and Linear Regression is determined by the size of the reference dataset. For municipalities that have more than 1000 trees registered in their inventory (Bodø and Oslo), we employ a Random Forest Regressor. For municipalities with fewer than 1000 trees (Kristiansand), we opt for a Linear Regression model. 

We split the reference dataset into 80% training and 20% testing sets. 
For the Random Forest models a grid search algorithm is implemented to optimize Max features and N estimators, utilizing a 10-fold cross-validation to evaluate each model's performance. The optimal model, selected based on the highest R-squared score, is further evaluated using an external test dataset. The linear models for Kristiansand are trained on the training (80%) dataset and evaluated against the test (20%) dataset.

```{note}
**Random Forest Regressor**

A Random Forest Regressor is a non-parametric model that can capture non-linear relationships between the predictor and response variables. A Random Forest (REF) builds multiple decision trees, with each tree being trained on a random subset of the training data. The Random Forest Regressor then averages the predictions of each tree to make a final prediction (REF). The number of trees in the forest (N estimators) and the maximum features considered for splitting a node (Max features) are parameters that can be tuned. Random Forest models can be prone to overfitting; therefore it is recommended to tune the parameters of the model and to test the model on unseen data (REF).

**Linear Regression**

A linear regression model is a parametric model that assumes a linear relationship between the predictor and response variables (REF). A linear regression model is better suited for small datasets as it is less prone to overfitting than a Random Forest Regressor (REF). 
```

### Model Performance

**Oslo and Bærum**

Table 1 presents the model performance of the Random Forest Regressor using three different predictor combinations:

- **Feature set 1 (FS1):** Species, DBH, Height, Crown Area and Pollution Zone
- **Feature set 2 (FS2):** DBH, Height, Crown Area and Pollution Zone
- **Feature set 3 (FS3):** Height, Crown Area and Pollution Zone

The model performance is evaluated using the R2 score, and the root mean squared error (RMSE). For the water runoff reduction and pollution reduction models, we select the model trained on **FS3**, despite having a slightly lower performance than the model trained on FS1. This decision is based on the model's simplicity and the fact that DBH and tree species information are not required. This is an advantage since DBH and species information are not directly available in the target dataset but must be inferred from other variables. For the carbon storage and carbon sequestration models, we observe that DBH is crucial, and the performance drops when removing this variable. Therefore, we opt for feature set **FS2**.

**Tabel 2.** Random Forest model performance results for the three different feature sets applied on Oslo's reference dataset. The final models that are applied to the all tree crowns located in the building zone of Oslo and Bærum are highlighted in bold text.

|Feature Set|FS1|FS1|FS2|FS2|FS3|FS3|
|---|---|---|---|---|---|---|
||*R2*|*RMSE*|*R2*|*RMSE*|*R2*|*RMSE*|
|Carbon Storage (kg)|0.98|89.97|**0.95**|**144.84**|0.37|506.34|
|Carbon Sequestration (kg/yr)|0.90|2.11|**0.78**|**3.05**|0.48| 4.73 |
|Runoff (m3/yr)|0.87|0.46|0.81|0.57|**0.81**|**0.57**|
|Reduction of NO2 pollution (g/yr)|0.90|79.98|0.86|97.59|**0.86**|**97.27**|
|Reduction of PM2.5 pollution (g/yr)|0.90| 8.11 |0.86|9.95|**0.86**|**9.87**|
|Reduction of SO2 pollution (g/yr)|0.90|5.90| 0.86 |7.22|**0.85**|**7.40**|
|Total pollution reduction (g/yr)|0.90| 282.96 |0.85|345.85|**0.85**|**349.26**|

```{note}
**R2 and RMSE**

The R2 score is a measure of how well the model fits the data. The R2 score is between 0 and 1, with 1 indicating a perfect fit. The RMSE is a measure of how well the model predicts the data. The RMSE is between 0 and infinity, with 0 indicating a perfect prediction. 
```

**Bodø**

**Kristiansand**

### Calculation of monetary values

The monetary values of the ecosystem services are calculated using benefit prices. An in-depth explanation of the selection of benefit prices is available in Appendix 10 " " of the [NINA Rapport](https://www.nina.no/). The benefit prices are presented in Table 3 and the formulas used to calculate the monetary values of the ecosystem services are presented in Table 4. 

**Table 3.** Benefit prices used to calculate the monetary value of the ecosystem services.

|Ecosystem Service|Benefit Price (NOK)|
|---|---|
|Carbon (ton)|1883.00 Nkr|
|Runoff reduction (m3)|7.802  Nkr|
|Air pollution reduction (kg)|6.37 Nkr|

**Table 4.** Formulas used to calculate the monetary value of the ecosystem services.

|Ecosystem Service|Formula|
|---|---|
|Carbon storage (Nkr)|*Carbon storage (kg) * 1.883*|
|Carbon sequestration (Nkr/2023)|*Carbon sequestration (kg/yr) * 1.883*|
|Runoff reduction (Nkr/2023)|*Runoff reduction (m3/yr) * 7.802*|
|Air pollution reduction (Nkr/2023)|*Air pollution reduction (kg/yr) * 6.37*|
|Total annual benefits (2023)| *Carbon sequestration (Nkr/2023) + Runoff reduction (Nkr/2023) + Air pollution reduction (Nkr/2023)*|

### References
- Barton, D. and Venter, Z., 2022. NINA Project memo 397 
- Cimburova, Z., & Barton, D. N. (2020). The potential of geospatial analysis and Bayesian networks to enable i-Tree Eco assessment of existing tree inventories. Urban Forestry & Urban Greening, 55, 126801. https://doi.org/10.1016/j.ufug.2020.126801

### **Contributors**
- Willeke A'Campo (NINA), willeke.acampo@nina.no
- David Barton (NINA), david.barton@nina.no
- Bart Immerzeel (NINA), bart.immerzeel@nina.no
