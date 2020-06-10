# CDSS Colorado (cm2015) Dataset (Prototype) #

This website provides a simple map-based interface to Colorado's Decision Support Systems (CDSS) Upper Colorado
surface water supply simulation model dataset.

### **Avoid refreshing the page because that will reload the application.  Use right-click or Ctrl-click to open links in a new tab.  Otherwise, navigating "back" will cause the web application to reload each time this page is refreshed.** ###

The information on this website was created as follows:

1. The latest `cm2015` dataset was downloaded from the [CDSS website](https://www.colorado.gov/pacific/cdss/surface-water-statemod).
2. [StateMod modeling software](https://www.colorado.gov/pacific/cdss/statemod) was run to simulate water allocation.
3. Input and output in large files was split into files for each model "node",
allowing individual time series and report sections to be quickly accessed for each node.
4. Maps and time series graph configurations were created to integrate with model data.
5. The files were uploaded to the cloud and this web application was configured to display the maps and time series.

Menus are provided for important dataset components and reflect the work necessary to create a simulation model
that is suitable for water resources planning.

See the [Upper Colorado Model Documentation](https://dnrweblink.state.co.us/cwcb/0/doc/200075/Electronic.aspx?searchid=d8eca6f8-7cfe-4ddf-9788-5886fd932c8c)
for detailed information about the model (**Warning:  PDF can be slow to download/view**).

See the ***About this Project*** menu for details about project implementation.

### **This website is under development.  Currently, menus are an outline for features that are being phased in.** ###
