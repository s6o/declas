INSERT INTO backend
( backend_name
, database_driver
, database_name
)
VALUES
('declas-api-db'
, 'sqlite'
, 'declas-api.sqlite'
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
, 'SELECT json_object(''schema_version'',schema_version) FROM declas;'
, 'declas-api-db'
);
