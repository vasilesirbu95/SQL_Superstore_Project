# 🛒 SQL Project: Superstore Data Analysis

This project demonstrates **data cleaning, KPIs, and analysis** using **MySQL** on a retail dataset.  
It is designed as a **Data Analyst portfolio project**.

---

## 📊 Dataset
The dataset is based on the **Superstore Sales Dataset** (Kaggle - only the first 1000 rows).  
It contains information about orders, customers, products, sales, shipping, and more.

**Key columns**:
- `Order Date` – date when the order was placed  
- `Ship Date` – date when the order was shipped  
- `Sales` – revenue from the order  
- `Profit` – profit from the order  
- `Discount` – discount applied
- `Quantity` - number of products purchased per order
- `Segment` - categories of customers based on their business type or purchasing behavior
- `City`, `State`, `Region`, `Postal Code` – geographical information  
- `Category`, `Product Name`, `Product ID` – product information
- `Customer ID`, `Customer Name` - customer information
- `Order ID` - order information

---

## ⚙️ Project Structure

### sql/
- `superstore_project.sql` – contains all SQL code:
  1. **Data Cleaning**
     - Drop & recreate table
     - Remove columns `Country` and `Sub-Category`
     - Check for duplicates and null values
     - Convert text to proper data types (`DATE`, `DOUBLE`)
     
  2. **KPI Queries**
     - Total Sales & Profit (total, %)
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
Kaggle-Link: https://www.kaggle.com/datasets/juhi1994/superstore? (only the first 1000 rows)

## 💡 Key Insights / Results

- The average profit margin 7.86 %.
- The highest sales were recorded in New York, followed by Philadelphia and San Francisco.
- Sales in the Southern US are significantly lower than in other regions.
- The Consumer segment generates the highest sales, followed by Corporate and Home Office.
- Top 3 products by sales:
-   1. Lexmark MX611dhe Monochrome Laser Printer
    2. Cubify CubeX 3D Printer Triple Head Print
    3. Fellowes PB500 Electric Punch Plastic Comb Binding Machine with Manual Bind
- Top 3 customers by sales:
-   1. Becky Martin – $10,539.90
    2. Grant Thornton – $8,167.42
    3. Christopher Martinez – $6,412.77
- The highest profit comes from products in the Technology category, average profit $45.97 per orders.
- In contrast, products in the Furniture category generate an average loss of $9.77 per order.
- Technology products also generate the highest total sales, accounting for 39.17% of total revenue, highlighting their importance and profitability.
- Yearly sales trends:
-   1. Best sales in 2014.
-   2. 2015 saw a 27.15% decrease in sales.
-   3. 2016 sales increased by 31.65%, almost reaching the 2014 level.
-   4. Minor decline of 8.1% in the following year.
- The average processing time per order is 4 days.
- Processing time varies by ship mode:
-   1. Same Day orders are shipped in less than 1 day
    2. First Class orders take on average 2.2 days
    3. Second Class orders take on average 3.2 days
    4. Standard Class orders take on average 5 days
- The largest discounts are applied to:
-   1. Furniture (average 18%)
    2. Office Supplies (average 16%)
    3. Technology (average 14%)
- The high discount on Furniture products likely contributes to their low profitability, even leading to losses.

---

## 🚀 How to Run

1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/superstore-sql-project.git
   cd superstore-sql-project
