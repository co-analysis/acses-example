
# [WIP] ACSES Publication Example

<!-- badges: start -->
<!-- badges: end -->

This repo is a work in progress prototype for a future microsite approach to the publication of the [Civil Service Statistics](https://www.gov.uk/government/collections/civil-service-statistics). 

This prototype is being developed in the open to enable end-user consultation and feedback. All data is from published statistics, however the content is likely to frequently change and therefore should not be relied on for analysis.

## Set-up

The prototype is developed using [`govukhugo`](https://co-analysis.github.io/govuk-hugo-demo/) a theme for [Hugo](https://gohugo.io/), a static site generator, and associated R package for working with R Markdown documents.

To contribute to the prototype you must:

1. Clone the repo using `git` or `gh`
```shell
gh repo clone co-analysis/acses-example
git clone https://github.com/co-analysis/acses-example.git
```

2. Initialise the govukhugo submodule
```shell
cd path/to/acses-example
git submodule update --init --recursive
```

3. Install the `{govukhugo}` R package
```r
install.packages("remotes")
remotes::install_github("co-analysis/govukhugo-r")
```

4. Install Hugo
Either use a system wide package manager such as `brew`
```shell
brew install hugo
```

For (for Windows users) use the installer inside the `{blogdown}` package (which is installed with `{govukhugo}`).
```r
blogdown::install_hugo()
```

## LICENCE

Code in this repository is licensed under the [MIT License](LICENSE.md). The content of the published documents is released under [Open Government Licence](https://www.nationalarchives.gov.uk/doc/open-government-licence/version/3/).

  
