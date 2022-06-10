---
title: "Data"
date: 2022-01-17
type: post
listpages: false
weight: 900
custom_title: "Download Civil Service Statistics dataset"
---

The full statistical tables are [published on GOV.UK](https://www.gov.uk/government/statistics/civil-service-statistics-2021). A machine readable format has also been created that makes it easier to work with the data programmatically. You can also use our table generator tool to filter the machine readable file for the selections you are most interested in.

{{< download_file link="../files/acses2021_processed.csv" text="Download the machine readable format" 
     type="CSV" size="11.9MB" >}}

<a href="table_generator/" role="button" draggable="false" class="govuk-button govuk-button--start" data-module="govuk-button">
  Generate your own tables
  <svg class="govuk-button__start-icon" xmlns="http://www.w3.org/2000/svg" width="17.5" height="19" viewBox="0 0 33 40" aria-hidden="true" focusable="false"><path fill="currentColor" d="M0 0h13l20 20-20 20H0l20-20z" /></svg>
</a>

{{< break type="m" visible=true >}}

## About the machine readable dataset

The machine readable dataset is a comma separated values (CSV) format file. It includes all values published in the traditional statistical tables spreadsheet, but in a format that can be interacted with programmatically.  The CSV file is comprised of 36,598 rows and 26 columns, where each row relates to a single value from the traditional tables.

The tables below provide general information about each of the columns, this is also available programmatically as a [JSON file](../files/acses2021_processed.json).

### Column specification
There are 26 columns in the file, a table column identifying the corresponding table in the traditional statistical tables, 21 variable columns that relate to characteristics of civil servants, 3 metadata variables providing information about the nature of the value, and 1 a single value column. The only column with blank cells is the `notes` column which only contains a value where there is a technical note relating to the data quality of the value in the `value` column of that row.

| Column | Type | Description |
|--------|------|-------------|
| `source_table` | Table | The statistical table |
| `age_band` | Variable | Age in 5 year bands |
| `appointment_status` | Variable | Permanent or temporary appointment |
| `country` | Variable | UK country of workplace, including a marker for overseas |
| `disability` | Variable | Disability status |
| `ethnicity` | Variable | Ethnic background |
| `flow` | Variable | Whether an entrant or leaver |
| `function_of_post` | Variable | Function of post |
| `leaver_cause` | Variable | The reason for leaving the Civil Service |
| `national_identity` | Variable | National identity |
| `nuts2` | Variable | NUTS2 area grouping |
| `nuts3` | Variable | NUTS3 area grouping |
| `organisation` | Variable | Organisation (department/agency) |
| `profession_of_post` | Variable | Profession of post |
| `religion_or_belief` | Variable | Religion or belief |
| `responsibility_level` | Variable | Responsbility level |
| `salary_band` | Variable | Salary in £5,000 bands, or high-earner threshold band |
| `sex` | Variable | Sex |
| `sexual_orientation` | Variable | Sexual orientation |
| `transfer_type` | Variable | Type of internal transfer |
| `uk_region` | Variable | Region of England, country if UK-based but not in England, and a marker for overseas |
| `working_pattern` | Variable | Whether full-time or part-time |
| `note` | Metadata | Technical or statistical quality notes about the cell value |
| `value_class` | Metadata | The general class of value type |
| `value_type` | Metadata | The specific type of value |
| `value` | Value | The value |

#### Value class specification
The `value_class` column defines the general class of the table, it is principally used to distinguish between counts of employees (the vast majority of values) and other types of value.

| Value class | Description |
|--------|-------------|
| `age` | The value is an age statistic, e.g. 47 years |
| `employment` | The value is a count of staff in post employees |
| `flow` | The value is a count of employees, but specifically of entrants, leavers or transfers |
| `salary` | The value is a salary statistic (e.g. £25,000 pounds) or a count of employees by salary band |

#### Value type specification
The `value_type` column defines the specific type of the value.

| Value type | Description |
|--------|-------------|
| `fte` | Counts of employees on a full-time equivalent basis |
| `headcount` | Counts of employees on a headcount basis |
| `highest_5k_pay_band` | Counts of employees (on a headcount basis) over a specific threshold salary |
| `lower_quartile` | The lower quartile salary of this group of employees  |
| `mean` | The mean salary of this group of employees  |
| `median` | The median age or median salary of this group of employees (refer to `value_class`) |
| `pay_ratio` | The ratio of the highest earner to median salary  |
| `upper_quartile` | The upper quartile salary of this group of employees  |

