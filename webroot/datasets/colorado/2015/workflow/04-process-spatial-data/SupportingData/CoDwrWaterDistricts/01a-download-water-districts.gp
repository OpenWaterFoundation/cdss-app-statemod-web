# Download Division 5 Water Districts file.
# - this should only need to be done periodically
# - use the file on the OWF website since it has already been clipped for Division 5
# - save the file in 'downloads' and then read and write to make sure GeoJSON uses the latest specification
WebGet(URL="http://data.openwaterfoundation.org/co/cdss-data-spatial-bybasin/data-files/CO-DWR-WaterDistrictBoundaries-Division05-20180228.geojson",OutputFile="downloads/co-dwr-water-districts-division5.geojson")
# Read the file from 'downloads/' and rewrite to 'layers/' to make sure the latest GeoJSON spec is used.
ReadGeoLayerFromGeoJSON(InputFile="downloads/co-dwr-water-districts-division5.geojson",GeoLayerID="WaterDistrictsLayer",Name="DWR Water Districts",Description="DWR Water Districts for Division 5")
WriteGeoLayerToGeoJSON(GeoLayerID="WaterDistrictsLayer",OutputFile="layers/co-dwr-water-districts-division5.geojson")
