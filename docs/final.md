### Summary of the Document: **Functional Dependencies (Chapter 4)**

This document focuses on the concept of **Functional Dependencies** (FDs) within the context of relational databases. Functional dependencies are constraints that help reduce data redundancy and improve data reliability by establishing relationships between attributes. This chapter defines, analyzes, and applies functional dependencies using inference axioms and algorithms.

---

### **Main Sections**

#### **4.1 Definitions**
- Introduces the concept of functional dependency as a relationship between attributes in a table.
- Example: In the relation `assign(PILOT, FLIGHT, DATE, DEPARTS)`, the following restrictions are defined:
  1. Each flight has a unique departure time.
  2. A specific pilot, on a specific date and time, is assigned to a unique flight.
  3. A specific flight on a specific date is assigned to a unique pilot.
- Formalization: A functional dependency is represented as `X → Y`, where `X` uniquely determines the values of `Y`.

#### **4.2 Inference Axioms**
- Presents a set of **six axioms** (also known as Armstrong's axioms) that serve as rules to deduce new functional dependencies:
  1. **Reflexivity**: If `Y ⊆ X`, then `X → Y`.
  2. **Augmentation**: If `X → Y`, then `XZ → Y` (where `Z` is an additional set of attributes).
  3. **Additivity**: If `X → Y` and `X → Z`, then `X → YZ`.
  4. **Projectivity**: If `X → YZ`, then `X → Y` and `X → Z`.
  5. **Transitivity**: If `X → Y` and `Y → Z`, then `X → Z`.
  6. **Pseudotransitivity**: If `X → Y` and `YZ → W`, then `XZ → W`.

#### **4.3 Applying the Axioms**
- Explains how to use the axioms to derive new functional dependencies.
- Introduces the concept of the **closure of a set of attributes** (`X+`), which includes all attributes determined by `X` under a set of functional dependencies `F`.

#### **4.4 Completeness of the Axioms**
- Demonstrates that the axioms are **complete**, meaning any functional dependency that can be inferred from a set of functional dependencies `F` can be derived using the axioms.
- Introduces the concept of **Armstrong relations**, which are relations designed to satisfy a specific set of functional dependencies and violate all others.

#### **4.5 Derivations and Directed Acyclic Graphs (DAGs)**
- Defines **derivation sequences** as steps to deduce a functional dependency from a given set.
- Introduces **DAGs based on functional dependencies** as a graphical representation of derivation sequences.
- Example: Constructing a DAG to represent the derivation of `X → Y` using functional dependencies.

#### **4.6 Testing Membership in F+**
- Presents algorithms to determine whether a functional dependency `X → Y` belongs to the closure of a set of dependencies `F+`:
  - **CLOSURE Algorithm**: Computes the closure `X+` under a set of dependencies `F`.
  - **LINCLOSURE Algorithm**: An optimized version of CLOSURE with a time complexity of **O(n)**.

#### **4.7 Exercises**
- Includes exercises to practice applying the axioms, constructing DAGs, and implementing algorithms.

---

### **Key Points**
1. **Functional dependencies**: Essential for ensuring consistency and minimizing redundancy in databases.
2. **Inference axioms**: Provide a formal framework for deducing new functional dependencies.
3. **Closure and algorithms**: Practical tools for analyzing functional dependencies in relational schemas.
4. **Armstrong relations**: Useful for validating sets of functional dependencies.
5. **DAGs**: Graphical representations that simplify understanding derivations.

---

### **Applications**
This chapter is fundamental for:
- **Database normalization**: Identifying and eliminating redundancies using functional dependencies.
- **Relational schema design**: Ensuring schemas comply with integrity constraints.
- **Query optimization**: Using functional dependencies to improve query performance.