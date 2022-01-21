# XIPE Equipment list

A Report Definition file (*.rep4) can be opened in the Reporting browser in COMET.
It is basically a .zip file that contains a datasource.cs file and a report.repx file.
The first contains the code that is loaded in the Code Editor.
The latter contains the definition of the visual part of a report (https://docs.devexpress.com/XtraReports/114104/wpf-reporting/end-user-report-designer-for-wpf).
</br>

## Version info
This report can only be executed in a COMET version >= 8.0.1.
</br>

## Data Selection

### EngineeringModel dependent Constants
The Code editor contains a class definition named `Variables`.
This variables class defines constants that are used during Data Selection.
These values might differ between different EngineeringModels, which could result in specific versions of this report definition for different EngineeringModels.

#### SpaceSegmentName constant
Data is collected by traversing the Product Tree using Element's Categories.
One of those Categories is the `Segment` Category.
The XIPE EngineeringModel's tree hierarchy shows multiple ElementUsages that are member of the `Segment` Category.
We only need the data in the ElementUsage named "Space Segment".
The report automatically filters the data found so only data from the "Space Segment" branch is selected. 

### Category Hierarchy
Data is selected based on the expected hierarchy of Categories that Elements in a Product Tree are member of.

The expected Category Hierarchy is:

- Missions
  - Segments
    - Elements [1..5 nesting levels]
      - Equipment

### Parameter values
The ShortNames of the Parameter values selected from the model are:

- m
- mass_margin
- n_items

For the all Parameter Values, only Parameter data at the deepest level of the Category Hierarchy will be selected.

### Extra filters

### Calculations and assumptions
- There is 1 more Report Parameters in the Report Parameter panel that is not based on data from the Model: Drilldown Expanded => Indicates if Drilldown to detail level is expanded in the report preview
- This report shows ElementDefinitions, so if there are multiple ElementUsages based on the same ElementDefinition and the Parameter values we are interested in are also equal, then the ElementDefinition will be shown once in the report and the corresponding NumberOfItems column values will be added together.