Oslo | tree inventory data
==============================



**Cleaning of the tree inventory data**

The tree inventory data was cleaned to ensure that only trees within the building zone were included in the analysis. 
Please refer to the `summary statistics <https://ninanor.github.io/trekroner-docs/html/summary_stat/index.html>`_ for more information on the tree inventory data.
Specific cleaning tasks are described below. 

*Manual cleaning tasks in ArcGIS Pro 3.0*

- Remove trees outside the study area.
- Delete attributes not relevant for this study.

*Automated cleaning tasks in Python*

- set standard field design 
- translate tree species 
- ensure that each tree point contains: stem_id, dbh, height, crown_diameter 
- group tree stem points by neighbourhood

.. note::
    See the script `clean_tree_inventory.py <https://github.com/NINAnor/itree-support-tools/blob/main/src/data/clean.py>`_ in the `itree-support-tools <https://github.com/NINAnor/itree-support-tools>`_ repository for more information on the automated cleaning tasks.
