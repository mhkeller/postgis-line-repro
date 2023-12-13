WITH tilebounds (geom) AS (SELECT ST_MakeEnvelope($1, $2, $3, $4, 3857)),
query AS (
  $query
)
SELECT ST_AsMVT(q, 'default', 4096, 'mvtgeom')
FROM (
  SELECT
    *,
    ST_AsMVTGeom(
      ST_Transform(query.geom, 3857),
      tileBounds.geom,
      4096,
      256,
      true
    ) mvtgeom
  FROM query, tilebounds
  WHERE ST_Transform(query.geom, 3857) && tilebounds.geom
) q
