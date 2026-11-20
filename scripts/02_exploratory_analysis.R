# ==============================================================================
# Script: 02_exploratory_analysis.R
# Purpose: Statistical modeling, hypothesis testing, PCA, and cluster analysis
# ==============================================================================

suppressPackageStartupMessages({
  library(dplyr)
  library(ggplot2)
  library(broom)
  library(car)
  library(corrplot)
  library(factoextra)
  library(cluster)
})

# Load cleaned data
cars <- read.csv("data/mtcars_cleaned.csv")
cars$origin <- factor(cars$origin, levels = c("US", "Europe", "Japan"))
cars$cyl_f  <- factor(cars$cyl_f, levels = c("4 Cylinders", "6 Cylinders", "8 Cylinders"))
cars$am_f   <- factor(cars$am_f, levels = c("Automatic", "Manual"))
cars$vs_f   <- factor(cars$vs_f, levels = c("V-shaped", "Straight/Inline"))

# ------------------------------------------------------------------------------
# 1. Fuel Efficiency vs Key Drivers (wt, hp, disp)
# ------------------------------------------------------------------------------
cor_matrix <- cor(cars[, c("mpg", "wt", "hp", "disp", "drat", "qsec")])
print("Correlation Matrix:")
print(round(cor_matrix, 3))

# Linear models
fit_wt <- lm(mpg ~ wt, data = cars)
fit_mult <- lm(mpg ~ wt + hp + disp, data = cars)

summary(fit_wt)
summary(fit_mult)

# Check Multicollinearity (VIF)
print("Variance Inflation Factors (VIF):")
print(vif(fit_mult))

# ------------------------------------------------------------------------------
# 2. Transmission Efficiency & Simpson's Paradox (am vs mpg controlling for wt)
# ------------------------------------------------------------------------------
# Naive model: am appears highly significant (+7.24 mpg for manual)
fit_am_naive <- lm(mpg ~ am_f, data = cars)
summary(fit_am_naive)

# Controlled model: adding wt absorbs the entire effect!
fit_am_controlled <- lm(mpg ~ am_f + wt, data = cars)
summary(fit_am_controlled)

# ------------------------------------------------------------------------------
# 3. Cylinder Differences: Parametric (ANOVA) and Non-Parametric (Kruskal-Wallis)
# ------------------------------------------------------------------------------
# Normality test within groups (Shapiro-Wilk)
by(cars$mpg, cars$cyl_f, shapiro.test)

# One-way ANOVA
anova_cyl <- aov(mpg ~ cyl_f, data = cars)
summary(anova_cyl)
TukeyHSD(anova_cyl)

# Kruskal-Wallis test (robust to non-normality and small N)
kruskal.test(mpg ~ cyl_f, data = cars)

# ------------------------------------------------------------------------------
# 4. Outliers & Influential Observations (Cook's Distance & Leverage)
# ------------------------------------------------------------------------------
cars_diag <- cars %>%
  mutate(
    hat_values = hatvalues(fit_mult),
    cooks_d    = cooks.distance(fit_mult),
    std_resid  = rstandard(fit_mult)
  )

# High leverage threshold: 2 * p / n = 2 * 4 / 32 = 0.25
cat("--> Influential observations (Cook's D > 0.15 or Leverage > 0.25):\n")
cars_diag %>%
  filter(cooks_d > 0.15 | hat_values > 0.25) %>%
  select(car_model, mpg, wt, hp, cooks_d, hat_values) %>%
  arrange(desc(cooks_d)) %>%
  print()

# ------------------------------------------------------------------------------
# 5. Principal Component Analysis (PCA) & Market Segmentation
# ------------------------------------------------------------------------------
pca_vars <- cars[, c("mpg", "disp", "hp", "drat", "wt", "qsec")]
pca_res  <- prcomp(pca_vars, scale. = TRUE)

summary(pca_res)
print("PCA Eigenvectors (Loadings):")
print(round(pca_res$rotation[, 1:2], 3))

# K-Means Clustering (k = 3)
set.seed(42)
km_res <- kmeans(scale(pca_vars), centers = 3, nstart = 25)
cars$cluster <- factor(km_res$cluster)

cat("--> Cluster Profiles:\n")
cars %>%
  group_by(cluster) %>%
  summarise(
    count = n(),
    mean_mpg = mean(mpg),
    mean_hp  = mean(hp),
    mean_wt  = mean(wt_lbs),
    mean_qsec = mean(qsec)
  ) %>%
  print()
