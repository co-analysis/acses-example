tmp_dir <- tempdir()
if (!dir.exists(file.path(tmp_dir, "Rmd"))) {
  dir.create(file.path(tmp_dir, "Rmd"))
}
if (!dir.exists(file.path(tmp_dir, "data"))) {
  dir.create(file.path(tmp_dir, "data"))
}
file.copy("R/data/acses_explorer.rds", file.path(tmp_dir, "data", "acses_explorer.rds"))

var_list <- c(
  "age_band",
  "dept_group",
  "disability"
)
  # "ethnicity",
  # "function_of_post",
  # "profession_of_post",
  # "responsibility_level",
  # "sex",
  # "sexual_orientation",
  # "uk_region"
# )

num_to_process <- length(var_list) +
  (length(var_list) * (length(var_list) - 1)) +
  (length(var_list) * (length(var_list) - 1) * (length(var_list) - 2)) + 1

pages_created <- character()

pb <- progress::progress_bar$new(
  total = num_to_process,
  format = "rendering [:bar] :percent eta: :eta"
)

# set up combinations and output folders
for (i in 1:length(var_list)) {

  # set and create var1 out_dir
  out_dir <- file.path("content", "data", "explorer", var_list[i])
  if (!dir.exists(out_dir)) {
    dir.create(out_dir)
  }

  pages_created <- c(pages_created, govukhugo::render_rmd(
    "R/data_explorer/explorer_template.Rmd",
    tmp_dir = tmp_dir,
    out_dir = out_dir,
    params = list(variables = var_list[i]),
    title = "Data Explorer",
    out_basename = "_index.html"
  ))

  pb$tick()

  for (j in 1:length(var_list)) {
    if (var_list[j] == var_list[i]) {
      next
    }
    out_dir <- file.path("content", "data", "explorer", var_list[i], var_list[j])
    if (!dir.exists(out_dir)) {
      dir.create(out_dir)
    }

    pages_created <- c(pages_created, govukhugo::render_rmd(
      "R/data_explorer/explorer_template.Rmd",
      tmp_dir = tmp_dir,
      out_dir = out_dir,
      params = list(variables = c(var_list[i], var_list[j])),
      title = "Data Explorer",
      out_basename = "_index.html"
    ))

    pb$tick()

    for (k in 1:length(var_list)) {
      if (var_list[k] == var_list[j] | var_list[k] == var_list[i]) {
        next
      }
      out_dir <- file.path("content", "data", "explorer", var_list[i], var_list[j], var_list[k])
      if (!dir.exists(out_dir)) {
        dir.create(out_dir)
      }

      pages_created <- c(pages_created, govukhugo::render_rmd(
        "R/data_explorer/explorer_template.Rmd",
        tmp_dir = tmp_dir,
        out_dir = out_dir,
        params = list(variables = c(var_list[i], var_list[j], var_list[k])),
        title = "Data Explorer",
        out_basename = "_index.html"
      ))

      pb$tick()

    }
  }
}

# Produce index page
pages_created <- c(pages_created, govukhugo::render_rmd(
  "R/data_explorer/explorer_index.Rmd",
  tmp_dir = tmp_dir,
  out_dir = "content/data/explorer",
  title = "Data Explorer",
  out_basename = "_index.html"
))
pb$tick()


