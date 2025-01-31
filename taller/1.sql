-- lab 1 tx-lab

BEGIN;

DO $$
DECLARE
    sender_email VARCHAR := 'bill.johnson@fmail.com';
    receiver_email VARCHAR := 'craig.williams@hmail.com';
    transfer_amount INTEGER := 100;

    sender_id INTEGER;
    receiver_id INTEGER;
    sender_balance INTEGER;
BEGIN
    SELECT id INTO sender_id
    FROM "user"
    WHERE email = sender_email;

    IF sender_id IS NULL THEN
        RAISE EXCEPTION 'Sender not found';
    END IF;

    SELECT id INTO receiver_id
    FROM "user"
    WHERE email = receiver_email;

    SELECT balance INTO sender_balance
    FROM "account"
    WHERE user_id = sender_id;

    UPDATE "account"
    SET balance = balance - transfer_amount
    WHERE user_id = sender_id;

    UPDATE "account"
    SET balance = balance + transfer_amount
    WHERE user_id = receiver_id;

    IF sender_balance < transfer_amount OR sender_id IS NULL OR receiver_id IS NULL THEN
        ROLLBACK;
    END IF;

END $$;

COMMIT;

-- lab 2 opt-lab


-- 1. Find all the customers who have never placed an order.
SELECT 
    customers.customer_id id,
    name, 
    order_id as order
FROM customers
LEFT JOIN orders 
    ON customers.customer_id = orders.customer_id
where order_id IS NULL;

-- 2. Which country has the highest number of customers?
SELECT 
    country, 
    count(*) as amount_customers
FROM customers
GROUP BY country
ORDER BY amount_customers DESC
LIMIT 1;

-- 3. List products that have been ordered more than 6500 times in total but haven't been ordered since 2023-09-10
SELECT 
    products.product_id AS id, 
    products.product_name AS product, 
    SUM(orderdetails.quantity_ordered) AS amount_orders, 
    MAX(orders.order_date) AS last_order
FROM 
    products
JOIN orderdetails 
    ON products.product_id = orderdetails.product_id
JOIN orders 
    ON orderdetails.order_id = orders.order_id
GROUP BY 
    products.product_id, products.product_name
HAVING 
    MAX(orders.order_date) = '2023-09-10' 
    AND SUM(orderdetails.quantity_ordered) > 6500;

-- 4. For a given product, identify customers who have ordered that product the most.
SELECT 
    products.product_name AS product,
    customers.name AS customer,
    SUM(orderdetails.quantity_ordered) AS amount_orders
FROM products
JOIN orderdetails 
    ON products.product_id = orderdetails.product_id
JOIN orders 
    ON orderdetails.order_id = orders.order_id
JOIN customers 
    ON orders.customer_id = customers.customer_id
WHERE products.product_name = 'DarkBlue Ultra drive'
GROUP BY products.product_name, customers.name
ORDER BY amount_orders DESC
LIMIT 10;

-- 5. Find the month with the highest sales.
SELECT 
    EXTRACT(MONTH FROM order_date) AS month,
    SUM(orderdetails.quantity_ordered * products.price) AS total_sales
FROM orders
JOIN orderdetails 
    ON orders.order_id = orderdetails.order_id
JOIN products 
    ON orderdetails.product_id = products.product_id
GROUP BY EXTRACT(MONTH FROM order_date)
ORDER BY total_sales DESC
LIMIT 1;

-- 6. Which tag has had the highest quantity of product purchases by customers with that tag
SELECT 
tags.tag_name AS tag, 
sum(orderdetails.quantity_ordered) AS total_purchases
FROM tags
JOIN customertags
    ON tags.tag_id = customertags.tag_id
JOIN customers
    ON customertags.customer_id = customers.customer_id
JOIN orders
    ON customers.customer_id = orders.customer_id
JOIN orderdetails
    ON orders.order_id = orderdetails.order_id
GROUP BY tags.tag_name
ORDER BY total_purchases DESC
LIMIT 1;

-- 7. Which products have both "Ashley" and "Karen"?


-- 8. Find products that have been purchased at least once by a customer with the “Ashley” tag (must complete in under 500ms)
SELECT 
    products.product_name AS product
FROM products
JOIN orderdetails
    ON products.product_id = orderdetails.product_id
JOIN orders
    ON orderdetails.order_id = orders.order_id
JOIN customers
    ON orders.customer_id = customers.customer_id
JOIN customertags
    ON customers.customer_id = customertags.customer_id
JOIN tags
    ON customertags.tag_id = tags.tag_id
WHERE tags.tag_name = 'Ashley'
GROUP BY products.product_name;
