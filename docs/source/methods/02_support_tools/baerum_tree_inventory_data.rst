Bærum | tree inventory data
==============================

Bærum municipality provided four vector files with point data (Table 1). Each point represents a tree mapped according to the Natur i Norge (NiN) mapping manual or the håndbok 13 (DN13) mapping manual (Miljødirektoratet, 2021, Direktoratet for naturforvaltning, 2007). These trees were mapped for different purposes (monitoring of hollow oaks, old trees, or forest areas) than this project's purpose (quantifying the benefits of trees). Note that this can overrepresent certain tree species, which could affect the outcomes of this study. 

.. xlsx-table:: **Table 1.** Bærum municipality tree inventory data.
    :file: tbl/tree_inventory_metadata.xlsx
    :sheet: baerum
    :header-rows: 1


**Cleaning of the tree inventory data**

The tree inventory data was cleaned to ensure that only trees within the building zone of Bærum municipality were included in the analysis. 
The resulting cleaned dataset contained: 1465 single trees, 23 clustered trees and 765 urban forest areas. In this study we only consider the single tree localities registered within Bærums building zone, which are 1408 trees in total.
Please refer to the `summary statistics <https://ninanor.github.io/trekroner-docs/html/summary_stat/index.html>`_ for more information on the tree inventory data.
Specific cleaning tasks are described below. 

*Manual cleaning tasks in ArcGIS Pro 3.0*

- Remove trees outside the study area.
- Delete attributes not relevant for this study (ensure that lokalid and NaturbaseID are kept).
- Translate the naturtype code to the corresponding naturtype name.
- Register stem circumference (cm) in a separate column, if this value is registered in the field “naturmangfoldBeskrivelse” or in the rapport by Olberg, S. & Nilsson, A. (2023). 
- Classify the objects into "enkeltTre" (single tree), "klynge" (clustered trees) or "byskog" (urban forest area) and store in different feature classes.

*Automated cleaning tasks in Python*

- set standard field design 
- translate tree species 
- ensure that each tree point contains: stem_id, dbh, height, crown_diameter 
- group tree stem points by neighbourhood

.. note::
    See the script `clean_tree_inventory.py <https://github.com/NINAnor/itree-support-tools/blob/main/src/data/clean.py>`_ in the `itree-support-tools <https://github.com/NINAnor/itree-support-tools>`_ repository for more information on the automated cleaning tasks.
