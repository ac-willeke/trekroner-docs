=================================
QField Tree Registration App (NO)
=================================

.. note:: **Last ned** QField Treregisteringsappen og instruksen fra `GitHub <https://github.com/NINAnor/QGIS-treregistrering>`_.

QField Treregisteringsapp er NINAs feltregistreringsverktøy for treregistrering 
for å utfylle dataene fra laserbasert trekronekartlegging med utvalgte variable 
som behøves for modellering i i-Tree Eco.  Feltbaserte metoder er gunstige for 
variabler som ikke kan beregnes fra LiDAR- eller GIS-analyser, spesielt for 
treslag, treets helsetilstand og treets egenskaper som habitat for andre arter.
QField Treregisteringsapp ble opprinnelig utviklet av Nollet et al. (2021) for 
anvendelse i Oslo. Det ble testet nye kriterier for bedre dokumentasjon av 
VAT-metoden, bl.a. for treets habitat-verdi. Denne oppdaterte versjonen har en 
mal som kan brukes til å kartlegge nye områder. Appen inkluderer registrering 
kriterier fra metoden for Verdsetting av Trær (VAT), med testing av kriterier 
som var vektlagt i Trekroner prosjektet, som treets betydning som habitat for 
andre arter. VAT metoden ventes standardisert av Standard Norge - QField app’en
kan oppgraderes til et fullstendig kriteriesett for VAT når standarden evt. 
publiseres. QField Treregisteringsappen ble testet i et pilotfeltbesøk i 
Sandvika i august 2023, og prosjektmalen er tilgjengelig 
på `GitHub <https://github.com/NINAnor/QGIS-treregistrering>`_.

App-instruksen viser QGIS-oppsettet på datamaskinen og gir veiledning i bruken 
av QField Treregisteringsappen i feltet. Kartleggingsprosessen involverer 
forberedelse av malen for det spesifikke feltområdet i QGIS, valg av et 
tilfeldig utvalg av laserdetekterte trekroner for registrering i feltet, 
installasjon av QField-applikasjonen på nettbrettet eller telefonen, og åpning 
av prosjektet i QField-appen. Deretter kan du begynne å registrere trær i feltet 
og overføre dataene tilbake til datamaskinen din.

For å dra nytte av QField Treregisteringsappen, er kunnskap om QGIS, QField, 
GeoPackage-formatet, raster- og vektordata nødvendig. I tillegg forutsettes 
kjennskap til i-Tree Eco og VAT-protokollene. Denne instruksjonen bør brukes 
sammen med de offisielle feltveiledningene for i-Tree Eco og VAT
(i-Tree Eco v.6,  Nollet et al. 2021).

**Relevante hjelpemidler og dokumentasjon**

- `QField-instruks for QField Treregisteringsappen <https://github.com/NINAnor/QGIS-treregistrering/tree/main/QField_treregistreringsapp_v3>`_
- `QField-instruks fra Nollet et al. (2021) <https://brage.nina.no/nina-xmlui/handle/11250/2725332>`_
- `QField-dokumentasjon <https://docs.qfield.org/>`_
- `i-Tree Eco Field Guide <https://www.itreetools.org/documents/274/EcoV6.FieldManual.2021.10.06.pdf>`_
- `NINA Rapport xxxx <lenke/kommer/her>`_

.. xlsx-table:: **Tabell 1.** Attributtskjema for treregistrering i QField appen
    :file: tbl/QField_treregisterinsapp_attribute_design.xlsx
    :header-rows: 1

**Referanser**

- i-Tree Eco v.6 [WWW Document], n.d. URL https://www.itreetools.org/documents/274/EcoV6.FieldManual.2021.10.06.pdf (accessed 10.10.23).
- Nollet, A., Barton, D.N., Cimburova, Z. & Often, A. 2021. Accounting for amenities and regulating ecosystem ser-vices of urban trees. Testing a combined field protocol for VAT19 and i-Tree Eco valuation methods. NINA Report 1948. Norwegian Institute for Nature Research.
