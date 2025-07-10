# app/utils.R

fetch_script <- function(name, url, force = FALSE) {
  dest <- file.path("external", name)
  if (!dir.exists("external")) dir.create("external")

  if (!file.exists(dest) || force) {
    message(sprintf("Pobieranie %s z %s...", name, url))
    download.file(url, destfile = dest, mode = "wb")
  }

  source(dest, local = TRUE)
}
