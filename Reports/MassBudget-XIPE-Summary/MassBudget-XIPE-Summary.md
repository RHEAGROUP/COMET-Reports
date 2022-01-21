# XIPE Mass Budget Summary

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

#### Path constants
There are 5 Path constants that could be used to get additional information from the Model.
These constants are strings that contain the Path of a single Parameter.
During rebuild of the Datasource the report engine tries to retrieve the value of this Parameter and creates a Report parameter that has this value set as its default value.
The created report parameter values can be manually changed by the user during report preview in the Report Parameter panel. 

A Parameter's Path can be retrieved using bij right mouse clicking on the Parameter in the Product tree and selecting the option "Copy Path to Clipboard".
The Path can then be pasted (using CTRL-V) in the code editor.
When the Path constants value is an empty string `""` then the default value of the report parameter will be 0. The user could still change its value during report preview.

When you paste a Path into the Code editor you should always prefix the string with the @ symbol. Strings that are prefixed with the @ symbol are interpreted literally. That is, you cannot escape any characters within the string if you use the @ prefix. The backslashes contained in the Path values are escape characters, so the compiler would not read the strings correctly without the @-prefix.

The 5 Paths that can be set are:

1. LauncherAdapterPath
2. FuelMassPath
3. OxidizerMassPath
4. PressurantMassPath
5. PropellantMassPath

#### SubsystemNames
During report preview, a selection per owner (DomainOfExpertise) can be made that indicates if either Function, or Product data should be used in the report for that particular DomainOfExpertise. 
The Variables class contains a List of strings called "SubsystemNames" that will always be shown in the Report Parameter selection panel in the report previewer, even if the Model doesn't contain any data for this DomainOfExpertise.
DomainOfExpertises that are found in the Model but are not defined in the SubsystemNames constant will also have a Function/Product selection dropdown in the Report Parameter panel during report preview.
The reason that this List exists is that a user could change the default value of the Product/Function report parameter and save that within the report definition file. That way, the user doesn't have to change the value of the report parameter every time the report is executed. Existence in the SubsystemNames list makes sure that this setting is saved correctly every time, even if a specific Option doesn't have data (yet) for the specific DomainOfExpertise.

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

- m
- mass_margin
- n_items

For the m and n_items Parameter Values, only Parameter data at the deepest level of the Category Hierarchy will be selected.

For the mass_margin parameter, Parameter values on all levels in the Category Hierarchy are collected. 
The reason for this is that the report engine can make use of extra mass_margin data, defined at the second System level (Module level) in a Product Tree.
This is usually the case for the Payload Module. 


### Extra filters
In the Report Parameter panel the user can select a System Name.
In case there are multiple System levels found in the Product Tree, the user can select the correct System to show data for.

### Calculations and assumptions
There are 4 more Report Parameters in the Report Parameter panel that are not based on data from the Model:

1. Drilldown Expanded => Indicates if Drilldown to detail level is expanded in the report preview
2. Harness Margin => The margin (0.05 = 5%) for the Harness
3. System Margin => The system margin (0.2 = 20%)
4. Propellant Margin => The margin for all Propellant used to calculate Wet mass (0.02 = 2%)
