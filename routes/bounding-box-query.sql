WITH query AS (
  $query
)
SELECT
ARRAY[
  ARRAY[
    ST_XMin(bbox),
    ST_YMin(bbox)
  ],
  ARRAY[
    ST_XMax(bbox),
    ST_YMax(bbox)
  ]
] as bbox,
geo_types
FROM (
  SELECT
  ST_Extent(ST_Transform(geom, 4326)) AS bbox,
  ARRAY_AGG(distinct ST_GeometryType(geom)) as geo_types
  FROM query
) y
