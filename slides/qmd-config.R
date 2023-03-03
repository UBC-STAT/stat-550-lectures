rmd_filename <- stringr::str_remove(knitr::current_input(),"\\.Rmd")
knitr::opts_chunk$set(
  fig.path = stringr::str_c("rmd_gfx/", rmd_filename, '/'),
  warning = FALSE, message = FALSE, dev = "svg"
)

primary <- "#2c365e"
secondary = "#e98a15"
tertiary = "#0a8754"
fourth_color = "#a8201a"

library(tidyverse)
library(fontawesome)
library(knitr)
theme_set(theme_bw(18))
# library(countdown)

pro = fa("thumbs-up", fill = tertiary)
con = fa("bomb", fill = secondary)

set.seed(12345)