CREATE OR REPLACE FUNCTION OSSILE/GET_IFS ( 
	"PATH" VARCHAR(256) ) 
	RETURNS TABLE ( 
	OBJECT_NAME VARCHAR(256) , 
	FULLPATH VARCHAR(512) , 
	"TYPE" VARCHAR(11) , 
	SIZE BIGINT , 
	"CCSID" SMALLINT , 
	LAST_ACCESS TIMESTAMP , 
	DATA_CHANGE TIMESTAMP , 
	ATTRIBUTE_CHANGE TIMESTAMP , 
	OWNER CHAR(10) )   
	LANGUAGE RPGLE 
	NOT DETERMINISTIC 
	NO SQL 
	CALLED ON NULL INPUT 
	NOT FENCED 
	CARDINALITY 1 
	EXTERNAL NAME 'OSSILE/GET_IFS' 
	PARAMETER STYLE DB2SQL ; 
  
