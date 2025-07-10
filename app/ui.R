# ui.R
script_choices <- list(
  "Download Kobo Attachment" = "download_kobo_attachment.R",
  "Estimate Indicator 1"     = "estimate_indicator1.R",
  "Get Indicator 1 Data"     = "get_indicator1_data.R",
  "Get Indicator 2 Data"     = "get_indicator2_data.R",
  "Get Indicator 3 Data"     = "get_indicator3_data.R",
  "Get Metadata"             = "get_metadata.R",
  "Process Attached Files"   = "process_attached_files.R",
  "Transform to Ne"          = "transform_to_Ne.R"
)

ui <- fluidPage(
  titlePanel("Script Selector"),
  sidebarLayout(
    sidebarPanel(
      selectInput(
        inputId = "script",
        label = "Choose a script:",
        choices = script_choices,
        selected = names(script_choices)[1]
      ),
      fileInput(
        inputId = "kobo_file",
        label = "Upload Kobo output CSV file",
        accept = c(".csv")
      ),
      actionButton("process", "Process")
    ),
    mainPanel(
      verbatimTextOutput("result")
    )
  )
)
