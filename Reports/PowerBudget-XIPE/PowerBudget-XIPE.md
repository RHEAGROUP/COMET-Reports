# XIPE Power Budget

A Report Definition file (*.rep4) can be opened in the Reporting browser in COMET.
It is basically a .zip file that contains a datasource.cs file and a report.repx file.
The first contains the code that is loaded in the Code Editor.
The latter contains the definition of the visual part of a report (https://docs.devexpress.com/XtraReports/114104/wpf-reporting/end-user-report-designer-for-wpf).
</br>

## Version info
This report can only be executed in a COMET version >= 9.0.1.
</br>

## Data Selection

### EngineeringModel dependent Constants
The Code editor contains a class definition named 'Variables'.
This variables class defines constants that are used during Data Selection.
These values might differ between different EngineeringModels, which could result in specific versions of this report definition for different EngineeringModels.

#### SpaceSegmentName constant
Data is collected by traversing the Product Tree using Element's Categories.
One of those Categories is the 'Segment' Category.
The XIPE EngineeringModel's tree hierarchy shows multiple ElementUsages that are member of the 'Segment' Category.
We only need the data in the ElementUsage named "Space Segment".
The report automatically filters the data found so only data from the "Space Segment" branch is selected. 

#### SystemModesShortName constant
This property is used to defined the ShortName of the ActualFiniteStateList that is used to define System Modes.
If an ActualFiniteStateList having this ShortName is not found, an error dialog is shown during a Datasource Rebuild.  

### Category Hierarchy
Data is selected based on the expected hierarchy of Categories that Elements in a Product Tree are member of.

In this case the Product tree is traversed twice: One time for Function data and one time for Product data.<br/>
The expected Category Hierarchies are:

Function:
- Missions
  - Segments
    - Systems [1..5 nesting levels]
      - Subsystems

Product:
- Missions
  - Segments
    - Elements [1..5 nesting levels]
      - Equipment

### Parameter values
The ShortNames of the Parameter values selected from the model are:

- redundancy
- P_on
- P_stby
- P_peak
- P_dut_cyc
- P_mean
- n_items
- maturity_margin

Only Parameter data at the deepest level of the Category Hierarchy will be selected.

### Extra filters
Either P_on or P_stby (or both) Parameters should be present on an Element and at least one of them should contain a value <> 0 for the Element to be shown in the report.
