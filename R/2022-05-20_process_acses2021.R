# process 2021 published tables

library(tidyverse)

ods_file <- file.path("R", "data", "Statistical_tables_-_Civil_Service_Statistics_2021.ods")

readODS::list_ods_sheets(ods_file)

processed_tables <- list()

# T1: responsibility level and sex ----

processed_tables$table_1 <- readODS::read_ods(path = ods_file, sheet = "Table_1") %>%
  .[9:19, 2:13] %>%
  janitor::remove_empty(which = c("rows", "cols")) %>%
  set_names(c("responsibility_level",
              "Full-time|Male",
              "Full-time|Female",
              "Full-time|All employees",
              "Part-time|Male",
              "Part-time|Female",
              "Part-time|All employees",
              "All employees|Male",
              "All employees|Female",
              "All employees|All employees"
              )) %>%
  as_tibble() %>%
  pivot_longer(cols = -responsibility_level, values_to = "headcount") %>%
  separate(name, into = c("working_pattern", "sex"), sep = "\\|") %>%
  mutate(table = "1")

# T2: responsibility level and ethnicity ----

processed_tables$table_2 <- readODS::read_ods(path = ods_file, sheet = "Table_2") %>%
  .[8:18, 2:14] %>%
  janitor::remove_empty(which = c("rows", "cols")) %>%
  set_names(c("responsibility_level",
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
  )) %>%
  as_tibble() %>%
  pivot_longer(cols = -responsibility_level, names_to = "ethnicity", values_to = "headcount") %>%
  mutate(table = "2")

# T3: responsibility level and ethnicity ----

processed_tables$table_3 <- readODS::read_ods(path = ods_file, sheet = "Table_3") %>%
  .[8:18, 2:9] %>%
  janitor::remove_empty(which = c("rows", "cols")) %>%
  set_names(c("responsibility_level",
              "Disabled",
              "Non-disabled",
              "Not declared",
              "Not reported",
              "All employees",
              "All declared"
  )) %>%
  as_tibble() %>%
  pivot_longer(cols = -responsibility_level, names_to = "disabled", values_to = "headcount") %>%
  mutate(table = "3")

# T4: responsibility level and age band ----

processed_tables$table_4 <- readODS::read_ods(path = ods_file, sheet = "Table_4") %>%
  .[8:18, 2:11] %>%
  janitor::remove_empty(which = c("rows", "cols")) %>%
  set_names(c("responsibility_level",
              "16-19",
              "20-29",
              "30-39",
              "40-49",
              "50-59",
              "60-64",
              "65 & over",
              "Not reported",
              "All employees"
  )) %>%
  as_tibble() %>%
  pivot_longer(cols = -responsibility_level, names_to = "age_band", values_to = "headcount") %>%
  mutate(table = "4")

# T4A: responsibility level and median age ----

processed_tables$table_4a <- readODS::read_ods(path = ods_file, sheet = "Table_4") %>%
  .[8:18, c(2,13)] %>%
  janitor::remove_empty(which = c("rows", "cols")) %>%
  set_names(c("responsibility_level",
              "median_age"
  )) %>%
  as_tibble() %>%
  mutate(table = "4A")

# T5: responsibility level and national identity ----

processed_tables$table_5 <- readODS::read_ods(path = ods_file, sheet = "Table_5") %>%
  .[8:18, 2:11] %>%
  janitor::remove_empty(which = c("rows", "cols")) %>%
  set_names(c("responsibility_level",
              "British or Mixed British",
              "English",
              "Northern Irish",
              "Scottish",
              "Welsh",
              "Other national identity",
              "Not declared",
              "Not reported",
              "All employees"
  )) %>%
  as_tibble() %>%
  pivot_longer(cols = -responsibility_level, names_to = "national_identity", values_to = "headcount") %>%
  mutate(table = "5")

# T6: salary band ----

processed_tables$table_6 <- readODS::read_ods(path = ods_file, sheet = "Table_6") %>%
  .[9:28, 2:13] %>%
  janitor::remove_empty(which = c("rows", "cols")) %>%
  set_names(c("salary_band",
              "Full-time|Male",
              "Full-time|Female",
              "Full-time|All employees",
              "Part-time|Male",
              "Part-time|Female",
              "Part-time|All employees",
              "All employees|Male",
              "All employees|Female",
              "All employees|All employees"
  )) %>%
  as_tibble() %>%
  pivot_longer(cols = -salary_band, values_to = "headcount") %>%
  separate(name, into = c("working_pattern", "sex"), sep = "\\|") %>%
  mutate(table = "6")

processed_tables$table_6a <- readODS::read_ods(path = ods_file, sheet = "Table_6") %>%
  .[31:34, 2:13] %>%
  janitor::remove_empty(which = c("rows", "cols")) %>%
  set_names(c("salary_summary",
              "Full-time|Male",
              "Full-time|Female",
              "Full-time|All employees",
              "Part-time|Male",
              "Part-time|Female",
              "Part-time|All employees",
              "All employees|Male",
              "All employees|Female",
              "All employees|All employees"
  )) %>%
  as_tibble() %>%
  pivot_longer(cols = -salary_summary, values_to = "pounds") %>%
  separate(name, into = c("working_pattern", "sex"), sep = "\\|") %>%
  mutate(table = "6A")

# T7: median salary by responsibility level and sex ----

processed_tables$table_7 <- readODS::read_ods(path = ods_file, sheet = "Table_7") %>%
  .[9:19, 2:9] %>%
  janitor::remove_empty(which = c("rows", "cols")) %>%
  set_names(c("responsibility_level",
              "Male|Full-time",
              "Male|Part-time",
              "Male|All employees",
              "Female|Full-time",
              "Female|Part-time",
              "Female|All employees"
  )) %>%
  as_tibble() %>%
  pivot_longer(cols = -responsibility_level, values_to = "pounds") %>%
  separate(name, into = c("sex", "working_pattern"), sep = "\\|") %>%
  mutate(table = "7")

# T8: organisation and profession ----

t8_raw <- readODS::read_ods(path = ods_file, sheet = "Table_8")

profession_names <- as.character(t8_raw[4,])

processed_tables$table_8 <- t8_raw[8:192, 2:34] %>%
  janitor::remove_empty(which = c("rows", "cols")) %>%
  set_names(c("organisation",
              profession_names[3:34]
  )) %>%
  as_tibble() %>%
  pivot_longer(cols = -organisation, names_to = "profession_of_post", values_to = "headcount") %>%
  drop_na(headcount) %>%
  mutate(
    table = "8",
    note = case_when(
      headcount == "0" & str_detect(organisation, "3") ~ "[x]",
      TRUE ~ headcount
    ),
    organisation = str_squish(str_remove(organisation, "\\d"))
  )

processed_tables$table_8a <- readODS::read_ods(path = ods_file, sheet = "Table_8A") %>%
  .[8:192, 2:34] %>%
  janitor::remove_empty(which = c("rows", "cols")) %>%
  set_names(c("organisation",
              profession_names[3:34]
  )) %>%
  as_tibble() %>%
  pivot_longer(cols = -organisation, names_to = "profession_of_post", values_to = "fte") %>%
  drop_na(fte) %>%
  mutate(
    table = "8A",
    note = case_when(
      fte == "0" & str_detect(organisation, "3") ~ "[x]",
      TRUE ~ fte
    ),
    organisation = str_squish(str_remove(organisation, "\\d"))
  )

# T9: entrants and leavers by responsibility level and sex ----

processed_tables$table_9 <- readODS::read_ods(path = ods_file, sheet = "Table_9") %>%
  .[9:19, 2:9] %>%
  janitor::remove_empty(which = c("rows", "cols")) %>%
  set_names(c("responsibility_level",
              "Entrants|Male",
              "Entrants|Female",
              "Entrants|All employees",
              "Leavers|Male",
              "Leavers|Female",
              "Leavers|All employees"
  )) %>%
  as_tibble() %>%
  pivot_longer(cols = -responsibility_level, values_to = "headcount") %>%
  separate(name, into = c("flow", "sex"), sep = "\\|") %>%
  mutate(table = "9")

# T10: location by contract status ----

processed_tables$table_10 <- readODS::read_ods(path = ods_file, sheet = "Table_10") %>%
  .[19:28, 2:9] %>%
  janitor::remove_empty(which = c("rows", "cols")) %>%
  set_names(c("country",
              "headcount|Permanent",
              "headcount|Temporary",
              "headcount|All employees",
              "fte|Permanent",
              "fte|Temporary",
              "fte|All employees"
  )) %>%
  as_tibble() %>%
  pivot_longer(cols = -country, values_to = "value") %>%
  separate(name, into = c("type", "appointment_status"), sep = "\\|") %>%
  pivot_wider(names_from = type, values_from = value) %>%
  mutate(table = "10")

processed_tables$table_10a <- readODS::read_ods(path = ods_file, sheet = "Table_10") %>%
  .[c(9:17, 20:28), 2:9] %>%
  janitor::remove_empty(which = c("rows", "cols")) %>%
  set_names(c("uk_region",
              "headcount|Permanent",
              "headcount|Temporary",
              "headcount|All employees",
              "fte|Permanent",
              "fte|Temporary",
              "fte|All employees"
  )) %>%
  as_tibble() %>%
  pivot_longer(cols = -uk_region, values_to = "value") %>%
  separate(name, into = c("type", "appointment_status"), sep = "\\|") %>%
  pivot_wider(names_from = type, values_from = value) %>%
  mutate(table = "10A")

# T11: QPSES/ACSES reconciliation ----

processed_tables$table_11 <- readODS::read_ods(path = ods_file, sheet = "Table_11") %>%
  .[9:193, 2:10] %>%
  janitor::remove_empty(which = c("rows", "cols")) %>%
  set_names(c("organisation",
              "QPSES|headcount",
              "QPSES|fte",
              "ACSES|headcount",
              "ACSES|fte",
              "Difference|headcount",
              "Difference|fte"
  )) %>%
  as_tibble() %>%
  pivot_longer(cols = -organisation, values_to = "value") %>%
  drop_na(value) %>%
  separate(name, into = c("source", "type"), sep = "\\|") %>%
  pivot_wider(names_from = "type", values_from = "value") %>%
  mutate(
    table = "11"
  )

# T12: location by organisation ----

processed_tables$table_12 <- readODS::read_ods(path = ods_file, sheet = "Table_12") %>%
  .[8:192, 2:17] %>%
  janitor::remove_empty(which = c("rows", "cols")) %>%
  set_names(c("organisation",
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
  )) %>%
  as_tibble() %>%
  pivot_longer(cols = -organisation, names_to = "uk_region", values_to = "headcount") %>%
  drop_na(headcount) %>%
  mutate(
    table = "12"
  )

# T13: region by contract type, sex, working pattern ----

processed_tables$table_13 <- readODS::read_ods(path = ods_file, sheet = "Table_13") %>%
  .[20:29, 2:25] %>%
  janitor::remove_empty(which = c("rows", "cols")) %>%
  set_names(c("country",
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
  )) %>%
  as_tibble() %>%
  pivot_longer(cols = -country, values_to = "headcount") %>%
  separate(name, into = c("appointment_status", "sex", "working_pattern"), sep = "\\|") %>%
  mutate(table = "13")

processed_tables$table_13a <- readODS::read_ods(path = ods_file, sheet = "Table_13") %>%
  .[c(10:18,21:29), 2:25] %>%
  janitor::remove_empty(which = c("rows", "cols")) %>%
  set_names(c("uk_region",
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
  )) %>%
  as_tibble() %>%
  pivot_longer(cols = -uk_region, values_to = "headcount") %>%
  separate(name, into = c("appointment_status", "sex", "working_pattern"), sep = "\\|") %>%
  mutate(table = "13A")

# T14: NUTS2 distribution ---

processed_tables$table_14 <- readODS::read_ods(path = ods_file, sheet = "Table_14") %>%
  .[10:79, 2:25] %>%
  janitor::remove_empty(which = c("rows", "cols")) %>%
  set_names(c("nuts2",
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
  )) %>%
  as_tibble() %>%
  pivot_longer(cols = -nuts2, values_to = "headcount") %>%
  drop_na(headcount) %>%
  separate(name, into = c("appointment_status", "sex", "working_pattern"), sep = "\\|") %>%
  mutate(table = "14")

# T15: NUTS3 distribution ----

processed_tables$table_15 <- readODS::read_ods(path = ods_file, sheet = "Table_15") %>%
  .[10:258, 2:25] %>%
  janitor::remove_empty(which = c("rows", "cols")) %>%
  set_names(c("nuts3",
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
  )) %>%
  as_tibble() %>%
  pivot_longer(cols = -nuts3, values_to = "headcount") %>%
  drop_na(headcount) %>%
  separate(name, into = c("appointment_status", "sex", "working_pattern"), sep = "\\|") %>%
  mutate(table = "15")

# T16: region, responsibility level and sex ----

processed_tables$table_16 <- readODS::read_ods(path = ods_file, sheet = "Table_16") %>%
  .[8:126, 2:6] %>%
  janitor::remove_empty(which = c("rows", "cols")) %>%
  set_names(c("uk_region",
              "responsibility_level",
              "Male",
              "Female",
              "All employees"
  )) %>%
  as_tibble() %>%
  fill(uk_region, .direction = "down") %>%
  pivot_longer(cols = c(-uk_region, -responsibility_level), names_to = "sex",
               values_to = "headcount") %>%
  drop_na(headcount) %>%
  mutate(table = "16")

# T17: region, responsibility level and ethnicity ----

processed_tables$table_17 <- readODS::read_ods(path = ods_file, sheet = "Table_17") %>%
  .[8:126, 2:10] %>%
  janitor::remove_empty(which = c("rows", "cols")) %>%
  set_names(c("uk_region",
              "responsibility_level",
              "White",
              "Ethnic minority",
              "Not declared",
              "Not reported",
              "All employees",
              "All declared"
  )) %>%
  as_tibble() %>%
  fill(uk_region, .direction = "down") %>%
  pivot_longer(cols = c(-uk_region, -responsibility_level), names_to = "ethnicity_binary",
               values_to = "headcount") %>%
  drop_na(headcount) %>%
  mutate(table = "17")

# T18: region, responsibility level and disability ----

processed_tables$table_18 <- readODS::read_ods(path = ods_file, sheet = "Table_18") %>%
  .[8:126, 2:10] %>%
  janitor::remove_empty(which = c("rows", "cols")) %>%
  set_names(c("uk_region",
              "responsibility_level",
              "Disabled",
              "Non-disabled",
              "Not declared",
              "Not reported",
              "All employees",
              "All declared"
  )) %>%
  as_tibble() %>%
  fill(uk_region, .direction = "down") %>%
  pivot_longer(cols = c(-uk_region, -responsibility_level), names_to = "disability",
               values_to = "headcount") %>%
  drop_na(headcount) %>%
  mutate(table = "18")

# T19: region and age band ----

processed_tables$table_19 <- readODS::read_ods(path = ods_file, sheet = "Table_19") %>%
  .[18:27, 2:11] %>%
  janitor::remove_empty(which = c("rows", "cols")) %>%
  set_names(c("country",
              "16-19",
              "20-29",
              "30-39",
              "40-49",
              "50-59",
              "60-64",
              "65 & over",
              "Not reported",
              "All employees"
  )) %>%
  as_tibble() %>%
  pivot_longer(cols = -country, names_to = "age_band", values_to = "headcount") %>%
  mutate(table = "19")

processed_tables$table_19a <- readODS::read_ods(path = ods_file, sheet = "Table_19") %>%
  .[c(8:16,19:27), 2:11] %>%
  janitor::remove_empty(which = c("rows", "cols")) %>%
  set_names(c("uk_region",
              "16-19",
              "20-29",
              "30-39",
              "40-49",
              "50-59",
              "60-64",
              "65 & over",
              "Not reported",
              "All employees"
  )) %>%
  as_tibble() %>%
  pivot_longer(cols = -uk_region, names_to = "age_band", values_to = "headcount") %>%
  mutate(table = "19A")


# T20/21: responsibility level and organisation ----

processed_tables$table_20 <- readODS::read_ods(path = ods_file, sheet = "Table_20") %>%
  .[8:192, 2:13] %>%
  janitor::remove_empty(which = c("rows", "cols")) %>%
  set_names(c("organisation",
              "Senior Civil Service Level",
              "Grades 6 and 7",
              "Senior and Higher Executive Officers",
              "Executive Officers",
              "Administrative Officers and Assistants",
              "Not reported",
              "All employees"
  )) %>%
  as_tibble() %>%
  pivot_longer(cols = -organisation, names_to = "responsibility_level", values_to = "headcount") %>%
  drop_na(headcount) %>%
  mutate(
    table = "20"
  )

processed_tables$table_21 <- readODS::read_ods(path = ods_file, sheet = "Table_21") %>%
  .[8:192, 2:13] %>%
  janitor::remove_empty(which = c("rows", "cols")) %>%
  set_names(c("organisation",
              "Senior Civil Service Level",
              "Grades 6 and 7",
              "Senior and Higher Executive Officers",
              "Executive Officers",
              "Administrative Officers and Assistants",
              "Not reported",
              "All employees"
  )) %>%
  as_tibble() %>%
  pivot_longer(cols = -organisation, names_to = "responsibility_level", values_to = "fte") %>%
  drop_na(fte) %>%
  mutate(
    table = "21"
  )

# T22: responsibility level, organisation and sex ----

processed_tables$table_22 <- readODS::read_ods(path = ods_file, sheet = "Table_22") %>%
  .[9:193, 2:21] %>%
  janitor::remove_empty(which = c("rows", "cols")) %>%
  set_names(c("organisation",
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
  )) %>%
  as_tibble() %>%
  pivot_longer(cols = -organisation, values_to = "headcount") %>%
  drop_na(headcount) %>%
  separate(name, into = c("responsibility_level", "sex"), sep = "\\|") %>%
  mutate(
    table = "22"
  )

# T23: responsibility level, age band, sex ----
processed_tables$table_23 <- readODS::read_ods(path = ods_file, sheet = "Table_23") %>%
  .[9:19, 2:27] %>%
  janitor::remove_empty(which = c("rows", "cols")) %>%
  set_names(c("organisation",
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
  )) %>%
  as_tibble() %>%
  pivot_longer(cols = -organisation, values_to = "headcount") %>%
  drop_na(headcount) %>%
  separate(name, into = c("responsibility_level", "sex"), sep = "\\|") %>%
  mutate(
    table = "23"
  )

# T24: mean salary by responsibilty level and sex ----

processed_tables$table_24 <- readODS::read_ods(path = ods_file, sheet = "Table_24") %>%
  .[9:19, 2:9] %>%
  janitor::remove_empty(which = c("rows", "cols")) %>%
  set_names(c("responsibility_level",
              "Male|Full-time",
              "Male|Part-time",
              "Male|All employees",
              "Female|Full-time",
              "Female|Part-time",
              "Female|All employees"
  )) %>%
  as_tibble() %>%
  pivot_longer(cols = -responsibility_level, values_to = "pounds") %>%
  separate(name, into = c("sex", "working_pattern"), sep = "\\|") %>%
  mutate(table = "24")

# T25: median salary by organisation and responsibility level ----

processed_tables$table_25 <- readODS::read_ods(path = ods_file, sheet = "Table_25") %>%
  .[8:192, 2:11] %>%
  janitor::remove_empty(which = c("rows", "cols")) %>%
  set_names(c("organisation",
              "Senior Civil Service Level",
              "Grades 6 and 7",
              "Senior and Higher Executive Officers",
              "Executive Officers",
              "Administrative Officers and Assistants",
              "All employees"
  )) %>%
  as_tibble() %>%
  pivot_longer(cols = -organisation, names_to = "responsibility_level", values_to = "pounds") %>%
  drop_na(pounds) %>%
  mutate(
    table = "25"
  )

