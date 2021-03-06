# Create a GeoMapProject file for cm2015B baseline model run
# - read previously downloaded or generated layer files
# - output to the web folder for use by the InfoMapper
# - layer view groups are added from 1st drawn (bottom) to last drawn (top)
#
# Define properties to control processing.
# - use relative paths so that the command file is portable
# - AssetsFolder is where map files exist for the InfoMapper tool
SetProperty(PropertyName="AppFolder",PropertyType="str",PropertyValue="../../../web")
SetProperty(PropertyName="MapsFolder",PropertyType="str",PropertyValue="${AppFolder}/data-maps")
SetProperty(PropertyName="MapFolder",PropertyType="str",PropertyValue="${MapsFolder}/BaselineSimulation")
#
# Create a single map project and map for that project.
# - GeoMapProjectID:  cm2015BaselineProject
# - GeoMapID:  cm2015BaselineMap
CreateGeoMapProject(NewGeoMapProjectID="cm2015BaselineProject",ProjectType="SingleMap",Name="Baseline Simulation Dataset",Description="Baseline Simulation Dataset",Properties="author:'Open Water Foundation',specificationVersion:'1.0.0'")
CreateGeoMap(NewGeoMapID="cm2015BaselineMap",Name="Baseline Simulation Dataset",Description="Baseline Simulation Dataset",CRS="EPSG:4326",Properties="extentInitial:'ZoomLevel:-107.9819,39.6923,9'")
AddGeoMapToGeoMapProject(GeoMapProjectID="cm2015BaselineProject",GeoMapID="cm2015BaselineMap")
# = = = = = = = = = =
# Background layers:  read layers and add a layer view group
# GeoLayerViewGroupID: BackgroundGroup
# - add tile servers from MapBox, Esri, and Google
#
# Mapbox background layers
AddGeoLayerViewGroupToGeoMap(GeoLayerViewGroupID="BackgroundGroup",Name="Background Layers",Description="Background maps from image servers.",Properties="isBackground: true, selectedInitial: true")
#
ReadRasterGeoLayerFromTileMapService(InputUrl="https://api.mapbox.com/styles/v1/mapbox/satellite-streets-v9/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1Ijoia3Jpc3RpbnN3YWltIiwiYSI6ImNpc3Rjcnl3bDAzYWMycHBlM2phbDJuMHoifQ.vrDCYwkTZsrA_0FffnzvBw",GeoLayerID="MapBoxSatelliteLayer",Name="Satellite (MapBox)",Description="Satellite background map from MapBox.",Properties="attribution: 'MapBox',isBackground: true")
AddGeoLayerViewToGeoMap(GeoLayerID="MapBoxSatelliteLayer",GeoLayerViewID="MapBoxSatelliteLayerView",Name="Satellite (MapBox)",Description="Satellite background map from MapBox.",Properties="selectedInital: false")
ReadRasterGeoLayerFromTileMapService(InputUrl="https://api.mapbox.com/styles/v1/mapbox/streets-v10/tiles/256/{z}/{x}/{y}?access_token=pk.eyJ1Ijoia3Jpc3RpbnN3YWltIiwiYSI6ImNpc3Rjcnl3bDAzYWMycHBlM2phbDJuMHoifQ.vrDCYwkTZsrA_0FffnzvBw",GeoLayerID="MapBoxStreetsLayer",Name="Streets (MapBox)",Description="Streets background map from MapBox.",Properties="attribution: 'MapBox',isBackground: true")
AddGeoLayerViewToGeoMap(GeoLayerID="MapBoxStreetsLayer",GeoLayerViewID="MapBoxStreetsLayerView",Name="Streets (MapBox)",Description="Streets background map from MapBox.",Properties="selectedInitial: false")
ReadRasterGeoLayerFromTileMapService(InputUrl="https://api.mapbox.com/v4/mapbox.streets-satellite/{z}/{x}/{y}.png?access_token=pk.eyJ1Ijoia3Jpc3RpbnN3YWltIiwiYSI6ImNpc3Rjcnl3bDAzYWMycHBlM2phbDJuMHoifQ.vrDCYwkTZsrA_0FffnzvBw",GeoLayerID="MapBoxStreets&SatelliteLayer",Name="Streets & Satellite (MapBox)",Description="Streets and satellite background map from MapBox.",Properties="attribution: 'MapBox',isBackground: true")
AddGeoLayerViewToGeoMap(GeoLayerID="MapBoxStreets&SatelliteLayer",GeoLayerViewID="MapBoxStreets&SatelliteLayerView",Name="Streets & Satellite (MapBox)",Description="Streets and satellite background map from MapBox.",Properties="selectedInitial: false")
ReadRasterGeoLayerFromTileMapService(InputUrl="https://api.mapbox.com/styles/v1/masforce/cjs108qje09ld1fo68vh7t1he/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoibWFzZm9yY2UiLCJhIjoiY2pzMTA0bmR5MXAwdDN5bnIwOHN4djBncCJ9.ZH4CfPR8Q41H7zSpff803g",GeoLayerID="MapBoxTopographicLayer",Name="Topographic (MapBox)",Description="Topographic background map from MapBox.",Properties="attribution: 'MapBox',isBackground: true")
AddGeoLayerViewToGeoMap(GeoLayerID="MapBoxTopographicLayer",GeoLayerViewID="MapBoxTopographicLayerView",Name="Topographic (MapBox)",Description="Topographic Map",Properties="selectedInitial: false")
#
# Esri background layers
ReadRasterGeoLayerFromTileMapService(InputUrl="https://services.arcgisonline.com/ArcGIS/rest/services/Canvas/World_Dark_Gray_Base/MapServer/tile/{z}/{y}/{x}",GeoLayerID="EsriDarkGray",Name="Dark Gray (Esri)",Description="Dark Gray background map from Esri.",Properties="attribution: 'Esri',isBackground: true")
AddGeoLayerViewToGeoMap(GeoLayerID="EsriDarkGray",GeoLayerViewID="EsriDarkGrayView",Name="Dark Gray (Esri)",Description="Dark Gray background map from Esri.",Properties="selectedInitial: false,separatorBefore:true")
ReadRasterGeoLayerFromTileMapService(InputUrl="https://services.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}",GeoLayerID="EsriImagery",Name="Imagery (Esri)",Description="Imagery background map from Esri.",Properties="attribution: 'Esri',isBackground: true")
AddGeoLayerViewToGeoMap(GeoLayerID="EsriImagery",GeoLayerViewID="EsriImageryView",Name="Imagery (Esri)",Description="Imagery background map from Esri.",Properties="selectedInitial: false")
ReadRasterGeoLayerFromTileMapService(InputUrl="https://services.arcgisonline.com/ArcGIS/rest/services/Canvas/World_Light_Gray_Base/MapServer/tile/{z}/{y}/{x}",GeoLayerID="EsriLightGray",Name="Light Gray (Esri)",Description="Light Gray background map from Esri.",Properties="attribution: 'Esri',isBackground: true")
AddGeoLayerViewToGeoMap(GeoLayerID="EsriLightGray",GeoLayerViewID="EsriLightGrayView",Name="Light Gray (Esri)",Description="Light Gray background map from Esri.",Properties="selectedInitial: false")
ReadRasterGeoLayerFromTileMapService(InputUrl="https://services.arcgisonline.com/ArcGIS/rest/services/NatGeo_World_Map/MapServer/tile/{z}/{y}/{x}",GeoLayerID="EsriNationalGeographic",Name="National Geographic (Esri)",Description="National Geographic background map from Esri.",Properties="attribution: 'Esri',isBackground: true")
AddGeoLayerViewToGeoMap(GeoLayerID="EsriNationalGeographic",GeoLayerViewID="EsriNationalGeographicView",Name="National Geographic (Esri)",Description="National Geographic background map from Esri.",Properties="selectedInitial: false")
ReadRasterGeoLayerFromTileMapService(InputUrl="https://services.arcgisonline.com/ArcGIS/rest/services/World_Shaded_Relief/MapServer/tile/{z}/{y}/{x}",GeoLayerID="EsriShadedRelief",Name="Shaded Relief (Esri)",Description="Shaded Relief background map from Esri.",Properties="attribution: 'Esri',isBackground: true")
AddGeoLayerViewToGeoMap(GeoLayerID="EsriShadedRelief",GeoLayerViewID="EsriShadedReliefView",Name="Shaded Relief (Esri)",Description="Terrain background map from Esri.",Properties="selectedInitial: false")
ReadRasterGeoLayerFromTileMapService(InputUrl="https://services.arcgisonline.com/ArcGIS/rest/services/World_Street_Map/MapServer/tile/{z}/{y}/{x}",GeoLayerID="EsriStreets",Name="Streets (Esri)",Description="Streets background map from Esri.",Properties="attribution: 'Esri',isBackground: true")
AddGeoLayerViewToGeoMap(GeoLayerID="EsriStreets",GeoLayerViewID="EsriStreetsView",Name="Streets (Esri)",Description="Streets background map from Esri.",Properties="selectedInitial: false")
ReadRasterGeoLayerFromTileMapService(InputUrl="https://services.arcgisonline.com/ArcGIS/rest/services/World_Terrain_Base/MapServer/tile/{z}/{y}/{x}",GeoLayerID="EsriTerrain",Name="Terrain (Esri)",Description="Terrain background map from Esri.",Properties="attribution: 'Esri',isBackground: true")
AddGeoLayerViewToGeoMap(GeoLayerID="EsriTerrain",GeoLayerViewID="EsriTerrainView",Name="Terrain (Esri)",Description="Terrain background map from Esri.",Properties="selectedInitial: false")
ReadRasterGeoLayerFromTileMapService(InputUrl="https://services.arcgisonline.com/ArcGIS/rest/services/World_Topo_Map/MapServer/tile/{z}/{y}/{x}",GeoLayerID="EsriTopographic",Name="Topographic (Esri)",Description="Topographic background map from Esri.",Properties="attribution: 'Esri',isBackground: true")
AddGeoLayerViewToGeoMap(GeoLayerID="EsriTopographic",GeoLayerViewID="EsriTopographicView",Name="Topographic (Esri)",Description="Topographic background map from Esri.",Properties="selectedInitial: false")
#
# Google background layers
ReadRasterGeoLayerFromTileMapService(InputUrl="http://mt0.google.com/vt/lyrs=s&x={x}&y={y}&z={z}",GeoLayerID="GoogleSatellite",Name="Satellite (Google)",Description="Satellite background map from Google.",Properties="attribution: 'Google',isBackground: true")
AddGeoLayerViewToGeoMap(GeoLayerID="GoogleSatellite",GeoLayerViewID="GoogleSatelliteView",Name="Satellite (Google)",Description="Satellite background map from Google.",Properties="selectedInitial:false,separatorBefore:true")
ReadRasterGeoLayerFromTileMapService(InputUrl="http://mt0.google.com/vt/lyrs=m&x={x}&y={y}&z={z}",GeoLayerID="GoogleStreets",Name="Streets (Google)",Description="Streets background map from Google.",Properties="attribution: 'Google',isBackground: true")
AddGeoLayerViewToGeoMap(GeoLayerID="GoogleStreets",GeoLayerViewID="GoogleStreetsView",Name="Streets (Google)",Description="Streets background map from Google.",Properties="selectedInitial: false")
ReadRasterGeoLayerFromTileMapService(InputUrl="http://mt0.google.com/vt/lyrs=s,h&x={x}&y={y}&z={z}",GeoLayerID="GoogleHybrid",Name="Streets & Satellite (Google)",Description="Streets & satellite background map from Google.",Properties="attribution: 'Google',isBackground: true")
AddGeoLayerViewToGeoMap(GeoLayerID="GoogleHybrid",GeoLayerViewID="GoogleHybridView",Name="Streets & Satellite (Google)",Description="Streets & satellite background map from Google.",Properties="selectedInitial: false")
ReadRasterGeoLayerFromTileMapService(InputUrl="http://mt0.google.com/vt/lyrs=p&x={x}&y={y}&z={z}",GeoLayerID="GoogleTerrain",Name="Terrain (Google)",Description="Terrain background map from Google.",Properties="attribution: 'Google',isBackground: true")
AddGeoLayerViewToGeoMap(GeoLayerID="GoogleTerrain",GeoLayerViewID="GoogleTerrainView",Name="Terrain (Google)",Description="Terrain background map from Google.",Properties="selectedInitial: false")
# Other
ReadRasterGeoLayerFromTileMapService(InputUrl="https://basemap.nationalmap.gov/ArcGIS/rest/services/USGSTopo/MapServer/tile/{z}/{y}/{x}",GeoLayerID="USGSTopo",Name="USGS Topo (USGS)",Description="Topo background map from USGS.",Properties="attribution: 'USGS',isBackground:true")
AddGeoLayerViewToGeoMap(GeoLayerID="USGSTopo",GeoLayerViewID="USGSTopoView",Name="USGS Topo (USGS)",Description="USGS Topo background map from USGS.",Properties="selectedInitial:true,separatorBefore:true")
# = = = = = = = = = =
# Instream flow reaches:  read layer and add to a layer view group.
# GeoLayerViewGroupID: InstreamReachesGroup
#
# Use the Stream reaches group for instream and stream reaches
AddGeoLayerViewGroupToGeoMap(GeoLayerViewGroupID="StreamReachesGroup",Name="Stream Reaches",Description="Stream Reaches from DWR",Properties="selectedInitial: true",InsertPosition="Top")
#
CopyFile(SourceFile="../SupportingData/InstreamFlowReaches/layers/instream-reaches.geojson",DestinationFile="layers/instream-reaches.geojson")
ReadGeoLayerFromGeoJSON(InputFile="layers/instream-reaches.geojson",GeoLayerID="InstreamReachesLayer",Name="Instream Flow Reaches",Description="Instream Flow Reaches from the CWCB")
AddGeoLayerViewToGeoMap(GeoLayerID="InstreamReachesLayer",GeoLayerViewID="InstreamReachesLayerView",Name="Instream Flow Reaches",Description="Instream Flow Reaches from the CWCB")
SetGeoLayerViewSingleSymbol(GeoLayerViewID="InstreamReachesLayerView",Name="Instream Flow Reaches",Description="Instream Flow Reaches from the CWCB",Properties="color:#00ffff,weight:5")
# = = = = = = = = = =
# Stream reaches:  read layer and add to a layer view group.
# GeoLayerViewGroupID: StreamReachesGroup
CopyFile(SourceFile="../SupportingData/StreamReaches/layers/stream-reaches.geojson",DestinationFile="layers/stream-reaches.geojson")
ReadGeoLayerFromGeoJSON(InputFile="layers/stream-reaches.geojson",GeoLayerID="StreamReachesLayer",Name="Stream Reaches",Description="Stream Reaches from DWR")
AddGeoLayerViewToGeoMap(GeoLayerID="StreamReachesLayer",GeoLayerViewID="StreamReachesLayerView",Name="Stream Reaches",Description="Stream Reaches from DWR",InsertPosition="Top")
SetGeoLayerViewSingleSymbol(GeoLayerViewID="StreamReachesLayerView",Name="Stream Reaches",Description="Stream Reaches from DWR",Properties="color:#6297f7")
# SetGeoLayerViewCategorizedSymbol(GeoLayerViewID="StreamReachesLayerView",Name="Stream Reaches",Description="Show stream reaches is blue lines",ClassificationAttribute="county",Properties="classificationType:'SingleSymbol'")
# = = = = = = = = = =
# Diversion stations:  read layer and add to a layer view group.
# GeoLayerViewGroupID: DiversionGroup
ReadGeoLayerFromGeoJSON(InputFile="layers/diversions.geojson",GeoLayerID="DiversionLayer",Name="Diversions",Description="Diversions")
AddGeoLayerViewGroupToGeoMap(GeoLayerViewGroupID="DiversionGroup",Name="Diversions",Description="Diversions",Properties="selectedInitial: true",InsertPosition="Top")
AddGeoLayerViewToGeoMap(GeoLayerID="DiversionLayer",GeoLayerViewID="DiversionLayer",Name="Diversions",Description="Diversions")
SetGeoLayerViewSingleSymbol(GeoLayerViewID="DiversionLayer",Name="Diversions",Description="Diversions",Properties="symbolShape:Square,color:black,fillColor:black,symbolSize:4,sizeUnits:pixels,opacity:1.0,fillOpacity:1.0,weight:1.5")
# = = = = = = = = = =
# Reservoir stations:  read layer and add to a layer view group.
# GeoLayerViewGroupID: ReservoirGroup
ReadGeoLayerFromGeoJSON(InputFile="layers/reservoirs.geojson",GeoLayerID="ReservoirLayer",Name="Reservoirs",Description="Reservoirs")
AddGeoLayerViewGroupToGeoMap(GeoLayerViewGroupID="ReservoirGroup",Name="Reservoirs",Description="Reservoirs",Properties="selectedInitial: true",InsertPosition="Top")
AddGeoLayerViewToGeoMap(GeoLayerID="ReservoirLayer",GeoLayerViewID="ReservoirLayerView",Name="Reservoirs",Description="Reservoirs")
SetGeoLayerViewSingleSymbol(GeoLayerViewID="ReservoirLayerView",Name="Reservoirs",Description="Reservoirs",Properties="symbolShape:Triangle-Up,color:black,fillColor:green,symbolSize:6,sizeUnits:pixels,opacity:1.0,fillOpacity:1.0,weight:1.5")
# = = = = = = = = = =
# Streamflow stations:  read layer and add to a layer view group.
# GeoLayerViewGroupID: StreamflowGroup
ReadGeoLayerFromGeoJSON(InputFile="layers/streamgages.geojson",GeoLayerID="StreamflowLayer",Name="Streamflow Stations",Description="Streamflow Stations")
AddGeoLayerViewGroupToGeoMap(GeoLayerViewGroupID="StreamflowGroup",Name="Streamflow Stations",Description="Streamflow Stations",Properties="selectedInitial: true",InsertPosition="Top")
AddGeoLayerViewToGeoMap(GeoLayerID="StreamflowLayer",GeoLayerViewID="StreamflowLayerView",Name="Streamflow Stations",Description="Streamflow Stations")
SetGeoLayerViewSingleSymbol(GeoLayerViewID="StreamflowLayerView",Name="Streamflow Stations",Description="Streamflow Stations",Properties="symbolShape:Circle,color:black,fillColor:red,symbolSize:4,sizeUnits:pixels,opacity:1.0,fillOpacity:1.0,weight:1.5")
# = = = = = = = = = =
# Write the map project file and copy layers to the location needed by the web application.
# - follow InfoMapper conventions
WriteGeoMapProjectToJSON(GeoMapProjectID="cm2015BaselineProject",Indent="2",OutputFile="cm2015-baseline-map.json")
CreateFolder(Folder="${MapFolder}/layers",CreateParentFolders="True",IfFolderExists="Ignore")
CopyFile(SourceFile="cm2015-baseline-map.json",DestinationFile="${MapFolder}/cm2015-baseline-map.json")
#
CopyFile(SourceFile="layers/instream-reaches.geojson",DestinationFile="${MapFolder}/layers/instream-reaches.geojson")
#
CopyFile(SourceFile="layers/stream-reaches.geojson",DestinationFile="${MapFolder}/layers/stream-reaches.geojson")
#
CopyFile(SourceFile="layers/streamgages.geojson",DestinationFile="${MapFolder}/layers/streamgages.geojson")
#
CopyFile(SourceFile="layers/reservoirs.geojson",DestinationFile="${MapFolder}/layers/reservoirs.geojson")
#
CopyFile(SourceFile="layers/diversions.geojson",DestinationFile="${MapFolder}/layers/diversions.geojson")
