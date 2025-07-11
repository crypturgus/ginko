library(shiny)
library(readr)
library(dplyr)
library(tidyr)
library(stringr)
library(DT)

server <- function(input, output, session) {
  # Reaktywny obiekt na wynik funkcji
  result_data <- reactiveVal(NULL)

  observeEvent(input$process, {
    req(input$kobo_file)
    req(input$script)

    # Wczytaj plik i przygotuj dane
    data <- read_csv(input$kobo_file$datapath, show_col_types = FALSE)
    data$end <- as.character(data$end)   # Konwersja end na character
    
    # Debug: Print column names and first few rows of data
    print("Columns in the data:")
    print(names(data))
    print("First few rows of data:")
    print(head(data))

    # Source selected script
    script_path <- file.path("external", input$script)
    source(script_path, local = TRUE)
    print('-------------')
    print(input$script)
    print('-------------')
    # Debug: Print data structure before processing
    if (input$script == 'transform_to_Ne.R') {
      print("Data structure before transform_to_Ne:")
      print(str(data))
      print("Column names:")
      print(names(data))
      if ("NcRange" %in% names(data)) {
        print("NcRange values:")
        print(unique(data$NcRange))
      } else {
        print("NcRange column not found in the data")
      }
    }

    # Infer function name from script filename
    fun_name <- sub("\\.R$", "", input$script)

    if (exists(fun_name)) {
      fun <- get(fun_name)
      # Try to process data
      result <- tryCatch(
        if (input$script == 'transform_to_Ne.R') {
          print(paste("Calling transform_to_Ne with ratio:", input$transformToNeRatio))
          result <- fun(ind1_data = data, ratio = input$transformToNeRatio)
          print("transform_to_Ne completed successfully")
          result
        } else {
          fun(kobo_output = data)
        },
        error = function(e) {
          err_msg <- paste("Error in", input$script, ":", e$message)
          print(err_msg)  # Print to console
          err_msg  # Return error message to UI
        }
      )
      result_data(result)  # Zapisz do rekatywnego obiektu

      output$result <- renderPrint({ result })
      output$result_table <- DT::renderDataTable({
        req(is.data.frame(result))
        DT::datatable(result, options = list(pageLength = 20))
      })
    } else {
      output$result <- renderPrint({ paste("Function", fun_name, "not found in", input$script) })
      output$result_table <- DT::renderDataTable(NULL)
      result_data(NULL)
    }
  })

  # Obsługa przycisku pobierania CSV
  output$download_csv <- downloadHandler(
    filename = function() { "result_data.csv" },
    content = function(file) {
      df <- result_data()
      # Jeżeli df to data.frame, zapisz, w przeciwnym razie przerwij
      if (is.data.frame(df)) {
        write.csv(df, file, row.names = FALSE, fileEncoding = "UTF-8")
      }
    }
  )
}
