## Advanced Telemetry Workshop Requirements ----
# rgdal
install.packages('rgdal')
library(rgdal)
rgdal::getGDALVersionInfo()

# Tidyverse (data cleaning and arrangement)
install.packages('tidyverse')

# glatos - acoustic telemetry package that does filtering, vis, array simulation, etc.
install.packages('remotes')
library(remotes) 
remotes::install_github('ocean-tracking-network/glatos')

#Additional packages for mapping.
install.packages('stringr')
install.packages('mapview')
install.packages('spdplyr')
install.packages('geodata')

# Lubridate - part of Tidyverse, improves the process of creating date objects
install.packages('lubridate')

# GGmap - complimentary to ggplot2, which is in the Tidyverse
install.packages('ggmap')

#SP and Raster packages for mapping.
install.packages('sp')
install.packages('raster')

# Install actel
library(remotes)
remotes::install_github("hugomflavio/actel", 
                        build_opts = c("--no-resave-data", "--no-manual"), build_vignettes = TRUE)

# Install packages for building/displaying R Markdown
install.packages('rmarkdown')
install.packages('knitr', dependencies = TRUE)

# Install additonal packages for `remora` lesson
install.packages('readr')
install.packages('sf')
install.packages('stars')

# Install remora
install.packages('devtools')
library(devtools)
devtools::install_github('ocean-tracking-network/remora@workshop_ready', force=TRUE)

# Install packages for animating detection data
install.packages('remotes')
library(remotes) 
remotes::install_github("jmlondon/pathroutr")

install.packages('plotly')
install.packages('gganimate')
install.packages('ggspatial')
