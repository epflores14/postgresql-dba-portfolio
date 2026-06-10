# Project 2: Security & Role Management

## 📌 Objective
Demonstrate the principle of **least privilege** in PostgreSQL by creating roles with different access levels (Analyst vs. DBA), enforcing password policies, and documenting security controls.

---

## 🛠️ Steps Implemented
1. **Created Roles**
   - `analyst` → read-only access
   - `dba` → full administrative privileges

2. **Assigned Privileges**
   - Analyst granted `SELECT` only on `employees` table.
   - DBA granted full privileges on the database.

3. **Password Policy**
   - Enforced strong password rules (minimum length, complexity).
   - Tested weak password rejection.

4. **Privilege Testing**
   - Analyst: `SELECT` succeeded, `INSERT/UPDATE/DELETE` denied.
   - DBA: `INSERT/UPDATE/DELETE` succeeded.

5. **Role Management**
   - DBA created additional roles and granted privileges.

---

## 📂 Evidence
- **Scripts:** See `scripts/` folder for SQL commands (`CREATE ROLE`, `GRANT`, `INSERT/UPDATE/DELETE`).  
- **Screenshots:** See `screenshots/` folder for proof of:
  - Analyst successful `SELECT`
  - Analyst denied `INSERT/UPDATE/DELETE`
  - DBA successful `INSERT/UPDATE/DELETE`
  - Password policy enforcement
  - Role creation by DBA

---

## ✅ Outcome
- Analyst role restricted to read-only queries.  
- DBA role confirmed with full privileges and ability to manage roles.  
- Password policy successfully enforced.  
- Principle of least privilege demonstrated with clear evidence.

