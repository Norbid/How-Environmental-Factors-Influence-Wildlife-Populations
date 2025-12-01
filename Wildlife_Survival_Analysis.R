# Wildlife EFA + Survival Analysis

library(psych)      # scree(), fa()
library(survival)   # Surv(), survfit()
library(broom)      # tidy()
library(survminer)  # ggsurvplot()
library(ggplot2)

# 0. Load data 

factor_data   <- read.csv("factor_data.csv",   stringsAsFactors = FALSE)
survival_data <- read.csv("survival_data.csv", stringsAsFactors = FALSE)

# Exploratory Data Analysis
# Structure and quick summary

str(factor_data)
summary(factor_data)

str(survival_data)
summary(survival_data)

# 1. Use cor() with pairwise complete observations on factor_data, store result in cor_factor_data.

factor_numeric <- factor_data[ , !(names(factor_data) %in% "index")]

cor_factor_data <- cor(factor_numeric,
                       use = "pairwise.complete.obs")
cor_factor_data

# 2. Find which variable is most strongly correlated with SpeciesDiversity, store as string in most_impactful_factor.

species_cor <- cor_factor_data[ , "SpeciesDiversity"]

# Remove self-correlation
species_cor <- species_cor[names(species_cor) != "SpeciesDiversity"]

# Use absolute value for "most strongly"
most_impactful_factor <- names(which.max(abs(species_cor)))
most_impactful_factor

# 3. Use scree() with factors = FALSE on the correlation data.

scree(cor_factor_data, factors = FALSE)

# 4. Observe the scree plot and choose number of factors. Set that integer to num_factors. Kaiser criterion (eigenvalues > 1) gives 2 factors here.

num_factors <- 2L
num_factors

# 5. Use fa() with nfactors = num_factors

EFA_model <- fa(r = cor_factor_data,
              nfactors = num_factors,
              fm = "ml",       # maximum likelihood (or "pa")
              rotate = "varimax")
print(EFA_model, sort = TRUE)

# Survival Analysis

# 6. Use Surv() on Survival_Time and Censoring_Status fit against Habitat, wrapping the formula in survfit().

surv_obj <- Surv(time  = survival_data$Survival_Time,
                 event = survival_data$Censoring_Status)

surv_fit <- survfit(surv_obj ~ Habitat, data = survival_data)

# 7. Use tidy() from broom on your survival object to create a model fit data frame.

survival_fit_df <- tidy(surv_fit)
head(survival_fit_df)

# 8. Use ggsurvplot() on the fitted object including the survival data as the data object.

ggsurvplot(
  fit  = surv_fit,
  data = survival_data,
  pval = TRUE,          # optional: show log-rank p-value
  conf.int = TRUE,      # show confidence bands
  risk.table = TRUE,    # add risk table below
  ggtheme = theme_minimal()
)

# 9. Look over survival curves and note which habitat -------
#    has the lowest survival probability around time ??? 400.
#    Store its name in low_surv_habitat.

low_surv_habitat <- "Savannah"
low_surv_habitat