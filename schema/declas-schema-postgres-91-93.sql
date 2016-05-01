CREATE TABLE backend
( backend_name TEXT PRIMARY KEY
, backend_properties JSON DEFAULT '{}'
, database_driver TEXT NOT NULL -- e.g. postgres, sqlite
, database_user TEXT
, database_password TEXT
, database_host TEXT DEFAULT 'localhost'
, database_port INTEGER DEFAULT 5432
, database_name TEXT
);

CREATE TABLE service
( service_name TEXT PRIMARY KEY
);

CREATE TABLE api
( id SERIAL PRIMARY KEY
, created_at_utc TIMESTAMP WITH TIME ZONE DEFAULT now()
, service_name TEXT REFERENCES service(service_name) ON UPDATE CASCADE
, version TEXT DEFAULT '*'                            -- API version e.g. 0.0.1 or *
, action TEXT NOT NULL CHECK(action = lower(action))  -- delete, get, post, put
, path TEXT NOT NULL CHECK(path = lower(path))       -- /api[/<version>]/<path> or /api[/<service>[/<version>]]/<path>
, request_headers JSON DEFAULT '{}'   -- JSON object of request header names and values
, request_arguments JSON DEFAULT '{}' -- JSON object of argument names and value types and value limits
, response_headers JSON DEFAULT '{}'  -- JSON object of response header names and values
, response_query TEXT NOT NULL        -- SQL query getting the JSON respone
, backend_name TEXT NOT NULL REFERENCES backend(backend_name) ON UPDATE CASCADE
);

CREATE TABLE declas
( schema_version TEXT PRIMARY KEY
, http_port INTEGER DEFAULT 8001
, https_port INTEGER DEFAULT 8443
);

CREATE TABLE global_request_header
( id SERIAL PRIMARY KEY
, created_at_utc TIMESTAMP WITH TIME ZONE DEFAULT now()
, api_version TEXT DEFAULT '*'
, request_headers JSON NOT NULL
);

CREATE TABLE global_response_header
( id SERIAL PRIMARY KEY
, created_at_utc TIMESTAMP WITH TIME ZONE DEFAULT now()
, api_version TEXT DEFAULT '*'
, response_headers JSON NOT NULL
);
