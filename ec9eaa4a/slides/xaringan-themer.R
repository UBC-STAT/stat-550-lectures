# load packages ----------------------------------------------------------------

library(xaringanthemer)

primary = "#6f42c1"
secondary = "#fd7e14"
tertiary = "#28a745"
fourth_color = "#ffc107"

# set colors -------------------------------------------------------------------
style_duo_accent(
  primary_color      = primary,  #"#002145", # UBC primary
  secondary_color    = secondary,  #"6EC4E8", # UBC secondary 4
  header_font_google = google_font("Fira Sans"),
  text_font_google   = google_font("Fira Sans", "300", "300i"),
  code_font_google   = google_font("Ubuntu Mono"),
  #text_font_size     = "30px",
  table_row_even_background_color = lighten_color(primary, 0.8),
  outfile            = "assets/xaringan-themer.css",
  colors = c(
    tertiary = tertiary, fourth_color = fourth_color,
    light_pri = lighten_color(primary, 0.8),
    light_sec = lighten_color(secondary, 0.8),
    light_ter = lighten_color(tertiary, 0.8),
    light_fou = lighten_color(fourth_color, 0.8)
    )
)
