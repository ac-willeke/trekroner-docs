# GRASS GIS and GRASS Addonns installation

## Computer specifications

The tools r.viewshed.exposure and r.viewshed.impact were run on a server with the following specifications (Table 1).

Table 1. Computer specifications.
||Visual Exposure|Visual Impact|
|---|---|---|
|Server|HPE ProLiant DL360 Gen 10|HPE ProLiant DL360 Gen 10|
|Processor|2 Intel ® Xeon ® Gold 6134 CPU @ 3.20 GHz Central Processing Units|2 Intel ® Xeon ® Gold 6134 CPU @ 3.20 GHz Central Processing Units|
|CPU cores|40 cores|40 cores|
|Random Access Memory|370 GB|377 GB|
|SSD|960 GB|960 GB|
|Fie System|Ubuntu 18.04.5 LTS|Ubuntu 18.04.5 LTS|


## Install GRASS GIS with Docker

Pull official [OSGEO GRASS](https://grass.osgeo.org/download/docker/#GRASS-GIS-current) 
`docker pull osgeo/grass-gis:releasebranch_8_3-ubuntu_wxgui`

Enter container from **Command Line Interface (CLI)**
`docker run -it osgeo/grass-gis:releasebranch_8_3-ubuntu_wxgui`

Enter Container from **Visual Studio Code**
- CTRL + ALT + P 
- add the .devcontainer.json to your .devcontainer folder 


## Open the GRASS GIS Command Line Interface (CLI) and Graphical User Interface (GUI)

Inside your container start GRASS 
```bash	
Grass
g.gui wxpython
```

*Common Error:* “Unable to access the X Display” 
- Stop containers
- outside container check whom has access to xhost `xhost`
- Prune docker `docker system prune`
- Recreate your grass container 

## Install GRASS GIS Addons

**Using GRASS GUI**
- Settings > Addons Extension 
- Search for extension 
- Install 
- Check that extension is installed

**Using GRASS CLI** 
`g.extension.install source=path/to/extension, destination=/path/to/volume/extension`

## Create new GRASS database
GRASS GIS Database - GRASS GIS Manual (osgeo.org)
- New database > your grassdata directory 
- Name your location folder UTMxx or WGSxx
- Set your EPSG code
    - 25832 (UTM32)
    - 25833 (UTM33)
- Apply transformation. 
- Finish 

## Import data into your GRASS Mapset
- Import dsm_dtm 
- Import trecrown binary raster 
- ensure that 0 is set to NA 

## Set Processing extent

**Using GUI**
- Settings
- Computational region
- Set region [g.region]
- Set elevation model as g.region

**Using CLI**
`gs.run_command('g.region', raster='%municipality%_dsmdtm_1m_utm32_flt@%MAPSET%’)`


## Run r.viewshed.exposure tool 

**Using GUI**
- Tools 
- Search for `r.viewshed.exposure`
- Fill in parameters 

**Using CLI**
`python3 /user/.grass8/addons/scripts/r.viewshed.exposure.py input=%municipality%_dsmdtm_1m_utmXX_flt@%MAPSET% out-put=%municipality%_visual_exposure_1m_utmXX source=%municipality%_treecrown_1m_utmXX_int@%MAPSET% range=100 func-tion=Distance_decay sample_density=25 seed=1 memory=200000 nprocs=40`

## Export rasters to GeoTIFF 

Set 0 to NA (for better visualisation)
File > Export raster map 
