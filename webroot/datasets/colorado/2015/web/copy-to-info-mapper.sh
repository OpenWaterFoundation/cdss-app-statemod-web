#!/bin/sh

# Copy  files to 'infomapper/src/assets/app' folder.
# Brute force way to provide content to InfoMapper and version control.
# Folder for this script is similar to:
#   C:/Users/user/cdss-dev/StateMod-Web/git-repos/cdss-app-statemod-web/webroot/datasets/colorado/2015/web

# Supporting functions, alphabetized.

# Make sure that the receiving folder exists.
# - call before trying to copy to the folder
# - set ${folder} to the receiving folder
checkDataMapsBaselineSimulationFolder() {
  folder=${appFolder}/data-maps/BaselineSimulation
  if [ ! -d "${folder}" ]; then
    echo "Creating folder ${folder}"
    mkdir -p ${folder}
  fi
}

# Make sure that the receiving folder exists.
# - call before trying to copy to the folder
# - set ${folder} to the receiving folder
checkDataMapsFolder() {
  folder=${appFolder}/data-maps
  if [ ! -d "${folder}" ]; then
    echo "Creating folder ${folder}"
    mkdir -p ${folder}
  fi
}

# Make sure that the receiving folder exists.
# - call before trying to copy to the folder
# - set ${folder} to the receiving folder
checkDataMapsHistoricalSimulationFolder() {
  folder=${appFolder}/data-maps/HistoricalSimulation
  if [ ! -d "${folder}" ]; then
    echo "Creating folder ${folder}"
    mkdir -p ${folder}
  fi
}

# Make sure that the receiving folder exists.
# - call before trying to copy to the folder
# - set ${folder} to the receiving folder
checkDataMapsSupportingDataFolder() {
  folder=${appFolder}/data-maps/SupportingData
  if [ ! -d "${folder}" ]; then
    echo "Creating folder ${folder}"
    mkdir -p ${folder}
  fi
}

# Make sure that the receiving folder exists.
# - call before trying to copy to the folder
# - set ${folder} to the receiving folder
checkDataTsInputFolder() {
  folder=${appFolder}/data-ts/input
  if [ ! -d "${folder}" ]; then
    echo "Creating folder ${folder}"
    mkdir -p ${folder}
  fi
}

# Make sure that the receiving folder exists.
# - call before trying to copy to the folder
# - set ${folder} to the receiving folder
checkDataTsOutputFolder() {
  folder=${appFolder}/data-ts/output
  if [ ! -d "${folder}" ]; then
    echo "Creating folder ${folder}"
    mkdir -p ${folder}
  fi
}

# Copy main configuration files
# - application configuration
# - content-pages
# - img
# - system
copyMainConfig() {
  # Make sure that folders exist
  if [ ! -d "${appFolder}" ]; then
    echo "Creating folder ${appFolder}"
    mkdir -p ${appFolder}
  fi

  # Main application configuration file
  sourceFile="${scriptFolder}/app-config.json"
  if [ ! -f "${sourceFile}" ]; then
    echo "${function}, source file does not exist:  ${sourceFile}"
  else
    cp -v ${sourceFile} ${appFolder}
  fi

  # Content pages
  sourceFolder="${scriptFolder}/content-pages"
  if [ ! -d "${sourceFolder}" ]; then
    echo "${function}, source folder does not exist:  ${sourceFolder}"
  else
    cp -r${verboseOption} ${sourceFolder} ${appFolder}
  fi

  # Images
  sourceFolder="${scriptFolder}/img"
  if [ ! -d "${sourceFolder}" ]; then
    echo "${function}, source folder does not exist:  ${sourceFolder}"
  else
    cp -r${verboseOption} ${scriptFolder}/img ${appFolder}
  fi

  # System
  sourceFolder="${scriptFolder}/system"
  if [ ! -d "${sourceFolder}" ]; then
    echo "${function}, source folder does not exist:  ${sourceFolder}"
  else
    cp -r${verboseOption} ${scriptFolder}/system ${appFolder}
  fi

  # Output the following regardless of whether verbose or not.
  echo "Copied main configuration files."

  return 0
}

# Copy simulation input time series.
#  from:  ${scriptFolder}/data-ts/input/${dataFolder}
#    to:  ${folder}
#
# - first argument is the node type data folder, for example "culocations"
#
# Depends on global data:
#   ${scriptFolder} - typically "web", under which all InfoMapper application assets live
copySimulationInputTs() {
  dataFolder=$1
  function="copySimulationInputTs"

  if [ -z "${dataFolder}" ]; then
    echo "${function}, no data folder was specified."
    return 1
  fi

  checkDataTsInputFolder

  # Check to see if the data folder is recognized.
  if [ "${dataFolder}" = "culocations" ]; then
    # ok
    :
  elif [ "${dataFolder}" = "diversions" ]; then
    # ok
    :
  elif [ "${dataFolder}" = "instream" ]; then
    # ok
    :
  elif [ "${dataFolder}" = "reservoirs" ]; then
    # ok
    :
  elif [ "${dataFolder}" = "stream" ]; then
    # ok
    :
  else
    echo "${function}, unrecognized input data folder:  ${dataFolder}"
    return 1
  fi

  # Copy time series files

  sourceFolder="${scriptFolder}/data-ts/input/${dataFolder}"
  if [ ! -d "${sourceFolder}" ]; then
    echo "${function}, source folder does not exist:  ${sourceFolder}"
    return 1
  fi
  cp -r${verboseOption} ${sourceFolder} ${folder}
  exitCode=$?
  echo "Copied ${datasetName} ${dataFolder} input time series files."
  return $exitCode
}

# Copy simulation output time series.
#  from:  ${scriptFolder}/data-ts/HistoricalSimulation/${dataset}${modifier}
#    to:  ${folder}
#
# - first argument is the dataset name, for example "cm2015"
# - second argument is the output file extension, for example "b43" or "xdd"
#
# Depends on global data:
#   ${scriptFolder} - typically "web", under which all InfoMapper application assets live
copySimulationOutputTs() {
  dataset=$1
  outputExt=$2
  function="copySimulationOutputTs"

  if [ -z "${dataset}" ]; then
    echo "${function}, no dataset was specified."
    return 1
  fi
  if [ -z "${outputExt}" ]; then
    echo "${function}, no output extension was specified."
    return 1
  fi

  checkDataTsOutputFolder

  # Check to see if the data folder is recognized.
  if [ "${outputExt}" = "b43" ]; then
    # ok
    :
  elif [ "${outputExt}" = "b44" ]; then
    # ok
    :
  elif [ "${outputExt}" = "xdd" ]; then
    # ok
    :
  elif [ "${outputExt}" = "xre" ]; then
    # ok
    :
  elif [ "${outputExt}" = "xop" ]; then
    # ok
    :
  elif [ "${outputExt}" = "xsf" ]; then
    # ok
    :
  else
    echo "Unrecognized output extension:  ${outputExt}"
    return 1
  fi

  # Copy time series files

  sourceFolder="${scriptFolder}/data-ts/output/${outputExt}"
  if [ ! -d "${sourceFolder}" ]; then
    echo "Source folder does not exist:  ${sourceFolder}"
    return 1
  fi
  cp -r${verboseOption} ${sourceFolder} ${folder}
  exitCode=$?
  echo "Copied ${dataset} ${outputExt} output time series files."
  return $exitCode
}

# Copy simulation maps, for example,
#  from:  ${scriptFolder}/data-maps/HistoricalSimulation
#  from:  ${scriptFolder}/data-maps/BaselineSimulation
#    to:  ${folder}
#
# - first argument is the dataset, e.g., "cm2015"
# - second argument is the modifier, e.g., "H", "H2", or "B"
#
# Depends on global data:
#   ${scriptFolder} - typically "web", under which all InfoMapper application assets live
#   ${historicalModifier} - such as "H" or "H2"
#   ${baselineModifier} - such as "B"
copySimulationMaps() {
  dataset=$1
  modifier=$2
  function="copySimulationMaps"

  if [ -z "${dataset}" ]; then
    echo "${function}, no dataset was specified."
    return 1
  fi
  if [ -z "${modifier}" ]; then
    echo "${function}, no modifier was specified."
    return 1
  fi

  checkDataMapsFolder
  if [ "${modifier}" = "${historicalModifier}" ]; then
    # OK
    :
  elif [ "${modifier}" = "${baselineModifier}" ]; then
    # OK
    :
  else
    echo "Unrecognized modifier:  ${modifier}"
    return 1
  fi

  # Copy simulation map folder and files
  if [ "${modifier}" = "${historicalModifier}" ]; then
    simFolder="HistoricalSimulation"
  elif [ "${modifier}" = "${baselineModifier}" ]; then
    simFolder="BaselineSimulation"
  fi
  sourceFolder="${scriptFolder}/data-maps/${simFolder}"
  if [ ! -d "${sourceFolder}" ]; then
    echo "Source folder does not exist:  ${sourceFolder}"
    return 1
  fi
  cp -r${verboseOption} ${sourceFolder} ${folder}
  # Output the following regardless of whether verbose or not.
  echo "Copied ${dataset} ${modifier} ${simFolder} map and graph files."
  return $?
}

# Copy data-maps/SupportingData folder
# - first argument is the folder to copy
copyDataMapsSupportingData() {
  mapFolder=$1
  function="copyDataMapsSupportingData"

  if [ -z "${mapFolder}" ]; then
    echo "Requested SupportingData map folder was not specified."
    return 1
  fi
  checkDataMapsSupportingDataFolder

  # Copy stream reaches map folder and files
  sourceFolder="${scriptFolder}/data-maps/SupportingData/${mapFolder}"
  if [ ! -d "${sourceFolder}" ]; then
    echo "${function}, source folder does not exist:  ${sourceFolder}"
    return 1
  fi
  cp -r${verboseOption} ${sourceFolder} ${folder}
  exitCode=$?
  echo "Copied ${dataset} ${mapFolder} supporting map files."
  return $exitCode
}

runInteractive() {
  while true; do
    echo ""
    echo "Enter an option to update application data."
    echo ""
    echo "Main Configuration:       c.  Copy main InfoMapper configuration files."
    echo "                          q.  Quit"
    echo "                          v.  Toggle verbose mode (currently ${verboseOn}."
    echo ""
    echo "Supporting Data:         sw.  Copy CoDwrWaterDistricts map files."
    echo "                         ss.  Copy StreamReaches map files."
    echo "                         si.  Copy InstreamFlowReaches map files."
    echo "                         sl.  Copy IrrigatedLands map files."
    echo ""
    echo "Simulation maps:       hmap.  Copy ${datasetName}${historicalModifier} map and graph files."
    echo "                       bmap.  Copy ${datasetName}${baselineModifier} map and graph files."
    echo ""
    echo "Input time series        cu.  Copy ${datasetName} culocations ts files."
    echo "                        div.  Copy ${datasetName} diversion ts files."
    echo "                        isf.  Copy ${datasetName} instream ts files."
    echo "                        res.  Copy ${datasetName} reservoir ts files."
    echo "                        str.  Copy ${datasetName} stream ts files."
    echo ""
    echo "Output time series.    hb43.  Copy ${datasetName} b43 ts files."
    echo "                       hb44.  Copy ${datasetName} b44 ts files."
    echo "                       hxdd.  Copy ${datasetName} xdd ts files."
    echo "                       hxre.  Copy ${datasetName} xre ts files."
    echo ""
    read -p "Enter command: " answer

    # List in order of application

    if [ "${answer}" = "c" ]; then
      # Copy main configuration files
      copyMainConfig
    elif [ "${answer}" = "q" ]; then
      # Quit - break out of the loop
      break
    elif [ "${answer}" = "v" ]; then
      if [ "${verboseOn}" = "true" ]; then
        verboseOn="false"
        verboseOption=""
      else
        verboseOn="true"
        verboseOption="v"
      fi

    # Supporting Data

    elif [ "${answer}" = "sw" ]; then
      copyDataMapsSupportingData CoDwrWaterDistricts
    elif [ "${answer}" = "si" ]; then
      copyDataMapsSupportingData InstreamFlowReaches
    elif [ "${answer}" = "sl" ]; then
      copyDataMapsSupportingData IrrigatedLands
    elif [ "${answer}" = "ss" ]; then
      copyDataMapsSupportingData StreamReaches

    # Simulation maps
    # - the second parameter indicates whether historical or baseline

    elif [ "${answer}" = "hmap" ]; then
      copySimulationMaps cm2015 H2
    elif [ "${answer}" = "bmap" ]; then
      copySimulationMaps cm2015 B

    # Input time series

    elif [ "${answer}" = "cu" ]; then
      copySimulationInputTs culocations
    elif [ "${answer}" = "div" ]; then
      copySimulationInputTs diversions
    elif [ "${answer}" = "isf" ]; then
      copySimulationInputTs instream
    elif [ "${answer}" = "res" ]; then
      copySimulationInputTs reservoirs
    elif [ "${answer}" = "str" ]; then
      copySimulationInputTs stream

    # Simulation time series

    elif [ "${answer}" = "hb43" ]; then
      copySimulationOutputTs ${datasetName} b43
    elif [ "${answer}" = "hb44" ]; then
      copySimulationOutputTs ${datasetName} b44
    elif [ "${answer}" = "hxdd" ]; then
      copySimulationOutputTs ${datasetName} xdd
    elif [ "${answer}" = "hxre" ]; then
      copySimulationOutputTs ${datasetName} xre
    fi

  done
  return 0
}

# Entry point into script.

# Dataset information, which may vary by dataset
datasetName="cm2015"
historicalModifier="H2"
baselineModifier="B"

# By default verbose is off
verboseOn="false"
verboseOption=""

scriptFolder=$(cd $(dirname "$0") && pwd)
datasetVersionFolder=$(dirname $scriptFolder)
datasetFolder=$(dirname $datasetVersionFolder)
datasetsFolder=$(dirname $datasetFolder)
webrootFolder=$(dirname $datasetsFolder)
repoFolder=$(dirname $webrootFolder)
gitReposFolder=$(dirname $repoFolder)
infoMapperRepoFolder=${gitReposFolder}/owf-app-infomapper-ng
infoMapperFolder=${infoMapperRepoFolder}/infomapper
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
