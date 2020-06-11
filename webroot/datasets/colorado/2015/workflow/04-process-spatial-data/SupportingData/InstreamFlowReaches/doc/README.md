# InstreamFlow/doc #

This folder contains files for the ***Supporting Data / Instream Flow Reaches*** map.

* [Introduction](#introduction)
* [Update Frequency](#update-frequency)
* [Datasets](#datasets)
* [Files](#files)
* [Workflow](#workflow)

-----------------------------

## Introduction ##

The ***Supporting Data / Instream Flow Reaches*** map illustrates the locations of instream flow reaches in the basin,
as lines that generally follow the river/stream center line.
The instream reaches layer and HydroBase data are used to define StateMod intream flow station data.

## Update Frequency ##

This product is updated multiple times a year,
based on CWCB instream flow water right appropriations.

## Datasets ##

The following are datasets for the map.

| **Dataset** | **Description** | **Data Source** |
| -- | -- | -- |
| Intream Flow Reaches | Stream linework with each instream flow right (reach) corresponding to a single line.  The CWCB maintains this dataset. | The data is originally from a statewide layer downloaded from the [State of Colorado CDSS website](https://www.colorado.gov/pacific/cdss/gis-data-category).  It was then processed by OWF to split into water district layer and is available on the [CDSS Spatial Datasets for Colorado Water Districts and Divisions](http://data.openwaterfoundation.org/co/cdss-data-spatial-bybasin/) website.  **The OWF dataset is older and uses the original GeoJSON specification.  The workflow reads the old GeoJSON and writes in latest specification.** |
| Intream Flow Terminia | Upper and lower termini of instream flow reaches.  The CWCB maintains this dataset. | The data is originally from a statewide layer downloaded from the [State of Colorado CDSS website](https://www.colorado.gov/pacific/cdss/gis-data-category).  It was then processed by OWF to split into water district layer and is available on the [CDSS Spatial Datasets for Colorado Water Districts and Divisions](http://data.openwaterfoundation.org/co/cdss-data-spatial-bybasin/) website.  **The OWF dataset is older and uses the original GeoJSON specification.  The workflow reads the old GeoJSON and writes in latest specification.** |

## Files ##

The following files and folders are used.

| **File/Folder** | **Description** | **Repo Ignore** |
| -- | -- | -- |
| `01a-download-instream-reaches.gp` | GeoProcessor command file to download reach data. | |
| `01b-download-instream-termini.gp` | GeoProcessor command file to download termini data. | |
| `03-create-map-instream-reaches.gp` | GeoProcessor command file to create map. | |
| `doc/` | This `README.md` and related files. | |
| `downloads/` | Downloaded files. | Yes - for downloaded files. |
| `layers/` | Layers and supporting files used in the map. | Yes - for generated files. |
| `instream-reaches.json` | Map configuration file. | Yes |

## Workflow ##

The following describes the workflow steps, which should be run in the order shown to fully regenerate the information products.

| **Command File/Script** | **Software** | **Description** |
| -- | -- | -- |
| `01a-download-instream-reaches.gp` | GeoProcessor | Download the instream flow reaches from OWF data website and rewrite to ensure latest GeoJSON format. |
| `01b-download-instream-termini.gp` | GeoProcessor | Download the instream flow termini from OWF data website and rewrite to ensure latest GeoJSON format. |
| `03-create-map-instream-reaches.gp` | GeoProcessor | Create the map configuration file and copy map and layer files to the distribution folder. |
