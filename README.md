# Analysis of New York Airbnb Dataset

## 📘 Project Overview

This project analyzes the Airbnb dataset for New York City to understand factors affecting pricing, identify trends across neighborhoods, and find the most cost-effective accommodations. Using statistical and geospatial methods, this project provides actionable insights for Airbnb hosts, travelers, and policymakers.

---

## 📂 Repository Structure


---

## 🔍 Key Objectives

1. **Pricing by Neighborhood**: Understand average pricing trends in neighborhoods, focusing on Manhattan.
2. **Distribution Analysis**: Compare price distributions of specific neighborhoods to overall NYC distribution.
3. **Cost-Effectiveness Analysis**: Identify the top 1,000 cost-effective listings in NYC using custom scoring.
4. **Statistical Confidence**: Use bootstrap methods to estimate average prices with confidence intervals.
5. **Variable Correlations**: Examine the relationship between price and other factors, such as reviews and availability.

---

## 📊 Methods and Approach

### **Data Source**
- The dataset: [`Airbnb_Open_Data.csv`](Airbnb_Open_Data.csv)
- Geospatial data: [`NY.geojson`](NY.geojson)

### **Steps in Analysis**
1. Data Cleaning:
   - Converted pricing and service fee columns to numeric.
   - Filtered outliers and irrelevant listings.
   - Focused on homes with sufficient reviews (≥10).

2. Geospatial Analysis:
   - Used [`NY.geojson`](NY.geojson) with `leaflet` in R to visualize neighborhood-level price trends.
   - Created an interactive heatmap showing average prices by neighborhood.

3. Statistical Insights:
   - Bootstrapped average price estimates with 95% confidence intervals.
   - Analyzed linear correlations between price and variables like number of reviews and availability.

4. Cost-Effectiveness Scoring:
   - Designed a custom scoring algorithm based on price, reviews, and features like cancellation policy and host verification.

---

## 📈 Visualizations and Findings

### **Heatmap of Pricing by Neighborhood**
- A heatmap was created using `leaflet` in R to display average prices across NYC neighborhoods.
- **Key finding**: Central NYC neighborhoods had similar pricing trends, likely due to high competition and demand.

### **Distribution Comparison**
- Neighborhood-specific price distributions were compared to overall NYC distribution.
- **Key insight**: Price distributions varied significantly, except for Midtown, which closely matched NYC's overall pattern.

### **Cost-Effective Listings**
- Identified the top 1,000 cost-effective listings using a scoring algorithm.
- **Observation**: Listings with high scores often shared attributes like flexible cancellation policies and verified hosts.

### **Bootstrap Analysis**
- Estimated the average price across NYC listings with a 95% confidence interval.
- **Result**: Average price ~524.27 (±1.94 standard error).

### **Variable Correlation**
- Analyzed the linear correlation between price and variables like reviews, availability, and rating.
- **Finding**: Correlations were weak, indicating complex pricing dynamics.

---

## 🛠 Tools and Technologies

- **Programming**: R
- **Geospatial Analysis**: `leaflet`, `sf`
- **Data Cleaning**: `tidyverse`
- **Statistical Analysis**: Bootstrapping, correlation analysis
- **Visualization**: Heatmaps, ggplot

---

## 🚀 How to Run the Analysis

1. Clone this repository:
   ```bash
   git clone https://github.com/your-username/NY-Airbnb-Analysis.git

install.packages(c("leaflet", "sf", "tidyverse", "ggplot2"))

source("r (1).R")

📧 Contact
For questions or collaboration opportunities, please contact:

Segev Cohen: [segev777701@gmail.com]
