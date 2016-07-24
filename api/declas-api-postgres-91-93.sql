INSERT INTO declas
( schema_version
)
VALUES
( '0.0.3'
);

INSERT INTO driver
( driver_name
) VALUES
( 'postgres'
),
( 'sqlite'
);

INSERT INTO service
( service_name
, database_driver
, database_name
)
VALUES
( 'declas'
, 'postgres'
, 'declas_api'
);

INSERT INTO global_request_header
( service_name
, request_headers
)
VALUES
( 'declas'
, '{"Accept":"application/json","Accept-Charset":"utf-8","Accept-Encoding":"gzip, deflate"}'
);

INSERT INTO global_response_header
( service_name
, response_headers
)
VALUES
( 'declas'
, '{"Content-Type":"application/json; charset=utf-8"}'
);

INSERT INTO api
( action
, service_name
, path
, sql_query
)
VALUES
( 'get'
, 'declas'
, 'schema-version'
, 'SELECT row_to_json(sv) FROM (SELECT schema_version FROM declas) AS sv;'
);
