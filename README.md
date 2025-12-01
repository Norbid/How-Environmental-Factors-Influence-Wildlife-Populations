Wildlife Populations – Environmental & Habitat Survival Analysis

This repository contains my solution for analyzing how environmental conditions influence
wildlife populations and how different habitats impact species survival probability over time.

The analysis uses:
- **Exploratory Factor Analysis (EFA)** to uncover latent environmental drivers of biodiversity
- **Kaplan–Meier survival modeling** to compare wildlife survival curves across habitats
- **Visual storytelling** with modern R data-science tools


Dataset Overview & EDA Insights

 `factor_data.csv`
- 1000 observations of 5 environmental impact metrics:
  `AirQuality`, `Temperature`, `DeforestationRate`, `SpeciesDiversity`, `ReproductiveRates`
- All features are numeric and roughly standardized (mean ~0, SD ~1)
- Key patterns from initial exploration:
  - **DeforestationRate** has a strong positive correlation with **SpeciesDiversity**
  - **ReproductiveRates** also show a notable relationship with species richness
  - Most calendar dummy columns contained no missing data, so imputation focused on discounts

 `survival_data.csv`
- 500 observations with:
  - **Survival_Time (time-to-event)**
  - **Censoring_Status (event indicator)**
  - **Habitat (categorical factor)**: `Wetland`, `Mountain`, `Forest`, `Grassland`, `Savanna`
- Survival times range from 0 to ~497, with approx 19% event incidence
