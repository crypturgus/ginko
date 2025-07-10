#!/usr/bin/env Rscript

# Force CRAN mirror
options(repos = c(CRAN = "https://cloud.r-project.org"))

# Install renv if missing
if (!requireNamespace("renv", quietly = TRUE)) {
  install.packages("renv")
}

# Load and upgrade renv
library(renv)
renv::upgrade(prompt = FALSE)

# Activate and restore environment
renv::activate()
renv::restore(confirm = FALSE)
