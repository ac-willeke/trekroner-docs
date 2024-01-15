# Configuration file for the Sphinx documentation builder.
#
# For the full list of built-in configuration values, see the documentation:
# https://www.sphinx-doc.org/en/master/usage/configuration.html

# add project root to python path
import os  # noqa: E402

# import modules
import sys  # noqa: E402

# add project_root to python path
current_dir = os.path.dirname(os.path.abspath(__file__))
project_root = os.path.dirname(os.path.dirname(current_dir))
print(project_root)
sys.path.append(project_root)

# -- Project information -----------------------------------------------------
# https://www.sphinx-doc.org/en/master/usage/configuration.html#project-information

project = 'Trekroner'
copyright = "2023, Willeke A'Campo"
author = "Willeke A'Campo"

# -- General configuration ---------------------------------------------------
# https://www.sphinx-doc.org/en/master/usage/configuration.html#general-configuration

extensions = [
    "sphinx.ext.autodoc",
    "sphinx.ext.napoleon",
    "sphinx_autodoc_typehints",
    "sphinx.ext.doctest",
    "sphinx.ext.todo",
    "sphinx.ext.coverage",
    "sphinx.ext.mathjax",
    "sphinx.ext.ifconfig",
    "sphinx.ext.viewcode",
    "sphinx.ext.mathjax",
    "nbsphinx",
    "myst_parser",
    "sphinx_copybutton",
    "sphinxcontrib.xlsxtable",
]

templates_path = ['_templates']

# directories to ignore when looking for source files.
exclude_patterns = ["_build", "**.ipynb_checkpoints"]

# The suffix(es) of source filenames.
source_suffix = {".rst": "restructuredtext", ".md": "markdown"}

# The master toctree document.
master_doc = "index"

language = "en"

# The name of the Pygments (syntax highlighting) style to use.
pygments_style = "sphinx"

# -- Options for HTML output -------------------------------------------------
# https://www.sphinx-doc.org/en/master/usage/configuration.html#options-for-html-output

# SPHINX THEME
#html_theme = "sphinx_rtd_theme"

# GITHUB THEME
# html_theme = "alabaster"

# BOOK THEME
#html_theme = "sphinx_book_theme"

# MATERIAL THEME
html_theme = "sphinx_material"
# THEME OPTIONS
# html_theme_options = {"collapse_navigation": False, "style_external_links": True}

html_static_path = ['_static']
html_show_sourcelink = False

# -- Options for HTMLHelp output ---------------------------------------------
# Output file base name for HTML help builder.
htmlhelp_basename = "trekroner_doc"

# -- Options for LaTeX output ------------------------------------------------

# -- Options for manual page output ------------------------------------------

# -- Options for Texinfo output ----------------------------------------------

# -- Options for todo extension ----------------------------------------------

# -- Extension configuration -------------------------------------------------


# -- NBconvert kernel config -------------------------------------------------
nbsphinx_kernel_name = "python3"

def remove_arrows_in_examples(lines):
    for i, line in enumerate(lines):
        lines[i] = line.replace(">>>", "")


def autodoc_process_docstring(app, what, name, obj, options, lines):
    remove_arrows_in_examples(lines)


def skip(app, what, name, obj, skip, options):
    if name == "__init__":
        return False
    return skip

def setup(app):
    app.connect("autodoc-process-docstring", autodoc_process_docstring)
    app.connect("autodoc-skip-member", skip)
