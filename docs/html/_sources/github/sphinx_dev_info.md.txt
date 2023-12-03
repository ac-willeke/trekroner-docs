# Sphinx Developer Information

This page contains information for contributors to the Sphinx project.

## Project Structure
- main index.rst file in docs/source
- subpages grouped in separate folders docs/source/%subpage%/%page%.md

## R Markdown HTML files
- write R Markdown files in /Rmd
- render R Markdown files to MD in R console

    ```python
    "knitr::knit('Rmd/example.Rmd', 'Rmd/md/output.md')"
    ```
    
    This creates a markdown file in the Rmd/md folder, with images
    in the Rmd/md/figure folder. The images are referenced in the markdown filed.

- copy the markdown file to the docs/source/Rmd folder
    - ensure that the links to the images do not contain spaces in 
    the file name and are relative to the markdown file
- copy the images to the docs/source/Rmd/figure folder
- add the markdown file to the index.rst file in docs/source/Rmd

