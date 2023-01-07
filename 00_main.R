# Source codes ------------------------------------------------------------

library(tidyverse)
library(magrittr)
library(RSelenium)
library(rvest)
source("functions.R")


# Input -------------------------------------------------------------------

login <- read.delim("private.txt", header = F) %>% as_vector()

parameters <- tibble(
  issued_till = Sys.Date() - 120,
  min_interest = 10, # percentage 
  max_term = 18, # in months
  min_ytm = min_interest,
  max_premium = -1,
  statuses = 256, # means current
  countries = list(c(8, 17, 19, 22, 25, 26, 27, 28, 37, 39, 43, 44, 45, 51, 61, 69, 71, 75, 79, 84, 87, 93, 247, 249)), # with the rating of at least C on explorep2p.com
  lender_groups = list(c(2, 25, 52, 58, 79, 80, 101, 102, 113)), # with the rating of at least 65 on explorep2p.com
  risk_categories = list(c(32, 33, 34, 35, 36)), # additional ratings for groups combined from several different companies with different risk ratings
  schedule_types = 1, # means full
  currencies = 978, # means EUR
  invested_in = 0, # means no current investments
  min_amount = 1, # available amount to invest
  with_buyback = 1, 
  pending_payments_status = 0, 
  max_results = 300  
)


# Execute -----------------------------------------------------------------

# 1. Download list of loans from Mintos
source("01_download_all.R")

# 2. Manually save files from GMAIL

# 3. Filter and standardize data
source("02_filter.R")

# 4. Loop through individual loan pages and get micro data
source("03_download_individual.R")