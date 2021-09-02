library(showtext)
library(hexSticker)
font_add_google("Roboto", "roboto")

showtext_auto()
sticker("data-raw/network.png",
  package = "cffr",
  p_family = "roboto",
  p_fontface = "bold",
  s_width = 1.2,
  s_height = 1,
  s_x = 1,
  s_y = 0.8,
  p_color = "#56a0d3",
  p_size = 30,
  p_y = 1.6,
  h_fill = "white",
  h_color = "#56a0d3",
  filename = "man/figures/logo.png"
)
