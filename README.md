# Trekroner Documentation

This repository contains the documentation for the Trekroner project. The map results are presented in AGOL-apps and the documentation is available as a hosted website on GitHub pages.

**Documentation website:** [https://ninanor.github.io/trekroner-docs/](https://ninanor.github.io/trekroner-docs/html/index.html)
**NINA Rapport:** [link to be added](https://www.nina.no/)

**AGOL-apps:**
| kommune | Bytre-atlas |
| --- | --- |
| Bodø | [Bytre-atlas Bodø](https://experience.arcgis.com/experience/5191adc2c4b34658aea227c9853c6ebb) |
| Bærum | [Bytre-atlas Bærum](https://experience.arcgis.com/experience/8e112760eff34fd5b9176cefb7d31eb3) |
| Kristiansand | [Bytre-atlas Kristiansand](https://experience.arcgis.com/experience/6e047c5432e64b3f9abb1592d7907ff6) |
| Oslo | [Bytre-atlas Oslo](https://experience.arcgis.com/experience/aa5030c8735946949086e4ee3dd7638b) |

**repo structure:**

```bash
|-- AGOL_bytreatlas             # AGOL manual in PDF-format
|-- docs                        # documentation source files
|-- ES_icons                    # ecosystem services icons in PNG-format 
|-- QField_treregisteringsapp   # QField manual and template-app
|-- R_summary_stat              # Rmd scripts for summary statistics, knitt to md and add to docs
```


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

</br>

*This repository is part of the project:*

**TREKRONER Prosjektet** | bistand til i å synliggjøre bytrærs rolle i klimatilpasning i kommuner. 

----------------
