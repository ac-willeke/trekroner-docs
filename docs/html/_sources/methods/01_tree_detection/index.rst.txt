=============================
Task 1 | Urban Tree Detection
=============================

*work in progress, move word docs to rst*

This is the documentation page related to the GitHub repository: 
`urban-tree-detection <https://github.com/NINAnor/urban-tree-detection>`_

The repository provides a workflow for detecting trees in urban areas using 
Airborne Laser Scanning (ALS) data and national geographic datasets. The output 
is a tree database with **tree crown** polygons and **tree top** points per 
neighbourhood. This tree database can be used as input for the 
`i-Tree Eco <https://www.itreetools.org/tools/i-tree-eco>`_ model 
to estimate the ecosystem services of trees in urban areas. However, the laser
data must be supplemented with in situ tree data (e.g. tree species, dbh, etc.) 
and gis-derived data (e.g. land use, building footprints, etc.) to successfully 
run the i-Tree Eco model. The repository 
`itree-supportTools <https://github.com/NINAnor/itree-supportTools>`_ provides 
a workflow for preparing and linking in situ data and gis-derived data to the 
detected laser trees.

In addition, the tree crowns can be used as an input to model other ecosystem 
services not included in the i-Tree Eco model, such as local climate regulating s
ervices and tree crown visibility cultural services. These workflows are included 
in the following repositories:

- `urban-climate <https://github.com/NINAnor/urban-climate>`_ for urban heat modelling
- `r.viewshed.exposure <https://github.com/OSGeo/grass-addons/tree/grass8/src/raster/r.viewshed.exposure>`_ for estimating tree crown visibility.
- `r.viewshed.impact <https://github.com/zofie-cimburova/r.viewshed.impact>`_ for estimating tree crown impact.


Code is provided for the following tasks:

1. **preparing Airborne laser scanning (ALS)** data from Terratec AS
2. **detecting tree crowns** in the built-up zone of Norwegian municipalities using a watershed segmentation method following the workflow from *Hanssen et al. (2021)*.
3. **detecing false positives**  (e.g. objects that are detected as trees but are instead buildings, lamp posts, etc.) by identifying outliers in the geometrical shape of the tree crowns.

The repository is applied on the Norwegian municipalities: *Bærum, Bodø, Kristiansand* and *Oslo.* 

Installation
------------
.. toctree::
   :maxdepth: 1 

   ../05_installation_manuals/01_tree_detection_installation
   project_structure



Data
----


*work in progress* load tables to restructred text



Workflow
----------
1. **Create a study area mask** (*optional manual action*)
   
   We recommend to create a study area mask manually, as it is specific to each municipality
   and you might want to mask out areas that are not relevant for your analysis 
   (e.g. water bodies, buildings but that are not yet available in national datasets).

   **Example of a mask formula:**

   mask = study_area_200m_buffer - buildin_footprints - waterbodes


.. htmlonly::

   <br>

2. **Pre-process the laser data** (*semi-automatic*)

   Run the following scripts to pre-process the laser data:

   a. `src/data/moveFile_lookUp.py`

      - classifies the laser tiles into inside and outside the build-up zone (only pre-process tiles inside the build-up zone)

   b. `src/data/extract_laz.bat`

      - extracts the .laz files from the .zip files to .las files

   c. `src/data/moveFile_substring.py`

      - create a copy per XXX-YYY tile and move the .las files to the corresponding folder

   d. `src/data/renameFile.bat`

      - rename the .las files to utmxx_X_XXX_YYY_X.las to make them compatible with ArcGIS Pro (e.g. utm33_1_495_304_01.las)

   e. `src/data/define_projection.py`

      - define the projection of the .las files to EPSG:25833 or EPSG:25832

   **TODO:** 
   move scripts as subroutines to `src/prepare_lidar.py`

3. **Detect tree crowns** (automatic) 

   Run the following scripts to detect tree crowns:

   a. `src/tree_detection/model_chm.py`

      - create a Canopy Height Model (CHM) from the laser data

   b. `src/tree_detection/watershed_segmentation.py`

      - detect tree crowns using a watershed segmentation method

   c. `src/tree_detection/identify_false_positives.py`

      - identify false positives (e.g. objects that are detected as trees but are instead buildings, lamp posts, etc.) by identifying outliers in the geometrical shape of the tree crowns.
    









**References:**

- Hanssen, F., Barton, D. N., Venter, Z. S., Nowell, M. S., & Cimburova, Z. (2021). Utilizing LiDAR data to map tree canopy for urban ecosystem extent and condition accounts in Oslo. Ecological Indicators, 130, 108007. https://doi.org/10.1016/j.ecolind.2021.108007

