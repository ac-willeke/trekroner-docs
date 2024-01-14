Metoder (EN)
============

Contents
--------
.. toctree::
   :maxdepth: 1 

   01_tree_detection/index
   02_support_tools/README_integration
   03_itree_eco/README
   02_support_tools/README_extrapolation
   05_urban_climate/README
   06_tree_visibility/README
   installation_manuals/index
   notebooks/index

Summary 
-------

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
6. **Tree Visibility and Impact Modelling:** The visual exposure to urban trees is modelled using the r.viewshed.exposure GRASS GIS addon Cimburova and Blumentrath (2022). In addition, the public and private tree visibility value is calculated for a case study site using the r.viewshed.impact GRASS GIS addon (Cimburova et al. 2023).
7. **3-30-300 Space Rule:** three indicators for the 3-30-300 rule are calculated per district (Konijnendijk, C. C. 2023). The indicators are:
    - number of residential buildings with at least 3 trees within 15 meters
    - crown cover percentage
    - number of residential buildings within a distance of 300 meters to a green space

The methods are documented online and from there you are pointed to the correct GitHub repositories. Map results are presented in the municipalities Urban Tree Atlas and the project report.

Table 1 shows each task and their corresponding GitHub-repository. Figure 2 shows the design of this semi-automatic workflow.



.. list-table:: **Table 1.** Tasks and GitHub repositories.
     :widths: 10 30 60
     :header-rows: 1

     * - Task
       - GitHub Repository
       - Description
     * - I
       - `urban-tree-detection <https://github.com/NINAnor/urban-tree-detection>`_
       - **Tree detection** using a watershed segmentation model.
     * - II
       - `itree-support-tools <https://github.com/NINAnor/itree-support-tools>`_
       - **Cleaning** municipal tree datasets. **Joining** in situ tree stems with laser tree crowns. **Calculating** i-Tree Eco **attributes** using auxiliary GIS-data.
     * - III
       - Software not a GitHub repository
       - **Calculating** i-Tree Eco **regulating services** for the registered in situ trees.
     * - IV
       - `itree-support-tools <https://github.com/NINAnor/itree-support-tools>`_
       - **Extrapolating** i-Tree Eco regulating services to all tree crowns in the building zone.
     * - V
       - `urban-climate <https://github.com/NINAnor/urban-climate>`_
       - **Land Surface Temperature (LST)** counterfactual modelling. Ecosystem Service Calculation as avoided heat risk persons.
     * - VI
       - `r.viewshed.exposure <https://github.com/OSGeo/grass-addons/tree/grass8/src/raster/r.viewshed.exposure>`_ and `r.viewshed.impact <https://github.com/zofie-cimburova/r.viewshed.impact>`_
       - **Visual exposure modelling** and **visual impact modelling**.
     * - VII
       - `itree-support-tools <https://github.com/NINAnor/itree-support-tools>`_
       - **Calculating** the 3-30-300 space rule.


.. figure:: img/dataflyt_trekroner.png
     :alt: workflow


**Figure 1.** Design of the semi-automatic workflow. The workflow consists of seven tasks. Each task is documented online and from there you are pointed to the correct GitHub repositories. Map results are presented in the municipalities Urban Tree Atlas and the project rapport.

**References:**

- Cimburova, Z. and Blumentrath, S., 2022. Viewshed-based modelling of visual exposure to urban greenery – An efficient GIS tool for practical planning applications. Landscape and Urban Planning, Volume 222,104395. `https://doi.org/10.1016/j.landurbplan.2022.104395 <https://doi.org/10.1016/j.landurbplan.2022.104395>`_
- Cimburova, Z., Blumentrath, S., Barton, D.N., 2023. Making trees visible: A GIS method and tool for modelling visibility in the valuation of urban trees. Urban Forestry & Urban Greening 81, 127839. `https://doi.org/10.1016/j.ufug.2023.127839 <https://doi.org/10.1016/j.ufug.2023.127839>`_
- Konijnendijk, C.C. 2023. Evidence-based guidelines for greener, healthier, more resilient neighbourhoods: Introducing the 3–30–300 rule. J. For. Res. 34, 821–830. `https://doi.org/10.1007/s11676-022-01523-z <https://doi.org/10.1007/s11676-022-01523-z>`_