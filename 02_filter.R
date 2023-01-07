# Downloaded files
files <- c("20220523-primary-market.xlsx",
           "20220523-secondary-market.xlsx")

# Merge data
all_data <- map_df(files, ~ {
  
  require(readxl)
  y <- read_excel(paste0("./input/", .x), col_types = "text") %>% 
    mutate(Type = unlist(str_split(.x, "-"))[2])
  
}) 

# Filter and sort data
filtered_data <- all_data %>%
  mutate(across(c("Payments Received", "Interest Rate"), as.numeric)) %>% 
  filter(`Payments Received` > 2) %>% 
  arrange(desc(`Payments Received`))
