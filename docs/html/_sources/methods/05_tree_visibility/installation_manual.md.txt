# Installation Manual | GRASS GIS Addons *r.viewshed.exposure* and *r.viewshed.impact*

## Computer specifications

The tools *r.viewshed.exposure* and *r.viewshed.impact* were run on a server with the following specifications (Table 1).

**Table 1.** Computer specifications.
||Visual Exposure|Visual Impact|
|---|---|---|
|Server|HPE ProLiant DL360 Gen 10|HPE ProLiant DL360 Gen 10|
|Processor|2 Intel ® Xeon ® Gold 6134 CPU @ 3.20 GHz Central Processing Units|2 Intel ® Xeon ® Gold 6134 CPU @ 3.20 GHz Central Processing Units|
|CPU cores|40 cores|40 cores|
|Random Access Memory|370 GB|377 GB|
|SSD|960 GB|960 GB|
|Fie System|Ubuntu 18.04.5 LTS|Ubuntu 18.04.5 LTS|

**Table 2.** Time used for r.viewshed.exposure processing.
|Municipality|Processing time|
|---|---|
|Bodø|211 min|
|Bærum|692 min|
|Kristiansand|58 min|
|Oslo|2078 min (34 hours 38 min)|

The *r.viewhsed.impact* tool is more computationally demanding than *r.viewshed.exposure*. Due to resource restrictions, the tool was solely run on a test-site for the municipality of Oslo.


## Install GRASS GIS with Docker

Pull official [OSGEO GRASS](https://grass.osgeo.org/download/docker/#GRASS-GIS-current) 

`docker pull osgeo/grass-gis:releasebranch_8_3-ubuntu_wxgui`

Enter container from **Command Line Interface (CLI)**

`docker run -it osgeo/grass-gis:releasebranch_8_3-ubuntu_wxgui`

Enter Container from **Visual Studio Code**
- CTRL + ALT + P 
- add the .devcontainer.json to your .devcontainer folder 

Inside your container start GRASS 

```bash	
grass
g.gui wxpython
```

## Install GRASS GIS Addons

Official GRASS documentation on how to install addons is available **[HERE](https://grass.osgeo.org/grass83/manuals/g.extension.html)**.

### **Using GRASS GUI**
- Settings > Addons Extension 
- Search for extension 
- Install 
- Check that extension is installed

### **Using GRASS CLI** 

```bash
# check if addonn is already installed 
g.extension -a 
g.extension -a | grep "r.viewshed.exposure"

# install extension using GRASS CLI 
g.extension extension=r.viewhsed.exposure

# install from GITHUB
# r.viewshed.exposure is part of grass-addons
g.extension extension=r.viewshed.exposure url=https://github.com/OSGeo/grass-addons/tree/grass8/src/raster/r.viewshed.exposure

# r.viewshed.impact is unreleased addon
g.extension extension=r.viewshed.impact url=https://github.com/zofie-cimburova/r.viewshed.impact 
```

## Install GRASS GIS Addons as a local module

In case you want to modify the code of the addon or you want to use an unreleased addon, you can install the addon as a local module.

```bash
# clone the addon code from GITHUB
git clone https://github.com/OSGeo/grass-addons.git grass-addons
git clone https://github.com/zofie-cimburova/r.viewshed.impact r.viewshed.impact

# install the addon by pointing to the local folder
g.extension extension=r.viewshed.impact url=/path/to/local/git-repo/r.viewshed.impact/
```

## GRASS GIS Tasks used in this project

Note that processing costs a large amount of resources and time (Table 1 and 2). Therefore scheduling the tasks and disucssing resource allocation with your IT department is recommended.

### **Using GRASS GUI**
1. Create new GRASS database
GRASS GIS Database - GRASS GIS Manual (osgeo.org)
- New database > your grassdata directory 
- Name your location folder UTMxx or WGSxx
- Set your EPSG code
    - 25832 (UTM32)
    - 25833 (UTM33)
- Apply transformation. 
- Finish 

2. Import data into your GRASS Mapset
- Import dsm_dtm 
- Import treecrown binary raster 
- Import treecrown vector
- Import public space binary raster
- Import private space binary raster 

3. Set computational region
- Settings
- Computational region
- Set region [g.region]
- Set elevation model as g.region

4. Run r.viewshed.exposure tool 
- Tools 
- Search for `r.viewshed.exposure`
- Fill in parameters 

4. Run r.viewshed.exposure tool 
- go to Python console
- import local grass.script
- click run > GUI opens fill in params

5. Export results
- File > Export raster map (visual exposure raster)
- File > Export vector map (tree crowns with public/private visibility values)

### **Using GRASS CLI**
```bash
# create new grass database
mkdir /path/to/dir/grassdata

# start grass session
grass /path/to/dir/grassdata

# create new grass location
grass -c EPSG:xxxxx /grassdata/new_location
grass -c EPSG:25832 /workspaces/urban-tree-visibility/grassdata/utm32

# init existing grass session 
grass /path/to/grassdata/location

# check if addonn is installed 
g.extension -a 
g.extension -a | grep "r.viewshed.exposure"

# install r.viewshed.exposure 
g.extension extension=r.viewshed.exposure

# install r.viewshed.impact as a local module
git clone https://github.com/zofie-cimburova/r.viewshed.impact r.viewshed.impact

# install the addon by pointing to the local folder
g.extension extension=r.viewshed.impact url=/path/to/local/git-repo/r.viewshed.impact/

# Set computational region 
g.region raster=dsmdtm_1m_utm32_flt@$MAPSET -p

# Run r.viewshed.exposure tool
r.viewshed.exposure input=dsmdtm_1m_utm32_flt@oslo output=visual_exposure_1m_utm32 source=treecrown_1m_utm32_int@oslo range=100 function=Distance_decay sample_density=25 seed=1 memory=200000 nprocs=40

# Export visual exposure raster
r.out.gdal input=visual_exposure_1m_utm32@oslo output=path/to/output/visual_exposure_1m_utm32.tif format=GTiff type=Float32 nodata=-9999

# Run r.viewshed.impact tool
r.viewshed.impact exposure=treecrowns@impact column=v_public dsm=dsmdtm_1m_utm32_flt@impact weight=public_space_1m_utm32_int@oslo_impact Range=100 seed=1 memory=200000 cores_e=10 cores_i=20

# Export tree crowns with public/private visibility values
v.out.ogr input=treecrowns@impact output=path/to/output/treecrowns_public_private.shp format=ESRI_Shapefile type=auto
```

