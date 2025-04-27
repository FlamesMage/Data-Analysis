WITH 

    customer_profit AS(
        SELECT o.customerNumber, 
               ROUND(SUM(od.quantityOrdered * (od.priceEach - p.buyPrice)),2) 
               AS profit
          FROM orderdetails AS od   
          JOIN products AS p  
            ON p.productCode = od.productCode   
          JOIN orders AS o   
            ON o.orderNumber = od.orderNumber  
         GROUP BY o.customerNumber    
        )
 /*       
--Top 5 VIP Customers       
SELECT c.contactFirstName, 
       c.contactLastName, 
       c.city, 
       c.country, 
       cp.profit
  FROM customers AS c
  JOIN customer_profit AS cp
    ON cp.customerNumber = c.customerNumber
 ORDER BY profit DESC
 LIMIT 5;
*/

--Top 5 Least Engaged Customers
SELECT c.contactFirstName, 
       c.contactLastName, 
       c.city, 
       c.country, 
       cp.profit
  FROM customers AS c
  JOIN customer_profit AS cp
    ON cp.customerNumber = c.customerNumber
 ORDER BY profit 
 LIMIT 5;