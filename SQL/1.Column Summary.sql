SELECT 'Customers' AS table_name, 
       (SELECT COUNT(*) FROM pragma_table_info('customers')) AS number_of_attributes, 
	   (SELECT COUNT(*) FROM customers) AS number_of_rows
		  
 UNION ALL
 
SELECT 'Products',
	   (SELECT COUNT(*) FROM pragma_table_info('products')),
	   (SELECT COUNT(*) FROM products)
		   
 UNION ALL

SELECT 'ProductLines',
	   (SELECT COUNT(*) FROM pragma_table_info('productlines')),
	   (SELECT COUNT(*) FROM productlines)

 UNION ALL

SELECT 'Orders',
       (SELECT COUNT(*) FROM pragma_table_info('orders')),
	   (SELECT COUNT(*) FROM orders)

 UNION ALL

SELECT 'OrderDetails',
       (SELECT COUNT(*) FROM pragma_table_info('orderdetails')),
	   (SELECT COUNT(*) FROM orderdetails)
	   
 UNION ALL

SELECT 'Payments',
       (SELECT COUNT(*) FROM pragma_table_info('payments')),
	   (SELECT COUNT(*) FROM payments)
	   
 UNION ALL

SELECT 'Employees',
       (SELECT COUNT(*) FROM pragma_table_info('employees')),
	   (SELECT COUNT(*) FROM employees)
	   
UNION ALL

SELECT 'Offices',
       (SELECT COUNT(*) FROM pragma_table_info('offices')),
	   (SELECT COUNT(*) FROM offices)