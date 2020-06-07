# workflow #

This folder contains numbered folders, each of which is a step in the overall workflow
of downloading ... running ... and publishing StateMod/StateCU dataset on the web.
The following is a summary of the workflow steps.

| **Workflow Folder** | **Description** |
| -- | -- |
| `01-download-dataset/` | Download the StateCU and StateMod datasets from CDSS website and unzip in standard location. |
| `02-run-models/` | Run StateMod to create output for publishing, including `H`, `H2`, and `B` simulation runs . |
| `03-split-model-files/` | Split `../StateMod` folder input and output files for web publishing. |
| `04-process-spatial/` | Create spatial data files for InfoMapper. |
| `05-upload-to-cloud/` | Upload the website content to the cloud. |
