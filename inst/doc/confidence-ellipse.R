## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----message=FALSE, warning=FALSE---------------------------------------------
library(magrittr)
library(dplyr)
library(ggplot2)

## ----message=FALSE, warning=FALSE---------------------------------------------
library(ConfidenceEllipse)

## -----------------------------------------------------------------------------
data(glass, package = "ConfidenceEllipse")

## ----message=FALSE, warning=FALSE---------------------------------------------
ellipse_99 <- confidence_ellipse(glass, x = SiO2, y = Al2O3, conf_level = 0.99)
ellipse_95 <- confidence_ellipse(glass, x = SiO2, y = Al2O3, conf_level = 0.95)
ellipse_90 <- confidence_ellipse(glass, x = SiO2, y = Al2O3, conf_level = 0.90)

## ----message=FALSE, warning=FALSE---------------------------------------------
ellipse_99 %>% glimpse()

## -----------------------------------------------------------------------------
ggplot() +
  geom_path(data = ellipse_99, aes(x = x, y = y), color = "red", linewidth = 1L) +
  geom_path(data = ellipse_95, aes(x = x, y = y), color = "blue", linewidth = 1L) +
  geom_path(data = ellipse_90, aes(x = x, y = y), color = "green", linewidth = 1L) +
  geom_point(data = glass, aes(x = SiO2, y = Al2O3), color = "black", size = 3L) +
  scale_color_brewer(palette = "Set1", direction = 1) +
  xlim(50, 80) +
  ylim(-.5, 5) +
  labs(x = "SiO2 (wt.%)", y = "Al2O3 (wt.%)") +
  theme_bw() +
  theme(legend.position = "none")

## ----message=FALSE, warning=FALSE---------------------------------------------
ellipse_grp <- confidence_ellipse(glass, x = SiO2, y = Na2O, .group_by = glassType)

## -----------------------------------------------------------------------------
ellipse_grp %>% glimpse()

## -----------------------------------------------------------------------------
ggplot() +
  geom_polygon(data = ellipse_grp, aes(x = x, y = y, fill = glassType), alpha = .45) +
  geom_point(data = glass, aes(x = SiO2, y = Na2O, color = glassType, shape = glassType), size = 2L) +
  scale_fill_brewer(palette = "Set1", direction = 1) +
  scale_color_brewer(palette = "Set1", direction = 1) +
  labs(x = "SiO2 (wt.%)", y = "Na2O (wt.%)") +
  theme_bw() +
  theme(legend.position = "none")

