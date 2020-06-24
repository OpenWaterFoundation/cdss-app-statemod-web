[Product]

ProductType = "Graph"
TotalHeight = "400"
TotalWidth = "600"

[SubProduct 1]

GraphType = "Line"
LeftYAxisLabelPrecision = "0"
LeftYAxisTitlePosition = "LeftOfAxis"
LeftYAxisTitleRotation = "270"
LeftYAxisTitleString = "ACFT"
MainTitleString = "StationId (StationName) - Stream at Diversion"
LayoutYPercent = ""

[Data 1.1]

TSAlias = "3600507-Available_Flow-Month"
TSID = "3600507...MONTH~StateMod~C:\Users\sam\cdss-dev\StateMod-Web\git-repos\cdss-app-statemod-web\webroot\datasets\colorado\2015\web/data-ts/output/b43/3600507.StateMod.Available_Flow.Month.H2.stm"

[SubProduct 2]

GraphType = "Line"
LeftYAxisLabelPrecision = "0"
LeftYAxisTitlePosition = "LeftOfAxis"
LeftYAxisTitleRotation = "270"
MainTitleString = "StationId (StationName) - Diversion"
RightYAxisGraphType = "None"
RightYAxisIgnoreUnits = "false"
LayoutYPercent = ""

[Data 2.1]

TSAlias = "3600507-DiversionHistorical-Month"
TSID = "3600507...MONTH~StateMod~C:\Users\sam\cdss-dev\StateMod-Web\git-repos\cdss-app-statemod-web\webroot\datasets\colorado\2015\web/data-ts/input/diversions/3600507.StateMod.DiversionHistorical.Month.stm"

[Data 2.2]

TSAlias = "3600507-DiversionDemand-Month"
TSID = "3600507...MONTH~StateMod~C:\Users\sam\cdss-dev\StateMod-Web\git-repos\cdss-app-statemod-web\webroot\datasets\colorado\2015\web/data-ts/input/diversions/3600507.StateMod.DiversionDemand.Month.H.stm"
