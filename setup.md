---
title: Setup
---

### Before You Begin

- You'll need a **laptop with admin rights** some installs require it
- A **strong internet connection** is recommended
- Installation can take a while depending on your connection, do this ahead of time

---

## Step 1 — Install R

1. Go to [https://cran.r-project.org/mirrors.html](https://cran.r-project.org/mirrors.html) and pick a USA mirror
2. Download the installer for your OS:
   - **Windows:** Click "Download R for Windows" → "base" → download the `.exe`
   - **Mac:** Click "Download R for (Mac) OS X" → download the `.pkg`
3. Run the installer. On Windows, choose **"Install as administrator"**. Default options are fine for both platforms.

> **Recommended version:** R 4.0.x or newer

---

## Step 2 — Install RStudio

1. Go to [https://www.rstudio.com/products/rstudio/download/](https://www.rstudio.com/products/rstudio/download/)
2. Download the **RStudio Desktop (Free)** version for your OS
3. Run the installer with default options
4. Open RStudio, you should see an active R console

> Install R **before** RStudio so RStudio can find and link to it automatically.

---

## Step 3 — Install R Packages

Open RStudio and run the install script below. **Run it line by line**, not all at once, this makes it easier to catch any errors.
 
> Alternatively, once you've downloaded the workshop files (Step 4), you can just open **`setup.R`** from the folder and run it directly, it contains the same installs.
 
> If prompted to upgrade dependent packages, choose **Option 3: None**. This avoids upgrading packages you didn't intend to touch.

```r
# Data cleaning and arrangement
install.packages('tidyverse')

# Reading parquet files into dataframes
install.packages('nanoparquet')

# Better date handling (also part of Tidyverse)
install.packages('lubridate')

# Map plotting (works alongside ggplot2)
install.packages('ggmap')

# Temporary API key for StadiaMaps — valid during the workshop only
ggmap::register_stadiamaps("b01d1235-69e8-49ea-b3bd-c35b42424b00")

# Interactive web-based charts
install.packages('plotly')

# Reading Excel files
install.packages("readxl")

# Colorblind-friendly and greyscale-compatible color scales
install.packages("viridis")
```

---

## Step 4 — Download Workshop Code and Data

Once packages are installed, download the workshop files from GitHub:

**[https://github.com/ocean-tracking-network/SCAS-workshop-2026](https://github.com/ocean-tracking-network/SCAS-workshop-2026/tree/master)**

**Option A — Download ZIP (recommended for most people)**
1. Click the green **"Code"** button → **"Download ZIP"**
2. Unzip the folder and move it somewhere stable (Desktop, Documents, etc.)
3. In RStudio, set your working directory to that folder:
   ```r
   setwd('/path/to/folder')
   ```

**Option B — Git clone**
```bash
git clone https://github.com/ocean-tracking-network/SCAS-workshop-2026.git
```
Then set your working directory in RStudio as above.

---

{% include links.md %}