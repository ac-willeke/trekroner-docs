# Mapping of trees visibility and accessibiltiy 

This method appendix documents the methods for the task “Tree Visibility and Impact Mod-elling”. 
The resulting products of the task are: (i) a map that shows the visual exposure of tree crowns within the municipalities study area, (ii) a map for a case study site in Oslo, which shows the public and private visibility value per tree, and (iii) three indicators for the 3-30-300 rule calculated per district (grunnkrets). 


**The 3-30-300 green space rule** 

The 3-30-300 green space proposed by Cecil Konijnendijk, is an evidence-based guideline for guideline for creating healthier and more sustainable cities through the strategic use of urban green spaces. (Konijnendijk, C.C. 2023). The rule outlies three key objectives:

**Rule 3:** all residents should be able to see at least 3 trees from their home.

**Rule 30:** all neighbourhoods should have 30% tree canopy cover.

**Rule 300:**  all residents should be able to access a green area within 300 m from their home.


## Materials and Methods

### Data 

The following data sources were used within this project. See Appendix X for a detailed de-scription of each dataset. 

**Building footprints** 

The FKB-Buildings vector map (Kartverket, 2020) was used to extract building footprints from the map layer ‘fkb_bygning_omrade’. In addition, we classified these footprints into res-idential and non-residential buildings using the bygningstype attribute (Appendix X). 

**Water bodies**

Water bodies were derived from the land resource map FKB-AR5 (NIBIO, 2020), category freshwater and sea.

**Digital surface model, digital terrain difference model (DSM-DTM)**

The Digital Surface Model (DSM) and Digital Terrain Model (DTM) are created from laser point cloud data. The DSM includes all points in the cloud, while the DTM only includes points classified as bare earth. The DSM-DTM is created by subtracting the DTM from the DSM, and it shows the height of all objects above the ground. The DSM-DTM model is down sampled to 1-meter resolution to improve processing speed.

**Tree crown polygons and binary raster**

Vector map of tree crown polygons detected from municipal laser data (see Tree Detection). 
The crown polygons were converted into a binary raster of 1x1 m resolution, where 1 repre-sents pixels covered by tree crown and NA represent pixels without tree crown coverage. 

**Open Space**

Within this project open space is defined as any space within the study area which is not a building footprint, a tree canopy or a water surface as recommended by (REF – visual im-pact appendix). Areas smaller than 1 m² were excluded from the open space dataset. The open space dataset was classified into public and private open space using a land resource map FKB-AR5 (NIBIO, 2020) and a land use map (Statistics Norway, 2022). The classes transport, open land, green areas, wetlands, forest and unclassified were classified as open space. Private space was classified as any open space that is not public (Appendix X). 

**Green space**

Green space is defined by Statistics Norway (Statistisk sentralbyrå, SSB) as urban nature areas, nærturterreng, larger than 200 000 m2 and urban recreation areas ,leke- rekreasjon-sareal, between 5 000 – 200 000 m2 (REF SSB). The World Health Organization (WHO) de-fines green space as public green spaces of at least 10 000 m2 (Konijnendijk, C. C. 2023). Here we use the definition by SSB. 

A land resource map FKB-AR5 (NIBIO, 2020) and a land use map (Statistics Norway, 2022) are combined, and the different land use classes are translated to green space or no-green space. The classes forest, open land, wetland, bare rock, gravel- and stone, park, sport are-as, together with lakes and ponds smaller than 1 000 m2 are classified as green space (Ap-pendix X). 


## Viewshed exposure modelling

Visual exposure to urban trees was determined using the r.viewshed.exposure tool in GRASS GIS  (Cimburova and Blumentrath (2022) for all treecrown municipalities. The DSM-DTM and the tree crown binary raster served as inputs for the analysis. The default methods settings, which define a good balance between accuracy and processing time, were applied to all municipalities (Table X). The viewshed parametrisation function was set to distance decay, which means that the pixel’s weight decreases the further you move away from the tree. The resulting visual exposure raster quantifies the level of visual exposure to urban trees, ranging from 0 (no exposure) to high expo-sure values. 

**FIGURE HERE**

## Visual Impact Modelling

The individual tree visibility of trees located in public and private spaces were modelled us-ing the r.viewshed.impact tool (Cimburovam, 2023). The viewshed impact tool differs from the viewshed exposure tool as it uses an additional exposure weight layer and results in an individual tree visibility attribute value. The DSM-DTM raster was used as elevation data and the tree crown binary raster as the input source. The model was run two times, with first the public open space and second the private open space binary raster as exposure weight lay-er. The viewshed parametrisation function, radius and sampling density are set to the same values as for the visual exposure modelling. This resulted in a public tree visibility value and a private tree visibility value for each tree located in in the Ulven study area. 


**FIGURE HERE**


**TABLE WITH PARAMETERS**


## Calculating measures for the 3-30-300 rule

Within this study we calculated the three indicators of the 3-30-300 rule for each district (grunnkrets) within the study area. Code is documented on GitHub (link to notebook).  

### Tree visibility count for residential buildings per district (rule 3)

As an indicator for rule 3, all residents should be able to see at least 3 trees from their home, we tested two different measures: (i) tree buffer count and (ii) viewshed count per district.

Tree crown buffer count
The buffer count is a measure of the amount of green space accessible to residents of a given area. The buffer count is calculated by counting the number of green spaces within a specified buffer distance of each residential address (Nieuwenhuijsen et al., 2022). This study calculated the number of tree canopies that intersect with a buffer distance of 15 me-ters of residential buildings. The output is a new attribute named “count_crown_buffer” as-signed to each district polygon.


**WORKFLOW HERE**


### Tree crown area percentage per district (rule 30)

The total crown area percentage is calculated per district as an indicator for rule 30, all neighbourhoods should have 30% tree canopy cover.

### Green area proximity for residential buildings per district (rule 300)

We calculated the percentage of residential buildings per district that are located within a 300 m distance of green space as an indicator for rule 300. First, the distance from each residential building to a green space is calculated in meters. This value is added to the green_area_proximity attribute in the residential buildings’ dataset. Then, we count the number of residential houses per district that are located within 300m of green areas. The count and percentage are added as attributes to the district dataset, n_green_space_buildings and proc_green_space_buildings. 

