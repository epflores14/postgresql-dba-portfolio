# Project 1: Backup & Recovery

## 🎯 Objective
Demonstrate ability to protect data and recover from disasters using PostgreSQL and pgAdmin4.

## 🛠️ Environment
- Database: `DBAportfolio_db`
- Tool: pgAdmin4
- Sample Table: `employees` (created with sample rows)

## 📋 Steps Performed
1. **Backup**  
   - Created `.backup` file using pgAdmin4 (Custom format).
2. **Simulated Data Loss**  
   - Dropped the `employees` table with `DROP TABLE employees;`.
3. **Restore**  
   - Restored database from the backup file using pgAdmin4 Restore.
4. **Verification**  
   - Queried `SELECT * FROM employees;` to confirm data recovery.

## 📸 Evidence
- ![Backup dialog screenshot](screenshots/backup.png)
- ![Drop table screenshot](screenshots/drop.png)
- ![Restore dialog screenshot](screenshots/restore.png)
- ![Verification screenshot](screenshots/select.png)

## ✅ Outcome
Successfully restored the `employees` table after simulated deletion.  
Recovery completed in under 1 minute.

## 🔑 Key Learning
- Importance of regular backups for disaster recovery.
- How to use pgAdmin4 for backup and restore operations.
- Demonstrates readiness for real DBA responsibilities.
