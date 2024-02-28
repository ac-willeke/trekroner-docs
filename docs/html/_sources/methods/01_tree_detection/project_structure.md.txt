
# Project Structure | *urban-tree-detection*

**GitHub Repository**: [urban-tree-detection](https://github.com/NINAnor/urban-tree-detection)

## Project folder structure

**TODO** CHECK AND UPDATE PROJECT FOLDER STRUCTURE

```bash
C:\path\to\project\folder	
├── .gitignore
├── environment.yml                     # conda env config
├── LICENSE
├── Makefile                                    
├── pyproject.toml                      # config for linters
├── README.md
├── requirements.txt                    # local package requirements
├── setup.py                            # local package install 
├── config
│   ├── catalog.yaml                    # data and metadata catalog
│   ├── credentials.yaml            
│   ├── logging.yaml                    
│   ├── parameters.yaml                 # project parameters
│   └── template.env                    # environment variables do NOT commit
├── docs
│   └── project_structure.md
├── log
│   └── .gitkeep
├── notebooks
└── src
    ├── config.py                       # load project config
    ├── decorators.py                   # project decorators
    ├── logger.py                       # logging config
    ├── utils.py                        # project utility methods       
    ├── __init__.py
    └── sub-package
        └── __init__.py
```


The following files are included in this template:

1. **Makefile** to setup, configure and run linters on your project

2. Configuration files:
    - [config/catalog.yaml](config/config.yaml) to set your project data and metadata catalog. 
    - [config/parameters.yaml](config/parameters.yaml) to set your project parameters.
    - [config/credentials.yaml](config/credentials.yaml) to set your project credentials.
    - [config/template.env](config/template.env) to set your environment variables. 
    - [config/logging.yaml](config/logging.yaml) to set your logging configuration.
    - [pyproject.toml](pyproject.toml) to set your linting configuration 

3. Environment Configuration files:
    - [environment.yml](environment.yml) to set your conda environment.
    - [setup.py](setup.py) and [requirements.txt](requirements.txt) to install your project packages. 

4. Python files:
    - [config.py](src/config.py) to load your project configuration.
    - [logger.py](src/logger.py) to set up your logging configuration.
    - [utils.py](src/utils.py) project utility methods.
    - [decorators.py](src/decorators.py) project decorators.

-------

## Data folder structure
Data is organized by municipality and has a similar sub-folder structure for each municipality. The data folder contains the following sub-folders:

```shell
path/to/urban-tree-detection/
    ├── data
    │   ├── bodo
    │   │   ├── interim        <- Intermediate data that has been transformed.
    │   │   ├── processed      <- The final, canonical data sets for modeling.
    │   │   └── raw            <- The original, immutable data dump.
    │   ├── baerum
    │   ├── kristiansand
    │   └── oslo
    ├── ...
    └── ...
```

## Raw data folder structure
Raw data folder contains the raw laser point cloud data provided by Terratec AS. The raw data is stored in the following folder structure:

```shell
path/to/folder/raw_data/
    │──	baerum/
    │   │── lidar/
    │   │   │── las_inside_BuildUpZone/
    │   │   │   │── all/
    │   │   │   │── inside_BuildUpZone/
    │   │   │   └── outside_BuildUpZone/	
    │   │   │── laz/
    │   │   └── raw/	
    │   └── vector/	
    │──	bodo/
    │──	kristiansand/
    └──	oslo/        
```