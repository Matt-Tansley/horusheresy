## code to prepare `horusheresy` dataset goes here

# Load raw data
library(tidyverse)
library(xml2)

# Download file from GitHub
url <- "https://raw.githubusercontent.com/BSData/horus-heresy-2nd-edition/refs/heads/main/2022%20-%20Horus%20Heresy.gst"
download.file(url, destfile = "data-raw/horus_heresy_raw.xml")

# Basic xml parsing
horusheresy_raw <- read_xml("data-raw/horus_heresy_raw.xml")
xml_ns_strip(horusheresy_raw)

# Extract rules
rules <- xml_find_all(horusheresy_raw, ".//rule")
rule_names <- xml_attr(rules, "name")
rule_texts <- xml_text(rules)

rules_df <- data.frame(
  name = rule_names,
  text = rule_texts,
  stringsAsFactors = FALSE
)

# Build final dataset
horusheresy <- rules_df
usethis::use_data(horusheresy, overwrite = TRUE)
