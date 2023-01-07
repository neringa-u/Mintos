address <- function(parameters, market = "primary", page = 1) {
  
  attach(parameters)
  link <- 
    paste0(
      "https://www.mintos.com/en/invest-en/",
      market, "-market/?",
      "issued_till=", format(as.Date(issued_till), "%d.%m.%Y"), "&",
      "min_interest=", min_interest, "&",
      "max_term=", max_term, "&",
      "statuses%5B%5D=", statuses, "&",
      paste0("countries%5B%5D=", countries %>% unlist(), collapse = "&"), "&",
      paste0("lender_groups%5B%5D=", lender_groups %>% unlist(), collapse = "&"), "&",
      paste0("risk_categories%5B%5D=", risk_categories %>% unlist(), collapse = "&"), "&",
      "schedule_types%5B%5D=", schedule_types, "&",
      "currencies%5B%5D=", currencies, "&",
      "invested_in=", invested_in, "&",
      "min_amount=", min_amount, "&",
      "with_buyback=", with_buyback, "&",
      "pending_payments_status=", pending_payments_status, "&",
      "max_results=", max_results, "&",
      "page=", page
    )
  
  
  if (market != "primary") {
    
    link <- paste0(
      link, "&",
      "min_ytm=", min_ytm, "&",
      "max_premium=", max_premium
    )
    
  }
  
  detach(parameters)
  return(link)
  
}