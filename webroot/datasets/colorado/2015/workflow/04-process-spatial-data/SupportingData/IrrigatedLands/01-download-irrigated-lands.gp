# Download Division 5 Irrigated Lands files.
# - this should only need to be done periodically
# - use the file on the OWF website since it has already been clipped for Division 5
# - save the file in 'downloads' and then read and write to make sure GeoJSON uses the latest specification
#
# Download 1993 Irrigated Lands
WebGet(URL="http://data.openwaterfoundation.org/co/cdss-data-spatial-bybasin/data-files/CO-DWR-IrrigatedLands-Division05-1993-20180228.geojson",OutputFile="downloads/irrigated-lands-1993.geojson")
# Read the file from 'downloads/' and rewrite to 'layers/' to make sure the latest GeoJSON spec is used.
ReadGeoLayerFromGeoJSON(InputFile="downloads/irrigated-lands-1993.geojson",GeoLayerID="IrrigatedLands1993Layer",Name="Irrigated Lands (1993)",Description="Irrigated Lands (1993)")
WriteGeoLayerToGeoJSON(GeoLayerID="IrrigatedLands1993Layer",OutputFile="layers/irrigated-lands-1993.geojson")
#
# Download 2015 Irrigated Lands
WebGet(URL="http://data.openwaterfoundation.org/co/cdss-data-spatial-bybasin/data-files/CO-DWR-IrrigatedLands-Division05-2015-20180228.geojson",OutputFile="downloads/irrigated-lands-2015.geojson")
# Read the file from 'downloads/' and rewrite to 'layers/' to make sure the latest GeoJSON spec is used.
ReadGeoLayerFromGeoJSON(InputFile="downloads/irrigated-lands-2015.geojson",GeoLayerID="IrrigatedLands2015Layer",Name="Irrigated Lands (2015)",Description="Irrigated Lands (2015)")
WriteGeoLayerToGeoJSON(GeoLayerID="IrrigatedLands2015Layer",OutputFile="layers/irrigated-lands-2015.geojson")
