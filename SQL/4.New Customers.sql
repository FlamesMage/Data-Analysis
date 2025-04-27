WITH 

--Create a CTE that adds a 'year_month' column from 'paymentDate'
payment_with_year_month_table AS (
SELECT *, 
--Extract year and month from paymentDate and combine into one integer (e.g., 202504 for April 2025)
       CAST(SUBSTR(paymentDate, 1,4) AS INTEGER)*100 + CAST(SUBSTR(paymentDate, 6,7) AS INTEGER) AS year_month
  FROM payments p
),

--Create a CTE that aggregates total number of payments and total payment amount per month
customers_by_month_table AS (
SELECT p1.year_month, 
	   COUNT(*) AS number_of_customers,  -- Total number of payment records
	   SUM(p1.amount) AS total         -- Total amount paid in that month
  FROM payment_with_year_month_table p1
 GROUP BY p1.year_month
),

--Create a CTE to find the new customers for each month
new_customers_by_month_table AS (
SELECT p1.year_month, 
       COUNT(DISTINCT customerNumber) AS number_of_new_customers, -- Number of new customers appearing for the first time
       SUM(p1.amount) AS new_customer_total,					-- Total payment amount from new customers
       
	   -- Pull total number of customers in that month from previous CTE
	   (SELECT number_of_customers
          FROM customers_by_month_table c
        WHERE c.year_month = p1.year_month) AS number_of_customers,
		
		-- Pull total amount in that month from previous CTE
       (SELECT total
          FROM customers_by_month_table c
         WHERE c.year_month = p1.year_month) AS total
  FROM payment_with_year_month_table p1
  
  -- Only include customers who have NOT paid before this month (i.e., truly new customers)
 WHERE p1.customerNumber NOT IN (SELECT customerNumber
                                   FROM payment_with_year_month_table p2
                                  WHERE p2.year_month < p1.year_month)
 GROUP BY p1.year_month
)

--Final result - calculate and output the proportions
SELECT year_month, 
       ROUND(number_of_new_customers*100/number_of_customers,1) AS number_of_new_customers_props,
       ROUND(new_customer_total*100/total,1) AS new_customers_total_props
  FROM new_customers_by_month_table;