# 📄 Product Requirements Document (PRD): Smart Discount Engine
[![Google Docs](https://img.shields.io/badge/Google%20Docs-View%20Official%20PRD-blue?style=for-the-badge&logo=google-docs)](https://docs.google.com/document/d/1iW5_moleygaQEfFiqdRXZBuCPQBEbKf9JHIgXQw0KOs/edit?usp=sharing)

| **Status** | **Owner** | **Date** |
| :--- | :--- | :--- |
| 🟢 In Development | [Christopher Bonnin](https://www.linkedin.com/in/christopher-bonnin-a08a95197/) | Q4 2024 |

## 1. Problem Statement
**Context:** Our data shows that 65% of users search for tickets (Paris -> Lyon) but abandon the cart.
**The Pain:** Users are price-sensitive, but blanket discounts destroy our profit margins.
**The Opportunity:** We need to target *only* the users who are "on the fence" (Medium Intent).

## 2. Goals & Success Metrics
* **Objective:** Increase conversion rate on high-volume routes without eroding margin.
* **North Star Metric:** Incremental Revenue per Search.
* **Key Results (KRs):**
    * 🚀 Increase Search-to-Booking conversion from 12% to 14%.
    * 🛡️ Keep average discount cost below €5 per booking.

## 3. The Solution (Feature Scope)
We will build a **Machine Learning-driven pricing engine** that assigns a "Booking Probability Score" to every search in real-time.

### **Functional Requirements**
| Feature | Description | Priority |
| :--- | :--- | :--- |
| **Prediction API** | An endpoint that accepts search params (Route, Time, Lead Days) and returns a probability (0.0 - 1.0). | P0 (Critical) |
| **Discount Logic** | IF probability is between 0.3 and 0.7 (Medium Intent) → Trigger "5% Off" banner. | P0 (Critical) |
| **Control Group** | 10% of eligible users must *not* receive the discount (to measure lift). | P1 |
| **High Intent Exclusion** | IF probability > 0.8 (High Intent) → Do NOT show discount (Save margin). | P1 |

## 4. User Stories
* **As a** Price-Sensitive Traveler, **I want to** receive personalized offers when I'm hesitant, **so that** I feel good about booking now.
* **As a** Finance Manager, **I want to** avoid discounting tickets for users who would have booked anyway, **so that** we protect revenue.

## 5. Risks & Mitigation
* **Risk:** Model is wrong and gives discounts to everyone.
    * *Mitigation:* Cap total daily discount budget at €1,000.
* **Risk:** Users learn to game the system (wait for discount).
    * *Mitigation:* Randomize offer timing; do not show to same user twice in 24h.
