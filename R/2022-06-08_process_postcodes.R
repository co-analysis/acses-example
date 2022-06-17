# process postcode file

### REQUIRES FEVELOPMENT VERSION OF readODS
### The current CRAN version of readODS includes a bug that
### means the number-rows-repeated attribute is considered
### a marker for blank rows not a sequential set of rows with
### identical values

# remotes::install_github("chainsawriot/readODS/")

library(tidyverse)

postcode_raw <- readODS::read_ods(
  path = file.path(
    "R", "data",
    "Civil-servants-by-postcode-department-responsibility-level-and-leaving-cause-2021.ods"),
  sheet = "Staff_in_post",
  skip = 4
)

postcode_proc <- postcode_raw %>%
  as_tibble() %>%
  purrr::set_names(
    "dept_group",
    "organisation",
    "nuts3",
    "postcode",
    "Senior Civil Service Level",
    "Grades 6 and 7",
    "Senior and Higher Executive Officers",
    "Executive Officers",
    "Administrative Officers and Assistants",
    "Not reported",
    "All employees"
  ) %>%
  pivot_longer(
    cols = c(-dept_group, -organisation, -nuts3, -postcode),
    names_to = "responsibility_level"
  ) %>%
  filter(postcode != "[c]") %>%
  mutate(
    responsibility_level = factor(
      responsibility_level,
      levels = c("Senior Civil Service Level",
                 "Grades 6 and 7",
                 "Senior and Higher Executive Officers",
                 "Executive Officers",
                 "Administrative Officers and Assistants",
                 "Not reported",
                 "All employees")),
    value_type = "headcount",
    value_class = "employment",
    note = case_when(
      str_detect(organisation, "\\[note \\d+\\]") & value == "[c]" ~
        paste0("[", str_replace(organisation, "^.*\\[note (\\d+)\\]$", "\\1"), "], [c]"),
      str_detect(organisation, "\\[note \\d+\\]") ~
        paste0("[", str_replace(organisation, "^.*\\[note (\\d+)\\]$", "\\1"), "]"),
      value == ".." ~ "[c]",
      value == "-" ~ "[z]",
      value == "[c]" ~ "[c]",
      TRUE ~ ""
    ),
    organisation = str_squish(str_remove_all(organisation, "\\[note \\d+\\]")),
    value = case_when(
      note == "" ~ value,
      TRUE ~ "0"
    ),
    value = as.numeric(value)
  ) %>%
  select(organisation, postcode, responsibility_level, value_class,
         value_type, value, note)

all_postcodes <- postcode_proc %>%
  group_by(postcode, responsibility_level) %>%
  summarise(value = sum(value), .groups = "drop") %>%
  mutate(
    organisation = "All employees",
    value_class = "employment",
    value_type = "headcount",
    note = ""
  ) %>%
  select(organisation, postcode, responsibility_level, value_class,
         value_type, value, note)

postcode_out <- bind_rows(postcode_proc, all_postcodes)

write_csv(
  postcode_out,
  "R/data/acses2021_postcodes.csv"
)


# filter NSPL to relevant subset
# due to the size of the National Statistics Postcode Lookup (NSPL) (~1.1GB) it
# should not be kept in the project data folder to minimise copy overheads in
# the govukhugo process
#
# You need to download the data from the ONS GeoPortal
# https://geoportal.statistics.gov.uk/datasets/national-statistics-postcode-lookup-may-2022/about


npsl_centriods <- {
  npsl_file <- rstudioapi::selectFile()
  if (basename(npsl_file) != "NSPL_MAY_2022_UK.csv") {
    cli::cli_abort(c(x = "You must select the file {.file NSPL_MAY_2022_UK.csv}"))
  }
  read_csv(npsl_file)
}

filtered_npsl <- npsl_centriods %>%
  mutate(postcode = str_remove_all(pcds, "\\s")) %>%
  filter(postcode %in% unique(postcode_out$postcode)) %>%
  select(postcode, pcds, lat, long)

write_csv(
  filtered_npsl,
  "R/data/acses_nspl.csv"
)
