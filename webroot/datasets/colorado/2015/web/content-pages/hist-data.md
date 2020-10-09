# Upper Colorado Water Allocation Model - Historical Simulation Data Files

Data for this dataset can be accessed several ways.

* CDSS Download Page
* Save from Data Visualizations
* Access Uploaded Data Files

----------------

## CDSS Download Page ##

The original model dataset files were processed and uploaded to this website.
The original files can e downloaded from:

* [CDSS Surface Water (StateMod) web page](https://www.colorado.gov/pacific/cdss/surface-water-statemod)

## Save from Data Visualizations ##

This website allows data to be viewed in tabular form and data reports.
The ***Save*** button on popup windows can be used to save data, with the following considerations:

* The data format for saved files is typically comma-separated-value (`csv`) for data and
text (`txt`) for text files, to allow for general use.
* These views show data that is formatted for a web browser,
including setting the precision of numbers, and handling missing data values.
Consequently, the values that are visible may be slightly different in format from the originally uploaded files.
* The name for each download file defaults to an appropriate value depending on the file being downloaded.

## Access Uploaded Data Files ##

The original dataset files consist of large text files that are input to the model,
and large binary (non-text) output files.
These files were split into separate files for each model node
so that the files can be downloaded and viewed in the website.
Large files cannot be easily processed in a web application.
The original files are available on the website and can be accessed directly.
For example, enter a URL as shown in the following table.
Depending on the file extension, the file may automatically download, or may display in the browser.
The pattern for the URL is consistent; therefore, the model node identifiers shown on the map
(and layer data table) can be used in the URL to select stations.

| **Data Resource** | **Example URL** |
| -- | -- |
| Map layer. | |
| Diversion station input time series as split StateMod file (**works and is desirable because don't need to hard-code the server and leading path so will work with different versions**). | [assets/app/data-ts/input/diversions/3900547.StateMod.DiversionDemand.Month.B.stm](assets/app/data-ts/input/diversions/3900547.StateMod.DiversionDemand.Month.B.stm) |
| Diversion station input time series as split StateMod file (**does not work**). | [data-ts/input/diversions/3900547.StateMod.DiversionDemand.Month.B.stm](data-ts/input/diversions/3900547.StateMod.DiversionDemand.Month.B.stm) |
| Diversion station input time series as split StateMod file (**does not work - maybe could achieve with redirect of some type?**). | [http://opencdss.openwaterfoundation.org/datasets/colorado/2015/data-ts/input/diversions/3900547.StateMod.DiversionDemand.Month.B.stm](http://opencdss.openwaterfoundation.org/datasets/colorado/2015/data-ts/input/diversions/3900547.StateMod.DiversionDemand.Month.B.stm)
| Diversion station input time series as split StateMod file (**works because matches full URL**). | [http://opencdss.openwaterfoundation.org/datasets/colorado/2015/assets/app/data-ts/input/diversions/3900547.StateMod.DiversionDemand.Month.B.stm](http://opencdss.openwaterfoundation.org/datasets/colorado/2015/assets/app/data-ts/input/diversions/3900547.StateMod.DiversionDemand.Month.B.stm)
