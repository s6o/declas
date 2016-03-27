# declas - the declarative API server

Describe an API with JSON and SQL, (re)start the server - thats it!

This repository contains the declas specification, for implementations look for
separate repositories: declas-*

# Overview

## API Description
The API description is stored in an relational database accordingly to the
specified schema.

The API schema will caputre:

  * API versions
  * actions (verbs - CRUD i.e. POST, GET, PUT, DELETE)
  * routes
  * query parameters as a JSON object, part of route pattern matching
  * request headers as a JSON object, part of route pattern matching
  * request body (POST, PUT) template/spec in JSON, part of route pattern matching
  * response headers as a JSON object
  * (parameterized) response query (GET) or action query (POST, PUT, DELETE) in SQL

## API Server
A declas API Server combines an HTTP server with an implementation of the declas
specification for pattern matching request routes, executing action or reponse
queries against a supported database and returning results.

Different implementation can be written, as long as they confirm to the declas
specifications, moving the API description from one implementation to another
should be seemless.

## Backend(s)
Backends must support JSON and SQL and storing data relationally and/or in JSON.
The data needs to be able to be queried via SQL and the returned results need to
be in JSON or transformed to JSON within the SQL query via respective JSON functions.

At present 2 suitable options exist:

  * [SQLite](http://sqlite.org/) - [JSON support](http://sqlite.org/json1.html)
  * [PostgreSQL](http://www.postgresql.org/) - [JSON support](http://www.postgresql.org/docs/9.5/interactive/functions-json.html)

NOTE: skimming the respective documentations it looks like MySQL and MariaDB would
also work, but author's experience with MySQL/MariaDB is limited, thus these are
not first in line to be supported.
