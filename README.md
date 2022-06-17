
# [WIP] ACSES Publication Example

<!-- badges: start -->
<!-- badges: end -->

This repo is a work in progress prototype for a future microsite approach to the publication of the [Civil Service Statistics](https://www.gov.uk/government/collections/civil-service-statistics). 

This prototype is being developed in the open to enable end-user consultation and feedback. All data is from published statistics, however the content is likely to frequently change and therefore should not be relied on for analysis.

## Set-up

The prototype is developed using [`govukhugo`](https://co-analysis.github.io/govuk-hugo-demo/) a theme for [Hugo](https://gohugo.io/), a static site generator, and associated R package for working with R Markdown documents.

To contribute to the prototype you must:

**1. Clone the repo using `git` or `gh`**
```shell
gh repo clone co-analysis/acses-example
git clone https://github.com/co-analysis/acses-example.git
```

**2. Initialise the govukhugo submodule**
```shell
cd path/to/acses-example
git submodule update --init --recursive
```

**3. Install the `{govukhugo}` R package**
```r
install.packages("remotes")
remotes::install_github("co-analysis/govukhugo-r")
```

**4. Install Hugo**
Either use a system wide package manager such as `brew`
```shell
brew install hugo
```

For (for Windows users) use the installer inside the `{blogdown}` package (which is installed with `{govukhugo}`).
```r
blogdown::install_hugo()
```

**5. Populate and prepare the `R/data` folder**
The `R/data` folder is the working folder for storing data that the site will be generated from.

In R source the `00_set-hp-data.R` script
```r
source(file.path("R", "00_set-up-data.R"))
```

This will download the relevant published release files, and copy the processed CSV file into the folder (so you can skip rebuilding).

You will however need to manually download [the NSPL file](https://geoportal.statistics.gov.uk/datasets/national-statistics-postcode-lookup-may-2022/about) from the ONS Geoportal. The `00_set-up-data.R` script will automatically open this in a new browser window for you. **DO NOT SAVE THIS FILE IN THE PROJECT DIRECTORY** the file is very big and will degrade the govukhugo building process.

## Contributing
Unless you know what you are doing you are should only edit items in the `content` and `R` directories.

In the `content` directory only edit Markdown documents (files with a `.md` with extension).

In the R folder, scripts for preparing data are stored in the folder itself (these are not called in the govukhugo building process so are only preparatory scripts), the `data` sub-folder stores files that Rmd files can call on during their build process, the `Rmd` sub-folder stores the R Markdown files that are converted into site content.

## LICENCE

Code in this repository is licensed under the [MIT License](LICENSE.md). The content of the published documents is released under [Open Government Licence](https://www.nationalarchives.gov.uk/doc/open-government-licence/version/3/).

  
