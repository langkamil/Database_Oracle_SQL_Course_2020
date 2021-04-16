-- Kasowanie zawartoœci bie¿¹cej bazy danych w Oracle
-- Skryptu nie powinien wykonywaæ u¿ytkownik o nazwie system
BEGIN
	FOR ii IN (SELECT object_name, object_type FROM user_objects 
        WHERE object_type='TABLE') 
    LOOP
        EXECUTE IMMEDIATE 'DROP '||ii.object_type||' "'||ii.object_name||'" CASCADE CONSTRAINTS';
	END LOOP;    
    FOR ii IN (SELECT object_name, object_type FROM user_objects
        WHERE object_type IN('VIEW','MATERIALIZED VIEW','PACKAGE','PROCEDURE',
            'FUNCTION','SEQUENCE','SYNONYM','PACKAGE BODY'))
	LOOP
		EXECUTE IMMEDIATE 'DROP '||ii.object_type||' "'||ii.object_name||'"';
	END LOOP;
    FOR ii IN (SELECT * FROM all_synonyms WHERE table_owner IN (SELECT USER FROM dual))
	LOOP
		EXECUTE IMMEDIATE 'DROP PUBLIC SYNONYM '||ii.synonym_name;
	END LOOP;
END;