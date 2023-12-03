---
title: "Kristiansand sammendragsstatistikk"
author: "David Barton, Bart Immerzeel og Willeke A'Campo"
date: "13. november 2023"
output:
  html_document: default
  pdf_document:  default
sansfont: Arial
params:
  region_str:
    label: "Kommune"
    value: Kristiansand
    input: select
    choices: ["Bærum", "Bodø", "Kristiansand", "Oslo"]
  region_var:
    label: "Kommune variabel"
    value: kristiansand
    input: select
    choices: ["baerum", "bodo", "kristiansand", "oslo"]
  data: 
    label: "Input dataset:"
    value: kristiansand_registrerte_traer.csv
    input: file
  agol:
    label: Bytraeratlas link (AGOL)
    tag: ['baerum', 'bodo', 'kristiansand', 'oslo']
    value: 6e047c5432e64b3f9abb1592d7907ff6
    input: select
    choices: ['bærum', 
    '5191adc2c4b34658aea227c9853c6ebb', 
    '6e047c5432e64b3f9abb1592d7907ff6', 
    'oslo']
---











### Registrerte trær i Bodø's byggesonen

Dette dokumentet viser sammendragstatistikken for registrerte trær innenfor Bodø's byggesone. Tilknyttede kartprodukter er synlige i bytræratlaset: [Bytræratlas Bodø](https://experience.arcgis.com/experience/5191adc2c4b34658aea227c9853c6ebb/)

| Gruppe                 | Beskrivelse                                            | Antall             |
|------------------|------------------------------------|------------------|
| Totalt registerte trær | Totalt antall registrerte trær i Bodø | 6184       |
| i-Tree Eco             | Totalt antall trær brukt i i-Tree Eco                  | 6131 |
| Sone 1                 | Trær i forurensnings sone 1 (grønn)                    | 5813    |
| Sone 2                 | Trær i forurensnings sone 2 (gull)                     | 371    |
| Sone 3                 | Trær i forurensnings sone 3 (rød)                      | 0    |
| Totalt trebestand      | Totalt antall trær i bestanden (basert på laserdata)   | 103738     |

<br>

### Treslagsfordeling i Bodø


![plot of chunk SPECIES PROBABILITY](_static/fig_kristiansand/SPECIES PROBABILITY-1.png)

<br>

### Tre egenskaper

------------------------------------------------------------------------

![plot of chunk TREE ATTRIBUTES](figure/TREE ATTRIBUTES-1.png)![plot of chunk TREE ATTRIBUTES](figure/TREE ATTRIBUTES-2.png)![plot of chunk TREE ATTRIBUTES](figure/TREE ATTRIBUTES-3.png)

<br>

### Regulerende økosystemtjenester

------------------------------------------------------------------------




![plot of chunk KARBON LAGRING](figure/KARBON LAGRING-1.png)

<font size="0.8" face="Arial">\*Treslag med gjennomsnittlig karbonlagring \< 100 kg vises ikke i plottet. </font>

![plot of chunk KARBON BINDING](figure/KARBON BINDING-1.png)

<font size="0.8" face="Arial">\*Treslag med årlig karbonbinding \< 5 kg/år vises ikke i plottet. </font>

![plot of chunk CARBON AVOIDED](figure/CARBON AVOIDED-1.png)

<font size="0.8" face="Arial">\*Treslag med CO2-utslipp unngått \< 5 kg/år vises ikke i plottet. </font>

![plot of chunk OVERFLATEAVRENNING](figure/OVERFLATEAVRENNING-1.png)

<font size="0.8" face="Arial">\*Treslag med gjennomsnittlig reduksjon av overflateavrenning \< 0.1 m3/år vises ikke i plottet. </font>

![plot of chunk POLLUTION](figure/POLLUTION-1.png)

<font size="0.8" face="Arial">\*Treslag med gjennomsnittlig reduksjon av luftforurensing \< 25 g/år vises ikke i plottet. </font>

<br>

*Dette dokumentet er en del av prosjektet:*

**TREKRONER Prosjektet** \| Trærs betydning for klimatilpasning, karbonbinding, økosystemtjenester og biologisk mangfold.
