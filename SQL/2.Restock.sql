WITH

-- Calculate total revenue for each product
 product_performance AS (
SELECT p.productCode,
       p.productName,
	   p.productLine,
	   SUM(od.quantityOrdered*od.priceEach) AS revenue
  FROM products AS p
  JOIN orderdetails AS od
    ON p.productCode = od.productCode -- Join products with order details based on productCode
 GROUP BY p.productCode
 ),

  -- Calculate the ratio of the total quantity ordered to the quantity in stock for each product
 restock AS (
 SELECT p.productCode,
       p.productName,
	   p.productLine,
	   ROUND(SUM(od.quantityOrdered)*1.0/p.quantityInStock,2) AS stockRatio
  FROM products AS p
  JOIN orderdetails AS od
    ON p.productCode = od.productCode 
 GROUP BY p.productCode 
 )
 
-- Display priority products for restocking
SELECT p.productCode, p.productName, p.productLine, p.revenue,
       r.stockRatio
  FROM product_performance AS p
  JOIN restock AS r
    ON p.productCode = r.productCode
 ORDER BY stockRatio DESC, revenue DESC -- Sort by products most in need of restocking first and by highest revenue
 