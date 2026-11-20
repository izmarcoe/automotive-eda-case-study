# Automotive Portfolio Exploratory Data Analysis (`mtcars`)
### Strategic Market Positioning, Fuel Efficiency & Powertrain Dynamics

[![R](https://img.shields.io/badge/Language-R%20v4.3+-blue.svg)](https://www.r-project.org/)
[![IDE](https://img.shields.io/badge/IDE-VS%20Code%20%2B%20R%20Extension-purple.svg)](https://code.visualstudio.com/)
[![Report](https://img.shields.io/badge/Output-HTML%20Report-brightgreen.svg)](mtcars_eda_report.html)
[![License](https://img.shields.io/badge/License-MIT-lightgrey.svg)](LICENSE)

---

## 🚗 Project Overview

This repository contains a comprehensive **Exploratory Data Analysis (EDA)** and strategic consulting assessment based on the historical `mtcars` specification dataset (1973–1974 *Motor Trend* survey, $N = 32$). 

The objective is to advise a car manufacturer's executive leadership team on designing and positioning their next-generation vehicle line-up following the disruptive macroeconomic shift of the **1973 OPEC Oil Embargo** and the onset of the American automotive "Malaise Era."

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
├── mtcars_eda_report.html          # Rendered, self-contained interactive HTML presentation
├── .gitignore                      # Git exclusion rules for R, cache, and OS files
└── README.md                       # Complete documentation and execution guide
```

---

## 🛠️ Environment Setup (VS Code + R Extension)

This project is tailored specifically for **Visual Studio Code** on Windows.

### 1. Prerequisites (R & Pandoc)
If not already installed on your system, install **R** and **Pandoc** using Windows `winget` in PowerShell:

```powershell
winget install --id RProject.R -e
winget install --id JohnMacFarlane.Pandoc -e
```

### 2. VS Code Extension
Open VS Code, navigate to Extensions (`Ctrl + Shift + X`), and ensure the official **`R`** extension (by *REditorSupport / Yuki Ueda*) is installed.

### 3. Install R Packages
Open an R terminal in VS Code (or PowerShell) and execute:

```r
source("scripts/00_setup_dependencies.R")
```

The script automatically verifies and installs:
* `rmarkdown`, `knitr`, `kableExtra`
* `tidyverse` (`dplyr`, `ggplot2`, `stringr`, `tibble`, `forcats`)
* `patchwork`, `corrplot`, `ggrepel`
* `car`, `broom`, `factoextra`, `cluster`

---

## 🚀 Execution & Rendering

### Option A: Interactive Execution in VS Code
1. Open `mtcars_eda_report.Rmd` in VS Code.
2. Click the **Run Chunk** button (green play icon) at the top of any code chunk, or press `Ctrl + Shift + Enter`.
3. To render the complete HTML report, press `Ctrl + Shift + P` $\rightarrow$ select **R: Knit to HTML**.

### Option B: Terminal Command Line
Run the compilation script directly from your terminal:

```bash
Rscript scripts/render_report.R
```

The generated file `mtcars_eda_report.html` is fully standalone with embedded CSS, interactive tables, and high-resolution plots.

---

## 📊 Summary of Analysis & Business Findings

### 1. Top 3 Management Findings
1. **Weight is the Decisive Driver of Fuel Thirst ($\beta = -5.35$ MPG / 1,000 lbs):** Vehicle curb weight explains over 75% of fuel consumption variance. The popular belief that manual transmissions improve efficiency is an illusion created by selection bias: controlling for weight, transmission choice has zero statistically significant effect ($p = 0.988$).
2. **The "Displacement Trap":** Domestic American V8s suffered from low specific power ($0.45\text{–}0.52\text{ hp}/\text{in}^3$), dragging excessive displacement without delivering quarter-mile speed advantages over lighter, higher-efficiency European and Japanese designs.
3. **Severe Geographic Polarization:** Japanese manufacturers occupied an unbeatable efficiency position in the $\ge 25\text{ MPG}$ compact class (averaging 25.5 MPG at 2,200 lbs), whereas the US fleet was entirely concentrated in sub-18 MPG heavyweight cruisers.

### 2. Top 3 Strategic Recommendations
1. **Mandate Platform Downsizing & Lightweighting:** Develop a unibody platform targeting curb weights $< 2,800\text{ lbs}$. Shedding 500 lbs yields an immediate ~2.7 MPG improvement.
2. **Shift to Overhead-Cam 4- and 6-Cylinder Engines:** Retire high-displacement, low-specific-output pushrod architectures in favor of engines engineered for high volumetric efficiency ($>0.75\text{ hp}/\text{in}^3$).
3. **Integrate Multi-Speed Overdrive Transmissions:** Modernize gearboxes with tall cruising ratios ($\text{drat} < 3.2$), severing the historic compromise between low-end launch acceleration and high-speed highway economy.

---

## 🔬 Core Business Questions Addressed

| # | Question Focus | Key Finding / Methodology |
|:---|:---|:---|
| **Q1** | Distribution of `mpg` | Right-skewed ($\text{Skew} = 0.61$). Median: 19.2 MPG, Mean: 20.09 MPG. "Typical car": 3,440 lbs, V8/I6, 123–175 hp, 3-speed auto. |
| **Q2** | Efficiency extremes | Top: Toyota Corolla (33.9), Fiat 128 (32.4). Bottom: Cadillac Fleetwood (10.4), Lincoln Continental (10.4). |
| **Q3** | Drivers of `mpg` | Strongest correlation: Weight ($r = -0.868$), Displacement ($r = -0.848$), Power ($r = -0.776$). GPM ($100/\text{mpg}$) restores linearity. |
| **Q4** | Surprising vehicles | *Merc 240D* (+3.32 MPG residual) excels via diesel compression efficiency; *Lotus Europa* (+3.08 residual) excels via lightweight aero chassis. |
| **Q5** | Power vs. Quickness | Quickest: *Pantera* (14.5s), *Bora* (14.6s). Most powerful: *Bora* (335 hp). High hp does not equal quickness if burdened by 5,300 lbs (Cadillac/Lincoln). |
| **Q6** | Efficiency vs. Speed | Strict 1974 Pareto boundary: Sub-16s cars averaged only 15.6 MPG. Lotus Europa was the sole exception. |
| **Q7** | Underperforming cars | Sluggish Index: *Valiant* and *Hornet* deliver both poor economy and glacial acceleration (>19.4s qsec). |
| **Q8** | Unusual combinations | *Maserati Bora* (extreme hp outlier), *Cadillac/Lincoln* (extreme mass outliers), *Honda Civic* (ultra-lightweight). |
| **Q9** | Cylinder groups | 4-cyl (26.7 MPG) vs 6-cyl (19.7 MPG) vs 8-cyl (15.1 MPG). ANOVA $F = 39.7, p < 0.001$; Kruskal-Wallis $H = 25.7, p < 0.001$. |
| **Q10** | Manual vs. Automatic | Naive: Manual +7.24 MPG ($p = 0.001$). Controlled for weight: $-0.02$ MPG ($p = 0.988$). Classic **Simpson's Paradox**. |
| **Q11** | V-shape vs. Straight | Straight engines (24.6 MPG) vs V-shaped (16.6 MPG); primarily driven by displacement differences. |
| **Q12** | PCA & Segmentation | PC1 (60.0%): Scale & Thirst. PC2 (24.1%): Acceleration & Gearing. Cumulative 84.1% variance. |
| **Q13** | Brand & Origin breakdown | US: 11 models (34.4%), Europe: 15 models (46.9%), Japan: 6 models (18.8%). Mercedes-Benz accounts for 7 models. |
| **Q14** | Regional spec profiles | Japan: 25.5 MPG, 2,200 lbs, 100 cu in. US: 15.0 MPG, 4,000 lbs, 337 cu in. Europe: bifurcated economy & sports GTs. |
| **Q15** | Fuel-conscious positioning | Japan positioned with decisive dominance; US domestic manufacturers catastrophically exposed. |
| **Q16** | Categorical encoding | Converted numeric codes (`cyl`, `vs`, `am`, `gear`, `carb`) to factors to prevent invalid linear assumptions. |
| **Q17** | Multicollinearity | Severe collinearity between `wt` ($\text{VIF} = 10.7$) and `disp` ($\text{VIF} = 11.2$). Isolated coefficients are unstable. |
| **Q18** | Sample limitations | Small $N = 32$; influential leverage points (*Chrysler Imperial*, *Cadillac Fleetwood*, *Maserati Bora*). |
| **Add Q1** | Power-to-weight track dynamics | Power-to-weight explains 49.5% of acceleration variance; transmission slippage and tall gearing cause substantial lag. |
| **Add Q2** | Carburetor efficiency penalty | 4-barrel carburetors inflict a 37.5% MPG penalty (15.8 vs 25.3 MPG) with marginal real-world utility. |

---

## 📄 License
This project is open-source and available under the MIT License.
