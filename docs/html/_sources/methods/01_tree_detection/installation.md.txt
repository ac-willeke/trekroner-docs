# Environment Setup and Configuration

### Installation 

The code runs in an ArcGIS Pro 3.1.0. conda environment and depends on 3D analyst, image analyst, spatial analyst licenses. 

Here are the steps to create a conda env compatible with ArcGIS Pro 3.0.1 and to install the local project package `urban-treeDetection`:

1. Create a new conda environment with the necessary dependencies described in `environment.yml`
- Open the Anaconda Prompt and run the following commands:
    
        ```console
        cd /d P:\%project_folder%\urban-tree-detection
        cd ...\urban-tree-detection
        conda env create -f environment.yml
        conda activate urban-tree-detection
        ```
 
- OR clone your ArcGIS Pro 3.0.1 base env and manually install the dependencies listed in `requirements.txt` using conda or pip. [ArcGIS Pro | Clone an environment](<https://pro.arcgis.com/en/pro-app/latest/arcpy/get-started/clone-an-environment.htm>)

2. Install the urban-tree-detection (urban-tree-detection/src) as a local package using pip:

        pip install -e .
        # installs project packages in development mode 
        # this creates a folder urban-tree-detection.egg-info

3. In case you run into errors remove your conda env and reinstall 

        conda remove --name myenv --all
        # verify name is deleted from list
        conda info --envs

4.  Install linters using pipx 
    ```bash
        # install linters using make
        make install-global
        # test linters
        make codestyle
    ```

    **note:** As `pre-commit` unfortunately gives acces-denied errors on Windows OS, I would recommend to run `make codestyle` command before you commit your changes. This command runs black, isort and ruff on all files.

### Configuration
This project uses a .env and a config.yaml file to store configuration variables. The module `utils.config.py` and `yaml_utils.py` provides functions to read and write these files.

Run `src/test/test_config.py` to test the configuration and logger.

#### .env
        # R GeoSpatialData
        FKB_BUILDING_PATH="path/to/gdbfile"
        FKB_WATER_PATH="path/to/gdbfile"
        SSB_DISTRICT_PATH="path/to/gdbfile"
        AR5_LANDUSE_PATH="path/to/filgdbfilee"

        # Trekroner project 
        RAW_DATA_PATH="path/to/raw/data/folder"
        PROJECT="path/to/project/folder/which/contains/the/data/folder"   
        LOCAL_GIT="path/to/the/local/version/of/this/repository" 
