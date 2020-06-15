#!/bin/sh

# Copy  files to 'info-mapper/src/assets/app' folder.
# Brute force way to provide content to InfoMapper and version control.
# Folder for this script is similar to:
#   C:/Users/user/cdss-dev/StateMod-Web/git-repos/cdss-app-statemod-web/webroot/datasets/colorado/2015/web

# Supporting functions, alphabetized.

check_BaselineSimulation_Folder() {
  # Make sure that the receiving folder exists
  folder=${appFolder}/data-maps/BaselineSimulation
  if [ ! -d "${folder}" ]; then
    echo "Creating folder ${folder}"
    mkdir -p ${folder}
  fi
}

check_HistoricalSimulation_Folder() {
  # Make sure that the receiving folder exists
  folder=${appFolder}/data-maps/HistoricalSimulation
  if [ ! -d "${folder}" ]; then
    echo "Creating folder ${folder}"
    mkdir -p ${folder}
  fi
}

check_SupportingData_Folder() {
  # Make sure that the receiving folder exists
  folder=${appFolder}/data-maps/SupportingData
  if [ ! -d "${folder}" ]; then
    echo "Creating folder ${folder}"
    mkdir -p ${folder}
  fi
}

copy_BaselineSimulation_cm2015B() {
  check_BaselineSimulation_Folder

  # Copy baseline simulation map folder and files
  cp -rv ${scriptFolder}/data-maps/BaselineSimulation/cm2015B ${folder}
}

copy_HistoricalSimulation_cm2015H2() {
  check_HistoricalSimulation_Folder

  # Copy historical simulation map folder and files
  cp -rv ${scriptFolder}/data-maps/HistoricalSimulation/cm2015H2 ${folder}
}

copy_MainConfig() {
  # Make sure that folders exist
  if [ ! -d "${appFolder}" ]; then
    echo "Creating folder ${appFolder}"
    mkdir -p ${appFolder}
  fi

  # Main application configuration file
  cp -v ${scriptFolder}/app-config.json ${appFolder}
  # Content pages
  cp -rv ${scriptFolder}/content-pages ${appFolder}
  # Images
  cp -rv ${scriptFolder}/img ${appFolder}
}

copy_SupportingData_CoDwrWaterDistricts() {
  check_SupportingData_Folder

  # Copy stream reaches map folder and files
  cp -rv ${scriptFolder}/data-maps/SupportingData/CoDwrWaterDistricts ${folder}
}

copy_SupportingData_InstreamFlowReaches() {
  check_SupportingData_Folder

  # Copy instream flow reaches map folder and files
  cp -rv ${scriptFolder}/data-maps/SupportingData/InstreamFlowReaches ${folder}
}

copy_SupportingData_IrrigatedLands() {
  check_SupportingData_Folder

  # Copy stream reaches map folder and files
  cp -rv ${scriptFolder}/data-maps/SupportingData/IrrigatedLands ${folder}
}

copy_SupportingData_StreamReaches() {
  check_SupportingData_Folder

  # Copy stream reaches map folder and files
  cp -rv ${scriptFolder}/data-maps/SupportingData/StreamReaches ${folder}
}

runInteractive() {
  while true; do
    echo ""
    echo "Enter an option to update application data."
    echo ""
    echo "Main Configuration:    c.  Copy main configuration files."
    echo "                       q.  Quit"
    echo ""
    echo "Supporting Data:      sw.  Copy CoDwrWaterDistricts files."
    echo "                      ss.  Copy StreamReaches files."
    echo "                      si.  Copy InstreamFlowReaches files."
    echo "                      sl.  Copy IrrigatedLands files."
    echo ""
    echo "Historical Simulation  h.  Copy cm2015H2 files."
    echo ""
    echo "Baseline Simulation    b.  Copy cm2015B files."
    echo ""
    read -p "Enter command: " answer

    # List in order of application

    if [ "${answer}" = "c" ]; then
      copy_MainConfig
    elif [ "${answer}" = "q" ]; then
      break

    # Supporting Data

    elif [ "${answer}" = "sw" ]; then
      copy_SupportingData_CoDwrWaterDistricts
    elif [ "${answer}" = "si" ]; then
      copy_SupportingData_InstreamFlowReaches
    elif [ "${answer}" = "sl" ]; then
      copy_SupportingData_IrrigatedLands
    elif [ "${answer}" = "ss" ]; then
      copy_SupportingData_StreamReaches

    # Historical Simulation

    elif [ "${answer}" = "h" ]; then
      copy_HistoricalSimulation_cm2015H2

    # Baseline Simulation

    elif [ "${answer}" = "b" ]; then
      copy_BaselineSimulation_cm2015B
    fi
  done
  return 0
}

# Entry point into script.

scriptFolder=$(cd $(dirname "$0") && pwd)
datasetVersionFolder=$(dirname $scriptFolder)
datasetFolder=$(dirname $datasetVersionFolder)
datasetsFolder=$(dirname $datasetFolder)
webrootFolder=$(dirname $datasetsFolder)
repoFolder=$(dirname $webrootFolder)
gitReposFolder=$(dirname $repoFolder)
infoMapperRepoFolder=${gitReposFolder}/owf-app-info-mapper-ng
infoMapperFolder=${infoMapperRepoFolder}/info-mapper
appFolder=${infoMapperFolder}/src/assets/app

echo "Folders for application:"
echo "scriptFolder=${scriptFolder}"
echo "datasetVersionFolder=${datasetVersionFolder}"
echo "datasetFolder=${datasetFolder}"
echo "datasetsFolder=${datasetsFolder}"
echo "webrootFolder=${webrootFolder}"
echo "repoFolder=${repoFolder}"
echo "gitReposFolder=${gitReposFolder}"
echo "infoMapperRepoFolder=${infoMapperRepoFolder}"
echo "infoMapperFolder=${infoMapperRepoFolder}"
echo "appFolder=${appFolder}"

# Run interactively. with script exit from that function
runInteractive
