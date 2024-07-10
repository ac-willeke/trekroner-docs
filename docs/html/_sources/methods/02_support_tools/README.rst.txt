=====================================================================================
Task 2 | Integration of Municipal Tree points and Laser-detected Tree Crown polygons
=====================================================================================

This repository provides a workflow for preparing municipal tree data for 
i-Tree Eco analysis and extrapolating the results to full the study area 
extent, using the lidar-segmented tree crowns and auxiliary GIS datasets.

Code is provided for the following tasks:

1. **i-Tree Eco Data Preparation:** preparing an input dataset for i-Tree 
Eco analysis by supplementing existing municipal tree inventories with 
crown geometry from the ALS data and auxiliary spatial datasets following 
the workflow by *Cimburova and Barton (2020).* 

Installation
------------
.. toctree::
   :maxdepth: 1 
   :caption: View the installation manual and project structure for instructions.
   
   installation_manual
   project_structure

Data
----

The following data sources were used within this project task.

**Land use**

In i-Tree Eco Land Use (LU) is defined as the land use type in which a tree is located. In i-Tree Eco, there are 13 default land use classes defined (see `Table 1 <tables.rst>`_).
The land resource map FKB-AR5 (Ahlstrøm et al. 2019, Kartverket, 2023b) and the land use map from SSB (2022) are combined, and the different land use classes are translated to the Land Use classes defined in i-Tree Eco `Table 2 <tables.rst>`_ and `Table 3 <tables.rst>`_.


Municipal Tree Inventory
~~~~~~~~~~~~~~~~~~~~~~~~
.. toctree::
   :maxdepth: 1 
   :caption: Specific manual cleaning tasks for each municipality are described in the following documents:
   
   baerum_tree_inventory_data
   bodo_tree_inventory_data
   kristiansand_tree_inventory_data
   oslo_tree_inventory_data



Methods
-------

The workflow consists of three main steps:

1. Prepare Data

   **entry point:** ``prepare_data.py``

   **tasks:**

   a. load the lidar-segmented tree crown polygons from the ALS data per neighbourhood

   b. load the in situ tree stems from the municipal tree inventory

   c. clean the in situ tree stems

      - manual municipality-specific cleaning tasks (see Data)
      
      - automatic cleaning tasks:
         - set standard field design
         - translate tree species
         - ensure that each tree stem contains: stem_id, dbh, height, crown_diameter 

   d. group tree stem points by neighbourhood
      
2. Join the in situ tree stems with the lidar-segmented tree crowns
    
   **entry point:** ``join_data.py``

   **tasks:** 

   a. classify the geometrical relationship
   b. split lidar-segmented tree crowns that overlap with multiple tree stems
   c. model the crown geometry of tree stems that do not overlap with lidar-segmented trees
   d. quality control whether each crown polygon is assigned to a single tree stem
   e. join the in situ tree stems with the lidar-segmented tree crowns
   
   **Geometrical Relations:**

   - **Case 1:** one polygon contains one point (1:1), simple join.  
   - **Case 2:** one polygon contains more than one point (1:n), split crown with voronoi tesselation.
   - **Case 3:** a point is not overlapped by any polygon (0:1), model tree crown using oslo formula.
   - **Case 4:** a polygon does not contain any point (1:0), not used to train i-tree eco/dataset for extrapolation.

3. Compute tree attributes and auxiliary attributes
    
   **entry point:** ``compute_attributes.py``

   **tasks:** 

   a. compute tree crown attributes (all trees in the study area)

      - overlay attributes (pollution zone, neighbourhood code)
      - crown_id (based on neighbourhood code and objectid)
      - tree height, crown area 

   b. compute tree stem attributes (in-situ trees)

      - overlay attributes (e.g. pollution zone, neighbourhood code, land use) 
      - tree attributes (e.g. dbh, height, crown diameter)
      - join crown attributes (e.g. crown_id, crown area, crown volume, crown shape)
      - building-related attributes (e.g. building distance, building direction)
      - crown condition (e.g. crown light exposure)

.. warning::

   **Known Issues**

   - RUN the **building-related attributes** and **crown condition attributes** separately. 
   - Make a backup of the input data before running the scripts. 
   - Note that calculating the crown condition attributes is extremely slow (e.g., it can take more than 12 hours to run).

**References**

- Cimburova, Z., & Barton, D. N. (2020). The potential of geospatial analysis and Bayesian networks to enable i-Tree Eco assessment of existing tree inventories. Urban Forestry & Urban Greening, 55, 126801. https://doi.org/10.1016/j.ufug.2020.126801

**Contributors**

- Willeke A'Campo (NINA), willeke.acampo@nina.no



