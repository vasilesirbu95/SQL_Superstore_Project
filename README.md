# 🛒 SQL Project: Superstore Data Analysis

This project demonstrates **data cleaning, KPIs, and analysis** using **MySQL** on a retail dataset.  
It is designed as a **Data Analyst portfolio project**.

---

## 📊 Dataset
The dataset is based on the **Superstore Sales Dataset** (Kaggle).  
It contains information about orders, customers, products, sales, shipping, and more.

**Key columns**:
- `Order Date` – date when the order was placed  
- `Ship Date` – date when the order was shipped  
- `Sales` – revenue from the order  
- `Profit` – profit from the order  
- `Discount` – discount applied  
- `City`, `State`, `Region` – geographical information  
- `Category`, `Product Name` – product information  

---

## ⚙️ Project Structure

### sql/
- `superstore_project.sql` – contains all SQL code:
  1. **Data Cleaning**
     - Drop & recreate table
     - Remove columns `Country` and `Sub-Category`
     - Convert text to proper data types (`DATE`, `DOUBLE`)
     - Check for duplicates and null values
  2. **KPI Queries**
     - Total Sales & Profit
     - Sales by City, State, Region, Segment
     - Top 10 Products & Customers
     - Average Profit per Category
     - Sales per Category (% of total)
     - Yearly Sales + Year-over-Year Growth
  3. **Analysis Queries**
     - Average Processing Time overall & by Ship Mode
     - Sales & Profit by Discount
     - Average Discount per Category

### dataset/
- `us_superstore_data.csv` – original CSV dataset (optional)

---

## 🚀 How to Run

1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/superstore-sql-project.git
   cd superstore-sql-project
