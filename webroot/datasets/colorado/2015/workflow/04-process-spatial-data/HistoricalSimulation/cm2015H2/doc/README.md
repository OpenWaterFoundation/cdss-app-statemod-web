# HistoricalSimulation / cm2015H2 / doc #

This folder contains files for the ***Historical Simulation / cm2015H2*** map.

* [Introduction](#introduction)
* [Update Frequency](#update-frequency)
* [Datasets](#datasets)
* [Files](#files)
* [Workflow](#workflow)

-----------------------------

## Introduction ##

The ***Historical Simulation / cm2015H2*** map presents the model nodes for the `cm2015H2`
model run, providing access to time series for the model nodes.

## Update Frequency ##

This product is updated infrequently,
based on changes in CDSS model datasets.

## Datasets ##

The following are datasets for the map.

| **Dataset** | **Description** | **Data Source** |
| -- | -- | -- |
| Source Water Route Framework (SWRF)  | Stream linework with each stream corresponding to a single line. | See the Supporting Data / Stream Reaches. |

## Files ##

The following files and folders are used.

| **File/Folder** | **Description** | **Repo Ignore** |
| -- | -- | -- |
| `03-create-map-cm2015H2.gp` | GeoProcessor command file to create map. | |
| `doc/` | This `README.md` and related files. | |
| `downloads/` | Downloaded files. | Yes - for downloaded files. |
| `layers/` | Layers and supporting files used in the map. | Yes - for generated files. |
| `cm2015H2.json` | Map configuration file. | Yes |

## Workflow ##

The following describes the workflow steps, which should be run in the order shown to fully regenerate the information products.

| **Command File/Script** | **Software** | **Description** |
| -- | -- | -- |
| `03-create-map-cm2015H2.gp` | GeoProcessor | Create the map configuration file and copy map and layer files to the distribution folder. |
