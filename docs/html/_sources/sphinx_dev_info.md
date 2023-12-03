# Sphinx Developer Information

This page contains information for contributors to the Sphinx project.

### Project Structure

# Main Pages 
- main index.rst file in docs/source
- write main pages .md files in docs/source

# R Markdown HTML files
- write R Markdown files in /Rmd

```R
"knitr::knit('example.Rmd', 'output.md')"
```

- render R Markdown files to MD in R Studio (or other R Markdown editor)
- copy HTML files to docs/html/%name%.html
- add links to HTML files in docs/source/index.rst
