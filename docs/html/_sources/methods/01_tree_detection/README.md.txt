# Task 1 | Urban Tree Detection

This project provides a workflow for detecting trees in urban areas using Airborne Laser Scanning (ALS) data and national geographic datasets. The output is a tree database with **tree crown** polygons and **tree top** points per neighbourhood. 

This tree database can be used as input for the [i-Tree Eco](https://www.itreetools.org/tools/i-tree-eco) model to estimate the ecosystem services of trees in urban areas. However, the laser data must be supplemented with in situ tree data (e.g. tree species, dbh, etc.) and gis-derived data (e.g. land use, building footprints, etc.) to succesfully run the i-Tree Eco model. The repository *[itree-supportTools](https://github.com/ac-willeke/itree-supportTools)* provides a workflow for preparing and linking in situ data and gis-derived data to the detected laser trees. 

In addition, the tree crowns can be used as an input to model other ecosystem services not included in the i-Tree Eco model, such as   local climate regulating services and tree crown visibility cultural services. These workflows are included in the following repositories:

- [urban-climateServices](<https://github.com/ac-willeke>) for urban heat modelling
- [r.viewshed.exposure](<https://github.com/OSGeo/grass-addons/tree/grass8/src/raster/r.viewshed.exposure>) for estimating tree crown visibility.
- [r.viewshed.impact](https://github.com/zofie-cimburova/r.viewshed.impact) for estimating tree crown impact. 


------------

Code is provided for the following tasks:

1. **preparing Airborne laser scanning (ALS)** data from [Kartverket](https://hoydedata.no/).
2. **detecting tree crowns** in the built-up zone of Norwegian municipalities using a watershed segmentation method following the workflow from *Hanssen et al. (2021)*.
3. **detecing false positives**  (e.g. objects that are detected as trees but are instead buildings, lamp posts, etc.) by identifying outliers in the geometrical shape of the tree crowns.

The repository is applied on the Norwegian municipalities: *Bærum, Bodø, Kristiansand* and *Oslo.* 

------------
## Installation
Clone the repository and follow the instructions in [Installation](installation.md) and [Project structure](project_structure.md).

## Workflow

1. **TODO:** Create Folder structure

2. **TODO:** Import Data using FME
a. study area [vector - fileGDB feature class]
b. laser data [laz - zipped las file]  
c. building footprints [vector - fileGDB feature class]
d. water bodies [vector - fileGDB feature class]
e. land use [vector - fileGDB feature class]

2. Create a municipality-specific study area mask in ArcGIS Pro 
We recommend to create a study area mask manually, as it is specific to each municipality and you might want to mask out areas that are not relevant for your analysis (e.g. water bodies, buildings but that are not yet available in national datasets). 
**Example of a mask formula:**
mask = study_area_200m_buffer - fkb_bygning_omr_1m_buffer - fkb_vann_omrade - ssb_lufthavn - ssb_bane 

4. **TODO:** Pre-process the laser data
script: `src\data\prepare_lidar.py`

5. **TODO:** Detect tree crowns
sub-package: `src\tree_detection`
a. Create a Canopy Height Model (CHM) `model_chm.py`
b. Detect trees using a watershed segmentation method `watershed_segmentation.py`
c. Identify false positives `identify_false_positives.py`

**TODO:**
Step 1 can be run using makefile `src\Makefile`
Steps 4 and 5 can be run using subroutines in `src\main.py`
### References 
- Hanssen, F., Barton, D. N., Venter, Z. S., Nowell, M. S., & Cimburova, Z. (2021). Utilizing LiDAR data to map tree canopy for urban ecosystem extent and condition accounts in Oslo. Ecological Indicators, 130, 108007. https://doi.org/10.1016/j.ecolind.2021.108007

### Acknowledgments

*This repository is part of the project:*

**TREKRONER Prosjektet** | Trærs betydning for klimatilpasning, karbonbinding, økosystemtjenester og biologisk mangfold. 


