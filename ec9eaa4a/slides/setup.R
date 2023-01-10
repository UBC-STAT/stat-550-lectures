rmd_filename = stringr::str_remove(knitr::current_input(),"\\.Rmd")
knitr::opts_chunk$set(
  fig.path = stringr::str_c("rmd_gfx/", rmd_filename, '/'),
  warning=FALSE, message=FALSE, dev="svg",
  echo=FALSE
)