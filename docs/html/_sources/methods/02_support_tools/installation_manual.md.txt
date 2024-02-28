# Installation Manual | *itree-support-tools*

**GitHub Repository**: [itree-support-tools](https://github.com/NINAnor/itree-support-tools)

## Installation

The code is build in an ArcGIS Pro 3.1.0. conda environment with the spatial analyst license enabled. 

1. Clone the repository.
3. Open [Project structure](project_structure.md) to view the structure of the project.
4. Set up your Python Environment:
    
    a. Create a new conda environment using the `environment.yml` file or clone the arcgispro-py3 environment from your ArcGIS Pro installation and install the required packages listed in the `requirements.txt` file.
    ```bash
        cd path/to/project/folder
        conda env create -f environment.yml
        conda activate project-name
    ```

    b. (Optional) Install linters using pipx 
    ```bash
        # install linters using pipx
        make install-global
        # test linters
        make codestyle
    ```

    **note:** As `pre-commit` unfortunately often gives acces-denied errors on Windows OS, I would recommend to run `make codestyle` command before you commit your changes. This command runs black, isort and ruff on all files using the configuration specified in the [pyproject.toml](pyproject.toml) file.

    c. Install as a local package 
    ```bash
        pip install .
        pip install -e . # for development
    ```
    -  installs project packages in development mode
    - creates a folder **package-name.egg-info**

## Configuration

1. Copy template.env to  $user/.env and fill in the variables. 
*ENSURE THAT YOU DO NOT COMMIT .ENV TO THE REPOSITORY*

2. Check that your data is located in the correct folders, look at the [Project structure](docs/project_structure.md) and the [Catalog](config/catalog.yaml) for more details. 

3. Define your municipality in the [parameters](config/parameters.yaml) file.

4. Run `config.py` in the conda env to test your project config.
-------