# Alone Survivalists: Advanced_SQL_couse_final_project

📊 **Advanced SQL for Data Science** — Final Project  
👨‍💻 **Author:** Maor Nave  
🗂️ **Student ID:** 313603391  
🌐 **Live App:** [Base44 SQL Analytics Hub](https://app--maor-nave-sql-analytics-hub-2d23fd15.base44.app)

---

## 📌 Project Overview

This project analyzes and transforms data from the reality TV show *Alone*, where survivalists compete to outlast each other in the wilderness. The original dataset was flat and contained redundancy, inconsistencies, and missing values. Using SQL and data modeling techniques, I normalized the data, created an efficient relational schema, and developed analytical queries, views, and stored procedures to derive deep insights into contestant performance.

---

## 🧾 Dataset Description

- **Source file:** `survivalists.csv`
- **Rows:** 140 (one per appearance)
- **Content:** Survivalist metadata (name, gender, age, city, profession, etc.), appearance outcomes, seasons, and tap-out reasons.

🧹 **Preprocessing:**
- Removed unnecessary fields and duplicates.
- Imputed missing values using domain knowledge.
- Standardized professions, locations, and tap-out reasons.

---

## 🧱 Database Schema (Normalized to 3NF)

- `season_data`: Season number and country version.
- `survivalist_data`: Static info per contestant.
- `survivor_season_data`: Demographics & profession per season.
- `appearance_data`: Results, duration, and tap-out info per appearance.

📁 See: `Q1_Survalist_db.sql`

---

## 🔍 Analytical Queries (Q3)

Implemented optimized queries of each type:

1. **JOIN** — Find the longest-lasting contestant per show version.
2. **SUBQUERY** — Identify contestants who lasted more than the global average.
3. **CTE** — Highlight seasons with below-average survival duration.
4. **WINDOW FUNCTION** — Compute day-gap between winner and runner-up per season.
5. **UNION** — Show winners and medically evacuated contestants with labels.

📁 See: `Q3-4-5.sql`

---

## 👁️ Analytical View (Q4)

The view `season_metrics` was created to provide an overview of each season’s difficulty and risk.

📁 See: `Q3-4-5.sql`

---

## 👁️ Analytical View - Stored Procedure(Q5)

The stored procedure receives a profession as input and returns a full performance profile.

📊 It outputs:
Total appearances of contestants with the given profession
Average, minimum, and maximum survival days
% winners among them
% medically evacuated
✅ Use case:
Quickly evaluate how a specific background (e.g. “School Teacher”, “Hunting Guide”) correlates with survival performance, endurance, and safety outcomes — a valuable tool for casting or risk analysis.

📁 See: `Q3-4-5.sql`

---

## 📧 Contact Me
I'm always open to feedback, collaboration, and new research opportunities.

📮 Email:  maornanibar@gmail.com
💬 LinkedIn: [linkedin.com/in/maornave](https://www.linkedin.com/in/maor-moshe-nave/)
🧠 Research interests: Computer Vision - Advanced image processing and physical simulations, Data Analytics - Statistical analysis and database optimization,
AI Applications - Machine & Deep learning.
📮 Or feel free to reach out directly via the contact panel in the Base44 web app.
