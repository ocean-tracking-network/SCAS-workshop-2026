---
title: Telemetry Reports - Imports
teaching: 10
exercises: 0
questions:
    - "What datasets do I need from the Network?"
    - "How do I import all the datasets?"
---

**NOTE:** this workshop has been update to align with OTN's 2025 Detection Extract Format. For older detection extracts, please see the this lesson: [Archived OTN Workshop](https://ocean-tracking-network.github.io/otn-workshop-2025-06/). 


### Importing all the datasets
Let's look at how we might implement a common telemetry workflow using Tidyverse libraries like `dplyr` and `ggplot2`. 

We are going to use OTN-style detection extracts for this lesson. If you're unfamiliar with detection extracts formats from OTN-style database nodes, see the documentation [here](https://members.oceantrack.org/data/otn-detection-extract-documentation-matched-to-animals). 

For OTN you will receive Detection Extracts which include (1) Matched to Animals YYYY, (2) Detections Mapped to Other Trackers YYYY (also called Qualified) and (3) Unqualified Detections YYYY. In each case, the YYYY in the filename indicates the single year of data contained in the file. The types of detection extracts you receive will differ depending on the type of project you have regitered with the Network. ex: Tag-only projects will not receive Qualified and Unqualified detection extracts.

> ## Regarding Raw Data
> Although this lesson assumes you are working with detection extracts from your node (processed data containing matches between animals and receivers), 
> it is likely that you also have raw data directly from your instruments. If you are using Innovasea equipment, the file format for this raw data is '.vdat.' 
> While reading and manipulating this raw data is beyond the scope of this workshop, there are tools available to help you with this. The [rvdat](https://github.com/mhpob/rvdat/) 
> package provides a lightweight R interface for inspecting .vdat file metadata and converting the data to .csv format. Additionally, .csv files created in this way can be 
> read and manipulated with the glatos package, covered later in this workshop. In short, although the purpose of this workshop is to teach you to work with detection extracts, 
> there exist related, robust options for managing your raw data as well.
{: .callout}

To illustrate the many meaningful summary reports which can be created use detection extracts, we will import an example of Matched and Qualified extracts.

First, we will comfirm we have our Tag Matches stored in a dataframe.
~~~
view(nsbs_matched_full) #Check to make sure we already have our tag matches, from a previous episode

# if you do not have the variable created from a previous lesson, you can use the following code to re-create it:

#nsbs_matched_2021 <- read_csv("nsbs_matched_detections_2021.zip") #Import 2021 detections
#nsbs_matched_2022 <- read_csv("nsbs_matched_detections_2022.zip") # Import 2022 detections
#nsbs_matched_full <- rbind(nsbs_matched_2021, nsbs_matched_2022) #Now join the two dataframes
# release records for animals often appear in >1 year, this will remove the duplicates
#nsbs_matched_full <- nsbs_matched_full %>% distinct() # Use distinct to remove duplicates.  
~~~
{: .language-r}


Next, we will load in and join our Array matches. Ensure you replace the filepath to show the files as they appear in your working directory, if needed.
~~~

hfx_qual_2021 <- read_csv("hfx_qualified_detections_2021.csv")
hfx_qual_2022 <- read_csv("hfx_qualified_detections_2022.csv") 
hfx_qual_21_22_full <- rbind(hfx_qual_2021, hfx_qual_2022) 

~~~
{: .language-r}

To give meaning to these detections we should import our Instrument Deployment Metadata and Tagging Metadata as well. These are in the standard OTN-style templates which can be found [here](https://members.oceantrack.org/data/data-collection).
~~~
#These are saved as XLS/XLSX files, so we need a different library to read them in. 

# Deployment Metadata
hfx_deploy <- read_excel("hfx_sample_deploy_metadata_export.xlsx", skip=3) #can also do argument "sheet = XXX" if needed
View(hfx_deploy)

# Tag metadata
nsbs_tag <- read_excel("nsbs_sample_tag_metadata_export.xlsx")
View(nsbs_tag)

#keep in mind the timezone of the columns
~~~
{: .language-r}

