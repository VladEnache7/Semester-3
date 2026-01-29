
# 🗄️ Databases

This course provides a comprehensive deep-dive into the Relational Model. It covers everything from basic SQL queries to complex T-SQL programming (Stored Procedures, Triggers) and database internals (Indexes, B-Trees, Query Optimization).

### 📅 Weekly Syllabus

The schedule combines weekly lectures with bi-weekly seminars. The Laboratory component is typically structured around **5 Project Milestones**.

| Week | 👨‍🏫 Lecture Content | 📝 Seminar (Bi-Weekly) | 💻 Lab Milestones |
|:---:|:---|:---|:---|
| **1** | **Intro:** Database concepts, DBMS architecture | **S1: SQL DDL:** Create, Drop, Alter tables | **L1: Design:** ER Diagrams & Schema creation |
| **2** | **Relational Model:** Relations, Keys, Integrity Constraints | *--* | *--* |
| **3** | **SQL Queries:** Basic syntax, Joins, Aggregates | **S2: SQL DML:** Insert, Update, Delete, Complex Selects | **L2: Queries:** Implementing complex queries |
| **4** | **Normalization I:** Functional Dependencies | *--* | *--* |
| **5** | **Normalization II:** Normal Forms (1NF, 2NF, 3NF, BCNF) | **S3: Procedural:** Stored Procedures, Dynamic SQL, Cursors | **L3: Versioning:** DB Version Control mechanisms |
| **6** | **Relational Algebra:** Select, Project, Union, Cartesian Product | *--* | *--* |
| **7** | **Internals:** Physical storage of data on disk | **S4: Functions:** User Defined Functions, Views, Triggers | *--* |
| **8** | **Indexes I:** Introduction to Indexing strategies | *--* | **L4: Testing:** Generating data & Performance testing |
| **9** | **Indexes II:** B-Trees, structure and traversal | **S5: Indexes I:** Practical indexing examples | *--* |
| **10** | **Hashing:** Hash files and collisions | *--* | *--* |
| **11** | **Optimization:** Evaluating Relational Algebra operators | **S6: Indexes II:** Analyzing Execution Plans | **L5: Optimization:** Index usage & Query refactoring |
| **12** | **Modeling:** Advanced Conceptual Modeling | *--* | *--* |
| **13** | **Streams:** Introduction to Data Streams | **S7: Review:** Final problem solving | *--* |
| **14** | **Final Review:** Problem solving sessions | *--* | *--* |

---

### 📚 Key Topics Breakdown

<details>
<summary><strong>Click to expand detailed topic list</strong></summary>

#### Part I: SQL & T-SQL (Practical)
*   **DDL (Data Definition):** Creating tables, constraints (Primary Key, Foreign Key, Unique, Check).
*   **DML (Data Manipulation):** `INNER JOIN`, `LEFT/RIGHT JOIN`, `GROUP BY`, `HAVING`, Subqueries.
*   **Procedural Extensions:**
    *   **Stored Procedures:** Precompiled SQL code.
    *   **Triggers:** Code that runs automatically on Insert/Update/Delete.
    *   **Views:** Virtual tables for security and abstraction.
    *   **Cursors:** Row-by-row processing (and why to avoid them).

#### Part II: Theory & Design
*   **Normalization:** The process of organizing data to reduce redundancy (splitting tables).
*   **Relational Algebra:** The mathematical theoretical foundation behind SQL.
*   **ER Diagrams:** Entity-Relationship modeling (One-to-One, One-to-Many, Many-to-Many).

#### Part III: Internals & Performance
*   **Indexes:**
    *   **Clustered Index:** Physically sorts the data (like a phonebook).
    *   **Non-Clustered Index:** A separate lookup structure (like a book index).
*   **Execution Plans:** Reading how the database engine executes a query (Table Scan vs Index Seek).
*   **Data Structures:** B-Trees and Hash Tables used for storage.

</details>

---

### 🛠️ Resources & Tools

*   **SQL Server Management Studio (SSMS)** - The standard industry tool for MSSQL.
*   **Microsoft SQL Server** - The database engine used for the course.
*   **Azure Data Studio** - A modern, lightweight alternative to SSMS.
*   **LucidChart / Draw.io** - Essential for drawing Entity-Relationship (ER) diagrams.

---

> *"Data matures like wine, applications like fish."* — James Governor
