# ==============================================================================
# Script: render_report.R
# Purpose: Compiles mtcars_eda_report.Rmd into a standalone HTML presentation
# ==============================================================================

if (!requireNamespace("rmarkdown", quietly = TRUE)) {
  stop("rmarkdown is not installed. Please run scripts/00_setup_dependencies.R first.")
}

cat("--> Rendering mtcars_eda_report.Rmd to HTML...\n")
rmarkdown::render(
  input = "mtcars_eda_report.Rmd",
  output_format = "html_document",
  output_file = "mtcars_eda_report.html",
  clean = TRUE
)

cat("--> Report successfully rendered to mtcars_eda_report.html!\n")
