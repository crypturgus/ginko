library(shiny)
library(DT)

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
  tags$head(
    tags$style(HTML("
      .btn-green {background-color: #4CAF50; color: white;}
      .btn-blue {background-color: #2196F3; color: white;}
      .well-custom {background: #f7f7fa; border-radius: 12px; padding: 18px; box-shadow: 0 2px 12px #e2e2ef;}
      .control-label {font-weight: bold;}
    "))
  ),
  titlePanel("Script Selector"),
  br(),
  wellPanel(
    class = "well-custom",
    fluidRow(
      column(3,
             selectInput(
               inputId = "script",
               label = "Choose a script:",
               choices = script_choices,
               selected = names(script_choices)[1]
             ),
             conditionalPanel(
               condition = "input.script == 'transform_to_Ne.R'",
               numericInput(
                 inputId = "transformToNeRatio",
                 label = "Transformation Ratio (0-1)",
                 value = 1,
                 min = 0,
                 max = 1,
                 step = 0.01
               )
             )
      ),
      column(3,
             fileInput(
               inputId = "kobo_file",
               label = "Upload Kobo CSV file",
               accept = c(".csv")
             )
      ),
      column(2,
             br(),
             actionButton("process", "Process",
                          class = "btn-green", style = "width:100%; font-weight:bold;")
      ),
      column(2,
             br(),
             downloadButton("download_csv", "Download as CSV",
                            class = "btn-blue", style = "width:100%; font-weight:bold;")
      )
    )
  ),
  br(),
  DT::dataTableOutput("result_table"),
  br(),
  verbatimTextOutput("result")
)
