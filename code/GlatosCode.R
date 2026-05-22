# 07 - Introduction to glatos ####

## Set your working directory

library(glatos)
library(tidyverse)
library(lubridate)

# First we need to import a detection extract
# we'll use a system default file.

det_file <- system.file("extdata", "blue_shark_detections.csv",
                        package = "glatos"
)


## glatos help files are helpful!!
?read_otn_deployments

# Save our detections file data into a dataframe called detections
detections <- read_otn_detections(det_file)

# View first 2 rows of output
head(detections, 2)

## Filtering False Detections ####
## ?glatos::false_detections

# write the filtered data (no rows deleted, just a filter column added)
# to a new det_filtered object
detections_filtered <- false_detections(detections, tf=3600, show_plot=TRUE)
head(detections_filtered)
nrow(detections_filtered)


# Filter based on the column if you're happy with it.
detections_filtered <- detections_filtered[detections_filtered$passed_filter == 1,]
nrow(detections_filtered) # Smaller than before


# Summarize Detections ####
# ?summarize_detections
# summarize_detections(detections_filtered)

# By animal ====

sum_animal <- summarize_detections(detections_filtered, location_col = 'station', summ_type='animal')

sum_animal


# By location ====

sum_location <- summarize_detections(detections_filtered, location_col = 'station', summ_type='location')

head(sum_location)


# You can make your own column and use that as the location_col
# For example we will create a uniq_station column for if you have duplicate station names across projects

detections_filtered_special <- detections_filtered %>%
  mutate(station_uniq = paste(glatos_project_receiver, station, sep=':'))


sum_location_special <- summarize_detections(detections_filtered_special, location_col = 'station_uniq', summ_type='location')

head(sum_location_special)


# By both dimensions
sum_animal_location <- summarize_detections(det = detections_filtered,
                                            location_col = 'station',
                                            summ_type='both')

head(sum_animal_location)


# Filter out stations where the animal was NOT detected.
sum_animal_location <- sum_animal_location %>% filter(num_dets > 0)

sum_animal_location


# Create a custom vector of Animal IDs to pass to the summary function
# look only for these ids when doing your summary
tagged_fish <- c('NSBS-Xena', 'NSBS-Hooker', 'NSBS-Alison')

sum_animal_custom <- summarize_detections(det=detections_filtered,
                                          animals=tagged_fish,  # Supply the vector to the function
                                          location_col = 'station',
                                          summ_type='animal')

sum_animal_custom


# Reduce Detections to Detection Events ####

# ?glatos::detection_events
# arrival and departure time instead of multiple detection rows
# you specify how long an animal must be absent before starting a fresh event

events <- detection_events(detections_filtered,
                           location_col = 'station',
                           time_sep=3600)

head(events)


# keep detections, but add a 'group' column for each event group
detections_w_events <- detection_events(detections_filtered,
                                        location_col = 'station',
                                        time_sep=3600, condense=FALSE)

# 08 - More Features of glatos ####


?residence_index

#Using all the events data will take too long, we will subset to just use a couple animals
events %>% group_by(animal_id) %>% summarise(count=n()) %>% arrange(desc(count))

subset_animals <- c('NSBS-Xena', 'NSBS-Hooker')
events_subset <- events %>% filter(animal_id %in% subset_animals)

events_subset
# Calc residence index using the Kessel method
rik_data <- residence_index(events_subset,
                            calculation_method = 'kessel')
rik_data


# Calc residence index using the time interval method, interval set to 6 hours
# "Kessel" method is a special case of "time_interval" where time_interval_size = "1 day"

rit_data <- residence_index(events_subset,
                            calculation_method = 'time_interval',
                            time_interval_size = "6 hours")
rit_data

# BREAK

# 9 - Basic Visualization and Plotting

# Visualizing Data - Abacus Plots ####
# ?glatos::abacus_plot
# customizable version of the standard VUE-derived abacus plots

abacus_plot(detections_w_events,
            location_col='station',
            main='NSBS Detections by Station') # can use plot() variables here, they get passed thru to plot()

# pick a single fish to plot
abacus_plot(detections_filtered[detections_filtered$animal_id== "NSBS-Xena",],
            location_col='station',
            main="NSBS-Xena Detections By Station")

# Bubble Plots for Spatial Distribution of Fish ####
# bubble variable gets the summary data that was created to make the plot
detections_filtered

?detection_bubble_plot

# We'll use raster to get a polygon to plot against
library(geodata)
CAN <- geodata::gadm("CANADA", level=1, path=".")
NS <- CAN[CAN$NAME_1=="Nova Scotia",]

bubble_station <- detection_bubble_plot(detections_filtered,
                                        background_ylim = c(43.4, 46),
                                        background_xlim = c(-66, -62),
                                        map = NS,
                                        location_col = 'station',
                                        out_file = 'nsbs_bubbles_by_stations.png')
bubble_station

bubble_array <- detection_bubble_plot(detections_filtered,
                                      background_ylim = c(43.4, 46),
                                      background_xlim = c(-66, -62),
                                      map = NS,
                                      out_file = 'nsbs_bubbles_by_array.png')
bubble_array


