# 🇮🇳 India Traffic Accident Risk Analysis

An end-to-end Data Analyst portfolio project analyzing road, railway, and crossing accidents across Indian states and UTs using **Python, PostgreSQL, and Power BI**.

---

## 📌 Project Overview
India records over 4 lakh road accidents annually, yet raw death counts alone are misleading — large states dominate simply due to population size.  
This project builds a complete analytical pipeline to uncover the true danger zones using **fatality rates, composite risk scores, and multi-dimensional segmentation**.

**Key finding:** Smaller cities like *Varanasi (107.41% fatality rate)* are proportionally far more dangerous than high-death-count states like UP — completely hidden in raw numbers.

---

## 🗂️ Dataset
- **Source:** Government of India — NCRB / Road Transport Ministry  
- **Coverage:** 160+ States, UTs, and Cities  
- **Raw Columns:** 13 (Cases, Injured, Died across Road, Railway, Crossing, Total)  
- **Engineered Features:** 9 new columns created  

**Columns include:**  
State/UT/City · Road Accidents (Cases, Injured, Died) · Railway Accidents (Cases, Injured, Died) · Crossing Accidents (Cases, Injured, Died) · Total Traffic Accidents (Cases, Injured, Died)

---

## 🛠️ Tech Stack
- **Python (Pandas, NumPy, Seaborn, Matplotlib):** EDA & Feature Engineering  
- **PostgreSQL:** SQL Analysis — 7 queries  
- **Power BI + DAX:** Interactive Dashboard  
- **PowerPoint:** Final Presentation  

---

## 📁 Project Structure
india-accident-risk-analysis/
├── data/
│   └── ADSI_Table_1A.2.csv
├── powerbi/
│   └── Dashboard.png
├── presentation/
│   └── accidents_project.pptx
├── python/ 
│   ├── data_cleaning.ipynb
├── sql/ 
│   └── sql_scripts.sql 
├── .gitignore
├── postgreeSQL.md
└── README.md


---

## 🔍 Phase 1 — Exploratory Data Analysis (Python)
- Data quality checks: shape, dtypes, nulls, duplicates, negative values  
- Outlier detection using IQR  
- Visualizations: histograms, KDE, correlation heatmap, stacked bar charts, scatter plots  

**Insight:** Most columns are right-skewed — large states dominate raw counts, masking severity in smaller states.

---

## ⚙️ Phase 2 — Feature Engineering (Python)
Created 9 new features including:
- `Road_Fatality_Rate = Road_Died / Road_Cases × 100`
- `Crossing_Death_Share = Crossing_Died / Total_Died × 100`
- `Composite_Risk_Score = 0.5×Fatality + 0.3×Injury + 0.2×Crossing`
- `Risk_Tier = High / Medium / Low segmentation`

**Insight:** Varanasi has a **107.41% fatality rate** — highest in dataset, hidden in raw counts.

---

## 🗄️ Phase 3 — SQL Analysis (PostgreSQL)
7 queries covering:
- Ranking states by deaths
- Fatality rate calculation
- States above national average
- Road vs Rail vs Crossing breakdown
- Risk quartile grouping
- Crossing danger states
- National summary rollup  

**Star Query:** National summary → 618K deaths · 88.17% road · 10.55% crossing · ~39% fatality rate.

---

## 📊 Phase 4 — Power BI Dashboard
**Visuals:**
- KPI cards (Cases, Injured, Deaths, Fatality Rate)
- India map (deaths by state)
- Top 10 states bar chart
- Road vs Rail vs Crossing stacked bar
- Donut chart (national death share)
- Summary table (fatality rate per state)

**Slicers:** State dropdown · Risk Tier (High/Medium/Low)

**DAX Examples:**
```DAX
Total Deaths = SUM(accidents[total_died])
Fatality Rate % = DIVIDE(SUM(accidents[total_died]), SUM(accidents[total_cases])) * 100
Road Death Share % = DIVIDE(SUM(accidents[road_died]), SUM(accidents[total_died])) * 100
