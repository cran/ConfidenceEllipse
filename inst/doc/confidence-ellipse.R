## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----message=FALSE, warning=FALSE---------------------------------------------
library(magrittr)
library(dplyr)
library(ggplot2)
library(patchwork)

## ----message=FALSE, warning=FALSE---------------------------------------------
library(ConfidenceEllipse)

## -----------------------------------------------------------------------------
data(glass, package = "ConfidenceEllipse")

## ----message=FALSE, warning=FALSE---------------------------------------------
ellipse99 <- confidence_ellipse(glass, x = SiO2, y = Al2O3, conf_level = 0.99)
ellipse95 <- confidence_ellipse(glass, x = SiO2, y = Al2O3, conf_level = 0.95)
ellipse90 <- confidence_ellipse(glass, x = SiO2, y = Al2O3, conf_level = 0.90)

## -----------------------------------------------------------------------------
ellipse99_rob <- confidence_ellipse(glass, x = SiO2, y = Al2O3, conf_level = 0.99, robust = TRUE)
ellipse95_rob <- confidence_ellipse(glass, x = SiO2, y = Al2O3, conf_level = 0.95, robust = TRUE)
ellipse90_rob <- confidence_ellipse(glass, x = SiO2, y = Al2O3, conf_level = 0.90, robust = TRUE)

## ----message=FALSE, warning=FALSE---------------------------------------------
ellipse99 %>% glimpse()

## -----------------------------------------------------------------------------
ggplot() +
  geom_path(data = ellipse99, aes(x = x, y = y), color = "red", linewidth = 0.7, linetype = "dashed") +
  geom_path(data = ellipse95, aes(x = x, y = y), color = "blue", linewidth = 0.7, linetype = "dashed") +
  geom_path(data = ellipse90, aes(x = x, y = y), color = "green", linewidth = 0.7, linetype = "dashed") +
  geom_path(data = ellipse99_rob, aes(x = x, y = y), color = "red", linewidth = 1L, linetype = "solid") +
  geom_path(data = ellipse95_rob, aes(x = x, y = y), color = "blue", linewidth = 1L, linetype = "solid") +
  geom_path(data = ellipse90_rob, aes(x = x, y = y), color = "green", linewidth = 1L, linetype = "solid") +
  geom_point(data = glass, aes(x = SiO2, y = Al2O3), fill = "grey", color = "black", shape = 21, size = 3L) +
  annotate("text", x = 70, y = 3.5, label = "Classical confidence ellipses", color = "black", size = 4) +
  annotate("text", x = 74, y = 2.3, label = "Robust confidence ellipses", color = "black", size = 4) +
  scale_color_brewer(palette = "Set1", direction = 1) +
  xlim(50, 80) +
  ylim(-.5, 5) +
  labs(
    x = "SiO2 (wt.%)",
    y = "Al2O3 (wt.%)",
    title = "Confidence ellipses",
    caption = "
    Figure 1: Comparison between classical and robust confidence ellipse."
  ) +
  theme_bw() +
  theme(
    aspect.ratio = .7,
    panel.grid = element_blank(),
    legend.position = "none"
  )

## ----message=FALSE, warning=FALSE---------------------------------------------
ellipse_grp <- confidence_ellipse(glass, x = SiO2, y = Na2O, .group_by = glassType)
ellipse_grph <- confidence_ellipse(glass, x = SiO2, y = Na2O, .group_by = glassType, distribution = "hotelling")

## -----------------------------------------------------------------------------
ellipse_grp %>% print()

## -----------------------------------------------------------------------------
ellipse_grph %>% print()

## -----------------------------------------------------------------------------
p1 <- ggplot() +
  geom_polygon(data = ellipse_grp, aes(x = x, y = y, fill = glassType), color = "black", alpha = .45) +
  geom_point(data = glass, aes(x = SiO2, y = Na2O, color = glassType, shape = glassType), size = 3L) +
  scale_fill_brewer(palette = "Set1", direction = 1) +
  scale_color_brewer(palette = "Set1", direction = 1) +
  labs(
    x = "SiO2 (wt.%)",
    y = "Na2O (wt.%)"
  ) +
  theme_bw() +
  theme(
    panel.grid = element_blank(),
    legend.position = "none"
  )

## -----------------------------------------------------------------------------
p2 <- ggplot() +
  geom_polygon(data = ellipse_grph, aes(x = x, y = y, fill = glassType), color = "black", alpha = .45) +
  geom_point(data = glass, aes(x = SiO2, y = Na2O, color = glassType, shape = glassType), size = 3L) +
  scale_fill_brewer(palette = "Set1", direction = 1) +
  scale_color_brewer(palette = "Set1", direction = 1) +
  labs(
    x = "SiO2 (wt.%)",
    y = "Na2O (wt.%)",
    caption = "
    Figure 2: Comparison between normal distribution (left) and Hotelling's T² distribution (right) ellipses."
  ) +
  theme_bw() +
  theme(
    panel.grid = element_blank(),
    legend.position = "none"
  )

## -----------------------------------------------------------------------------
patchwork::wrap_plots(p1, p2, ncol = 2) +
  patchwork::plot_annotation(
    title = "Statistically-based confidence ellipses drawn around each group",
    theme = theme(plot.title = element_text(hjust = 0.5))
  )

