# cdss-app-statemod-web #

This repository contains the StateMod dataset web publishing tools.
Automated workflows are provided to download datasets and software, run StateMod,
process input and output files, and publish a web application to view the datasets.

* [Repository Contents](#repository-contents)
* [Development Environment Folder Structure](#development-environment-folder-structure)
* [Workflow Summary](#workflow-summary)
	+ [Download Datasets](#download-datasets)
	+ [Run StateMod](#run-statemod)
	+ [Process Data](#process-data)
	+ [Publish to Cloud](#publish-to-cloud)
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

```

## Workflow Summary ##

The following summarized main workflow steps.
Currently the web publishing tool (this repository) must be cloned from GitHub and
the workflow run within the repository files.

### Download Datasets ###

The `workflow/01-download-dataset` folder for each dataset contains a TSTool
command file that downloads the basin's StateCU and StateMod datasets,
and the StateMod software executable that is compatible with the dataset.
The resulting folders and files are ignored from the Git repository since they are dynamic.

Some datasets require manual steps, as indicated by comments in the TSTool command file.
These steps may be fully automated in the future.

### Run StateMod ###

The following is a summary on running StateMod for the dataset.
This follows standard modeling conventions.

Need to fill out...

### Process Data ###

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

Need to fill out more detail...

### Publish to Cloud ###

Each dataset is configured as its own web application using the
[InfoMapper](https://github.com/OpenWaterFoundation/owf-app-info-mapper-ng)
software developed by the Open Water Foundation.
This requires assembling files and uploading to the website in a form that
is necessary for the web application.

Need to fill out...

## License ##

Copyright Colorado Department of Natural Resources.

The software is licensed under GPL v3+. See the [LICENSE.md](LICENSE.md) file.

Workflows and documentation are licensed under
[Creative Commons Attribution International 4.0 (CC BY 4.0) license](https://creativecommons.org/licenses/by/4.0/).

## Maintainers ##

This product was developed by the [Open Water Foundation](http://openwaterfoundation.org/)
for the [Colorado Water Conservation Board](https://cwcb.colorado.gov/)
and is maintined as part of
[OpenCDSS](http://opencdss.state.co.us/opencdss/).
