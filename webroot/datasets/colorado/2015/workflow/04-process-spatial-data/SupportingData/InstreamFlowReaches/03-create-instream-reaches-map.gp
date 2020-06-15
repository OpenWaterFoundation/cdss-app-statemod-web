# Create a GeoMapProject file for instream flow reaches for the Upper Colorado Basin
# - read the previously downloaded layer file
# - output to the dist/info-mapper folder for use by the InfoMapper
# - layer view groups are added from 1st drawn (bottom) to last drawn (top)
#
# Define properties to control processing.
# - use relative paths so that the command file is portable
# - AssetsFolder is where map files exist for the InfoMapper tool
SetProperty(PropertyName="AppFolder",PropertyType="str",PropertyValue="../../../../web")
SetProperty(PropertyName="MapsFolder",PropertyType="str",PropertyValue="${AppFolder}/data-maps")
SetProperty(PropertyName="MapFolder",PropertyType="str",PropertyValue="${MapsFolder}/SupportingData/InstreamFlowReaches")
#
# Create a single map project and map for that project.
# - GeoMapProjectID:  InstreamReachesProject
# - GeoMapID:  InstreamReachesMap
CreateGeoMapProject(NewGeoMapProjectID="InstreamReachesProject",ProjectType="SingleMap",Name="Upper Colorado Instream Flow Reaches",Description="Upper Colorado Instream Flow Reaches",Properties="author:'Open Water Foundation',specificationVersion:'1.0.0'")
CreateGeoMap(NewGeoMapID="InstreamReachesMap",Name="Upper Colorado Instream Flow Reaches",Description="Upper Colorado Instream Flow Reaches",CRS="EPSG:4326",Properties="extentInitial:'ZoomLevel:-107.9819,39.6923,9'")
AddGeoMapToGeoMapProject(GeoMapProjectID="InstreamReachesProject",GeoMapID="InstreamReachesMap")
# = = = = = = = = = =
# Background layers:  read layers and add a layer view group
# GeoLayerViewGroupID: BackgroundGroup
ReadRasterGeoLayerFromTileMapService(InputUrl="https://api.mapbox.com/styles/v1/masforce/cjs108qje09ld1fo68vh7t1he/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoibWFzZm9yY2UiLCJhIjoiY2pzMTA0bmR5MXAwdDN5bnIwOHN4djBncCJ9.ZH4CfPR8Q41H7zSpff803g",GeoLayerID="MapBoxTopographicLayer",Name="Topographic (MapBox)",Description="Topographic background map from MapBox.",Properties="attribution: 'MapBox',isBackground: true")
ReadRasterGeoLayerFromTileMapService(InputUrl="https://api.mapbox.com/styles/v1/mapbox/satellite-streets-v9/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1Ijoia3Jpc3RpbnN3YWltIiwiYSI6ImNpc3Rjcnl3bDAzYWMycHBlM2phbDJuMHoifQ.vrDCYwkTZsrA_0FffnzvBw",GeoLayerID="MapBoxSatelliteLayer",Name="Satellite (MapBox)",Description="Satellite background map from MapBox.",Properties="attribution: 'MapBox',isBackground: true")
ReadRasterGeoLayerFromTileMapService(InputUrl="https://api.mapbox.com/styles/v1/mapbox/streets-v10/tiles/256/{z}/{x}/{y}?access_token=pk.eyJ1Ijoia3Jpc3RpbnN3YWltIiwiYSI6ImNpc3Rjcnl3bDAzYWMycHBlM2phbDJuMHoifQ.vrDCYwkTZsrA_0FffnzvBw",GeoLayerID="MapBoxStreetsLayer",Name="Streets (MapBox)",Description="Streets background map from MapBox.",Properties="attribution: 'MapBox',isBackground: true")
ReadRasterGeoLayerFromTileMapService(InputUrl="https://api.mapbox.com/v4/mapbox.streets-satellite/{z}/{x}/{y}.png?access_token=pk.eyJ1Ijoia3Jpc3RpbnN3YWltIiwiYSI6ImNpc3Rjcnl3bDAzYWMycHBlM2phbDJuMHoifQ.vrDCYwkTZsrA_0FffnzvBw",GeoLayerID="MapBoxStreets&SatelliteLayer",Name="Streets & Satellite (MapBox)",Description="Streets and satellite background map from MapBox.",Properties="attribution: 'MapBox',isBackground: true")
AddGeoLayerViewGroupToGeoMap(GeoMapID="InstreamReachesMap",GeoLayerViewGroupID="BackgroundGroup",Name="Background Layers",Description="Background maps from image servers.",Properties="isBackground: true, selectedInitial: true")
AddGeoLayerViewToGeoMap(GeoLayerID="MapBoxTopographicLayer",GeoMapID="InstreamReachesMap",GeoLayerViewGroupID="BackgroundGroup",GeoLayerViewID="MapBoxTopographicLayerView",Name="Topographic (MapBox)",Description="Topographic Map",Properties="selectedInitial: true")
AddGeoLayerViewToGeoMap(GeoLayerID="MapBoxSatelliteLayer",GeoMapID="InstreamReachesMap",GeoLayerViewGroupID="BackgroundGroup",GeoLayerViewID="MapBoxSatelliteLayerView",Name="Satellite (MapBox)",Description="Satellite background map from MapBox.",Properties="selectedInital: false")
AddGeoLayerViewToGeoMap(GeoLayerID="MapBoxStreetsLayer",GeoMapID="InstreamReachesMap",GeoLayerViewGroupID="BackgroundGroup",GeoLayerViewID="MapBoxStreetsLayerView",Name="Streets (MapBox)",Description="Streets background map from MapBox.",Properties="selectedInitial: false")
AddGeoLayerViewToGeoMap(GeoLayerID="MapBoxStreets&SatelliteLayer",GeoMapID="InstreamReachesMap",GeoLayerViewGroupID="BackgroundGroup",GeoLayerViewID="MapBoxStreets&SatelliteLayerView",Name="Streets & Satellite (MapBox)",Description="Streets and satellite background map from MapBox.",Properties="selectedInitial: false")
# = = = = = = = = = =
# Instream flow reaches:  read layer and add to a layer view group.
# GeoLayerViewGroupID: InstreamReachesGroup
ReadGeoLayerFromGeoJSON(InputFile="layers/instream-reaches.geojson",GeoLayerID="InstreamReachesLayer",Name="Upper Colorado Instream Flow Reaches",Description="Upper Colorado Instream Flow Reaches")
AddGeoLayerViewGroupToGeoMap(GeoMapID="InstreamReachesMap",GeoLayerViewGroupID="InstreamReachesGroup",Name="Upper Colorado Instream Flow Reaches",Description="Upper Colorado Instream Flow Reaches",Properties="selectedInitial: true",InsertPosition="Top")
AddGeoLayerViewToGeoMap(GeoLayerID="InstreamReachesLayer",GeoMapID="InstreamReachesMap",GeoLayerViewGroupID="InstreamReachesGroup",GeoLayerViewID="InstreamReachesLayerView",Name="Upper Colorado Instream Flow Reaches",Description="Upper Colorado Instream Flow Reaches")
SetGeoLayerViewSingleSymbol(GeoMapID="InstreamReachesMap",GeoLayerViewGroupID="InstreamReachesGroup",GeoLayerViewID="InstreamReachesLayerView",Name="Upper Colorado Instream Flow Reaches",Description="Upper Colorado Instream Flow Reaches")
# = = = = = = = = = =
# Instream flow termini:  read layer and add to a layer view group.
# GeoLayerViewGroupID: InstreamReachesGroup
ReadGeoLayerFromGeoJSON(InputFile="layers/instream-termini.geojson",GeoLayerID="InstreamTerminiLayer",Name="Upper Colorado Instream Flow Reach Termini",Description="Upper Colorado Instream Flow Reach Termini")
AddGeoLayerViewToGeoMap(GeoLayerID="InstreamTerminiLayer",GeoMapID="InstreamReachesMap",GeoLayerViewGroupID="InstreamReachesGroup",GeoLayerViewID="InstreamTerminiLayerView",Name="Upper Colorado Instream Flow Reach Termini",Description="Upper Colorado Instream Flow Reach Termini")
SetGeoLayerViewSingleSymbol(GeoMapID="InstreamReachesMap",GeoLayerViewGroupID="InstreamReachesGroup",GeoLayerViewID="InstreamTerminiLayerView",Name="Upper Colorado Instream Flow Reach Termini",Description="Upper Colorado Instream Flow Reach Termini shown as cyan diamond",Properties="symbolShape:Diamond,color:cyan,fillColor:cyan,size:6,sizeUnits:pixels,opacity:1.0,fillOpacity:1.0,weight:1.5")
# = = = = = = = = = =
# Write the map project file and copy layers to the location needed by the web application.
# - follow InfoMapper conventions
WriteGeoMapProjectToJSON(GeoMapProjectID="InstreamReachesProject",Indent="2",OutputFile="instream-reaches-map.json")
CreateFolder(Folder="${MapFolder}/layers",CreateParentFolders="True",IfFolderExists="Ignore")
CopyFile(SourceFile="instream-reaches-map.json",DestinationFile="${MapFolder}/instream-reaches-map.json")
CopyFile(SourceFile="layers/instream-reaches.geojson",DestinationFile="${MapFolder}/layers/instream-reaches.geojson")
CopyFile(SourceFile="layers/instream-termini.geojson",DestinationFile="${MapFolder}/layers/instream-termini.geojson")
