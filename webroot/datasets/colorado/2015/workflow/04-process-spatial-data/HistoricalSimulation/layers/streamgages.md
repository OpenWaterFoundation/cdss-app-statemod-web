# Layer: Streamflow Stations

The Streamflow Stations layer corresponds to stream gages in the StateMod dataset.
These are locations where water is measured by the Division of Water Resources,
United States Geological Survey, or other entities.
Streamflow measurements, converted to monthly volumes,
are used to calibrate the model.

## Data Sources

The following are data sources for this map:

| **Resource** | **Source** |
| -- | -- |
| Streamflow Stations layer | Model identifiers are extracted from the StateMod `*.ris` file and corresponding coordinates are extracted from HydroBase. |

## Map Creation Workflow

The workflow to create the map can be found in the
[StateMod Web GitHub repository](https://github.com/OpenWaterFoundation/cdss-app-statemod-web/tree/master/webroot/datasets/colorado/2015/workflow).
