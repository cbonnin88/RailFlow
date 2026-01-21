# <img width="2816" height="1536" alt="railflow" src="https://github.com/user-attachments/assets/cf276f84-f371-4976-b424-ae08b07c2beb" /> RailFlow: End-to-End Product Analytics Pipeline


![RailFlow Banner](https://img.shields.io/badge/Status-Complete-green?style=for-the-badge) ![Python](https://img.shields.io/badge/Python-3.10-blue?style=for-the-badge) ![BigQuery](https://img.shields.io/badge/Google-BigQuery-yellow?style=for-the-badge) ![dbt](https://img.shields.io/badge/dbt-Core-orange?style=for-the-badge) ![Streamlit](https://img.shields.io/badge/Streamlit-App-red?style=for-the-badge)


**RailFlow** is a full-stack data project simulating a high-volume European train booking platform (inspired by SNCF Connect). It ingests raw user logs, transforms them into business-ready models, deploys a Machine Learning model to predict booking probability, and activates data for marketing automation.

---

## 📖 Table of Contents
- [The Business Problem](#-the-business-problem)
- [Architecture & Tech Stack](#%EF%B8%8F-architecture--tech-stack)
- [Project Phases](#-project-phases)
  - [1. Data Engineering & GDPR](#1-data-engineering--gdpr-privacy)
  - [2. Analytics Engineering (dbt)](#2-analytics-engineering-dbt)
  - [3. Machine Learning (Prediction)](#3-machine-learning-prediction)
  - [4. Data App (Streamlit)](#4-data-app-streamlit)
  - [5. Product Analytics & A/B Testing](#5-product-analytics--ab-testing)
- [How to Run](#-how-to-run)
- [Repository Structure](#-repository-structure)

---

## 🎯 The Business Problem
**Context:** The Product Team at RailFlow noticed a gap between high search volume and low booking conversions on specific routes (e.g., Paris → Lyon).
**Goal:**
1.  **Visibility:** Create a trusted "Single Source of Truth" for revenue and search metrics.
2.  **Prediction:** Identify "High Intent" users in real-time who are likely to book but haven't yet.
3.  **Activation:** Automate marketing outreach (Push/Email) to those high-intent users to close the sale.

---

## 🏗️ Architecture & Tech Stack

This project follows the **Modern Data Stack** principles, moving from raw logs to activated data.



| Stage | Technology | Description |
| :--- | :--- | :--- |
| **Ingestion** | Python (`Faker`, `Polars`) | Generating 10k+ realistic synthetic log rows with schema enforcement. |
| **Privacy** | Python (`hashlib`) | **GDPR Compliance:** SHA-256 hashing of PII (emails) before warehousing. |
| **Warehousing** | Google BigQuery | Serverless Data Warehouse located in `europe-west9` (Paris). |
| **Transformation** | dbt (Data Build Tool) | Modeling raw data into a Star Schema (`fct_daily_performance`, `dim_users`). |
| **Machine Learning** | Scikit-Learn | Random Forest Classifier to predict booking probability. |
| **Application** | Streamlit | Interactive web app for stakeholders to test the ML model. |
| **Reverse ETL** | Python | Syncing "High Churn Risk" segments to Marketing tools (simulated). |
| **Validation** | SciPy | A/B Testing statistical significance calculator. |

---

## 🚀 Project Phases

### 1. Data Engineering & GDPR Privacy
* **Data Generation:** Created complex synthetic datasets (`searches.csv`, `bookings.csv`, `users.csv`) mimicking real user behavior (e.g., lead times, price sensitivity).
* **Privacy Layer:** Implemented a pre-ingestion masking layer.
    * *Technique:* Emails are salted and hashed using **SHA-256** to ensure no raw PII enters the Data Warehouse.

### 2. Analytics Engineering (dbt)
Built a production-grade **Star Schema** to enable self-service BI.
* **Staging Models:** Cleaned raw BigQuery tables, casting timestamps and handling nulls.
* **Intermediate Models:** `int_search_bookings.sql` reconstructs the user funnel by joining searches to bookings.
* **Marts (Gold Layer):**
    * `fct_daily_performance`: Aggregated revenue, conversion rates, and search volume per route/day.
    * `dim_users`: User demographic dimensions.



### 3. Machine Learning (Prediction)
Trained a **Random Forest Classifier** to predict `is_converted` (Booking Probability).
* **Features:** Origin, Destination, Lead Time (Days), Search Hour, Day of Week.
* **Performance:** The model identified that **Lead Time** is the #1 predictor of conversion.
* **Artifacts:** Exported model and label encoders as `railflow_brain.joblib` for deployment.

### 4. Data App (Streamlit)
Deployed a "Pricing Engine Simulator" allowing Product Managers to interact with the ML model.
* **Input:** User selects a route and travel date.
* **Output:** The app calculates a live probability score.
    * *Logic:* If Probability > 30% but < 70% (Medium Intent) → **Trigger 5% Discount**.



### 5. Product Analytics & A/B Testing
* **Tracking Plan:** Defined the schema for `search_route` and `ticket_purchased` events.
* **Experimentation:** Performed a Power Analysis to determine sample size (Required: ~86k users) and ran a Z-Test simulation to validate statistical significance of the discount feature.
* **Reverse ETL:** Wrote a script to query "High Churn Risk" users (Searched recently + No Booking) and generate a JSON payload for CRM tools (Braze/Salesforce).


## 📂 Repository Structure

```text
railflow/
│
├── README.md                  <-- You are here
├── requirements.txt           <-- Python dependencies
│
├── assets/                    <-- Screenshots for documentation
│   ├── architecture.png
│   ├── dbt_lineage.png
│   └── app_demo.png
│   └── dashboard.png
│
├── data_generation/           <-- Python scripts for Faker & GDPR hashing
│   ├── generate_data.py
│   └── anonymize_pii.py
│
├── dbt_project/               <-- The Transformation Layer
│   ├── models/
│   │   ├── staging/
│   │   ├── intermediate/
│   │   └── marts/
│   └── dbt_project.yml
│
├── ml_model/                  <-- The Intelligence Layer
│   ├── train_model.ipynb      <-- Colab notebook for training
│   └── railflow_brain.joblib  <-- Serialized Model Artifact
│
├── app/                       <-- The User Interface
│   └── app.py                 <-- Streamlit Application
│
└── analysis/                  <-- Advanced Analytics
    ├── ab_test_simulation.py  <-- SciPy Power Analysis & Z-Test
    └── reverse_etl_sync.py    <-- CRM Payload Generator
```

---

## [Railflow Dashboard](https://lookerstudio.google.com/reporting/c87b2a73-0902-43b3-9ee3-318a72594e91)

<img width="1199" height="858" alt="Capture d’écran 2026-01-21 à 12 12 20" src="https://github.com/user-attachments/assets/9c9c9664-a306-4677-a1ce-9bea11c60f47" />




## 💻 How to Run

### Prerequisites
* Python 3.8+
* Google Cloud Platform Account (BigQuery)
* dbt Core installed

### 1. Setup Environment
```bash
git clone [https://github.com/your-username/railflow.git](https://github.com/your-username/railflow.git)
cd railflow
pip install -r requirements.txt

### 2. Run the dbt Pipline
- cd dbt_project
- dbt debug  # Test connection
- dbt run    # Build models
- dbt test   # Run data quality tests

### 3. Launch the Streamlit App
- cd app
- streamlit run app.py
