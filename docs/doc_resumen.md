# Database Systems and SQL Study Guide

## 1. Data Modeling
**Purpose**: Create abstract representation of data requirements
- **Key Concepts**:
  - Entities (objects)
  - Relationships (connections)
  - Attributes (properties)
- **Process**:
  1. Requirements analysis
  2. Conceptual design
  3. Logical design
  4. Physical design

## 2. ER Models (Entity-Relationship)
**Components**:
- **Entities**: Rectangle (e.g., Student, Course)
- **Attributes**: Oval (e.g., student_id, course_name)
- **Relationships**: Diamond (e.g., Enrolls)
- **Cardinality**:
  - 1:1 (One-to-One)
  - 1:N (One-to-Many)
  - N:M (Many-to-Many)

```plaintext
Example:
[Student] ----<Enrolls>---- [Course]
   |                           |
student_id                 course_id
   |                           |
student_name              course_name
```

## 3. Relational Model
- **Tables** (Relations)
- **Tuples**: Rows
- **Attributes**: Columns
- **Primary Keys**: Unique identifiers
- **Foreign Keys**: References to other tables

**Example Table**:
| student_id (PK) | name  | course_id (FK) |
|-----------------|-------|----------------|
| 001             | Alice | CS101          |
| 002             | Bob   | MATH202        |

## 4. Normalization
**Purpose**: Minimize redundancy, avoid anomalies
- **1NF**: Atomic values
- **2NF**: No partial dependencies
- **3NF**: No transitive dependencies
- **BCNF**: Every determinant is candidate key

## 5. ACID Properties
1. **Atomicity**: All or nothing
2. **Consistency**: Valid state transitions
3. **Isolation**: Concurrent transactions don't interfere
4. **Durability**: Committed changes persist

## 6. Concurrency Control
- **Locking**:
  - Shared (Read)
  - Exclusive (Write)
- **Two-Phase Locking**:
  1. Growing Phase (acquire locks)
  2. Shrinking Phase (release locks)
- **Timestamp Ordering**

## 7. Transaction Recovery
- **Log-based Recovery**:
  - Write-Ahead Log (WAL)
  - UNDO/REDO operations
- **Checkpoints**

## 8. Basic Query Structure
```sql
SELECT [DISTINCT] columns
FROM tables
WHERE conditions
GROUP BY columns
HAVING group_conditions
ORDER BY columns;
```

## 9. CRUD Operations
- **Create**: `INSERT INTO table VALUES (...)`
- **Read**: `SELECT ... FROM ...`
- **Update**: `UPDATE table SET ... WHERE ...`
- **Delete**: `DELETE FROM table WHERE ...`

## 10. Joins
- **INNER JOIN**: Matching records
- **LEFT JOIN**: All left + matching right
- **RIGHT JOIN**: All right + matching left
- **FULL OUTER JOIN**: All records

```sql
SELECT * 
FROM TableA
INNER JOIN TableB 
ON TableA.id = TableB.fk;
```

## 11. Aggregation
- **Functions**: `COUNT()`, `SUM()`, `AVG()`, `MIN()`, `MAX()`
- **GROUP BY** groups rows
- **HAVING** filters groups

```sql
SELECT department, AVG(salary)
FROM employees
GROUP BY department
HAVING AVG(salary) > 50000;
```

## 12. Nested Queries
- Subqueries in WHERE/HAVING
- Correlated subqueries

```sql
SELECT name 
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);
```

## 13. Views
- Virtual tables
- **Create**:
  ```sql
  CREATE VIEW view_name AS
  SELECT columns FROM table WHERE conditions;
  ```

## 14. Indexing
- **Types**:
  - B-Tree (default)
  - Hash
  - Bitmap
- **Create Index**:
  ```sql
  CREATE INDEX idx_name ON table (column);
  ```

## 15. NoSQL Databases
- **Types**:
  - Document (MongoDB)
  - Key-Value (Redis)
  - Column-family (Cassandra)
  - Graph (Neo4j)
- **BASE** vs ACID:
  - Basically Available
  - Soft state
  - Eventually consistent

## 16. Database Design & Implementation
**Process**:
1. Requirements analysis
2. Conceptual design (ER Model)
3. Logical design (Relational Model)
4. Normalization
5. Physical design
6. Implementation (SQL DDL)
7. Testing & Optimization

**Example Implementation**:
```sql
CREATE TABLE Students (
  student_id INT PRIMARY KEY,
  name VARCHAR(50),
  email VARCHAR(100) UNIQUE
);

CREATE TABLE Courses (
  course_id INT PRIMARY KEY,
  title VARCHAR(100)
);

CREATE TABLE Enrollments (
  student_id INT REFERENCES Students,
  course_id INT REFERENCES Courses,
  enrollment_date DATE
);
```

## Best Practices
- Use proper data types
- Normalize tables
- Add indexes on frequent query columns
- Use transactions for multiple operations
- Regularly back up databases

## Summary Cheat Sheet
| Concept              | Key Points                          |
|----------------------|-------------------------------------|
| ACID                 | Atomic, Consistent, Isolated, Durable |
| Normalization        | 1NF-3NF, BCNF, reduce redundancy   |
| Joins                | INNER, LEFT, RIGHT, FULL            |
| Indexes              | Improve query speed, B-Tree common  |
| NoSQL                | Flexible schema, scale horizontally|
| Transactions         | BEGIN, COMMIT, ROLLBACK             |