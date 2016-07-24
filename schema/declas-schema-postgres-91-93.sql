CREATE TABLE declas
( schema_version TEXT PRIMARY KEY
, http_port INTEGER DEFAULT 8001
, https_port INTEGER DEFAULT 8443
);

CREATE TABLE driver
( driver_name TEXT PRIMARY KEY
);

CREATE TABLE service
( service_name TEXT CHECK (service_name = lower(replace(service_name, '/', '')))
, database_driver TEXT NOT NULL REFERENCES driver(driver_name) ON UPDATE CASCADE
, database_user TEXT
, database_password TEXT
, database_host TEXT DEFAULT 'localhost'
, database_port INTEGER DEFAULT 5432
, database_name TEXT
, PRIMARY KEY (service_name)
);

CREATE TABLE api
( created_at_utc TIMESTAMP WITH TIME ZONE DEFAULT now()
, action TEXT NOT NULL CHECK(action = lower(action))             -- delete, get, post, put
, path_prefix TEXT CHECK (path_prefix = lower(replace(path_prefix, '/', ''))) DEFAULT 'api'
, service_name TEXT REFERENCES service(service_name) ON UPDATE CASCADE
, api_version TEXT DEFAULT '*'                                   -- API version e.g. * for latest; or 0.0.1
, path TEXT NOT NULL CHECK(path = lower(replace(path, '/', ''))) -- [/<path_prefix>][/<service_name>][/<version>]/<path>
, request_headers JSON DEFAULT '{}'   -- JSON object of request header names and values
, request_arguments JSON DEFAULT '{}' -- JSON object of argument names and value types and value limits
, response_headers JSON DEFAULT '{}'  -- JSON object of response header names and values
, sql_query TEXT NOT NULL             -- SQL query performing an action and/or generating a JSON respone
, PRIMARY KEY (action, service_name, api_version, path_prefix, path)
);

CREATE TABLE global_request_header
( created_at_utc TIMESTAMP WITH TIME ZONE DEFAULT now()
, service_name TEXT REFERENCES service(service_name) ON UPDATE CASCADE
, api_version TEXT DEFAULT '*'
, request_headers JSON NOT NULL
, PRIMARY KEY (service_name, api_version)
);

CREATE TABLE global_response_header
( created_at_utc TIMESTAMP WITH TIME ZONE DEFAULT now()
, service_name TEXT REFERENCES service(service_name) ON UPDATE CASCADE
, api_version TEXT DEFAULT '*'
, response_headers JSON NOT NULL
, PRIMARY KEY (service_name, api_version)
);
