# app/scripts/fetch_external.R

# Function to download a single script by name and URL
download_script <- function(name, url) {
  dest <- file.path("external", name)
  # Create the target directory if it doesn't exist
  if (!dir.exists("external")) dir.create("external", recursive = TRUE)
  message(sprintf("📥 Fetching %s ...", name))
  download.file(url, destfile = dest, mode = "wb")
}

# List of scripts to download, each as a list with name and url
scripts <- list(
  list(
    name = "download_kobo_attachment.R",
    url = "https://raw.githubusercontent.com/CCGenetics/Ginko-Rfun/main/download_kobo_attachment.R"
  ),
  list(
    name = "estimate_indicator1.R",
    url = "https://raw.githubusercontent.com/CCGenetics/Ginko-Rfun/main/estimate_indicator1.R"
  ),
  list(
    name = "get_indicator1_data.R",
    url = "https://raw.githubusercontent.com/CCGenetics/Ginko-Rfun/main/get_indicator1_data.R"
  ),
  list(
    name = "get_indicator2_data.R",
    url = "https://raw.githubusercontent.com/CCGenetics/Ginko-Rfun/main/get_indicator2_data.R"
  ),
  list(
    name = "get_indicator3_data.R",
    url = "https://raw.githubusercontent.com/CCGenetics/Ginko-Rfun/main/get_indicator3_data.R"
  ),
  list(
    name = "get_metadata.R",
    url = "https://raw.githubusercontent.com/CCGenetics/Ginko-Rfun/main/get_metadata.R"
  ),
  list(
    name = "process_attached_files.R",
    url = "https://raw.githubusercontent.com/CCGenetics/Ginko-Rfun/main/process_attached_files.R"
  ),
  list(
    name = "transform_to_Ne.R",
    url = "https://raw.githubusercontent.com/CCGenetics/Ginko-Rfun/main/transform_to_Ne.R"
  )
)

# Iterate over the list and download each script
lapply(scripts, function(entry) {
  download_script(entry$name, entry$url)
})
