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

--Return the average customer profit 
SELECT ROUND(AVG(profit),2) AS avg_customer_profit
  FROM customer_profit AS cp
 