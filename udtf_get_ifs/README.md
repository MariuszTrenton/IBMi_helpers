
# SQL UDTF list source members #

A SQL user defined table function to list objects in directory.
Community response for [RFE: 90136] https://www.ibm.com/developerworks/rfe/execute?use_case=viewRfe&CR_ID=90136

### What is this UDTF do ? ###

* This SQL function will return list objects in directory passed in statement.  

* GET_IFS accepts only 1 parameter :  directory for listing. 
* The following parameters can be specified:

Parameter                          | Data type                     | Description
-----------------------------------|:------------------------------|:------------------------------------------
path			                   | varchar(256)                  | Specifies directory for listing

* The following attributes are returned:
* The following attributes are returned:

Attribute                          | Data type                     | Description
-----------------------------------|:------------------------------|:------------------------------------------
Object name                        | varchar(256)                  | 
Object full name                   | varchar(512)                  | Object name including fullpath
Object Type                        | char(11)                      | Type of object 
Object Size                        | bigint                        | Defined as follows for each file type:
CCSID                              | smallint                      |  The code page derived from the CCSID used for the data in the file 
Last Access                        | timestamp                     | The most recent timestamp the file was accessed.
Last data change                   | timestamp                     | The most recent timestamp the contents of the file were changed.
Last attribute change              | timestamp                     | The most recent timestamp the status of the file was changed
Owner                              | char(10)                      | Owner profile, if profile could not be retrieved 
                                   |                               |  'n/a' value is returned.

### How do I get set up? ###

For build and setup instructions, refer to the [README.md](../../README.md) for the OSSILE project.

### Usage examples ###

* Call the SQL function like the following 
 
		select * from table(ossile.get_ifs('/')) a 
		select * from table(ossile.get_ifs('/qsys.lib/qsys2.lib')) a 
