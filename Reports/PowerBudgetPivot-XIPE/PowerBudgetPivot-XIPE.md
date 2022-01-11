# XIPE Power Budget Pivot

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

#### ParameterOrder constant
In the report preview, the power (pivot) columns can be selected using a multi-select report parameter.
The order in which those selected columns are shown in the report can be set using the ParameterOrder constant.
It is a Dictionary that contain the Parameter name and an integer value that can be used to sort the column order.

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

- P_on
- P_stby
- P_peak
- P_dut_cyc
- P_mean

Only Parameter data at the deepest level of the Category Hierarchy will be selected.