# Open Mintos

cprof <- getChromeProfile("C:/Users/user1/AppData/Local/Google/Chrome", "Profile 1")
remDr <- rsDriver(
  remoteServerAddr = "localhost",
  port = 4447L,
  browser = "chrome",
  chromever = "101.0.4951.41",
  extraCapabilities = cprof
)$client
remDr$navigate("https://www.mintos.com/en/login")
Sys.sleep(runif(1, 2, 3))

# Log in

Sys.sleep(runif(1, 1, 3))
webElem <- remDr$findElement("#login-username", using = "css selector")
webElem$sendKeysToElement(list(login[1], key = "tab"))
Sys.sleep(runif(1, 1, 3))
webElem <- remDr$findElement("#login-password", using = "css selector")
webElem$sendKeysToElement(list(login[2], key = "enter"))

# Download data

for (m in c("secondary", "primary")) {
  
  # Open search results
  Sys.sleep(runif(1, 5, 15))
  remDr$navigate(address(parameters, market = m))
  
  # Click Download button
  Sys.sleep(runif(1, 2, 5))
  webElem <- remDr$findElement("body", using = "css")
  webElem$sendKeysToElement(list(key = "down_arrow"))
  Sys.sleep(runif(1, 2, 5))
  webLink <- "#investments > div.m-u-color-n2.m-u-padding-bottom-7.m-u-padding-bottom--lg-10.m-u-border-top-1.m-u-color-1-10--border > div > div > div.m-u-d-flex.m-u-jc-flex-end.m-u-w-full.m-u-w--lg-auto > div > div"
  webElem <- remDr$findElement(webLink, using = "css selector")
  webElem$clickElement()
  Sys.sleep(runif(1, 3, 5))
  webLink %<>% paste0(" > div.m-context-card__dropdown-wrapper.m-u-padding-5.m-context-card__dropdown-wrapper--right > section > div.download-links.mw-u-va-center.mw-u-transition-ease.m-u-color-b4--text.m-u-color-b7--text\\:hover.m-u-color-1-55--fill.m-u-color-1-10\\:hover.m-u-cursor-pointer.m-u-padding-y-3.m-u-padding-x-5")
  webElem <- remDr$findElement(webLink, using = "css selector")
  webElem$clickElement()
  
}
