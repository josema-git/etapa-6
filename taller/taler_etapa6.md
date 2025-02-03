# SQL Lab Exercises

## Lab 1: Transaction Lab

```sql
BEGIN;
DO $$
DECLARE
    sender_email VARCHAR := 'craig.williams@hmail.com';
    receiver_email VARCHAR := 'bill.johnson@fmail.com';
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

    IF receiver_id IS NULL THEN
        RAISE EXCEPTION 'Receiver not found';
    END IF;

    SELECT balance INTO sender_balance
    FROM "account"
    WHERE user_id = sender_id;

    IF sender_balance < transfer_amount THEN
        RAISE EXCEPTION 'Insufficient funds';
    END IF;

    UPDATE "account"
    SET balance = balance - transfer_amount
    WHERE user_id = sender_id;

    PERFORM pg_sleep(7);

    UPDATE "account"
    SET balance = balance + transfer_amount
    WHERE user_id = receiver_id;

    EXCEPTION
        WHEN OTHERS THEN
            RAISE NOTICE 'Error: %', SQLERRM;
END $$;
COMMIT;
```

## Lab 2: Query Optimization Lab

### 1. Find Customers Without Orders
```sql
SELECT 
    customers.customer_id id,
    customers.name, 
    orders.order_id as order
FROM customers
LEFT JOIN orders 
    ON customers.customer_id = orders.customer_id
where order_id IS NULL;
```

### 2. Country with Most Customers
```sql
SELECT 
    country, 
    count(*) as amount_customers
FROM customers
GROUP BY country
ORDER BY amount_customers DESC
LIMIT 1;
```

### 3. Products with High Orders but Not Recent
```sql
SELECT 
    products.product_id AS id, 
    products.product_name AS product, 
    SUM(orderdetails.quantity_ordered) AS amount_orders, 
    MAX(orders.order_date) AS last_order
FROM products
JOIN orderdetails 
    ON products.product_id = orderdetails.product_id
JOIN orders 
    ON orderdetails.order_id = orders.order_id
GROUP BY 
    products.product_id
HAVING 
    MAX(orders.order_date) < '2023-09-10' 
    AND SUM(orderdetails.quantity_ordered) > 6500;
```

### 4. Top Customers by Product
```sql
SELECT 
    products.product_id AS id,
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
WHERE products.product_id = 201294
GROUP BY products.product_id, products.product_name, customers.name
ORDER BY amount_orders DESC
LIMIT 10;
```

### 5. Month with Highest Sales
```sql
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
```

### 6. Most Popular Tag by Purchase Quantity
```sql
SELECT 
    tags.tag_id AS id,
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
GROUP BY tags.tag_id, tags.tag_name
ORDER BY total_purchases DESC
LIMIT 1;
```

### 7. Products Purchased by Both Ashley and Karen
```sql
SELECT DISTINCT
    products.product_id AS id, 
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
WHERE tags.tag_name IN ('Ashley', 'Karen')
GROUP BY products.product_id, products.product_name
HAVING COUNT(DISTINCT tags.tag_id) = 2;
```

### 8. Products Purchased by Ashley Tag (Optimized)

```sql
CREATE INDEX idx_tags_tag_name ON tags(tag_name);
CREATE INDEX idx_customertags_tag_id ON customertags(tag_id);
CREATE INDEX idx_customertags_customer_id ON customertags(customer_id);
CREATE INDEX idx_orders_customer_id ON orders(customer_id);
CREATE INDEX idx_orderdetails_order_id ON orderdetails(order_id);
CREATE INDEX idx_orderdetails_product_id ON orderdetails(product_id);

EXPLAIN ANALYZE
SELECT DISTINCT
    products.product_id AS id,
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
WHERE tags.tag_name = 'Ashley';
```
