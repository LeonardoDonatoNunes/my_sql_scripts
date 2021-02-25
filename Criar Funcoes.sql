CREATE OR REPLACE FUNCTION funcoes.create_geom_points()
RETURNS trigger AS 
$BODY$
DECLARE
	thegeom geometry;
BEGIN

IF NEW.lon IS NOT NULL AND NEW.lat IS NOT NULL THEN
	thegeom = ST_SetSRID(ST_MakePoint(NEW.lon, NEW.lat),4326);
	NEW.geom = thegeom;
END IF;

RETURN NEW;
END;$BODY$
LANGUAGE plpgsql VOLATILE
COST 100;
COMMENT ON FUNCTION funcoes.create_geom_points()
IS 'When called by a trigger (insert_lon_lat) this function populates the field geom using the values from lon and lat fields.';