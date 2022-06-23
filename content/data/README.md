# Table generator

The data folder includes the only "hard-coded" HTML (i.e. pure HTML file in the site, written by hand and not generated from Markdown) which is the `table-generator.html` file.

The table generator is designed to allow end-users to easily integroate and filter the machine readable format CSV without having to download and open it in a spreadsheet application.

The generator file has four sections:

- the front matter (YAML)
- the opening content (HTML)
- the generator skeleton (HTML)
- the generator script (JavaScript)

## Front matter
The front matter is a YAML block similar to that used in markdown docs to provide the page parameters (title, date, weight, summary, etc). The rmarkdown flag is included and set to `true` so as to import the relevant javascript libraries for DataTables as used by pages generated from R Markdown.

## Opening content
The opening content is  a simple introductory paragraph, followed by a `details` container with further instructions.

## Generator skeleton
The generator skeleton is for the HTML representation of the table generator, it consists of a set of inputs and placeholders for.

## Generator script
The main workhorse of the table generator is the JavaScript block starting at line 204.

### Variable set up
Lines 205-496 set up some critical variables:

- `csv_data`: an object for storing the raw CSV data (empty at intitalisation)
- `filter_res`: an object for storing a filtered version of the CSV data (empty at intialisation)
- `csv_columns`: an object for storing the column names of the csv (empty at intitalisation)
- `var_selected`: a string for holding the currently selected variable (empty, `""` at initalisation)
- `category_selections`: an obejct for storing filter categories (empty at initalisation)
- `number_of_selections`: an integer for counting the number of categories selected (`0` at intialisation)
- `table_variables`: an object containing the variables that should be shown for a given table
- `variable_labels`: an object of strings giving the label of variables
- `variable_categories`: an object containing arrays of strings listing the categories of each variable

### Parse CSV
Lines 498-507 reads in the CSV as a JSON object and assigns that object to the `csv_data` object.

### Functions
Lines 509-755 define JavaScript functions that run the generator

#### select_table()
This function runs when a user interacts with the table selection input.

- If no table is selected it will hide and reset any of the other inputs.
- When a table is selected it will generate the HTML for the variable selection input and show this. The variable input will list only the variables specified `table_variables`.

#### select_variable()
This function runs when a user interacts with the variable selection input.

- If no variable is selected it will hide and reset the category input.
- When a variable is selected it will generate the HTML for the category selection input, showing the categories specified in `variable_categories`.

#### select_category()
This function runs when a user selects the "Add category" button.

It gets the value of the current selected option in the category input and registers it in the `category_selections` object.

It will then (re-)generate the HTML for the list of category selections shown to the user.

#### reset_categories()
This function runs when the user selects the "Reset filters" button.

It will reset `number_of_selections` to 0 and `category_selections` to an empty object.

#### filter_results()
This is an internal function that filters the `csv_data` using filters registered in `category_selections`.

#### generate_table()
This function runs when a user selects the "Generate table" button.

First it calls `filter_results()`, if there are no results it shows an error/warning message and ends.

If there are results it will remove columns that are not to be displayed, so that the final table only includes those variables necessary.

It will then generate the HTML for the table, and initalise it as a DataTables interactive table.

Finally it applies the govuk_DT_styling() function included in the govukhugo templates to apply any additional GOV.UK Design System classes.

### Bindings
Lines 749-763 bind the functions to the relevant user interactions.