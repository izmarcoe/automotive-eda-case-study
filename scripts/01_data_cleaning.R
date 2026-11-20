# ==============================================================================
# Script: 01_data_cleaning.R
# Purpose: Clean, preprocess, and engineer features for the mtcars dataset
# ==============================================================================

suppressPackageStartupMessages({
  library(dplyr)
  library(tibble)
  library(stringr)
  library(forcats)
})

# 1. Load built-in mtcars
data(mtcars)

# 2. Extract car model names from row names
cars_raw <- mtcars %>%
  rownames_to_column(var = "car_model")

# 3. Derive Brand and Region of Origin
# Notes on brand mapping:
# - 'Hornet' -> AMC
# - 'Valiant' & 'Duster' -> Plymouth (Chrysler Corp)
# - 'Merc' -> Mercedes-Benz
# - 'Ford Pantera L' -> De Tomaso / Ford (European sports coupe with Ford V8, Italian chassis)
# - 'Camaro' -> Chevrolet (GM)
# - 'Firebird' -> Pontiac (GM)

cars_clean <- cars_raw %>%
  mutate(
    # Brand extraction
    brand = case_when(
      str_detect(car_model, "^Mazda") ~ "Mazda",
      str_detect(car_model, "^Datsun") ~ "Datsun",
      str_detect(car_model, "^Hornet") ~ "AMC",
      str_detect(car_model, "^Valiant") ~ "Plymouth",
      str_detect(car_model, "^Duster") ~ "Plymouth",
      str_detect(car_model, "^Merc") ~ "Mercedes-Benz",
      str_detect(car_model, "^Cadillac") ~ "Cadillac",
      str_detect(car_model, "^Lincoln") ~ "Lincoln",
      str_detect(car_model, "^Chrysler") ~ "Chrysler",
      str_detect(car_model, "^Fiat") ~ "Fiat",
      str_detect(car_model, "^Honda") ~ "Honda",
      str_detect(car_model, "^Toyota") ~ "Toyota",
      str_detect(car_model, "^Dodge") ~ "Dodge",
      str_detect(car_model, "^AMC") ~ "AMC",
      str_detect(car_model, "^Camaro") ~ "Chevrolet",
      str_detect(car_model, "^Pontiac") ~ "Pontiac",
      str_detect(car_model, "^Porsche") ~ "Porsche",
      str_detect(car_model, "^Lotus") ~ "Lotus",
      str_detect(car_model, "^Ford Pantera") ~ "De Tomaso / Ford",
      str_detect(car_model, "^Ferrari") ~ "Ferrari",
      str_detect(car_model, "^Maserati") ~ "Maserati",
      str_detect(car_model, "^Volvo") ~ "Volvo",
      TRUE ~ "Other"
    ),
    
    # Geographic region classification
    origin = case_when(
      brand %in% c("Mazda", "Datsun", "Honda", "Toyota") ~ "Japan",
      brand %in% c("Mercedes-Benz", "Fiat", "Porsche", "Lotus", "Ferrari", "Maserati", "Volvo", "De Tomaso / Ford") ~ "Europe",
      brand %in% c("AMC", "Plymouth", "Cadillac", "Lincoln", "Chrysler", "Dodge", "Chevrolet", "Pontiac") ~ "US",
      TRUE ~ "Unknown"
    ),
    
    # Factor conversions with meaningful, self-documenting labels
    cyl_f  = factor(cyl, levels = c(4, 6, 8), labels = c("4 Cylinders", "6 Cylinders", "8 Cylinders")),
    vs_f   = factor(vs, levels = c(0, 1), labels = c("V-shaped", "Straight/Inline")),
    am_f   = factor(am, levels = c(0, 1), labels = c("Automatic", "Manual")),
    gear_f = factor(gear, levels = c(3, 4, 5), labels = c("3 Gears", "4 Gears", "5 Gears")),
    carb_f = factor(carb, levels = c(1, 2, 3, 4, 6, 8)),
    origin = factor(origin, levels = c("US", "Europe", "Japan")),
    brand  = factor(brand),
    
    # Feature Engineering for Automotive Analytics
    wt_lbs = wt * 1000,                                 # Actual curb weight in lbs
    gpm = 100 / mpg,                                    # Gallons per 100 miles (linear fuel consumption)
    hp_per_wt = hp / wt,                                # Horsepower-to-weight ratio (hp per 1,000 lbs)
    specific_power = hp / disp,                         # Volumetric efficiency: hp per cubic inch
    disp_per_cyl = disp / cyl                           # Cubic inches displacement per cylinder
  )

# Verify results
cat("--> mtcars dataset cleaned successfully!\n")
cat("--> Dimensions:", nrow(cars_clean), "rows x", ncol(cars_clean), "columns\n")
cat("--> Regional distribution:\n")
print(table(cars_clean$origin))

# Save cleaned dataset
dir.create("data", showWarnings = FALSE)
write.csv(cars_clean, "data/mtcars_cleaned.csv", row.names = FALSE)
cat("--> Cleaned data saved to data/mtcars_cleaned.csv\n")
