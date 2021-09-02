library(showtext)
library(hexSticker)
font_add_google("Roboto", "roboto")

showtext_auto()
sticker("data-raw/network.png",
  package = "cffr",
  p_family = "roboto",
  p_fontface = "bold",
  s_width = .7,
  s_height = .7,
  s_x = 0.9,
  s_y = .75,
  p_color = "#1892E3",
  p_size = 30,
  p_y = 1.6,
  h_fill = "white",
  h_color = "#1892E3",
  filename = "man/figures/logo.png"
)
