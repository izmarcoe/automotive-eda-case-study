# ==============================================================================
# Script: 00_setup_dependencies.R
# Purpose: Verify and install all necessary R packages for the mtcars EDA project
# ==============================================================================

required_packages <- c(
  "rmarkdown",    # R Markdown document compilation
  "knitr",        # Dynamic report generation engine
  "tidyverse",    # Core data manipulation and visualization (dplyr, ggplot2, etc.)
  "kableExtra",   # High-quality HTML styling for summary tables
  "patchwork",    # Multi-panel ggplot layouts
  "corrplot",     # Correlation matrix visualization
  "ggrepel",      # Intelligent text labeling without overlapping
  "broom",        # Tidy statistical modeling outputs
  "car",          # Variance Inflation Factor (VIF) and diagnostic tools
  "factoextra",   # PCA and clustering visualization
  "cluster",      # Clustering algorithms (k-means, PAM, hierarchical)
  "scales"        # Aesthetic formatting for axis scales and percentages
)

cat("--> Checking installed packages...\n")
installed <- rownames(installed.packages())
to_install <- setdiff(required_packages, installed)

if (length(to_install) > 0) {
  cat("--> Installing missing packages:", paste(to_install, collapse = ", "), "\n")
  install.packages(to_install, repos = "https://cloud.r-project.org")
} else {
  cat("--> All required packages are already installed!\n")
}

cat("--> Setup completed successfully.\n")
