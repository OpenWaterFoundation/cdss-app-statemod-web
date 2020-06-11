#!/bin/sh

# Copy  files to 'info-mapper/src/assets/app' folder.
# Brute force way to provide content to InfoMapper and version control.
# Folder for this script is similar to:
#   C:/Users/user/cdss-dev/StateMod-Web/git-repos/cdss-app-statemod-web/webroot/datasets/colorado/2015/web

# Supporting functions, alphabetized.

checkSupportingDataFolder() {
  # Make sure that the receiving folder exists
  folder=${appFolder}/data-maps/SupportingData
  if [ ! -d "${folder}" ]; then
    echo "Creating folder ${folder}"
    mkdir -p ${folder}
  fi
}

copyInstreamFlowReaches() {
  checkSupportingDataFolder

  # Copy instream flow reaches map folder and files
  cp -rv ${scriptFolder}/data-maps/SupportingData/InstreamFlowReaches ${folder}
}

copyIrrigatedLands() {
  checkSupportingDataFolder

  # Copy stream reaches map folder and files
  cp -rv ${scriptFolder}/data-maps/SupportingData/IrrigatedLands ${folder}
}

copyMainConfig() {
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

copyStreamReaches() {
  checkSupportingDataFolder

  # Copy stream reaches map folder and files
  cp -rv ${scriptFolder}/data-maps/SupportingData/StreamReaches ${folder}
}

copyWaterDistricts() {
  checkSupportingDataFolder

  # Copy stream reaches map folder and files
  cp -rv ${scriptFolder}/data-maps/SupportingData/CoDwrWaterDistricts ${folder}
}

runInteractive() {
  while true; do
    echo ""
    echo "Enter an option to update application data."
    echo ""
    echo " c.  Copy main configuration files."
    echo "si.  Copy SupportingData/InstreamFlowReaches map files."
    echo "sl.  Copy SupportingData/IrrigatedLands map files."
    echo "ss.  Copy SupportingData/StreamReaches map files."
    echo "sw.  Copy SupportingData/CoDwrWaterDistricts map files."
    echo ""
    echo "q.  Quit"
    echo ""
    read -p "Enter command: " answer
    if [ "${answer}" = "c" ]; then
      copyMainConfig
    elif [ "${answer}" = "si" ]; then
      copyInstreamFlowReaches
    elif [ "${answer}" = "sl" ]; then
      copyIrrigatedLands
    elif [ "${answer}" = "ss" ]; then
      copyStreamReaches
    elif [ "${answer}" = "sw" ]; then
      copyWaterDistricts
    elif [ "${answer}" = "q" ]; then
      break
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
