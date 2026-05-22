---
title: Basic Visualization and Plotting with glatos
teaching: 30
exercises: 0
questions:
    - "How can I use glatos to plot my data?"
    - "What kinds of plots can I make with my data?"
---

Now that we've cleaned and processed our data, we can use `glatos`' built-in plotting tools to make quick and effective visualizations out of it. One of the simplest visualizations is an abacus plot to display animal detections against the appropriate stations. To this end, `glatos` supplies a built-in, customizable `abacus_plot` function.

~~~
# Visualizing Data - Abacus Plots ####
# ?glatos::abacus_plot
# customizable version of the standard VUE-derived abacus plots


abacus_plot(detections_w_events,
            location_col='station',
            main='NSBS Detections by Station') # can use plot() variables here, they get passed thru to plot()


~~~
{: .language-r}

This is good, but you can see that the plot is cluttered. Rather than plotting our entire dataset, let's try filtering out a single animal ID and only plotting that. We can do this right in our call to `abacus_plot` with the filtering syntax we've previously covered.

~~~
# pick a single fish to plot
abacus_plot(detections_filtered[detections_filtered$animal_id== "NSBS-Xena",],
            location_col='station',
            main="NSBS-Xena Detections By Station")
~~~
{: .language-r}

Other plots are available in `glatos` and can show different facets of our data. If we want to see the physical distribution of our stations, for example, a bubble plot will serve us better.

~~~
# Bubble Plots for Spatial Distribution of Fish ####
# bubble variable gets the summary data that was created to make the plot
detections_filtered

?detection_bubble_plot

# We'll use raster to get a polygon to plot against
library(geodata)

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
~~~
{: .language-r}

These examples provide just a brief introduction to some of the plotting available in `glatos`.


