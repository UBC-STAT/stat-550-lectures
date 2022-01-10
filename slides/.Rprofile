rmd_filename <- stringr::str_remove(knitr::current_input(),"\\.Rmd")
knitr::opts_chunk$set(
  fig.path = stringr::str_c("rmd_gfx/", rmd_filename, '/'),
  warning=FALSE, message=FALSE, dev="svg"
)
options(htmltools.dir.version = FALSE)
purple = "#6f42c1"
orange = "#fd7e14"
green = "#28a745"
yellow = "#ffc107"
library(tidyverse)
library(cowplot)
library(fontawesome)
library(knitr)
theme_set(theme_bw(18, "Fira Sans"))
# library(countdown)

pro = fa("thumbs-up", fill=green)
con = fa("bomb", fill=orange)

set.seed(12345)
