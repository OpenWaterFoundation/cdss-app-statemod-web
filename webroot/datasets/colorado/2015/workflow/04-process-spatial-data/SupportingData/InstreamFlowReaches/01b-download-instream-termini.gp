# Download the Instream Flow Termini for Division 5
# - this should only need to be done periodically
# - use the file on the OWF website since it has already been clipped for Division 5
# - TODO smalers 2020-06-09 need to update the workflow to download from CDSS website
# - save the file locally and then read and write to make sure GeoJSON file is saved as latest spec
WebGet(URL="http://data.openwaterfoundation.org/co/cdss-data-spatial-bybasin/data-files/CO-CWCB-InstreamFlowReachTerminiDecreed-Division05-20180228.geojson",OutputFile="downloads/instream-termini.geojson")
# Read the file from 'downloads/' and then write to 'layers/' to make sure the latest GeoJSON spec is used.
ReadGeoLayerFromGeoJSON(InputFile="downloads/instream-termini.geojson",GeoLayerID="InstreamTerminiLayer",Name="Instream Reach Termini",Description="Instream Flow Reach Termini from CWCB")
WriteGeoLayerToGeoJSON(GeoLayerID="InstreamTerminiLayer",OutputFile="layers/instream-termini.geojson")