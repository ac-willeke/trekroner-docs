# Trekroner Documentation

This repository contains the documentation for the Trekroner project.

**[Link to documentation](https://ninanor.github.io/trekroner-docs/html/index.html)**

## How to contribute to the documentation?

`\docs\source` contains the source files for the documentation. The documentation is written in reStructuredText (rst) and Markdown (md) files and built using [Sphinx](https://www.sphinx-doc.org/en/master/).

**Updating or adding a page:**
Update or add a new page by creating a new rst or md file in the appropriate folder. Add the page to the index.rst file.

**Building the documentation:**
Install Sphinx and other dependencies listed in `pyproject.toml`. Run `make html` in the `docs` folder to build the html files. The output html files are located in `docs\html`.

**Deploy the documentation to GitHub pages:**
Push the updated documentation to the remote repository. The documentation is automatically deployed to GitHub pages using GitHub actions.


**Sphinx project structure:**

```bash
# sphinx page structure
|-- docs
    |-- doctrees                                    
    |-- html                                        # html output files  
    |-- source                                      # source files
        |-- index.rst
        |-- app_instructions 
            |-- agol.md                             # AGOL manual (Bytreatlas)
            |-- qfield.md                           # QField manual (data registration app)
        |-- methods
            |-- index.rst
            |-- 01_tree_detection                   # github: NINAnor/urban-tree-detection
            |-- 02_support_tools                    # github: NINAnor/itree-support-tools
            |-- 03_urban_climate                    # github: NINAnor/urban-climate
            |-- 04_tree_visibility                  # tree visibility modelling and
                                                    # 3-30-300 space rule
        |-- summary_stat
            |-- index.md
            |-- %municipality%_summary_stat.md      # summary statistics for the registered
                                                    # trees within the municipalities
            |-- %municipality%_img 
                |-- SPECIES_PROBABILITY-1.png
                |-- ...
        |-- ES_icons                                # ecosystem services icons
            |-- ES_icons.md
            |-- OT_Ikoner.png
            |-- ...
    |-- .nojekyll                                  
    |-- make.bat                                    
    |-- Makefile                                    # Run make html to build the html files
```

More detailed information about the project structure can be found in the [Sphinx Developer Information](https://ninanor.github.io/trekroner-docs/html/methods/sphinx_dev_info.html) page.

### **Contributors**

- Willeke A'Campo (NINA), willeke.acampo@nina.no

- David Barton (NINA), david.barton@nina.no

- Bart Immerzeel (NINA), bart.immerzeel@nina.no

### **Acknowledgments**

*This repository is part of the project:*

**TREKRONER Prosjektet** | Trærs betydning for klimatilpasning, karbonbinding, økosystemtjenester og biologisk mangfold.

----------------
