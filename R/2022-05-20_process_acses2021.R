# process 2021 published tables

library(tidyverse)

ods_file <- file.path(
  "R",
  "data",
  "Statistical_tables_-_Civil_Service_Statistics_2021.ods"
)

processed_tables <- list()

# T1: responsibility level and sex ----

processed_tables$table_01 <- readODS::read_ods(
  path = ods_file,
  sheet = "Table_1"
) %>%
  .[9:19, 2:13] %>%
  janitor::remove_empty(which = c("rows", "cols")) %>%
  set_names(
    c(
      "responsibility_level",
      "Full-time|Male",
      "Full-time|Female",
      "Full-time|All employees",
      "Part-time|Male",
      "Part-time|Female",
      "Part-time|All employees",
      "All employees|Male",
      "All employees|Female",
      "All employees|All employees"
    )
  ) %>%
  as_tibble() %>%
  pivot_longer(
    cols = -responsibility_level,
    values_to = "value"
  ) %>%
  separate(name,
    into = c("working_pattern", "sex"),
    sep = "\\|"
  ) %>%
  mutate(
    value_type = "headcount",
    value_class = "employment"
  )

# T2: responsibility level and ethnicity ----

processed_tables$table_02 <- readODS::read_ods(
  path = ods_file,
  sheet = "Table_2"
) %>%
  .[8:18, 2:14] %>%
  janitor::remove_empty(which = c("rows", "cols")) %>%
  set_names(
    c(
      "responsibility_level",
      "White",
      "Asian",
      "Black",
      "Chinese",
      "Mixed",
      "Other",
      "Not declared",
      "Not reported",
      "All employees",
      "All declared"
    )
  ) %>%
  as_tibble() %>%
  pivot_longer(
    cols = -responsibility_level,
    names_to = "ethnicity",
    values_to = "value"
  ) %>%
  mutate(
    value_type = "headcount",
    value_class = "employment"
  )

# T3: responsibility level and ethnicity ----

processed_tables$table_03 <- readODS::read_ods(
  path = ods_file,
  sheet = "Table_3"
) %>%
  .[8:18, 2:9] %>%
  janitor::remove_empty(which = c("rows", "cols")) %>%
  set_names(
    c(
      "responsibility_level",
      "Disabled",
      "Non-disabled",
      "Not declared",
      "Not reported",
      "All employees",
      "All declared"
    )
  ) %>%
  as_tibble() %>%
  pivot_longer(
    cols = -responsibility_level,
    names_to = "disability",
    values_to = "value"
  ) %>%
  mutate(
    value_type = "headcount",
    value_class = "employment"
  )

# T4: responsibility level and age band ----

processed_tables$table_04 <- readODS::read_ods(
  path = ods_file,
  sheet = "Table_4"
) %>%
  .[8:18, 2:11] %>%
  janitor::remove_empty(which = c("rows", "cols")) %>%
  set_names(
    c(
      "responsibility_level",
      "16-19",
      "20-29",
      "30-39",
      "40-49",
      "50-59",
      "60-64",
      "65 & over",
      "Not reported",
      "All employees"
    )
  ) %>%
  as_tibble() %>%
  pivot_longer(
    cols = -responsibility_level,
    names_to = "age_band",
    values_to = "value"
  ) %>%
  mutate(
    value_type = "headcount",
    value_class = "employment"
  )

# T4A: responsibility level and median age ----

processed_tables$table_04a <- readODS::read_ods(
  path = ods_file,
  sheet = "Table_4"
) %>%
  .[8:18, c(2, 13)] %>%
  janitor::remove_empty(which = c("rows", "cols")) %>%
  set_names(c(
    "responsibility_level",
    "value"
  )) %>%
  as_tibble() %>%
  mutate(
    value_type = "median",
    value_class = "age"
  )

# T5: responsibility level and national identity ----

processed_tables$table_05 <- readODS::read_ods(
  path = ods_file,
  sheet = "Table_5"
) %>%
  .[8:18, 2:11] %>%
  janitor::remove_empty(which = c("rows", "cols")) %>%
  set_names(
    c(
      "responsibility_level",
      "British or Mixed British",
      "English",
      "Northern Irish",
      "Scottish",
      "Welsh",
      "Other national identity",
      "Not declared",
      "Not reported",
      "All employees"
    )
  ) %>%
  as_tibble() %>%
  pivot_longer(
    cols = -responsibility_level,
    names_to = "national_identity",
    values_to = "value"
  ) %>%
  mutate(
    value_type = "headcount",
    value_class = "employment"
  )

# T6: salary band ----

processed_tables$table_06 <- readODS::read_ods(
  path = ods_file,
  sheet = "Table_6"
) %>%
  .[9:28, 2:13] %>%
  janitor::remove_empty(which = c("rows", "cols")) %>%
  set_names(
    c(
      "salary_band",
      "Full-time|Male",
      "Full-time|Female",
      "Full-time|All employees",
      "Part-time|Male",
      "Part-time|Female",
      "Part-time|All employees",
      "All employees|Male",
      "All employees|Female",
      "All employees|All employees"
    )
  ) %>%
  as_tibble() %>%
  pivot_longer(
    cols = -salary_band,
    values_to = "value"
  ) %>%
  separate(name,
    into = c("working_pattern", "sex"),
    sep = "\\|"
  ) %>%
  mutate(
    value_type = "headcount",
    value_class = "employment"
  )

processed_tables$table_06a <- readODS::read_ods(
  path = ods_file,
  sheet = "Table_6"
) %>%
  .[31:34, 2:13] %>%
  janitor::remove_empty(which = c("rows", "cols")) %>%
  set_names(
    c(
      "value_type",
      "Full-time|Male",
      "Full-time|Female",
      "Full-time|All employees",
      "Part-time|Male",
      "Part-time|Female",
      "Part-time|All employees",
      "All employees|Male",
      "All employees|Female",
      "All employees|All employees"
    )
  ) %>%
  as_tibble() %>%
  mutate(value_type = c("mean", "lower_quartile", "median", "upper_quartile")) %>%
  pivot_longer(
    cols = -value_type,
    values_to = "value"
  ) %>%
  separate(name,
    into = c("working_pattern", "sex"),
    sep = "\\|"
  ) %>%
  mutate(value_class = "salary")

# T7: median salary by responsibility level and sex ----

processed_tables$table_07 <- readODS::read_ods(
  path = ods_file,
  sheet = "Table_7"
) %>%
  .[9:19, 2:9] %>%
  janitor::remove_empty(which = c("rows", "cols")) %>%
  set_names(
    c(
      "responsibility_level",
      "Male|Full-time",
      "Male|Part-time",
      "Male|All employees",
      "Female|Full-time",
      "Female|Part-time",
      "Female|All employees"
    )
  ) %>%
  as_tibble() %>%
  pivot_longer(cols = -responsibility_level, values_to = "value") %>%
  separate(name,
    into = c("sex", "working_pattern"),
    sep = "\\|"
  ) %>%
  mutate(
    value_type = "median",
    value_class = "salary"
  )

# T8: organisation and profession ----

processed_tables$table_08 <- readODS::read_ods(
  path = ods_file,
  sheet = "Table_8"
) %>%
  .[c(4, 8:192), 2:34] %>%
  janitor::remove_empty(which = c("rows", "cols")) %>%
  janitor::row_to_names(1) %>%
  rename(organisation = Department) %>%
  as_tibble() %>%
  pivot_longer(
    cols = -organisation,
    names_to = "profession_of_post",
    values_to = "value"
  ) %>%
  drop_na(value) %>%
  mutate(
    note = case_when(
      value == "0" & str_detect(organisation, "3") ~ "[x]",
      TRUE ~ NA_character_
    ),
    organisation = str_squish(str_remove(organisation, "\\d")),
    value_type = "headcount",
    value_class = "employment"
  )

# T
processed_tables$table_08a <- readODS::read_ods(
  path = ods_file,
  sheet = "Table_8A"
) %>%
  .[c(4, 8:192), 2:34] %>%
  janitor::remove_empty(which = c("rows", "cols")) %>%
  janitor::row_to_names(1) %>%
  rename(organisation = Department) %>%
  as_tibble() %>%
  pivot_longer(
    cols = -organisation,
    names_to = "profession_of_post",
    values_to = "value"
  ) %>%
  drop_na(value) %>%
  mutate(
    note = case_when(
      value == "0" & str_detect(organisation, "3") ~ "[x]",
      TRUE ~ NA_character_
    ),
    organisation = str_squish(str_remove(organisation, "\\d")),
    value_type = "fte",
    value_class = "employment"
  )

# T9: entrants and leavers by responsibility level and sex ----

processed_tables$table_09 <- readODS::read_ods(
  path = ods_file,
  sheet = "Table_9"
) %>%
  .[9:19, 2:9] %>%
  janitor::remove_empty(which = c("rows", "cols")) %>%
  set_names(
    c(
      "responsibility_level",
      "Entrants|Male",
      "Entrants|Female",
      "Entrants|All employees",
      "Leavers|Male",
      "Leavers|Female",
      "Leavers|All employees"
    )
  ) %>%
  as_tibble() %>%
  pivot_longer(
    cols = -responsibility_level,
    values_to = "value"
  ) %>%
  separate(name, into = c("flow", "sex"), sep = "\\|") %>%
  mutate(
    value_type = "headcount",
    value_class = "flow"
  )

# T10: location by contract status ----

processed_tables$table_10 <- readODS::read_ods(
  path = ods_file,
  sheet = "Table_10"
) %>%
  .[19:28, 2:9] %>%
  janitor::remove_empty(which = c("rows", "cols")) %>%
  set_names(
    c(
      "country",
      "headcount|Permanent",
      "headcount|Temporary",
      "headcount|All employees",
      "fte|Permanent",
      "fte|Temporary",
      "fte|All employees"
    )
  ) %>%
  as_tibble() %>%
  pivot_longer(
    cols = -country,
    values_to = "value"
  ) %>%
  separate(name,
    into = c("value_type", "appointment_status"),
    sep = "\\|"
  ) %>%
  mutate(value_class = "employment")

processed_tables$table_10a <- readODS::read_ods(
  path = ods_file,
  sheet = "Table_10"
) %>%
  .[c(9:17, 20:28), 2:9] %>%
  janitor::remove_empty(which = c("rows", "cols")) %>%
  set_names(
    c(
      "uk_region",
      "headcount|Permanent",
      "headcount|Temporary",
      "headcount|All employees",
      "fte|Permanent",
      "fte|Temporary",
      "fte|All employees"
    )
  ) %>%
  as_tibble() %>%
  pivot_longer(
    cols = -uk_region,
    values_to = "value"
  ) %>%
  separate(name,
    into = c("value_type", "appointment_status"),
    sep = "\\|"
  ) %>%
  mutate(value_class = "employment")

# T12: location by organisation ----

processed_tables$table_12 <- readODS::read_ods(
  path = ods_file,
  sheet = "Table_12"
) %>%
  .[8:192, 2:17] %>%
  janitor::remove_empty(which = c("rows", "cols")) %>%
  set_names(
    c(
      "organisation",
      "North East",
      "North West",
      "Yorkshire and The Humber",
      "East Midlands",
      "West Midlands",
      "East of England",
      "London",
      "South East",
      "South West",
      "Wales",
      "Scotland",
      "Northern Ireland",
      "Overseas",
      "Not reported",
      "All employees"
    )
  ) %>%
  as_tibble() %>%
  pivot_longer(
    cols = -organisation,
    names_to = "uk_region",
    values_to = "value"
  ) %>%
  drop_na(value) %>%
  mutate(
    value_type = "headcount",
    value_class = "employment"
  )

# T13: region by contract type, sex, working pattern ----

processed_tables$table_13 <- readODS::read_ods(
  path = ods_file,
  sheet = "Table_13"
) %>%
  .[20:29, 2:25] %>%
  janitor::remove_empty(which = c("rows", "cols")) %>%
  set_names(
    c(
      "country",
      "Permanent|Male|Full-time",
      "Permanent|Male|Part-time",
      "Permanent|Male|All employees",
      "Permanent|Female|Full-time",
      "Permanent|Female|Part-time",
      "Permanent|Female|All employees",
      "Temporary|Male|Full-time",
      "Temporary|Male|Part-time",
      "Temporary|Male|All employees",
      "Temporary|Female|Full-time",
      "Temporary|Female|Part-time",
      "Temporary|Female|All employees",
      "All employees|Male|Full-time",
      "All employees|Male|Part-time",
      "All employees|Male|All employees",
      "All employees|Female|Full-time",
      "All employees|Female|Part-time",
      "All employees|Female|All employees"
    )
  ) %>%
  as_tibble() %>%
  pivot_longer(cols = -country, values_to = "value") %>%
  separate(
    name,
    into = c("appointment_status", "sex", "working_pattern"),
    sep = "\\|"
  ) %>%
  mutate(
    value_type = "headcount",
    value_class = "employment"
  )

processed_tables$table_13a <- readODS::read_ods(
  path = ods_file,
  sheet = "Table_13"
) %>%
  .[c(10:18, 21:29), 2:25] %>%
  janitor::remove_empty(which = c("rows", "cols")) %>%
  set_names(
    c(
      "uk_region",
      "Permanent|Male|Full-time",
      "Permanent|Male|Part-time",
      "Permanent|Male|All employees",
      "Permanent|Female|Full-time",
      "Permanent|Female|Part-time",
      "Permanent|Female|All employees",
      "Temporary|Male|Full-time",
      "Temporary|Male|Part-time",
      "Temporary|Male|All employees",
      "Temporary|Female|Full-time",
      "Temporary|Female|Part-time",
      "Temporary|Female|All employees",
      "All employees|Male|Full-time",
      "All employees|Male|Part-time",
      "All employees|Male|All employees",
      "All employees|Female|Full-time",
      "All employees|Female|Part-time",
      "All employees|Female|All employees"
    )
  ) %>%
  as_tibble() %>%
  pivot_longer(cols = -uk_region, values_to = "value") %>%
  separate(
    name,
    into = c("appointment_status", "sex", "working_pattern"),
    sep = "\\|"
  ) %>%
  mutate(
    value_type = "headcount",
    value_class = "employment"
  )

# T14: NUTS2 distribution ---

processed_tables$table_14 <- readODS::read_ods(
  path = ods_file,
  sheet = "Table_14"
) %>%
  .[10:79, 2:25] %>%
  janitor::remove_empty(which = c("rows", "cols")) %>%
  set_names(
    c(
      "nuts2",
      "Permanent|Male|Full-time",
      "Permanent|Male|Part-time",
      "Permanent|Male|All employees",
      "Permanent|Female|Full-time",
      "Permanent|Female|Part-time",
      "Permanent|Female|All employees",
      "Temporary|Male|Full-time",
      "Temporary|Male|Part-time",
      "Temporary|Male|All employees",
      "Temporary|Female|Full-time",
      "Temporary|Female|Part-time",
      "Temporary|Female|All employees",
      "All employees|Male|Full-time",
      "All employees|Male|Part-time",
      "All employees|Male|All employees",
      "All employees|Female|Full-time",
      "All employees|Female|Part-time",
      "All employees|Female|All employees"
    )
  ) %>%
  as_tibble() %>%
  pivot_longer(cols = -nuts2, values_to = "value") %>%
  drop_na(value) %>%
  separate(
    name,
    into = c("appointment_status", "sex", "working_pattern"),
    sep = "\\|"
  ) %>%
  mutate(
    value_type = "headcount",
    value_class = "employment"
  )

# T15: NUTS3 distribution ----

processed_tables$table_15 <- readODS::read_ods(
  path = ods_file,
  sheet = "Table_15"
) %>%
  .[10:258, 2:25] %>%
  janitor::remove_empty(which = c("rows", "cols")) %>%
  set_names(
    c(
      "nuts3",
      "Permanent|Male|Full-time",
      "Permanent|Male|Part-time",
      "Permanent|Male|All employees",
      "Permanent|Female|Full-time",
      "Permanent|Female|Part-time",
      "Permanent|Female|All employees",
      "Temporary|Male|Full-time",
      "Temporary|Male|Part-time",
      "Temporary|Male|All employees",
      "Temporary|Female|Full-time",
      "Temporary|Female|Part-time",
      "Temporary|Female|All employees",
      "All employees|Male|Full-time",
      "All employees|Male|Part-time",
      "All employees|Male|All employees",
      "All employees|Female|Full-time",
      "All employees|Female|Part-time",
      "All employees|Female|All employees"
    )
  ) %>%
  as_tibble() %>%
  pivot_longer(cols = -nuts3, values_to = "value") %>%
  drop_na(value) %>%
  separate(
    name,
    into = c("appointment_status", "sex", "working_pattern"),
    sep = "\\|"
  ) %>%
  mutate(
    value_type = "headcount",
    value_class = "employment"
  )

# T16: region, responsibility level and sex ----

processed_tables$table_16 <- readODS::read_ods(
  path = ods_file,
  sheet = "Table_16"
) %>%
  .[8:126, 2:6] %>%
  janitor::remove_empty(which = c("rows", "cols")) %>%
  set_names(c(
    "uk_region",
    "responsibility_level",
    "Male",
    "Female",
    "All employees"
  )) %>%
  as_tibble() %>%
  fill(uk_region, .direction = "down") %>%
  pivot_longer(
    cols = c(-uk_region, -responsibility_level),
    names_to = "sex",
    values_to = "value"
  ) %>%
  drop_na(value) %>%
  mutate(
    value_type = "headcount",
    value_class = "employment"
  )

# T17: region, responsibility level and ethnicity ----

processed_tables$table_17 <- readODS::read_ods(
  path = ods_file,
  sheet = "Table_17"
) %>%
  .[8:126, 2:10] %>%
  janitor::remove_empty(which = c("rows", "cols")) %>%
  set_names(
    c(
      "uk_region",
      "responsibility_level",
      "White",
      "Ethnic minority",
      "Not declared",
      "Not reported",
      "All employees",
      "All declared"
    )
  ) %>%
  as_tibble() %>%
  fill(uk_region, .direction = "down") %>%
  pivot_longer(
    cols = c(-uk_region, -responsibility_level),
    names_to = "ethnicity"
  ) %>%
  drop_na(value) %>%
  mutate(
    value_type = "headcount",
    value_class = "employment"
  )

# T18: region, responsibility level and disability ----

processed_tables$table_18 <- readODS::read_ods(
  path = ods_file,
  sheet = "Table_18"
) %>%
  .[8:126, 2:10] %>%
  janitor::remove_empty(which = c("rows", "cols")) %>%
  set_names(
    c(
      "uk_region",
      "responsibility_level",
      "Disabled",
      "Non-disabled",
      "Not declared",
      "Not reported",
      "All employees",
      "All declared"
    )
  ) %>%
  as_tibble() %>%
  fill(uk_region, .direction = "down") %>%
  pivot_longer(
    cols = c(-uk_region, -responsibility_level),
    names_to = "disability",
  ) %>%
  drop_na(value) %>%
  mutate(
    value_type = "headcount",
    value_class = "employment"
  )

# T19: region and age band ----

processed_tables$table_19 <- readODS::read_ods(
  path = ods_file,
  sheet = "Table_19"
) %>%
  .[18:27, 2:11] %>%
  janitor::remove_empty(which = c("rows", "cols")) %>%
  set_names(
    c(
      "country",
      "16-19",
      "20-29",
      "30-39",
      "40-49",
      "50-59",
      "60-64",
      "65 & over",
      "Not reported",
      "All employees"
    )
  ) %>%
  as_tibble() %>%
  pivot_longer(
    cols = -country,
    names_to = "age_band"
  ) %>%
  mutate(
    value_type = "headcount",
    value_class = "employment"
  )

processed_tables$table_19a <- readODS::read_ods(
  path = ods_file,
  sheet = "Table_19"
) %>%
  .[c(8:16, 19:27), 2:11] %>%
  janitor::remove_empty(which = c("rows", "cols")) %>%
  set_names(
    c(
      "uk_region",
      "16-19",
      "20-29",
      "30-39",
      "40-49",
      "50-59",
      "60-64",
      "65 & over",
      "Not reported",
      "All employees"
    )
  ) %>%
  as_tibble() %>%
  pivot_longer(cols = -uk_region, names_to = "age_band") %>%
  mutate(
    value_type = "headcount",
    value_class = "employment"
  )


# T20/21: responsibility level and organisation ----

processed_tables$table_20 <- readODS::read_ods(
  path = ods_file,
  sheet = "Table_20"
) %>%
  .[8:192, 2:13] %>%
  janitor::remove_empty(which = c("rows", "cols")) %>%
  set_names(
    c(
      "organisation",
      "Senior Civil Service Level",
      "Grades 6 and 7",
      "Senior and Higher Executive Officers",
      "Executive Officers",
      "Administrative Officers and Assistants",
      "Not reported",
      "All employees"
    )
  ) %>%
  as_tibble() %>%
  pivot_longer(cols = -organisation, names_to = "responsibility_level") %>%
  drop_na(value) %>%
  mutate(
    value_type = "headcount",
    value_class = "employment"
  )

processed_tables$table_21 <- readODS::read_ods(
  path = ods_file,
  sheet = "Table_21"
) %>%
  .[8:192, 2:13] %>%
  janitor::remove_empty(which = c("rows", "cols")) %>%
  set_names(
    c(
      "organisation",
      "Senior Civil Service Level",
      "Grades 6 and 7",
      "Senior and Higher Executive Officers",
      "Executive Officers",
      "Administrative Officers and Assistants",
      "Not reported",
      "All employees"
    )
  ) %>%
  as_tibble() %>%
  pivot_longer(cols = -organisation, names_to = "responsibility_level") %>%
  drop_na(value) %>%
  mutate(
    value_type = "fte",
    value_class = "employment"
  )

# T22: responsibility level, organisation and sex ----

processed_tables$table_22 <- readODS::read_ods(
  path = ods_file,
  sheet = "Table_22"
) %>%
  .[9:193, 2:21] %>%
  janitor::remove_empty(which = c("rows", "cols")) %>%
  set_names(
    c(
      "organisation",
      "Senior Civil Service Level|Male",
      "Senior Civil Service Level|Female",
      "Grades 6 and 7|Male",
      "Grades 6 and 7|Female",
      "Senior and Higher Executive Officers|Male",
      "Senior and Higher Executive Officers|Female",
      "Executive Officers|Male",
      "Executive Officers|Female",
      "Administrative Officers and Assistants|Male",
      "Administrative Officers and Assistants|Female",
      "Not reported|Male",
      "Not reported|Female",
      "All employees|All employees"
    )
  ) %>%
  as_tibble() %>%
  pivot_longer(cols = -organisation) %>%
  drop_na(value) %>%
  separate(name,
    into = c("responsibility_level", "sex"),
    sep = "\\|"
  ) %>%
  mutate(
    value_type = "headcount",
    value_class = "employment"
  )

# T23: responsibility level, age band, sex ----
processed_tables$table_23 <- readODS::read_ods(
  path = ods_file,
  sheet = "Table_23"
) %>%
  .[9:19, 2:27] %>%
  janitor::remove_empty(which = c("rows", "cols")) %>%
  set_names(
    c(
      "responsibility_level",
      "16-19|Male",
      "16-19|Female",
      "20-29|Male",
      "20-29|Female",
      "30-39|Male",
      "30-39|Female",
      "40-49|Male",
      "40-49|Female",
      "50-59|Male",
      "50-59|Female",
      "60-64|Male",
      "60-64|Female",
      "65 & over|Male",
      "65 & over|Female",
      "Not reported|Male",
      "Not reported|Female",
      "All employees|All employees"
    )
  ) %>%
  as_tibble() %>%
  pivot_longer(cols = -responsibility_level) %>%
  drop_na(value) %>%
  separate(name, into = c("age_band", "sex"), sep = "\\|") %>%
  mutate(
    value_type = "headcount",
    value_class = "employment"
  )

# T24: mean salary by responsibility level and sex ----

processed_tables$table_24 <- readODS::read_ods(
  path = ods_file,
  sheet = "Table_24"
) %>%
  .[9:19, 2:9] %>%
  janitor::remove_empty(which = c("rows", "cols")) %>%
  set_names(
    c(
      "responsibility_level",
      "Male|Full-time",
      "Male|Part-time",
      "Male|All employees",
      "Female|Full-time",
      "Female|Part-time",
      "Female|All employees"
    )
  ) %>%
  as_tibble() %>%
  pivot_longer(cols = -responsibility_level, values_to = "value") %>%
  separate(name,
    into = c("sex", "working_pattern"),
    sep = "\\|"
  ) %>%
  mutate(
    value_type = "mean",
    value_class = "salary"
  )

# T25: median salary by organisation and responsibility level ----

processed_tables$table_25 <- readODS::read_ods(
  path = ods_file,
  sheet = "Table_25"
) %>%
  .[8:192, 2:11] %>%
  janitor::remove_empty(which = c("rows", "cols")) %>%
  set_names(
    c(
      "organisation",
      "Senior Civil Service Level",
      "Grades 6 and 7",
      "Senior and Higher Executive Officers",
      "Executive Officers",
      "Administrative Officers and Assistants",
      "All employees"
    )
  ) %>%
  as_tibble() %>%
  pivot_longer(cols = -organisation, names_to = "responsibility_level") %>%
  drop_na(value) %>%
  mutate(
    value_type = "median",
    value_class = "salary"
  )

# T26: median salary by region and responsibility level ----

processed_tables$table_26 <- readODS::read_ods(
  path = ods_file,
  sheet = "Table_26"
) %>%
  .[18:27, 2:11] %>%
  janitor::remove_empty(which = c("rows", "cols")) %>%
  set_names(
    c(
      "country",
      "Senior Civil Service Level",
      "Grades 6 and 7",
      "Senior and Higher Executive Officers",
      "Executive Officers",
      "Administrative Officers and Assistants",
      "All employees"
    )
  ) %>%
  as_tibble() %>%
  pivot_longer(cols = -country, names_to = "responsibility_level") %>%
  mutate(
    value_type = "median",
    value_class = "salary"
  )

processed_tables$table_26a <-
  readODS::read_ods(path = ods_file, sheet = "Table_26") %>%
  .[c(8:16, 19:27), 2:11] %>%
  janitor::remove_empty(which = c("rows", "cols")) %>%
  set_names(
    c(
      "uk_region",
      "Senior Civil Service Level",
      "Grades 6 and 7",
      "Senior and Higher Executive Officers",
      "Executive Officers",
      "Administrative Officers and Assistants",
      "All employees"
    )
  ) %>%
  as_tibble() %>%
  pivot_longer(cols = -uk_region, names_to = "responsibility_level") %>%
  mutate(
    value_type = "median",
    value_class = "salary"
  )

# T27: median salary by ethnicity and responsibility level ----

processed_tables$table_27 <- readODS::read_ods(
  path = ods_file,
  sheet = "Table_27"
) %>%
  .[8:18, 2:11] %>%
  janitor::remove_empty(which = c("rows", "cols")) %>%
  set_names(
    c(
      "responsibility_level",
      "White",
      "Asian",
      "Black",
      "Chinese",
      "Mixed",
      "Other ethnicity",
      "Not declared",
      "Not reported",
      "All employees"
    )
  ) %>%
  as_tibble() %>%
  pivot_longer(cols = -responsibility_level, names_to = "ethnicity") %>%
  mutate(
    value_type = "median",
    value_class = "salary"
  )

# T28: median salary by disability and responsibility level ----

processed_tables$table_28 <- readODS::read_ods(
  path = ods_file,
  sheet = "Table_28"
) %>%
  .[8:18, 2:7] %>%
  janitor::remove_empty(which = c("rows", "cols")) %>%
  set_names(
    c(
      "responsibility_level",
      "Disabled",
      "Non-disabled",
      "Not declared",
      "Not reported",
      "All employees"
    )
  ) %>%
  as_tibble() %>%
  pivot_longer(cols = -responsibility_level, names_to = "disability") %>%
  mutate(
    value_type = "median",
    value_class = "salary"
  )

# T29: median and mean salary by organisation and sex (FT) ----

processed_tables$table_29 <- readODS::read_ods(
  path = ods_file,
  sheet = "Table_29"
) %>%
  .[9:193, 2:4] %>%
  janitor::remove_empty(which = c("rows", "cols")) %>%
  set_names(c(
    "organisation",
    "Male",
    "Female"
  )) %>%
  as_tibble() %>%
  pivot_longer(cols = -organisation, names_to = "sex") %>%
  drop_na(value) %>%
  mutate(
    working_pattern = "Full-time",
    value_type = "median",
    value_class = "salary"
  )

processed_tables$table_29a <- readODS::read_ods(
  path = ods_file,
  sheet = "Table_29"
) %>%
  .[9:193, c(2, 7:8)] %>%
  janitor::remove_empty(which = c("rows", "cols")) %>%
  set_names(c(
    "organisation",
    "Male",
    "Female"
  )) %>%
  as_tibble() %>%
  pivot_longer(cols = -organisation, names_to = "sex") %>%
  drop_na(value) %>%
  mutate(
    working_pattern = "Full-time",
    value_type = "mean",
    value_class = "salary"
  )

# T30: median and mean salary by organisation and sex (PT) ----

processed_tables$table_30 <- readODS::read_ods(
  path = ods_file,
  sheet = "Table_30"
) %>%
  .[9:193, 2:4] %>%
  janitor::remove_empty(which = c("rows", "cols")) %>%
  set_names(c(
    "organisation",
    "Male",
    "Female"
  )) %>%
  as_tibble() %>%
  pivot_longer(cols = -organisation, names_to = "sex") %>%
  drop_na(value) %>%
  mutate(
    working_pattern = "Part-time",
    value_type = "median",
    value_class = "salary"
  )

processed_tables$table_30a <- readODS::read_ods(
  path = ods_file,
  sheet = "Table_30"
) %>%
  .[9:193, c(2, 7:8)] %>%
  janitor::remove_empty(which = c("rows", "cols")) %>%
  set_names(c(
    "organisation",
    "Male",
    "Female"
  )) %>%
  as_tibble() %>%
  pivot_longer(cols = -organisation, names_to = "sex") %>%
  drop_na(value) %>%
  mutate(
    working_pattern = "Part-time",
    value_type = "mean",
    value_class = "salary"
  )

# T31: median and mean salary by organisation and sex (all) ----

processed_tables$table_31 <- readODS::read_ods(
  path = ods_file,
  sheet = "Table_31"
) %>%
  .[9:193, 2:4] %>%
  janitor::remove_empty(which = c("rows", "cols")) %>%
  set_names(c(
    "organisation",
    "Male",
    "Female"
  )) %>%
  as_tibble() %>%
  pivot_longer(cols = -organisation, names_to = "sex") %>%
  drop_na(value) %>%
  mutate(
    working_pattern = "All Employees",
    value_type = "median",
    value_class = "salary"
  )

processed_tables$table_31a <- readODS::read_ods(
  path = ods_file,
  sheet = "Table_31"
) %>%
  .[9:193, c(2, 7:8)] %>%
  janitor::remove_empty(which = c("rows", "cols")) %>%
  set_names(c(
    "organisation",
    "Male",
    "Female"
  )) %>%
  as_tibble() %>%
  pivot_longer(cols = -organisation, names_to = "sex") %>%
  drop_na(value) %>%
  mutate(
    working_pattern = "All Employees",
    value_type = "mean",
    value_class = "salary"
  )

# T32: median salary by organisation and sex (all) ----

processed_tables$table_32 <- readODS::read_ods(
  path = ods_file,
  sheet = "Table_32"
) %>%
  .[9:193, c(2:4, 7:8, 11:12, 15:16, 19:20)] %>%
  janitor::remove_empty(which = c("rows", "cols")) %>%
  set_names(
    c(
      "organisation",
      "Senior Civil Service Level|Male",
      "Senior Civil Service Level|Female",
      "Grades 6 and 7|Male",
      "Grades 6 and 7|Female",
      "Senior and Higher Executive Officers|Male",
      "Senior and Higher Executive Officers|Female",
      "Executive Officers|Male",
      "Executive Officers|Female",
      "Administrative Officers and Assistants|Male",
      "Administrative Officers and Assistants|Female"
    )
  ) %>%
  as_tibble() %>%
  pivot_longer(cols = -organisation, names_to = "type") %>%
  drop_na(value) %>%
  separate(type,
    into = c("responsibility_level", "sex"),
    sep = "\\|"
  ) %>%
  mutate(
    working_pattern = "All Employees",
    value_type = "median",
    value_class = "salary"
  )

# T33: mean salary by organisation and sex (all) ----

processed_tables$table_33 <- readODS::read_ods(
  path = ods_file,
  sheet = "Table_33"
) %>%
  .[9:193, c(2:4, 7:8, 11:12, 15:16, 19:20)] %>%
  janitor::remove_empty(which = c("rows", "cols")) %>%
  set_names(
    c(
      "organisation",
      "Senior Civil Service Level|Male",
      "Senior Civil Service Level|Female",
      "Grades 6 and 7|Male",
      "Grades 6 and 7|Female",
      "Senior and Higher Executive Officers|Male",
      "Senior and Higher Executive Officers|Female",
      "Executive Officers|Male",
      "Executive Officers|Female",
      "Administrative Officers and Assistants|Male",
      "Administrative Officers and Assistants|Female"
    )
  ) %>%
  as_tibble() %>%
  pivot_longer(cols = -organisation, names_to = "type") %>%
  drop_na(value) %>%
  separate(type,
    into = c("responsibility_level", "sex"),
    sep = "\\|"
  ) %>%
  mutate(
    working_pattern = "All Employees",
    value_type = "mean",
    value_class = "salary"
  )

# T35: number of civil servants in high pay bands ----

processed_tables$table_35 <- readODS::read_ods(
  path = ods_file,
  sheet = "Table_35"
) %>%
  .[c(4, 8), 3:5] %>%
  janitor::row_to_names(1) %>%
  pivot_longer(cols = everything(), names_to = "salary_band") %>%
  mutate(
    working_pattern = "All Employees",
    value_type = "headcount",
    value_class = "employment"
  )

# T37: employment by organisation and ethnicity ----

processed_tables$table_37 <- readODS::read_ods(
  path = ods_file,
  sheet = "Table_37"
) %>%
  .[8:192, 2:9] %>%
  janitor::remove_empty(which = c("rows", "cols")) %>%
  set_names(
    c(
      "organisation",
      "White",
      "Ethnic minority",
      "Not declared",
      "Not reported",
      "All employees",
      "All declared"
    )
  ) %>%
  as_tibble() %>%
  pivot_longer(cols = -organisation, names_to = "ethnicity") %>%
  drop_na(value) %>%
  mutate(
    value_type = "headcount",
    value_class = "salary"
  )

# T38: employment by organisation and disability ----

processed_tables$table_38 <- readODS::read_ods(
  path = ods_file,
  sheet = "Table_38"
) %>%
  .[8:192, 2:9] %>%
  janitor::remove_empty(which = c("rows", "cols")) %>%
  set_names(
    c(
      "organisation",
      "White",
      "Ethnic minority",
      "Not declared",
      "Not reported",
      "All employees",
      "All declared"
    )
  ) %>%
  as_tibble() %>%
  pivot_longer(cols = -organisation, names_to = "ethnicity") %>%
  drop_na(value) %>%
  mutate(
    value_type = "headcount",
    value_class = "employment"
  )

# T39: employment by organisation and age band ----

processed_tables$table_39 <- readODS::read_ods(
  path = ods_file,
  sheet = "Table_39"
) %>%
  .[8:192, 2:11] %>%
  janitor::remove_empty(which = c("rows", "cols")) %>%
  set_names(
    c(
      "organisation",
      "16-19",
      "20-29",
      "30-39",
      "40-49",
      "50-59",
      "60-64",
      "65 & over",
      "Not reported",
      "All employees"
    )
  ) %>%
  as_tibble() %>%
  pivot_longer(cols = -organisation, names_to = "age_band") %>%
  drop_na(value) %>%
  mutate(
    value_type = "headcount",
    value_class = "employment"
  )

# T40: entrants and leavers by organisation and sex ----

processed_tables$table_40 <- readODS::read_ods(
  path = ods_file,
  sheet = "Table_40"
) %>%
  .[9:193, 2:9] %>%
  janitor::remove_empty(which = c("rows", "cols")) %>%
  set_names(
    c(
      "organisation",
      "Entrants|Male",
      "Entrants|Female",
      "Entrants|All employees",
      "Leavers|Male",
      "Leavers|Female",
      "Leavers|All employees"
    )
  ) %>%
  as_tibble() %>%
  pivot_longer(cols = -organisation) %>%
  drop_na(value) %>%
  separate(name, into = c("flow", "sex"), sep = "\\|") %>%
  mutate(
    value_type = "headcount",
    value_class = "employment"
  )

# T41: entrants and leavers by organisation and ethnicity ----

processed_tables$table_41 <- readODS::read_ods(
  path = ods_file,
  sheet = "Table_41"
) %>%
  .[9:193, 2:19] %>%
  janitor::remove_empty(which = c("rows", "cols")) %>%
  set_names(
    c(
      "organisation",
      "White|Entrants",
      "White|Leavers",
      "Ethnicy minority|Entrants",
      "Ethnicy minority|Leavers",
      "Not declared|Entrants",
      "Not declared|Leavers",
      "Not reported|Entrants",
      "Not reported|Leavers",
      "All employees|Entrants",
      "All employees|Leavers",
      "All declared|Entrants",
      "All declared|Leavers"
    )
  ) %>%
  as_tibble() %>%
  pivot_longer(cols = -organisation) %>%
  drop_na(value) %>%
  separate(name, into = c("ethnicity", "flow"), sep = "\\|") %>%
  mutate(
    value_type = "headcount",
    value_class = "employment"
  )

# T42: leaver by organisation and leaving cause ----

processed_tables$table_42 <- readODS::read_ods(
  path = ods_file,
  sheet = "Table_42"
) %>%
  .[c(4, 8:194), 2:20] %>%
  janitor::row_to_names(1) %>%
  rename(organisation = Department) %>%
  janitor::remove_empty(which = c("rows", "cols")) %>%
  as_tibble() %>%
  pivot_longer(cols = -organisation, names_to = "leaver_cause") %>%
  drop_na(value) %>%
  mutate(
    value_type = "headcount",
    value_class = "employment"
  )

# T43: internal transfers ----

processed_tables$table_43 <- readODS::read_ods(
  path = ods_file,
  sheet = "Table_43"
) %>%
  .[c(4, 8:194), 2:7] %>%
  janitor::row_to_names(1) %>%
  rename(organisation = Department) %>%
  janitor::remove_empty(which = c("rows", "cols")) %>%
  as_tibble() %>%
  pivot_longer(cols = -organisation, names_to = "transfer_type") %>%
  drop_na(value) %>%
  mutate(
    value_type = "headcount",
    value_class = "employment"
  )

# T45: salary quartiles by profession ----

processed_tables$table_45 <- readODS::read_ods(
  path = ods_file,
  sheet = "Table_45"
) %>%
  .[8:41, 2:7] %>%
  janitor::remove_empty(which = c("rows", "cols")) %>%
  set_names(c(
    "profession_of_post",
    "lower_quartile",
    "median",
    "upper_quartile"
  )) %>%
  as_tibble() %>%
  pivot_longer(cols = -profession_of_post, names_to = "value_type") %>%
  mutate(value_class = "salary")

# T47: employment by region and profession ----

processed_tables$table_47 <- readODS::read_ods(
  path = ods_file,
  sheet = "Table_47"
) %>%
  .[c(4, 8:41), 2:17] %>%
  janitor::remove_empty(which = c("rows", "cols")) %>%
  janitor::row_to_names(1) %>%
  rename(profession_of_post = `Profession of post3`) %>%
  as_tibble() %>%
  pivot_longer(cols = -profession_of_post, names_to = "uk_region") %>%
  mutate(
    value_type = "headcount",
    value_class = "employment"
  )

# TA1: employment by sexual orientation and department ----

processed_tables$table_a1 <- readODS::read_ods(
  path = ods_file,
  sheet = "Table_A1"
) %>%
  .[8:192, 2:11] %>%
  janitor::remove_empty(which = c("rows", "cols")) %>%
  set_names(
    c(
      "organisation",
      "Bisexual",
      "Gay/Lesbian",
      "Heterosexual/Straight",
      "Other",
      "Not declared",
      "Not reported",
      "All employees",
      "All declared"
    )
  ) %>%
  as_tibble() %>%
  pivot_longer(cols = -organisation, names_to = "sexual_orientation") %>%
  drop_na(value) %>%
  mutate(
    value_type = "headcount",
    value_class = "employment"
  )

# TA2: employment by sexual orientation and responsibility level ----

processed_tables$table_a2 <- readODS::read_ods(
  path = ods_file,
  sheet = "Table_A2"
) %>%
  .[8:18, 2:11] %>%
  janitor::remove_empty(which = c("rows", "cols")) %>%
  set_names(
    c(
      "responsibility_level",
      "Bisexual",
      "Gay/Lesbian",
      "Heterosexual/Straight",
      "Other",
      "Not declared",
      "Not reported",
      "All employees",
      "All declared"
    )
  ) %>%
  as_tibble() %>%
  pivot_longer(cols = -responsibility_level, names_to = "sexual_orientation") %>%
  mutate(
    value_type = "headcount",
    value_class = "employment"
  )

# TA3: employment by religion and organisation ----

processed_tables$table_a3 <- readODS::read_ods(
  path = ods_file,
  sheet = "Table_A3"
) %>%
  .[8:192, 2:15] %>%
  janitor::remove_empty(which = c("rows", "cols")) %>%
  set_names(
    c(
      "organisation",
      "Christian",
      "Buddhist",
      "Hindu",
      "Jewish",
      "Muslim",
      "Sikh",
      "Any other religion",
      "No religion",
      "Not declared",
      "Not reported",
      "All employees",
      "All declared"
    )
  ) %>%
  as_tibble() %>%
  pivot_longer(cols = -organisation, names_to = "religion_or_belief") %>%
  drop_na(value) %>%
  mutate(
    value_type = "headcount",
    value_class = "employment"
  )

# TA4: employment by religion and responsibility level ----

processed_tables$table_a4 <- readODS::read_ods(
  path = ods_file,
  sheet = "Table_A4"
) %>%
  .[8:18, 2:15] %>%
  janitor::remove_empty(which = c("rows", "cols")) %>%
  set_names(
    c(
      "responsibility_level",
      "Christian",
      "Buddhist",
      "Hindu",
      "Jewish",
      "Muslim",
      "Sikh",
      "Any other religion",
      "No religion",
      "Not declared",
      "Not reported",
      "All employees",
      "All declared"
    )
  ) %>%
  as_tibble() %>%
  pivot_longer(cols = -responsibility_level, names_to = "religion_or_belief") %>%
  mutate(
    value_type = "headcount",
    value_class = "employment"
  )

# TB: pay ratio by organisation ----

processed_tables$table_b <- readODS::read_ods(
  path = ods_file,
  sheet = "Table_B"
) %>%
  .[8:192, 2:7] %>%
  janitor::remove_empty(which = c("rows", "cols")) %>%
  set_names(c(
    "organisation",
    "highest_5k_pay_band",
    "median",
    "pay_ratio"
  )) %>%
  as_tibble() %>%
  pivot_longer(cols = -organisation, names_to = "value_type") %>%
  drop_na(value) %>%
  mutate(value_class = "salary")

# TD1: employment by function and organisation ----

processed_tables$table_d1 <- readODS::read_ods(
  path = ods_file,
  sheet = "Table_D1"
) %>%
  .[c(4, 8:192), 2:19] %>%
  janitor::row_to_names(1) %>%
  janitor::remove_empty(which = c("rows", "cols")) %>%
  rename(organisation = Department) %>%
  as_tibble() %>%
  pivot_longer(cols = -organisation, names_to = "function_of_post") %>%
  drop_na(value) %>%
  mutate(
    value_type = "headcount",
    value_class = "employment"
  )

# TD2: employment by function and organisation ----

processed_tables$table_d2 <- readODS::read_ods(
  path = ods_file,
  sheet = "Table_D2"
) %>%
  .[c(4, 8:192), 2:19] %>%
  janitor::row_to_names(1) %>%
  janitor::remove_empty(which = c("rows", "cols")) %>%
  rename(organisation = Department) %>%
  as_tibble() %>%
  pivot_longer(cols = -organisation, names_to = "function_of_post") %>%
  drop_na(value) %>%
  mutate(
    value_type = "fte",
    value_class = "employment"
  )

# TD3: salary quartiles by function ---

processed_tables$table_d3 <- readODS::read_ods(
  path = ods_file,
  sheet = "Table_D3"
) %>%
  .[8:26, 2:7] %>%
  janitor::remove_empty(which = c("rows", "cols")) %>%
  set_names(c(
    "function_of_post",
    "lower_quartile",
    "median",
    "upper_quartile"
  )) %>%
  as_tibble() %>%
  pivot_longer(cols = -function_of_post, names_to = "value_type") %>%
  mutate(value_class = "salary")

# TD4: employment by function and region ----

processed_tables$table_d4 <- readODS::read_ods(
  path = ods_file,
  sheet = "Table_D4"
) %>%
  .[c(4, 8:26), 2:17] %>%
  janitor::row_to_names(1) %>%
  janitor::remove_empty(which = c("rows", "cols")) %>%
  rename(function_of_post = Function3) %>%
  as_tibble() %>%
  pivot_longer(cols = -function_of_post, names_to = "uk_region") %>%
  drop_na(value) %>%
  mutate(
    value_type = "headcount",
    value_class = "employment"
  )

# aggregate tables ----

aggregate_tables <- bind_rows(processed_tables,
  .id = "source_table"
) %>%
  mutate(
    organisation = str_squish(str_remove_all(organisation, "\\d")),
    note = case_when(
      value == ".." ~ "[c]",
      value == "-" ~ "[z]",
      TRUE ~ ""
    ),
    value = case_when(
      !is.na(note) ~ "0",
      TRUE ~ value
    ),
    value = as.numeric(value)
  ) %>%
  select(
    source_table,
    one_of(sort(names(.)))
  ) %>%
  relocate(value_class, value_type, value,
    .after = last_col()
  )

# write csv ----

write_csv(aggregate_tables,
  "R/data/acses2021_processed.csv",
  na = "All employees"
)

### END NOTES ----

# Table 11 not processed as comparative between QPSES and ACSES
# Tables 34, 36, 44, 46,  only contain percentages
