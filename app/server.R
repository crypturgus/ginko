# server.R

library(shiny)
library(readr)
library(dplyr)
library(tidyr)
library(stringr)
# library(utile.tools) jeśli Twój skrypt go używa

server <- function(input, output, session) {
  observeEvent(input$process, {
    req(input$kobo_file)
    req(input$script)

    # Read the uploaded CSV file
    data <- read_csv(input$kobo_file$datapath, show_col_types = FALSE)
    data$end <- as.character(data$end)


    print("==== DEBUG: PIERWSZE 5 KOLUMN ====")
    print(colnames(data)[1:5])

    print("==== DEBUG: WSZYSTKIE NAZWY KOLUMN ====")
    print(colnames(data))

    print("==== DEBUG: TYPY KOLUMN ====")
    print(str(data))

    print("==== DEBUG: PIERWSZE 5 WARTOŚCI Z 'end' ====")
    print(head(data$end, 5))

    print("==== DEBUG: CZY SĄ NA W 'end' ====")
    print(any(is.na(data$end)))

    print("==== DEBUG: DŁUGOŚĆ 'end' ====")
    print(head(nchar(as.character(data$end)), 5))

    # Source the selected script from external/
    script_path <- file.path("external", input$script)
    source(script_path, local = TRUE)

    # Infer function name from script filename (remove .R)
    fun_name <- sub("\\.R$", "", input$script)

    # Check if function exists, then call it
    if (exists(fun_name)) {
      fun <- get(fun_name)
      # Try to process data
      result <- tryCatch(
        fun(kobo_output = data),
        error = function(e) paste("Error:", e$message)
      )
      output$result <- renderPrint({ result })
    } else {
      output$result <- renderPrint({ paste("Function", fun_name, "not found in", input$script) })
    }
  })
}
