CREATE TABLE api (
  id INTEGER PRIMARY KEY
  , created_ts_utc TEXT DEFAULT (strftime('%Y-%m-%d %H:%m:%S.%s', 'now', 'utc'))
  , version TEXT DEFAULT '*'                           -- API version e.g. 0.0.1 or *
  , action TEXT NOT NULL CHECK(action = lower(action)) -- delete, get, post, put
  , path TEXT NOT NULL CHECK(path = lower(path))       -- /api/<version>/path
  , request_headers TEXT DEFAULT '{}'   -- JSON object of request header names and values
  , request_arguments TEXT DEFAULT '{}' -- JSON object of argument names and value types and value limits
  , response_headers TEXT DEFAULT '{}'  -- JSON object of response header names and values
  , response_query TEXT NOT NULL        -- SQL query getting the JSON respone
);

CREATE TABLE declas (
  schema_version TEXT PRIMARY KEY
);

CREATE TABLE global_request_header (
  id INTEGER PRIMARY KEY
  , created_ts_utc TEXT DEFAULT (strftime('%Y-%m-%d %H:%m:%S.%s', 'now', 'utc'))
  , api_version TEXT DEFAULT '*'
  , request_headers TEXT NOT NULL
);

CREATE TABLE global_response_header (
  id INTEGER PRIMARY KEY
  , created_ts_utc TEXT DEFAULT (strftime('%Y-%m-%d %H:%m:%S.%s', 'now', 'utc'))
  , api_version TEXT DEFAULT '*'
  , response_headers TEXT NOT NULL
);
