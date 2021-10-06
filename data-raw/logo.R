library(showtext)
library(hexSticker)
font_add_google("Roboto", "roboto")

showtext_auto()


# Subplot
img <- magick::image_read("data-raw/network.png")
g <- grid::rasterGrob(img, interpolate = TRUE)

p <- ggplot2::ggplot() +
  ggplot2::annotation_custom(g, xmin = -Inf, xmax = Inf, ymin = -Inf, ymax = Inf) +
  ggplot2::theme_void()


p
sticker(p,
  package = "cffr",
  p_family = "roboto",
  p_fontface = "bold",
  s_width = 1.4,
  s_height = 1.4,
  s_x = 0.9,
  s_y = .77,
  p_color = "#1892E3",
  p_size = 30,
  p_y = 1.6,
  h_fill = "white",
  h_color = "#1892E3",
  filename = "man/figures/logo.png"
)
