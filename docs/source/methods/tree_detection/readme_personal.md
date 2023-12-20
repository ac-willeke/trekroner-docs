### Installation 

The code is build in an ArcGIS Pro 3.1.0. conda environment with 3D analyst, image analyst, spatial analyst licensed. 

Here are the steps to create a conda env compatible with ArcGIS Pro 3.0.1 and to install the local project package `treeDetection`:

1. Create a new conda environment with the necessary dependencies described in `environment.yml`
    
        cd /d P:\%project_folder%\treeDetection
        #REMOVE from public README 
        cd /d P:\152022_itree_eco_ifront_synliggjore_trars_rolle_i_okosyst\treeDetection
        cd ...\urban-treeDetection
        conda env create environment.yml
        conda activate treeDetection

2. Install the treeDetection (urban-treeDetection/src) as a local package using pip:

        pip install -e .
        # installs project packages in development mode 
        # this creates a folder treeDetection.egg-info

3. In case you run into errors remove your conda env and reinstall 

        conda remove --name myenv --all
        # verify name is deleted from list
        conda info --envs




## TODO
- update folder structure
- lookat makefile etc. 


# variable names
%xxx%_admin = admin dataset
- study area extent 
%xxx%_in_situ_trees = municipal tree dataset
- stem_point 

%xxx%_laser_trees = laser segmented tree dataset
- crown_laser(tree crown polygon)
- top_laser (tree top point) 
%xxx%_urban_trees = combined municipal and laser tree dataset 

```shell
## folder structure
## raw data folder
P:/
    152022_itree_eco_ifront_synliggjore_trars_rolle_i_okosyst/
    │──	raw_data/
        │──	baerum/
            │── lidar/
                │── las_inside_BuildUpZone/
                    │── all/
                    │── inside_BuildUpZone/
                    └── outside_BuildUpZone/	

                │── laz/
                └── raw/	
            └── vector/	
        │──	bodo/
        │──	kristiansand/
        └──	oslo/
        

## modelling folder 
P:/
    15220700_gis_samordning_2022_(marea_spare_ecogaps)/Willeke/
        │──	baerum/
        │──	treeDetection/
            │── arcgispro/
            │──	data/
            │──	docs/
            │──	src/
                │──	data/     -> scripts for collecting, processing, and cleaning raw data. 
                │──	features/ -> scripts for creating features from cleaned data
                │──	models/   -> scripts for training/evaluating models
                └──	visualization/	-> scripts for creating visualizations from the cleaned data and the models. 
            │──	test/
            └──	tools/	
        │──	bodo/
        │──	kristiansand/
        └──	oslo/
        
```

template_cookiecutter
==============================

Python project folder structure template from cookiecutter 

Project Organization
------------

    ├── LICENSE            **TODO** 
    ├── README.md          <- The top-level README for developers using this project.
    ├── data
    │   ├── baerum
    │   │   ├── interim        <- Intermediate data that has been transformed.
    │   │   ├── processed      <- The final, canonical data sets for modeling.
    │   │   └── raw            <- The original, immutable data dump.
    │   ├── bodo
    │   └── kristiansand
    ├── docs               <- A default Sphinx project; see sphinx-doc.org for details
    │
    │
    ├── notebooks          <- **TODO** Jupyter notebooks. Naming convention is a number (for ordering),
    │                         the creator's initials, and a short `-` delimited description, e.g.
    │                         `1.0-jqp-initial-data-exploration`.
    │
    ├── references         <- **TODO** Data dictionaries, manuals, and all other explanatory materials.
    │
    ├── reports            <- **TODO** Generated analysis as HTML, PDF, LaTeX, etc.
    │   └── figures        <- **TODO** Generated graphics and figures to be used in reporting
    │
    ├── requirements.txt   <- **TODO** The requirements file for reproducing the analysis environment, e.g.
    │                         generated with `pip freeze > requirements.txt`
    │
    ├── setup.py           <- **TODO** makes project pip installable (pip install -e .) so src can be imported
    ├── src                <- Source code for use in this project.
    │   ├── __init__.py    <- Makes src a Python module
    │   │
    │   ├── data           <- Scripts to download or generate data
    │   │   └── make_dataset.py
    │   │
    │   ├── features       <- Scripts to turn raw data into features for modeling
    │   │   └── build_features.py
    │   │
    │   ├── models         <- Scripts to train models and then use trained models to make
    │   │   │                 predictions
    │   │   ├── predict_model.py
    │   │   └── train_model.py
    │   │
    │   └── visualization  <- Scripts to create exploratory and results oriented visualizations
    │       └── visualize.py
    │
    └── tox.ini            <- tox file with settings for running tox; see tox.readthedocs.io