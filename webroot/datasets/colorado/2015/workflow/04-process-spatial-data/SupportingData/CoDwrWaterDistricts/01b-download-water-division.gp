# Download Division 5 boundary file.
# - use the zipped shapefile on the CDSS website and split out Division 5
# - this should only need to be done if setting up a new workspace
# - apparently the 'DIV3' in the filename means version 3 and not 'Division 3'?
WebGet(URL="https://dnrftp.state.co.us/CDSS/GIS/DIV3CO.zip",OutputFile="downloads/DIV3CO.zip")
# Unzip the zip file
UnzipFile(File="downloads/DIV3CO.zip",OutputFolder="downloads/DIV3CO",IfFolderDoesNotExist="Create")
# Read the 'downloads' shapefile, split out Division 5 into a new layer (default is GeoPackage format),
# and write to 'layers/'as a GeoJSON file.
ReadGeoLayerFromShapefile(InputFile="downloads/DIV3CO/DIV3CO.shp",GeoLayerID="WaterDivisionsLayer",Name="DWR Division Boundaries",Description="DWR Division Boundaries")
SplitGeoLayerByAttribute(InputGeoLayerID="WaterDivisionsLayer",AttributeName="DIV",IncludeAttributeValues="5",TemporaryFolder="downloads/DIV3CO-split")
# Use the following to troubleshoot the split command if necessary.
# ReadGeoLayersFromGeoPackage(InputFile="downloads/DIV3CO-split/DIV_5.gpkg",ReadOneLayer="True",LayerName="DIV_5",GeoLayerID="WaterDivisionLayer")
WriteGeoLayerToGeoJSON(GeoLayerID="WaterDivisionsLayer_DIV_5",OutputFile="layers/co-dwr-water-division5.geojson")