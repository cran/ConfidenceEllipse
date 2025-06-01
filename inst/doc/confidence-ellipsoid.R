## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----message=FALSE, warning=FALSE---------------------------------------------
library(magrittr)
library(dplyr)

## ----message=FALSE, warning=FALSE---------------------------------------------
library(ConfidenceEllipse)

## -----------------------------------------------------------------------------
data(glass, package = "ConfidenceEllipse")

## ----message=FALSE, warning=FALSE---------------------------------------------
ellipsoid <- glass %>%
  confidence_ellipsoid(x = SiO2, y = Na2O, z = Fe2O3, conf_level = 0.95)

## -----------------------------------------------------------------------------
ellipsoid %>% glimpse()

## ----message=FALSE, warning=FALSE---------------------------------------------
rgl::setupKnitr(autoprint = TRUE)
rgl::plot3d(
  x = ellipsoid$x,
  y = ellipsoid$y,
  z = ellipsoid$z,
  xlab = "SiO2 (wt.%)",
  ylab = "Na2O (wt.%)",
  zlab = "Fe2O3 (wt.%)",
  type = "l",
  radius = .05,
  col = "darkgrey"
)
rgl::points3d(
  x = glass$SiO2,
  y = glass$Na2O,
  z = glass$Fe2O3,
  col = "darkred",
  size = 5
)
rgl::view3d(zoom = .8)

## ----message=FALSE, warning=FALSE---------------------------------------------
ellipsoid_grp <- glass %>%
  confidence_ellipsoid(x = SiO2, y = Na2O, z = Fe2O3, .group_by = glassType, conf_level = 0.95)

## -----------------------------------------------------------------------------
ellipsoid_grp %>% glimpse()

## ----message=FALSE, warning=FALSE---------------------------------------------
rgl::setupKnitr(autoprint = TRUE)
rgl::plot3d(
  x = ellipsoid_grp$x,
  y = ellipsoid_grp$y,
  z = ellipsoid_grp$z,
  xlab = "SiO2 (wt.%)",
  ylab = "Na2O (wt.%)",
  zlab = "Fe2O3 (wt.%)",
  type = "s",
  radius = .03,
  col = as.numeric(ellipsoid_grp$glassType)
)
rgl::points3d(
  x = glass$SiO2,
  y = glass$Na2O,
  z = glass$Fe2O3,
  col = as.numeric(glass$glassType),
  size = 5
)
rgl::view3d(zoom = .8)

