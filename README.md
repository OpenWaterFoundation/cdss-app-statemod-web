# cdss-app-statemod-web #

This repository contains the StateMod dataset web publishing tools.
The following are the published locations of the website:

* [Upper Colorado Water Allocation Model](http://opencdss.openwaterfoundation.org/datasets/colorado/2015/) - currently hosted at Open Water Foundation

Automated workflows are provided to download datasets and software, run StateMod,
process input and output files, and publish a web application to view the datasets.

* [Repository Contents](#repository-contents)
* [Development Environment Folder Structure](#development-environment-folder-structure)
* [Getting Started](#getting-started)
* [Workflow Summary](#workflow-summary)
	+ [Download Datasets](#download-datasets)
	+ [Run StateMod](#run-statemod)
	+ [Split Model Files](#split-model-files)
	+ [Process Spatial Data](##process-spatial-data)
	+ [Upload to Cloud](#upload-to-cloud)
* [License](#license)
* [Maintainers](#maintainers)

-----

## Repository Contents ##

The following are the main folders and files in this repository, listed alphabetically.
The folders for the Colorado dataset are expanded as an illustration.

* "Working files" means folders that are used to prepare data.
* The final dataset files are written to `StateCU` and `StateMod` folders,
which are used to run the software.
* `README.md` files are used in many folders to explain the contents of folders.
* Lowercase folders are specific to the web publishing tools.
MixedCase folders are standardize for modeling files.

```
cdss-app-statemod-web/        This repository.
  .git/                       Git repository folder (DO NOT MODIFY THIS except with Git tools).
  .gitattributes              Git configuration file for repository.
  .gitignore                  Git configuration file for repository.
  README.md                   This file.
  webroot/                    Folder that is equivalent to the root folder of the website where datasets will be published.
    datasets/                 Folder for datasets.
      colorado/               Folder for Upper Colorado datasets.
        2015/                 Folder for version of Colorado dataset, indicated by year of datase release.
                              More specific dates may be used.
          bin/                Executable programs, including StateMod that is compatible with the dataset.
          ClimateCU/          Working files for StateCU climate data.
          Crops/              Working files for StateCU crop data.
          Diversions/         Working files for StateMod diversion data.
          DiversionsCU/       Working files for StateCU diversion data.
          DocsCU/             Documentation for StateCU dataset.
          DocsSW/             Documentation for StateMod dataset.
          downloads/          Folder for downloads, which are then copied to other folders.
          Instream/           Working files for StateMod instream flow data.
          LocationCU/         Working files for StateCU location data.
          Network/            Working files for StateMod network data.
          Reservoirs/         Working files for StateMod reservoir data.
          scripts/            Windows batch files and Linux scripts to automate processing.
          StateCU/            Folder for complete StateCU dataset, used to run the software.
          StateMod/           Folder for complete StateMod dataset, used to run the software.
          StreamSW/           Working files for StateMod streamflow data.
          web/                Folder to collect files used for web dataset.
          workflow/           Folders containing workflow processing steps to run modeling software
                              and process data for publishing.
      gunnison/
      northplatte/
      sanjuan/
      southplatte/
      white/
      yampa/
```

## Development Environment Folder Structure ##

The following are recommended folders for the development environment.

```
C:\Users\user\                               Windows user home folder (typical development environment).
/home/user/                                  Linux user home folder (not tested).
/cygdrive/C/Users/user                       Cygdrive home folder (not tested).
  cdss-dev/                                  Projects that are part of Colorado's Decision Support Systems.
    StateMod-Web/                            StateMod web publishing product folder.
      ==================== Above this names are recommendation, below are required ==================
      git-repos/                             Git repositories for StateMod web publishing tool.
        cdss-app-statemod-web/               See repository dependency list above.
        owf-app-info-mapper-ng/              Open Water Foundation InfoMapper web application,
                                             which provides the web interface.

```

## Getting Started ##

The following explains how to get started with StateMod Web tools.

1. **Clone this repository**.  The folder structure described above is recommended.
2. **Clone InfoMapper repository**.  Run the `build-util/git-clone-prod.sh` script to clone.
	1. In the `owf-app-info-mapper-ng/info-mapper` folder, run `npm install`.
	2. Do not run `npm audit fix`.
3. **Install software if not already installed**.
The following software are neeeded to run all workflow steps.
	* Note:  StateMod software will automatically be downloaded by the workflow process.
	* [TSTool](http://opencdss.state.co.us/tstool/) - download the latest development release
	* [GeoProcessor](http://software.openwaterfoundation.org/geoprocessor/) - download the latest development release
		+ QGIS - download version compatible with GeoProcessor, as noted in the above
		GeoProcessor installation instructions
	* [StateDMI](http://opencdss.state.co.us/statedmi/) - download the latest development release
4. **Run the workflow below to process data:**
	* Run the workflow steps (see below) for the `colorado/2015` dataset.
	* Run the `web/copy-to-info-mapper.sh` script and copy files to the InfoMapper application files.
	This step is needed to ensure separation of InfoMapper repository files from this repository's files.
5. **Run InfoMapper**:
	* In the `owf-app-info-mapper-ng/info-mapper` folder, run `ng serve --open`.
	* View the website in a local browser as [http://localhost:4200/](http://localhost:4200/).

## Workflow Summary ##

The following summarizes main workflow steps that need to be run in the `workflow/` folders.
Currently the web publishing tool (this repository) must be cloned from GitHub and
the workflow run within the repository working files.

The workflow files are specific to a dataset, for example `webroot/datasets/colorado/cm2015/workflow/`
and can be duplicated similarly for each basin and dataset version.

### Download Datasets ###

The `workflow/01-download-dataset` folder for each dataset contains a TSTool
command file that automates download of the following, for the dataset:

* StateCU CDSS dataset - saved to `StateCU` folder
* StateMod CDSS dataset - saved to `StateMod` folder
* StateMod software executable that is compatible with the dataset - saved to `bin` folder

The resulting folders and files are ignored from the Git repository since they are dynamic.

Some datasets require manual steps, as indicated by comments in the TSTool command file
(for example North Platte WinZip installer cannot be run on the command line).
These steps may be fully automated in the future and are indicated in
[repository issues](https://github.com/OpenWaterFoundation/cdss-app-statemod-web/issues).

### Run StateMod ###

The `workflow/02-run-models` folder for each dataset contains a `run-statemod-cmd` Windows script
that runs the StateMod model in the proper sequence.
Run the script from a Windows command prompt window.
The default run mode is to show an interactive text menu to guide the user through the run process.

### Split Model Files ###

The `workflow/03-split-model-files` folder for each dataset contains
TSTool and StateDMI command files to split large model input and output files
into separate files for each model node.

The dataset published to the cloud needs to be accessible by the web application
in a way that results in good performance.
The technology solution involves publishing data on a static website,
meaning that data are accessed as text files,
not a server that performs database queries.
To accomplish this requires splitting the large model input and output files
into small files associated with each model mode.
These files can then be accessed individually as needed based on the user's
interactions with the web application.

TSTool software and command files are used to split the large model input
and output files into individual files, saving the
results to the `web` folder.

### Process Spatial Data ###

The `workflow/04-process-spatial-data` folder for each dataset contains
TSTool and GeoProcessor command files to create spatial data layers and
map configurations for the web application.

The web application uses open data formats, in particular GeoJSON files.
GeoJSON files have a number of advantages over shapefiles:

* Single file for layer whereas shapefiles have multiple files.
* Text format so transparent to review and troubleshoot.
* No limit on attribute names (shapefile have 10-character limit).
* Only geographic coordinate system is used, so data preparation is simplified.

### Publish to Cloud ###

The `workflow/05-upload-to-cloud` folder for each dataset contains
the `copy-to-owf-amazon-s3.sh` script to package and upload the InfoMapper distribution files
to the Open Water Foundation's Amazon S3 bucket.
A similar script will be enabled to publish files to the State of Colorado's
OpenCDSS website, with similar URL and folder structure..

Each dataset is configured as its own web application using the
[InfoMapper](https://github.com/OpenWaterFoundation/owf-app-info-mapper-ng)
software developed by the Open Water Foundation.
This requires assembling files and uploading to the website in a form that
is necessary for the web application.

## License ##

The InfoMapper software is licensed under GPL v3+. See the [LICENSE.md](LICENSE.md) file.

Workflows and documentation are licensed under
[Creative Commons Attribution International 4.0 (CC BY 4.0) license](https://creativecommons.org/licenses/by/4.0/).

## Maintainers ##

This product was developed by the [Open Water Foundation](http://openwaterfoundation.org/)
for the [Colorado Water Conservation Board](https://cwcb.colorado.gov/)
and is maintined as part of
[OpenCDSS](http://opencdss.state.co.us/opencdss/).
