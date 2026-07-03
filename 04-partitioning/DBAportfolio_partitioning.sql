-- Create the parent table with range partitioning
CREATE TABLE orders (
    order_id SERIAL,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    total_amount NUMERIC(10,2),
    status VARCHAR(20),
    PRIMARY KEY (order_id, order_date) -- Partition key must be part of the primary key
) PARTITION BY RANGE (order_date);

-- Create partitions for Q1 and Q2 2026
CREATE TABLE orders_2026_m01 PARTITION OF orders
    FOR VALUES FROM ('2026-01-01') TO ('2026-02-01');

CREATE TABLE orders_2026_m02 PARTITION OF orders
    FOR VALUES FROM ('2026-02-01') TO ('2026-03-01');

CREATE TABLE orders_2026_m03 PARTITION OF orders
    FOR VALUES FROM ('2026-03-01') TO ('2026-04-01');

CREATE TABLE orders_2026_m04 PARTITION OF orders
    FOR VALUES FROM ('2026-04-01') TO ('2026-05-01');

-- Create a default partition to catch out-of-range data safely
CREATE TABLE orders_default PARTITION OF orders DEFAULT;

INSERT INTO orders (customer_id, order_date, total_amount, status)
SELECT 
    floor(random() * 100000 + 1)::int AS customer_id,
    '2026-01-01'::date + (random() * 110)::int AS order_date, -- Spreads data across Jan-Apr 2026
    round((random() * 500 + 5)::numeric, 2) AS total_amount,
    (ARRAY['Pending', 'Shipped', 'Delivered', 'Cancelled'])[floor(random() * 4 + 1)] AS status
FROM generate_series(1, 10000000);

SELECT * FROM orders;

-- Check total rows vs partition routing
SELECT 'Parent Total' AS table_name, COUNT(*) FROM orders
UNION ALL
SELECT 'Jan Partition', COUNT(*) FROM orders_2026_m01
UNION ALL
SELECT 'Feb Partition', COUNT(*) FROM orders_2026_m02
UNION ALL
SELECT 'Default Partition', COUNT(*) FROM orders_default;

-- Check Query Execution Plan
EXPLAIN ANALYZE 
SELECT SUM(total_amount) 
FROM orders 
WHERE order_date BETWEEN '2026-02-10' AND '2026-02-20';





