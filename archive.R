

# Extract table 

p <-  1
stop_loop = F
while (!stop_loop) {
  
  # Open results website  
  print(p)
  Sys.sleep(runif(1, 1, 5))
  remDr$navigate(address(parameters, market = m, page = p))
  
  # Get subset of html 
  Sys.sleep(runif(1, 1, 5))
  page_source <- remDr$findElement("#filter-results-wrapper", using = "css selector")$getElementAttribute("innerHTML") %>% .[[1]]
  
  # Find table
  table_rows <- page_source %>% 
    read_html() %>% 
    html_nodes(".claims__item")
  
  # Extract data if table is not empty 
  if (length(table_rows)) {
    
    loans <- map_df(table_rows, ~ {
      
      y <- .x %>% 
        html_children() %>% 
        html_text()
      
      y <- tibble(
        loan_id = y %>% 
          str_split("\n") %>% 
          unlist() %>% 
          str_trim() %>% 
          .[grep("-", .)], 
        months_paid = y %>% 
          str_extract("(?<=\\().*(?=\\))") %>% 
          .[!is.na(.)] %>% 
          as.numeric()
      )
      
      return(y)
      
    })
    
    # Get next page number
    p <- p + 1
    
  } else stop_loop = T
  
  # Merge with loan list
  loan_list %<>% bind_rows(loans) 
  
}


loan_list %>% filter(months_paid > 2)
