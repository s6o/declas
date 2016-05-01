CREATE TABLE backend (
  backend_name TEXT PRIMARY KEY
  , backend_properties TEXT DEFAULT '{}'
  , database_driver TEXT NOT NULL -- e.g. postgres, sqlite
  , database_user TEXT
  , database_password TEXT
  , database_host TEXT
  , database_port INTEGER
  , database_name TEXT
);

CREATE TABLE service (
  service_name TEXT PRIMARY KEY
);

CREATE TABLE api (
  id INTEGER PRIMARY KEY
  , created_at_utc TEXT DEFAULT (strftime('%Y-%m-%d %H:%m:%S.%s', 'now', 'utc'))
  , service_name TEXT REFERENCES service(service_name) ON UPDATE CASCADE
  , version TEXT DEFAULT '*'                           -- API version e.g. 0.0.1 or *
  , action TEXT NOT NULL CHECK(action = lower(action)) -- delete, get, post, put
  , path TEXT NOT NULL CHECK(path = lower(path))       -- /api[/<version>]/<path> or /api[/<service>[/<version>]]/<path>
  , request_headers TEXT DEFAULT '{}'   -- JSON object of request header names and values
  , request_arguments TEXT DEFAULT '{}' -- JSON object of argument names and value types and value limits
  , response_headers TEXT DEFAULT '{}'  -- JSON object of response header names and values
  , response_query TEXT NOT NULL        -- SQL query getting the JSON respone
  , backend_name TEXT NOT NULL REFERENCES backend(backend_name) ON UPDATE CASCADE
);

CREATE TABLE declas (
  schema_version TEXT PRIMARY KEY
  , http_port INTEGER DEFAULT 8001
  , https_port INTEGER DEFAULT 8443
);

CREATE TABLE global_request_header (
  id INTEGER PRIMARY KEY
  , created_at_utc TEXT DEFAULT (strftime('%Y-%m-%d %H:%m:%S.%s', 'now', 'utc'))
  , api_version TEXT DEFAULT '*'
  , request_headers TEXT NOT NULL
);

CREATE TABLE global_response_header (
  id INTEGER PRIMARY KEY
  , created_at_utc TEXT DEFAULT (strftime('%Y-%m-%d %H:%m:%S.%s', 'now', 'utc'))
  , api_version TEXT DEFAULT '*'
  , response_headers TEXT NOT NULL
);
