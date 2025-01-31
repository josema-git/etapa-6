# MongoDB Course
## 1. Introduction to MongoDB

### 1.1 What is MongoDB?

MongoDB is part of the NoSQL database family, designed for efficient read and write operations with a unique data storage approach.

### 1.2 NoSQL Databases

#### Types of NoSQL Databases

- Document-oriented: Uses key-value structured documents
- Graph-oriented: Focuses on data relationship representations
- Key-value: Simple key-value storage for quick access
- Column-oriented: Column-based storage optimized for large dataset queries

#### Scaling Approaches

- Vertical scaling: Increasing single server capabilities
- Horizontal scaling: Adding multiple nodes for improved availability and replication

#### Replication System

Replication distributes database operations across multiple nodes through horizontal scaling, using a central point to manage requests and queries.

### 1.3 Core Concepts

#### Documents

Basic information units in MongoDB, storing domain-specific data like:
- E-commerce products
- Course materials
- Store inventory items

#### Collections

Organized groups of related documents sharing similar structures. Example: A "Users" collection containing all user documents.

### 1.4 Supported Data Types

MongoDB supports various data types:

- **String**: UTF-8 encoded text
- **Integer**: 32/64-bit numerical values
- **Boolean**: true/false values
- **Double**: Floating-point numbers
- **Arrays**: Lists of values
- **Timestamp**: Document modification tracking
- **Object**: Embedded documents
- **Date**: DateTime values
- **ObjectId**: Unique document identifiers
- **Binary**: Binary data
- **Null**: Null values
- **Regular Expression**: Pattern matching
- **Code**: JavaScript code storage

### 1.5 Update Operators

MongoDB provides various operators for document updates:

| Operator | Description |
|----------|-------------|
| $inc | Increments a numeric attribute by a specified amount |
| $mul | Multiplies a numeric attribute by a specified factor |
| $rename | Changes an attribute's name |
| $set | Assigns a specific value to an attribute |
| $unset | Removes an attribute from a document |
| $min | Updates with minimum value if current is greater |
| $max | Updates with maximum value if current is lesser |
| $currentDate | Sets attribute to current date/time |
| $addToSet | Adds unique value to array |
| $pop | Removes first/last element from array |
| $pull | Removes specific value from array |
| $push | Adds value to array |
| $pullAll | Removes multiple specified values from array |

### 1.6 Query Operators

#### Comparison Operators
| Operator | Description |
|----------|-------------|
| $eq | Matches values equal to specified value |
| $gt | Matches values greater than specified value |
| $gte | Matches values greater than or equal to specified value |
| $in | Matches any values within an array |
| $lt | Matches values less than specified value |
| $lte | Matches values less than or equal to specified value |
| $ne | Matches values not equal to specified value |
| $nin | Matches none of the values in an array |

#### Logical Operators
| Operator | Description |
|----------|-------------|
| $and | Joins query clauses with logical AND |
| $not | Inverts query expression effect |
| $nor | Joins query clauses with logical NOR |
| $or | Joins query clauses with logical OR |

#### Element Operators
| Operator | Description |
|----------|-------------|
| $exists | Matches documents with specified field |
| $type | Selects documents by field type |

#### Evaluation Operators
| Operator | Description |
|----------|-------------|
| $expr | Allows aggregation expressions |
| $jsonSchema | Validates against JSON Schema |
| $mod | Performs modulo operation |
| $regex | Matches regular expression pattern |
| $text | Performs text search |
| $where | Matches JavaScript expression |

#### Geospatial Operators
| Operator | Description |
|----------|-------------|
| $geoIntersects | Selects intersecting geometries |
| $geoWithin | Selects geometries within boundary |
| $near | Returns objects near point |
| $nearSphere | Returns objects near point on sphere |

#### Array Operators
| Operator | Description |
|----------|-------------|
| $all | Matches arrays containing all elements |
| $elemMatch | Matches documents with array element meeting conditions |

### 1.7 Regular Expression Queries

MongoDB supports regex pattern matching in queries. While $regex operator exists, direct regex syntax is often clearer.

#### Common Regex Patterns

| Pattern | Description | Example |
|---------|-------------|---------|
| /word/ | Exact match | `/line/` matches "line" exactly |
| /word/i | Case-insensitive match | `/line/i` matches "Line", "LINE" |
| /word$/ | End of string match | `/line$/` matches strings ending in "line" |
| /^word/ | Start of string match | `/^Single/` matches strings starting with "Single" |
| /^char/m | Multiline start match | `/^S/m` matches 'S' at start of any line |

Note: While $regex operator exists, direct regex syntax is typically more readable and preferred.

### code

#### Starting MongoDB
```bash
docker-compose up -d mongodb
```

#### Container Management
```bash
docker-compose ps
docker-compose exec mongodb bash
```

#### Database Connection
```bash
mongosh "mongodb+srv://<db_user>:<db_password>@cluster0.nhpio.mongodb.net/"
```

#### Basic Commands
```bash
# List databases
show dbs                

# List collections
show collections       

# Select database
use ("dbs")           

# Query products
db.products.find().skip(2).limit(5) # limita a que solo muestre 5 documentos despues de los 2 primeros

# Insert single document
db.products.insertOne(
    {
        name: "producto 1", 
        price: 1000,
    }
 ) 
 
 # clears the table
 db.products.drop() 

# Insert many documents
 db.products.insertMany(
    [ 
        { _id: 1, name: "product 1", price: 100 }, 
        { _id: 2, name: "product 2", price: 200 }, 
        { _id: 3, name: "product 3", price: 300 }, 
        { _id: 4, name: "product 4", price: 400 }, 
        { _id: 5, name: "product 5", price: 500 }
    ],
    {
        ordered: false # deja por fuera solo a los problemas, no a todos, sin esto, no haria nada despues de la duplicidad (error)
    }
)

#update a document
db.products.updateOne(
    { 
        _id: 2 
    }, 
    { 
        $set: } 
            name: 'changed_name'
            }
    },
    {
        upsert: true #en caso de no existir, la inserta con los datos puestos
    }
)

#update a document
db.products.updateMany(
    { 
        price: 100
    }, 
    { 
        $set: } 
            name: 'changed_name'
            }
    }
)

#deletes a document
db.products.deleteOne({_id:1}) 

#deletes many documents  
db.products.deleteMany({price:100})

#using operators
db.products.find($or: [price: { $eq: 20 } , price:{ $neq: 10}])

# Project with conditions
db.products.find(
    { price: { $gt: 200 } },
    {
        name: 1,
        price: 1,
        _id: 0
    }
)

#expresive operator
db.products.find({
    $expr: {
        $gte: ["$spent" : "$budget"] # finds the documents wich spent value is greater or equal tan budget value
    }
})

```
