
### ACSES 2021: CIVIL SERVICE STATISTICS RELEASE

# Source page: https://www.gov.uk/government/statistics/civil-service-statistics-2021
# acses2021_release <- "https://assets.publishing.service.gov.uk/government/uploads/system/uploads/attachment_data/file/1006365/Statistical_tables_-_Civil_Service_Statistics_2021.ods"

download.file(acses2021_release,
              file.path("R", "data", basename(acses2021_release)))

# processed file
file.copy(
  file.path("static", "files", "acses2021_processed.csv"),
  file.path("R", "data", "acses2021_processed.csv")
)

### ACSES 2021: POSTCODE-LEVEL DATA AD-HOC RELEASE

# Source page: https://www.gov.uk/government/statistics/number-of-civil-servants-by-postcode-department-responsibility-level-and-leaving-cause-2021
acses2021_postcode_adhoc <- "https://assets.publishing.service.gov.uk/government/uploads/system/uploads/attachment_data/file/1055152/Civil-servants-by-postcode-department-responsibility-level-and-leaving-cause-2021.ods"

download.file(acses2021_postcode_adhoc,
              file.path("R", "data", basename(acses2021_postcode_adhoc)))

### MANUALLY DOWNLOAD NPSL FROM GEOPORTAL

geoportal_url <- "https://geoportal.statistics.gov.uk/datasets/national-statistics-postcode-lookup-may-2022/about"

message("You must manually download the NPSL file from the Geoportal ",
        "DO NOT save this file in the project folders.")

utils::browseURL(geoportal_url)

rstudioapi::restartSession()
