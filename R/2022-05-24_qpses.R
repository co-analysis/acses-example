# process QPSES data for organisation employment data

library(tidyverse)

ods_file <- file.path(
  "R",
  "data",
  "Statistical_tables_-_Civil_Service_Statistics_2021.ods"
)

qpses_table <- readODS::read_ods(path = ods_file,
                                 sheet = "Table_11") %>%
  .[9:193, 2:7] %>%
  janitor::remove_empty(which = c("rows", "cols")) %>%
  set_names(
    c("organisation",
      "QPSES|headcount",
      "QPSES|fte",
      "ACSES|headcount",
      "ACSES|fte")) %>%
  as_tibble() %>%
  pivot_longer(cols = -organisation) %>%
  drop_na(value) %>%
  separate(name,
           into = c("data_source", "value_type"),
           sep = "\\|") %>%
  mutate(
    value_class = "employment",
    organisation = str_squish(str_remove_all(organisation, "\\d")),
    value = as.numeric(value)
  )

write_csv(
  qpses_table,
  file.path("R", "data", "qpses_acses_2021.csv")
)

group_lookup <- readODS::read_ods(path = ods_file,
                                  sheet = "Table_11") %>%
  .[9:192, c(2,6)] %>%
  set_names(c("organisation", "value")) %>%
  mutate(organisation = str_squish(str_remove_all(organisation, "\\d"))) %>%
  drop_na(organisation) %>%
  mutate(dept_group = if_else(is.na(value), organisation, NA_character_)) %>%
  fill(dept_group, .direction = "down") %>%
  drop_na(value) %>%
  select(dept_group, organisation)

write_csv(
  group_lookup,
  file.path("R", "data", "dept_group_lookup.csv")
)
)
