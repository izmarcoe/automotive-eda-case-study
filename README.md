# 🏎️ Automotive Portfolio Exploratory Data Analysis (`mtcars`)
### Strategic Market Positioning, Powertrain Architecture & Fuel Efficiency Dynamics
*Prepared for Automotive Client Executive Leadership & Product Planning Teams*

[![R](https://img.shields.io/badge/Language-R%20v4.3+-276DC3.svg?logo=r&logoColor=white)](https://www.r-project.org/)
[![IDE](https://img.shields.io/badge/IDE-VS%20Code%20%2B%20R%20Extension-007ACC.svg?logo=visual-studio-code&logoColor=white)](https://code.visualstudio.com/)
[![Web Server](https://img.shields.io/badge/Server-XAMPP%20Localhost-FB7A24.svg?logo=xampp&logoColor=white)](http://localhost/mtcars-eda/mtcars_eda_report.html)
[![Report](https://img.shields.io/badge/Deliverable-Interactive%20HTML%20Report-2ECC71.svg)](mtcars_eda_report.html)
[![License](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

---

## 📌 Executive Summary

This repository contains a comprehensive **Exploratory Data Analysis (EDA)** and strategic product-planning study evaluating the historical `mtcars` dataset (1973–1974 *Motor Trend* automotive survey, $N = 32$).

### The Business Challenge
An automotive manufacturer planning its next-generation passenger car line-up engaged our consultancy practice to analyze the fundamental relationships between vehicle design choices (weight, engine displacement, cylinder architecture, induction systems, gearing) and real-world outcomes (fuel economy and track acceleration), while assessing competitor market positioning across geographic regions (United States, Europe, Japan).

### Historical Context: The 1973 OPEC Shock & The "Malaise Era"
The 1973–1974 model years represent a seismic inflection point in automotive history. Following the 1973 OPEC oil embargo, crude oil prices quadrupled almost overnight. Prior to this crisis, American vehicle development prioritized physical scale, cubic displacement, and straight-line torque. The sudden premium placed on fuel economy exposed severe structural vulnerabilities in domestic platforms, catalyzing the rapid rise of lightweight Japanese imports and permanently reshaping consumer expectations.

---

## 🏆 Key Findings for Executive Leadership

```
┌────────────────────────────────────────────────────────────────────────────────────────┐
│                               TOP 3 STRATEGIC FINDINGS                                 │
├────────────────────────────────────────────────────────────────────────────────────────┤
│ 1. WEIGHT IS THE DECISIVE DETERMINANT OF FUEL THIRST (β = -5.35 MPG / 1,000 lbs)       │
│    Vehicle curb weight alone explains over 75% of fuel consumption variance. The       │
│    industry belief that manual transmissions yield superior economy (+7.24 MPG         │
│    unadjusted) is an illusion: controlling for mass, transmission choice has virtually │
│    zero direct effect (p = 0.988, Simpson's Paradox).                                  │
├────────────────────────────────────────────────────────────────────────────────────────┤
│ 2. THE "DISPLACEMENT TRAP" OF AMERICAN DOMESTIC V8s                                    │
│    American manufacturers relied on massive displacement (330–472 cu in) with sluggish │
│    specific output (~0.45–0.52 hp/cu in), burning excessive fuel without delivering    │
│    quarter-mile acceleration advantages over lighter European/Japanese competition.    │
├────────────────────────────────────────────────────────────────────────────────────────┤
│ 3. ACUTE GEOGRAPHIC MARKET POLARIZATION                                                │
│    Japanese automakers established an unassailable efficiency beachhead (averaging     │
│    25.5 MPG at 2,200 lbs), while US manufacturers were 100% concentrated in sub-18 MPG │
│    heavyweight platforms, leaving them catastrophically vulnerable to oil shocks.      │
└────────────────────────────────────────────────────────────────────────────────────────┘
```

---

## 💡 Strategic Recommendations for Next-Gen Vehicle Line-Up

1. **Mandate Platform Downsizing & Unibody Lightweighting:**
   * *Target:* Curb weight below **2,800 lbs**.
   * *Rationale:* Weight is the single largest physical predictor of fuel consumption ($r = -0.868$). Reducing vehicle mass by 500 lbs yields an immediate ~2.7 MPG efficiency dividend, far exceeding gains achievable through isolated engine tuning.
2. **Shift Powertrain Strategy to Overhead-Cam / Multi-Valve 4- & 6-Cylinder Engines:**
   * *Target:* Specific power output exceeding **0.75 hp per cubic inch** ($> 45\text{ hp/liter}$).
   * *Rationale:* High volumetric efficiency and multi-valve cylinder heads eliminate the need for heavy, high-displacement combustion blocks, matching acceleration expectations while drastically cutting thermal and friction losses.
3. **Deploy Multi-Speed Drivetrains with Tall Overdrive Highway Gearing:**
   * *Target:* 4-speed or 5-speed transmissions with high final drive ratios ($\text{drat} < 3.2$).
   * *Rationale:* Decouples low-gear launch acceleration from high-speed highway cruising, eliminating the historical trade-off between quarter-mile responsiveness and fuel economy.

---

## 🔬 Comprehensive Analytical Breakdown

### Phase 1: Data Architecture & Feature Engineering
* **Row Names Extraction:** Converted car model strings from index metadata into an explicit `car_model` column.
* **Brand & Origin Parsing:** Derived 18 distinct automotive marques and classified them into three core geographic theaters: **United States** (11 models, 34.4%), **Europe** (15 models, 46.9%), and **Japan** (6 models, 18.8%).
* **Categorical Typing:** Converted numeric doubles (`cyl`, `vs`, `am`, `gear`, `carb`) into structured R factors with self-documenting level labels to prevent invalid continuous linear modeling assumptions.
* **Domain Feature Engineering:**
  * $\text{wt\_lbs} = \text{wt} \times 1,000$ (actual curb weight in pounds).
  * $\text{GPM} = 100 / \text{mpg}$ (gallons per 100 miles, restoring mathematical consumption linearity).
  * $\text{Power-to-Weight} = (\text{hp} / \text{wt\_lbs}) \times 100$ (gross horsepower per 100 lbs).
  * $\text{Specific Output} = \text{hp} / \text{disp}$ (volumetric efficiency in horsepower per cubic inch).

---

### Phase 2: Exploratory Data Analysis & Hypotheses Testing

#### 1. Fuel Efficiency Dynamics (Questions 1–4)
* **Fleet Distribution:** Right-skewed ($\text{Skewness} = 0.61$), with a median of **19.2 MPG** and mean of **20.09 MPG**. The "typical car" archetype represents a 3,440 lb sedan with a 6-to-8 cylinder engine generating 123–175 hp.
* **Leaders & Laggards:** 
  * *Efficiency Leaders:* Toyota Corolla (33.9 MPG), Fiat 128 (32.4 MPG), Lotus Europa (30.4 MPG), and Honda Civic (30.4 MPG)—all featuring sub-100 cu in engines and curb weights $< 2,200\text{ lbs}$.
  * *Consumption Laggards:* Cadillac Fleetwood (10.4 MPG) and Lincoln Continental (10.4 MPG)—exceeding 5,200 lbs with 460–472 cu in V8 blocks.
* **The "MPG Illusion":** Diminishing returns in raw MPG are resolved by evaluating GPM. Upgrading a 10 MPG vehicle to 15 MPG saves **3.33 gallons/100 mi**, whereas upgrading a 30 MPG vehicle to 35 MPG saves only **0.48 gallons/100 mi**.
* **Residual Standouts:**
  * *Mercedes-Benz 240D (+3.32 MPG residual):* High efficiency enabled by the dataset's lone **diesel compression-ignition engine**.
  * *Lotus Europa (+3.08 MPG residual):* Exceptional efficiency enabled by Colin Chapman's aerodynamic, 1,513 lb fiberglass chassis.

#### 2. Performance and Design Dynamics (Questions 5–8)
* **Power vs. Quickness Divergence:** Maserati Bora (335 hp) and Ford Pantera L (264 hp) lead both categories. However, high horsepower does not guarantee acceleration: the Cadillac Fleetwood (205 hp) and Lincoln Continental (215 hp) clock sluggish ~18.0s quarter-miles due to massive inertial mass.
* **The Efficiency-Speed Pareto Frontier:** Sub-16-second performance cars averaged only 15.6 MPG. High-mileage cars ($>25\text{ MPG}$) required over 18.5 seconds to complete the quarter-mile.
* **The Sluggish Index:** Identified vehicles suffering from poor mileage without acceleration return: the *Valiant* (18.1 MPG, 20.22s qsec) and *Hornet 4 Drive* (21.4 MPG, 19.44s qsec).
* **Multi-Dimensional Outliers (Mahalanobis Distance):** *Maserati Bora* (extreme horsepower outlier) and *Cadillac Fleetwood / Lincoln Continental* (extreme weight/displacement outliers).

#### 3. Vehicle Segments & Drivetrain Architecture (Questions 9–12)
* **Cylinder Groups:** 4-cylinders (26.7 MPG) vs 6-cylinders (19.7 MPG) vs 8-cylinders (15.1 MPG). Validated through One-Way ANOVA ($F = 39.7, p < 0.001$) and non-parametric Kruskal-Wallis ($H = 25.7, p < 0.001$).
* **Simpson's Paradox in Transmission Efficiency:** Naive analysis shows manual transmissions outperforming automatics by **+7.24 MPG ($p = 0.001$)**. When controlling for curb weight via ANCOVA, the manual coefficient drops to **-0.024 MPG ($p = 0.988$)**, demonstrating that the effect was entirely an artifact of vehicle mass.
* **Principal Component Analysis (PCA):**
  * *PC1 (60.0% Variance) — "Scale, Displacement & Fuel Thirst":* High positive loadings on `disp`, `wt`, `hp`; negative loading on `mpg`.
  * *PC2 (24.1% Variance) — "Track Acceleration & Gearing":* High positive loading on `qsec`; negative loadings on `drat` and `hp`.
  * *Cumulative Variance:* Captures **84.1%** of fleet variance.

#### 4. Geographic Origin & Market Positioning (Questions 13–15)
* **Japan:** 25.53 MPG average, 2,208 lbs average weight, 102.6 cu in average displacement. Unbeatable post-crisis positioning.
* **United States:** 14.97 MPG average, 4,008 lbs average weight, 337.6 cu in displacement, 100% automatic transmissions. Completely vulnerable to fuel shocks.
* **Europe:** 20.57 MPG average. Bifurcated across high-efficiency economy/diesel models and premium sports GTs.

#### 5. Methodological Rigor, Diagnostics & Limitations (Questions 16–18)
* **Multicollinearity Diagnostic:** Variance Inflation Factors exceed critical thresholds ($\text{VIF} = 10.7$ for `wt` and $11.2$ for `disp`), warning analysts against interpreting individual regression coefficients in isolation.
* **Influential Leverage Points:** Evaluated Cook's Distance ($4/N = 0.125$ cutoff), identifying the *Maserati Bora* (horsepower leverage) and *Cadillac Fleetwood / Lincoln Continental* (mass leverage) as high-influence observations.
* **Historical Caveat:** 1974 carburetor technology cannot be directly generalized to modern computer-controlled, turbocharged direct-injection drivetrains.

#### 6. Additional Advanced Inquiries
* **Additional Question 1 (Power-to-Weight Track Dynamics):** Power-to-weight explains 49.5% of acceleration variance. Luxury grand tourers like the *Merc 450SL* suffer from high drivetrain slip and tall gearing, lagging lighter sports cars with identical power-to-weight ratios.
* **Additional Question 2 (The Carburetor Penalty):** Upgrading from 1-2 barrels to 4-barrel carburetors inflicts an immediate **37.5% fuel economy penalty (25.3 down to 15.8 MPG)** with diminishing acceleration returns.

---

## 📁 Repository Structure

```text
mtcars-eda/
├── .vscode/
│   ├── extensions.json             # Recommended VS Code extensions (R, R Markdown)
│   └── settings.json               # Configured VS Code R terminal & editor settings
├── scripts/
│   ├── 00_setup_dependencies.R     # Auto-installer for required CRAN packages
│   ├── 01_data_cleaning.R          # Feature engineering, brand & origin derivation
│   ├── 02_exploratory_analysis.R   # Statistical models, ANOVA, Kruskal-Wallis, PCA & K-Means
│   └── render_report.R             # 1-click script to render .Rmd to HTML via rmarkdown
├── data/
│   └── mtcars_cleaned.csv          # Preprocessed dataset with engineered features
├── mtcars_eda_report.Rmd           # Master R Markdown analysis & narrative
├── mtcars_eda_report.html          # Rendered presentation-grade HTML report
├── .gitignore                      # Git exclusion rules for R, cache, and OS files
└── README.md                       # Comprehensive project documentation
```

---

## 🛠️ Reproduction & Setup Guide (VS Code)

### 1. Prerequisites
Ensure **R (v4.3+)** and **Pandoc** are installed on your system:

```powershell
winget install --id RProject.R -e
winget install --id JohnMacFarlane.Pandoc -e
```

### 2. VS Code Configuration
1. Open this folder in VS Code:
   ```bash
   code C:\xampp\htdocs\mtcars-eda
   ```
2. When prompted by VS Code, install the recommended **`R`** extension (by *REditorSupport*).

### 3. Install Required R Libraries
Open an R terminal in VS Code and run:

```r
source("scripts/00_setup_dependencies.R")
```

### 4. Render the Report
To re-compile the report into HTML:
* **In VS Code:** Press `Ctrl + Shift + P` $\rightarrow$ select **R: Knit to HTML**.
* **In Terminal:** Run:
  ```bash
  Rscript scripts/render_report.R
  ```

---

## 🌐 Localhost Access (XAMPP)

Because this repository is located in your XAMPP web root (`htdocs`), you can launch the Apache server in the XAMPP Control Panel and view the interactive HTML report directly in your browser:

👉 **[http://localhost/mtcars-eda/mtcars_eda_report.html](http://localhost/mtcars-eda/mtcars_eda_report.html)**

---

## 📤 Pushing to Your GitHub Remote

To push this repository to your personal or organization GitHub account:

```bash
# 1. Navigate to the project directory
cd C:\xampp\htdocs\mtcars-eda

# 2. Add your GitHub remote URL
git remote add origin https://github.com/<YOUR_GITHUB_USERNAME>/<YOUR_REPOSITORY_NAME>.git

# 3. Ensure the branch is named main
git branch -M main

# 4. Push all commits and tags
git push -u origin main
```

---

## 📜 License
This project is open-source and available under the [MIT License](LICENSE).
