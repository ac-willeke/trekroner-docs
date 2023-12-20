Description of Methods
======================
The Trekroner project aims to quantify the benefits of trees in four Norwegian municipalities: Bodø, Bærum, Kristiansand, and Oslo. The project will provide a comprehensive understanding of the value of trees in urban areas by combining in situ tree observations with remotely sensed data. Regulating ecosystem services are calculated using the i-Tree Eco model. Additionally, the local climate regulating effect and the visibility impact of trees are estimated.

A Semi-Automatic Workflow for Data Processing
---------------------------------------------
To create a workflow that can be applied to different input dataset from different geographic locations, we created a semi-automatic workflow. The workflow selects the most appropriate route based on the characteristics of the input dataset. For instance, laser data with lower point cloud density would follow a different processing path compared to data with higher density. The workflow builds upon existing workflows, leveraging their established methodologies and is programmed in Python.

The workflow consists of the following tasks:

1. **Urban Tree Detection:** tree crown polygons and tree top points are detected from Airborne Laser Scanning (ALS) data, following the tree detection method established by Hanssen et al. (2021).
2. **Integration of Municipal Tree Databases:** Existing municipality tree inventories are integrated into one unified tree database for each municipality. The registered trees in the database are linked with the laser-detected tree crowns, and additional attributes are calculated using various GIS analyses.
3. **I-Tree Eco Modelling:** Regulating services for the registered in situ trees are calculated using the i-Tree Eco model.
4. **Extrapolation:** Linear regression models are used to extrapolate the regulating service values to the whole tree cover of the municipalities’ built up zone.
5. **Local Climate Regulation:** The effect of tree crown coverage on land surface temperature (LST) is estimated using counterfactual modelling. The climate service of trees is calculated in terms of avoided heat risk persons.