INSERT INTO backend
( backend_name
, database_driver
, database_user
, database_host
, database_port
, database_name
)
VALUES
( 'declas-pg-db'
, 'postgres'
, 'postgres'
, 'localhost'
, 5432
, 'declas_api'
);

INSERT INTO declas
( schema_version
)
VALUES
( '0.0.2'
);

INSERT INTO global_request_header
( api_version
, request_headers
)
VALUES
( '0.0.1'
, '{"Accept":"application/json","Accept-Charset":"utf-8","Accept-Encoding":"gzip, deflate"}'
);

INSERT INTO global_response_header
( api_version
, response_headers
)
VALUES
( '0.0.1'
, '{"Content-Type":"application/json; charset=utf-8"}'
);

INSERT INTO api
( version
, action
, path
, response_query
, backend_name
)
VALUES
( '0.0.1'
, 'get'
, '/schema-version'
, 'SELECT row_to_json(declas) FROM declas;'
, 'declas-pg-db'
);
