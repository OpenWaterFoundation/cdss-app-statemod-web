# Download Division 5 boundary file.
# - use the file on the OWF website since it has already been clipped for Division 5
# - using CDSS data directly is preferred, hence the other command file
# - this should only need to be done if setting up a new workspace
# - save the file to 'downloads' and then read and write to make sure GeoJSON version uses the latest specification
WebGet(URL="http://data.openwaterfoundation.org/co/cdss-data-spatial-bybasin/data-files/CO-DWR-WaterDivisionBoundaries-Division05-20180228.geojson",OutputFile="downloads/co-dwr-water-division5.geojson")
# Read 'download/' file and rewrite to 'layers/' to make sure the latest GeoJSON spec is used.
ReadGeoLayerFromGeoJSON(InputFile="downloads/co-dwr-water-division5.geojson",GeoLayerID="WaterDivisionLayer",Name="DWR Division 5 Boundary",Description="DWR Division 5 Boundary")
WriteGeoLayerToGeoJSON(GeoLayerID="WaterDivisionLayer",OutputFile="layers/co-dwr-water-division5.geojson")
