INSERT INTO declas
(schema_version
, backend_database_driver
, backend_database_user
, backend_database_host
, backend_database_port
, backend_database_name)
VALUES
('0.0.1'
, 'postgres'
, 'postgres'
, 'localhost'
, 5432
, 'declas_api'
);

INSERT INTO global_request_header (api_version, request_headers)
VALUES (
  '0.0.1'
  , '{"Accept":"application/json","Accept-Charset":"utf-8","Accept-Encoding":"gzip, deflate"}'
);

INSERT INTO global_response_header (api_version, response_headers)
VALUES (
  '0.0.1'
  , '{"Content-Type":"application/json; charset=utf-8"}'
);

INSERT INTO api (
  version
  , action
  , path
  , response_query)
VALUES (
  '0.0.1'
  , 'get'
  , '/schema-version'
  , 'SELECT row_to_json(declas) FROM declas;'
);
