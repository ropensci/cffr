library(hexSticker)

library(showtext)

font_add_google("Roboto", "roboto")

showtext_auto()

sticker("./data-raw/book.png",
  package = "cffR",
  p_family = "roboto",
  p_fontface = "bold",
  s_width = 0,
  s_height = 0,
  s_x = 1,
  s_y = 0.9,
  p_color = "white",
  p_size = 65,
  p_y = 1,
  h_fill = "#56a0d3",
  h_color = "#56a0d3",
  filename = "man/figures/logo.png"
)
