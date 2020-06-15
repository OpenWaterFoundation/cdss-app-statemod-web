# SupportingData-IrrigatedLands/doc #

This folder contains files for the ***Supporting Data / Irrigated Lands*** map.

* [Introduction](#introduction)
* [Update Frequency](#update-frequency)
* [Datasets](#datasets)
* [Files](#files)
* [Workflow](#workflow)

-----------------------------

## Introduction ##

The ***Supporting Data / Irrigated Lands*** map indicates irrigated lands for 2015.

## Update Frequency ##

This product is updated infrequently, based on changes in CDSS irrigated lands.

## Datasets ##

The following are datasets for the map.

| **Dataset** | **Description** | **Data Source** |
| -- | -- | -- |
| CDSS Irrigated Lands (2015) | CDSS irrigated lands. | The data is originally from Division 5 layer downloaded from the [State of Colorado CDSS website](https://www.colorado.gov/pacific/cdss/gis-data-category).  It was then processed by OWF to split into water district extent and is available on the [CDSS Spatial Datasets for Colorado Water Districts and Divisions](http://data.openwaterfoundation.org/co/cdss-data-spatial-bybasin/) website.  **The OWF dataset is older and uses the original GeoJSON specification.  The workflow reads the old GeoJSON and writes in latest specification.** |

## Files ##

The following files and folders are used.

| **File/Folder** | **Description** | **Repo Ignore** |
| -- | -- | -- |
| `01-download-irrigated-lands.gp` | GeoProcessor command file to download irrigated lands dataset. | |
| `03-create-irrigated-lands-map.gp` | GeoProcessor command file to create map. | |
| `irrigated-lands-map.json` | Map configuration file. | Yes |
| `data/` | Data files used as input and stored in the repository. | |
| `doc/` | This `README.md` and related files. | |
| `downloads/` | Downloaded files. | Yes - for downloaded files. |
| `layers/` | Layers and supporting files used in the map. | Yes - for generated files. |

## Workflow ##

The following describes the workflow steps, which should be run in the order shown to fully regenerate the information products.

| **Command File/Script** | **Software** | **Description** |
| -- | -- | -- |
| `01-download-irrigated-lands.gp` | GeoProcessor | Download irrigated lands layers from OWF CDSS data website and save to `layers` folder. |
| `03-create-irrigated-lands-map.gp` | GeoProcessor | Create a GeoMapProject file for use with the InfoMapper. |
