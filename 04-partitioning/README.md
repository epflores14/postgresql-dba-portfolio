# PostgreSQL Table Partitioning Optimization Project

## 📌 Project Overview
This database administration (DBA) project demonstrates how to implement declarative range partitioning in PostgreSQL to optimize data architecture and improve query efficiency. 

By restructuring a high-volume table into monthly partitions, the query planner is able to isolate specific data subsets, drastically reducing the dataset footprint during query execution.

### Project Metrics:
* **Database Engine:** PostgreSQL 13+
* **Data Volume Managed:** 10,000,000 synthetic records
* **Partitioning Strategy:** Monthly Range Partitioning
* **Core Skill Demonstrated:** Declarative Partition Pruning

---

## 🛠️ Implementation & Architecture

### 1. Parent Partitioned Table
The primary `orders` table acts as the structural blueprint. It routes incoming writes using the `order_date` column as the boundary key.

```sql
CREATE TABLE orders (
    order_id SERIAL,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    total_amount NUMERIC(10,2),
    status VARCHAR(20),
    PRIMARY KEY (order_id, order_date)
) PARTITION BY RANGE (order_date);
```

### 2. Child Partitions & Default Safety Net
Dedicated storage structures were explicitly mapped for active operational months, alongside a fallback table to catch anomalies.

```sql
CREATE TABLE orders_2026_m01 PARTITION OF orders FOR VALUES FROM ('2026-01-01') TO ('2026-02-01');
CREATE TABLE orders_2026_m02 PARTITION OF orders FOR VALUES FROM ('2026-02-01') TO ('2026-03-01');
CREATE TABLE orders_2026_m03 PARTITION OF orders FOR VALUES FROM ('2026-03-01') TO ('2026-04-01');
CREATE TABLE orders_2026_m04 PARTITION OF orders FOR VALUES FROM ('2026-04-01') TO ('2026-05-01');
CREATE TABLE orders_default PARTITION OF orders DEFAULT;
```

---

## 📊 DBA Performance Verification & Analysis

### 1. Data Routing Audit
After seeding **10 million rows** across a 110-day window, a system catalog check verified that rows were perfectly distributed within their designated monthly segments with zero leaks into the default partition.

### 2. Query Optimizer Analysis (Partition Pruning)
To evaluate the success of the architecture, an `EXPLAIN ANALYZE` block was run to isolate records spanning mid-February:

```sql
EXPLAIN ANALYZE 
SELECT SUM(total_amount) 
FROM orders 
WHERE order_date BETWEEN '2026-02-10' AND '2026-02-20';
```

#### Key Findings from the Execution Plan:
* **Successful Partition Pruning:** The query engine immediately identified the date parameters and bypassed the parent table layout entirely. It scanned **only** the `orders_2026_m02` child partition, ignoring January, March, April, and default blocks.
* **Execution Strategy:** Because this phase focused purely on data segregation without a localized date index, the engine deployed a `Parallel Seq Scan` with 2 active worker threads to process the targeted partition file in **209 milliseconds**.

