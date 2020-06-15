# Create a GeoMapProject file for cm2015H2 historical model run
# - read previously downloaded or generated layer files
# - output to the web folder for use by the InfoMapper
# - layer view groups are added from 1st drawn (bottom) to last drawn (top)
#
# Define properties to control processing.
# - use relative paths so that the command file is portable
# - AssetsFolder is where map files exist for the InfoMapper tool
SetProperty(PropertyName="AppFolder",PropertyType="str",PropertyValue="../../../../web")
SetProperty(PropertyName="MapsFolder",PropertyType="str",PropertyValue="${AppFolder}/data-maps")
SetProperty(PropertyName="MapFolder",PropertyType="str",PropertyValue="${MapsFolder}/HistoricalSimulation/cm2015H2")
#
# Create a single map project and map for that project.
# - GeoMapProjectID:  cm2015HistoricalProject
# - GeoMapID:  cm2015HistoricalMap
CreateGeoMapProject(NewGeoMapProjectID="cm2015HistoricalProject",ProjectType="SingleMap",Name="Upper Colorado Historical Dataset",Description="Upper Colorado Historical Dataset",Properties="author:'Open Water Foundation',specificationVersion:'1.0.0'")
CreateGeoMap(NewGeoMapID="cm2015HistoricalMap",Name="Upper Colorado Historical Dataset",Description="Upper Colorado Stream Reaches",CRS="EPSG:4326",Properties="extentInitial:'ZoomLevel:-107.9819,39.6923,9'")
AddGeoMapToGeoMapProject(GeoMapProjectID="cm2015HistoricalProject",GeoMapID="cm2015HistoricalMap")
# = = = = = = = = = =
# Background layers:  read layers and add a layer view group
# GeoLayerViewGroupID: BackgroundGroup
ReadRasterGeoLayerFromTileMapService(InputUrl="https://api.mapbox.com/styles/v1/masforce/cjs108qje09ld1fo68vh7t1he/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoibWFzZm9yY2UiLCJhIjoiY2pzMTA0bmR5MXAwdDN5bnIwOHN4djBncCJ9.ZH4CfPR8Q41H7zSpff803g",GeoLayerID="MapBoxTopographicLayer",Name="Topographic (MapBox)",Description="Topographic background map from MapBox.",Properties="attribution: 'MapBox',isBackground: true")
ReadRasterGeoLayerFromTileMapService(InputUrl="https://api.mapbox.com/styles/v1/mapbox/satellite-streets-v9/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1Ijoia3Jpc3RpbnN3YWltIiwiYSI6ImNpc3Rjcnl3bDAzYWMycHBlM2phbDJuMHoifQ.vrDCYwkTZsrA_0FffnzvBw",GeoLayerID="MapBoxSatelliteLayer",Name="Satellite (MapBox)",Description="Satellite background map from MapBox.",Properties="attribution: 'MapBox',isBackground: true")
ReadRasterGeoLayerFromTileMapService(InputUrl="https://api.mapbox.com/styles/v1/mapbox/streets-v10/tiles/256/{z}/{x}/{y}?access_token=pk.eyJ1Ijoia3Jpc3RpbnN3YWltIiwiYSI6ImNpc3Rjcnl3bDAzYWMycHBlM2phbDJuMHoifQ.vrDCYwkTZsrA_0FffnzvBw",GeoLayerID="MapBoxStreetsLayer",Name="Streets (MapBox)",Description="Streets background map from MapBox.",Properties="attribution: 'MapBox',isBackground: true")
ReadRasterGeoLayerFromTileMapService(InputUrl="https://api.mapbox.com/v4/mapbox.streets-satellite/{z}/{x}/{y}.png?access_token=pk.eyJ1Ijoia3Jpc3RpbnN3YWltIiwiYSI6ImNpc3Rjcnl3bDAzYWMycHBlM2phbDJuMHoifQ.vrDCYwkTZsrA_0FffnzvBw",GeoLayerID="MapBoxStreets&SatelliteLayer",Name="Streets & Satellite (MapBox)",Description="Streets and satellite background map from MapBox.",Properties="attribution: 'MapBox',isBackground: true")
AddGeoLayerViewGroupToGeoMap(GeoMapID="cm2015HistoricalMap",GeoLayerViewGroupID="BackgroundGroup",Name="Background Layers",Description="Background maps from image servers.",Properties="isBackground: true, selectedInitial: true")
AddGeoLayerViewToGeoMap(GeoLayerID="MapBoxTopographicLayer",GeoMapID="cm2015HistoricalMap",GeoLayerViewGroupID="BackgroundGroup",GeoLayerViewID="MapBoxTopographicLayerView",Name="Topographic (MapBox)",Description="Topographic Map",Properties="selectedInitial: true")
AddGeoLayerViewToGeoMap(GeoLayerID="MapBoxSatelliteLayer",GeoMapID="cm2015HistoricalMap",GeoLayerViewGroupID="BackgroundGroup",GeoLayerViewID="MapBoxSatelliteLayerView",Name="Satellite (MapBox)",Description="Satellite background map from MapBox.",Properties="selectedInital: false")
AddGeoLayerViewToGeoMap(GeoLayerID="MapBoxStreetsLayer",GeoMapID="cm2015HistoricalMap",GeoLayerViewGroupID="BackgroundGroup",GeoLayerViewID="MapBoxStreetsLayerView",Name="Streets (MapBox)",Description="Streets background map from MapBox.",Properties="selectedInitial: false")
AddGeoLayerViewToGeoMap(GeoLayerID="MapBoxStreets&SatelliteLayer",GeoMapID="cm2015HistoricalMap",GeoLayerViewGroupID="BackgroundGroup",GeoLayerViewID="MapBoxStreets&SatelliteLayerView",Name="Streets & Satellite (MapBox)",Description="Streets and satellite background map from MapBox.",Properties="selectedInitial: false")
# = = = = = = = = = =
# Instream flow reaches:  read layer and add to a layer view group.
# GeoLayerViewGroupID: InstreamReachesGroup
CopyFile(SourceFile="../../SupportingData/InstreamFlowReaches/layers/instream-reaches.geojson",DestinationFile="layers/instream-reaches.geojson")
ReadGeoLayerFromGeoJSON(InputFile="layers/instream-reaches.geojson",GeoLayerID="InstreamReachesLayer",Name="Upper Colorado Instream Flow Reaches",Description="Upper Colorado Instream Flow Reaches")
# Use the Stream reaches group for instream and stream reaches
AddGeoLayerViewGroupToGeoMap(GeoMapID="cm2015HistoricalMap",GeoLayerViewGroupID="StreamReachesGroup",Name="Upper Colorado Stream Reaches",Description="Upper Colorado Stream Reaches",Properties="selectedInitial: true",InsertPosition="Top")
AddGeoLayerViewToGeoMap(GeoLayerID="InstreamReachesLayer",GeoMapID="cm2015HistoricalMap",GeoLayerViewGroupID="StreamReachesGroup",GeoLayerViewID="InstreamReachesLayerView",Name="Upper Colorado Instream Flow Reaches",Description="Upper Colorado Instream Flow Reaches")
SetGeoLayerViewSingleSymbol(GeoMapID="cm2015HistoricalMap",GeoLayerViewGroupID="StreamReachesGroup",GeoLayerViewID="InstreamReachesLayerView",Name="Upper Colorado Instream Flow Reaches",Description="Upper Colorado Instream Flow Reaches")
# = = = = = = = = = =
# Stream reaches:  read layer and add to a layer view group.
# GeoLayerViewGroupID: StreamReachesGroup
CopyFile(SourceFile="../../SupportingData/StreamReaches/layers/stream-reaches.geojson",DestinationFile="layers/stream-reaches.geojson")
ReadGeoLayerFromGeoJSON(InputFile="layers/stream-reaches.geojson",GeoLayerID="StreamReachesLayer",Name="Upper Colorado Stream Reaches",Description="Upper Colorado Stream Reaches")
AddGeoLayerViewToGeoMap(GeoLayerID="StreamReachesLayer",GeoMapID="cm2015HistoricalMap",GeoLayerViewGroupID="StreamReachesGroup",GeoLayerViewID="StreamReachesLayerView",Name="Upper Colorado Stream Reaches",Description="Upper Colorado Stream Reaches")
SetGeoLayerViewSingleSymbol(GeoMapID="cm2015HistoricalMap",GeoLayerViewGroupID="StreamReachesGroup",GeoLayerViewID="StreamReachesLayerView",Name="Upper Colorado Stream Reaches",Description="Upper Colorado Stream Reaches")
# SetGeoLayerViewCategorizedSymbol(GeoMapID="cm2015HistoricalMap",GeoLayerViewGroupID="StreamReachesGroup",GeoLayerViewID="StreamReachesLayerView",Name="Upper Colorado Stream Reaches",Description="Show stream reaches is blue lines",ClassificationAttribute="county",Properties="classificationType:'SingleSymbol'")
# = = = = = = = = = =
# Diversion stations:  read layer and add to a layer view group.
# GeoLayerViewGroupID: DiversionGroup
ReadGeoLayerFromGeoJSON(InputFile="layers/diversions.geojson",GeoLayerID="DiversionLayer",Name="Diversions",Description="Diversions")
AddGeoLayerViewGroupToGeoMap(GeoMapID="cm2015HistoricalMap",GeoLayerViewGroupID="DiversionGroup",Name="Diversions",Description="Diversions",Properties="selectedInitial: true",InsertPosition="Top")
AddGeoLayerViewToGeoMap(GeoLayerID="DiversionLayer",GeoMapID="cm2015HistoricalMap",GeoLayerViewGroupID="DiversionGroup",GeoLayerViewID="DiversionLayer",Name="Diversions",Description="Diversions")
SetGeoLayerViewSingleSymbol(GeoMapID="cm2015HistoricalMap",GeoLayerViewGroupID="DiversionGroup",GeoLayerViewID="DiversionLayer",Name="Diversions",Description="Diversions",Properties="symbolShape:Square,color:black,fillColor:black,size:4,sizeUnits:pixels,opacity:1.0,fillOpacity:1.0,weight:1.5")
# = = = = = = = = = =
# Reservoir stations:  read layer and add to a layer view group.
# GeoLayerViewGroupID: ReservoirGroup
ReadGeoLayerFromGeoJSON(InputFile="layers/reservoirs.geojson",GeoLayerID="ReservoirLayer",Name="Reservoirs",Description="Reservoirs")
AddGeoLayerViewGroupToGeoMap(GeoMapID="cm2015HistoricalMap",GeoLayerViewGroupID="ReservoirGroup",Name="Reservoirs",Description="Reservoirs",Properties="selectedInitial: true",InsertPosition="Top")
AddGeoLayerViewToGeoMap(GeoLayerID="ReservoirLayer",GeoMapID="cm2015HistoricalMap",GeoLayerViewGroupID="ReservoirGroup",GeoLayerViewID="ReservoirLayerView",Name="Reservoirs",Description="Reservoirs")
SetGeoLayerViewSingleSymbol(GeoMapID="cm2015HistoricalMap",GeoLayerViewGroupID="ReservoirGroup",GeoLayerViewID="ReservoirLayerView",Name="Reservoirs",Description="Reservoirs",Properties="symbolShape:Triangle-Up,color:black,fillColor:green,size:6,sizeUnits:pixels,opacity:1.0,fillOpacity:1.0,weight:1.5")
# = = = = = = = = = =
# Streamflow stations:  read layer and add to a layer view group.
# GeoLayerViewGroupID: StreamflowGroup
ReadGeoLayerFromGeoJSON(InputFile="layers/streamgages.geojson",GeoLayerID="StreamflowLayer",Name="Streamflow Stations",Description="Streamflow Stations")
AddGeoLayerViewGroupToGeoMap(GeoMapID="cm2015HistoricalMap",GeoLayerViewGroupID="StreamflowGroup",Name="Streamflow Stations",Description="Streamflow Stations",Properties="selectedInitial: true",InsertPosition="Top")
AddGeoLayerViewToGeoMap(GeoLayerID="StreamflowLayer",GeoMapID="cm2015HistoricalMap",GeoLayerViewGroupID="StreamflowGroup",GeoLayerViewID="StreamflowLayerView",Name="Streamflow Stations",Description="Streamflow Stations")
SetGeoLayerViewSingleSymbol(GeoMapID="cm2015HistoricalMap",GeoLayerViewGroupID="StreamflowGroup",GeoLayerViewID="StreamflowLayerView",Name="Streamflow Stations",Description="Streamflow Stations",Properties="symbolShape:Circle,color:black,fillColor:red,size:4,sizeUnits:pixels,opacity:1.0,fillOpacity:1.0,weight:1.5")
# = = = = = = = = = =
# Write the map project file and copy layers to the location needed by the web application.
# - follow InfoMapper conventions
WriteGeoMapProjectToJSON(GeoMapProjectID="cm2015HistoricalProject",Indent="2",OutputFile="cm2015-historical-map.json")
CreateFolder(Folder="${MapFolder}/layers",CreateParentFolders="True",IfFolderExists="Ignore")
CopyFile(SourceFile="cm2015-historical-map.json",DestinationFile="${MapFolder}/cm2015-historical-map.json")
CopyFile(SourceFile="layers/instream-reaches.geojson",DestinationFile="${MapFolder}/layers/instream-reaches.geojson")
CopyFile(SourceFile="layers/stream-reaches.geojson",DestinationFile="${MapFolder}/layers/stream-reaches.geojson")
CopyFile(SourceFile="layers/streamgages.geojson",DestinationFile="${MapFolder}/layers/streamgages.geojson")
CopyFile(SourceFile="layers/reservoirs.geojson",DestinationFile="${MapFolder}/layers/reservoirs.geojson")
CopyFile(SourceFile="layers/diversions.geojson",DestinationFile="${MapFolder}/layers/diversions.geojson")
