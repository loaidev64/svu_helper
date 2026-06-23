--- Page 1 ---

title[[120, 307, 878, 349]]
# Oracle Database Administration  

text[[484, 373, 515, 403]]
I  

text[[164, 454, 832, 526]]
Chapter 8: Schema Objects: Tables and Constraints

--- Page 2 ---

sub_title[[732, 149, 887, 170]]  

text[[115, 207, 883, 735]]
Objectives 2  1. Naming Rules of Schema Objects 3  1.1. Objects in Database 3  1.2. Schema in Database 3  1.3. General Naming Rules of Schema Objects 4  1.4. Special Naming Rules of Schema Objects 4  2. Understanding Table and Data Types 5  2.1. Understanding Table Types 5  2.2. Understanding Data Types 6  3. Creating a Table 14  3.1. Creating a Heap-Organized Table 14  3.2. Implementing Virtual Columns 19  3.3. Making Read-Only Tables 21  4. Modifying a Table 23  5. Dropping a Table 25  6. Undropping a Table 26  7. Removing Data from a Table 27  8. Viewing and Adjusting the High- Water Mark 29  9. Creating a Temporary Table 30  10. Creating an Index-Organized Table 31  11. Managing Constraints 32  12. Quiz 38

--- Page 3 ---

sub_title[[117, 108, 253, 127]]
## Objectives:  

text[[148, 141, 545, 260]]
1. Define schema objects and data types  
2. Create and modify tables  
3. Define constraints  
4. View the columns and contents of a table  
5. Explain the use of temporary tables

--- Page 4 ---

sub_title[[120, 108, 559, 128]]
## 1. Naming Rules of Schema Objects:  

sub_title[[119, 142, 385, 160]]
### 1.1. Objects in Database:  

text[[117, 173, 880, 217]]
Usually, the first objects created for an application are the tables, constraints, and indexes.  

sub_title[[118, 221, 191, 236]]
## Table  

text[[116, 241, 881, 339]]
A table is the basic storage container for data in a database. You create and modify the table structure via DDL statements, such as CREATE TABLE and ALTER TABLE. You access and manipulate table data via DML statements (INSERT, UPDATE, DELETE, MERGE, SELECT).  

text[[116, 367, 880, 436]]
Tip: One important difference between DDL and DML statements is that with DML statements, you must explicitly/implicitly issue a COMMIT or ROLLBACK to end the transaction.  

sub_title[[117, 442, 242, 458]]
## constraint  

text[[115, 463, 881, 581]]
A constraint is a mechanism for enforcing that data adhere to business rules. Constraints inspect data as they're inserted, updated, and deleted to ensure that no business rules are violated. Almost always, when you create a table, the table needs one or more constraints defined; therefore, it makes sense to cover constraint management along with tables.  

sub_title[[117, 616, 384, 634]]
### 1.2. Schema in Database:  

text[[116, 648, 239, 664]]
A schema is:  

text[[146, 673, 806, 768]]
Collection of database objects that are owned by a particular user Use SQL or Toad for Oracle to create and manipulate schema objects SYS Schema is predefined SYSTEM Schema is predefined

--- Page 5 ---

sub_title[[119, 106, 606, 125]]
### 1.3. General Naming Rules of Schema Objects:  

text[[147, 137, 880, 310]]
- The length of names must be from 1 to 30 characters- Non quoted names cannot be Oracle-reserved words- Non quoted names must begin with an alphabetic character from your database character set- Names can only use letters, numbers, underscore (_), the dollar sign (\$), or the hash symbol (#)- Quoted names are not recommended  

sub_title[[119, 341, 602, 360]]
### 1.4. Special Naming Rules of Schema Objects:  

text[[147, 371, 740, 415]]
- Database name, which may be up to 8 characters only- Database link names, which may be up to 128 characters long

--- Page 6 ---

sub_title[[117, 108, 595, 129]]
## 2. Understanding Table and Data Types:  

title[[119, 142, 460, 160]]
#### 2.1. Understanding Table Types:  

text[[116, 173, 880, 218]]
The Oracle database supports a vast and robust variety of table types. These various types are described in the enclosed Table.  

text[[117, 223, 879, 269]]
This chapter focuses on the table types that are most often used: in particular, heap organized, index organized, and temporary tables.  

table[[127, 292, 867, 892]]

<table>Table TypeDescriptionTypical UseHeap<br>OrganizedThe default table type and the most commonly usedTable type to use unless you have a specific reason to use a different typeTemporarySession private data, stored for the duration of a session or transaction; space allocated in temporary segmentsProgram needs a temporary table structure to store and sort data; table is not required after program endsIndex<br>organizedData stored in a B-tree (balanced tree) index structure sorted by primary keyTable is queried mainly on primary key columns; provides fast random accessPartitionedA logical table that consists of separate physical segmentsType used with large tables with millions of rowsExternalTables that use data stored in OS files outside the databaseType lets you efficiently access data in a file outside the database (such as a CSV file)In-Memory<br>ExternalData that is not needed to load into Oracle storage and used for scanning as part of big data setsData that can be scanned for both RDBMS and Hadoop in-memory</table>

text[[119, 919, 475, 932]]
Chapter 8: Schema Objects: Tables and Constraints

--- Page 7 ---

table[[133, 100, 862, 412]]

<table>ClusteredA group of tables that share the same data blocksType used to reduce I/O for tables that are often joined on the same columnsHash clusteredA table with data that is stored and retrieved using a hash functionReduces the I/O for tables that are mostly static (not growing after initially loaded)NestedA table with a column with a data type that is another tableRarely usedObjectA table with a column with a data type that is an object typeRarely used</table>  

sub_title[[117, 442, 448, 462]]
### 2.2. Understanding Data Types:  

text[[115, 472, 881, 542]]
When creating a table, you must specify the columns names and corresponding data types. As a DBA you should understand the appropriate use of each data type. Oracle supports the following groups of data types:  

text[[147, 549, 273, 717]]
Character Numeric Date/Time RAW ROWID LOB JSON  

text[[115, 727, 876, 746]]
A brief description and usage recommendation are provided in the following sections.

--- Page 8 ---

title[[118, 108, 301, 126]]
#### 2.2.1. Character:  

text[[117, 139, 880, 184]]
Use a character data type to store characters and string data. The following character data types are available in Oracle:  

sub_title[[118, 211, 235, 227]]
## VARCHAR2  

text[[116, 234, 883, 354]]
The VARCHAR2 data type is what you should use in most scenarios to hold character/string data. A VARCHAR2 only allocates space based on the number of characters in the string. If you insert a one- character string into a column defined to be VARCHAR2(30), Oracle will only consume space for the one character. The following example verifies this behavior:  

text[[116, 374, 883, 508]]
SQL> create table d(d varchar2(30)); insert into d values ('a'); select dump(d) from d; --Here is a snippet of the output, verifying that only 1Byte has been allocated: DUMP(D)  

text[[118, 506, 253, 520]]
Typ=1 Len=1  

text[[116, 545, 883, 644]]
When you define a VARCHAR2 column, you must specify a length. There are two ways to do this: BYTE and CHAR. BYTE specifies the maximum length of the string in bytes, whereas CHAR specifies the maximum number of characters. For example, to specify a string that contains at the most 30B, you define it as: varchar2(30 byte)  

text[[116, 650, 880, 691]]
To specify a character string that can contain at most 30 characters, you define it as: varchar2(30 char)  

text[[115, 693, 881, 835]]
In almost all situations, you are safer specifying the length using CHAR. When working with multibyte character sets, if you specified the length to be VARCHAR2(30 byte), you may not get predictable results, because some characters require more than 1 byte of storage (like Arabic characters). In contrast, if you specify VARCHAR2(30 char), you can always store 30 characters in the string, regardless of whether some characters require more than 1 byte.

--- Page 9 ---

sub_title[[119, 104, 177, 118]]
## CHAR  

text[[116, 124, 883, 269]]
A CHAR is a fixed- length character field. If you define a CHAR (30) and insert a string that consists of only one character, Oracle will allocate 30B of space. This can be an inefficient use of space. If using CHAR, it does make sense to only use it if the size of the value will not change and is absolutely static. I have normally only used CHAR if the length was under 8, and the size was absolutely fixed. The following example verifies this behavior:  

text[[116, 290, 883, 440]]
SQL> create table d(d char(30)); insert into d values ('a'); select dump(d) from d; --Here is a snippet of the output, verifying that 30B have been consumed: DUMP(D) Typ=96 Len=30  

sub_title[[119, 468, 375, 484]]
## NVARCHAR2 and NCHAR  

text[[117, 489, 883, 606]]
The NVARCHAR2 and NCHAR data types are useful if you have a database that was originally created with a single- byte, fixed- width character set, but sometime later you need to store multibyte character set data in the same database; one of the permitted Unicode character sets. You can use the NVARCHAR2 and NCHAR data types to support this requirement.  

text[[117, 614, 881, 684]]
It is simpler to standardize with use of VARCHAR2 and provide enough length to handle the multibyte characters or use the length in character instead of using NVARCHAR2 and NCHAR.  

sub_title[[119, 721, 174, 735]]
## Note:  

text[[117, 743, 881, 789]]
In Oracle Database 12c and higher, you can specify up to 32,767 characters in a VARCHAR2 or NVARCHAR2 data type.  

text[[119, 796, 536, 813]]
To check Database Character set in database:  

text[[117, 834, 881, 890]]
select \* from nls_database_parameters where parameter like '%CHARACTERSET'; PARAMETER VALUE

--- Page 10 ---

text[[117, 121, 388, 176]]
NLS_NCHAR_CHARACTERSET AL16UTF16 NLS_CHARACTERSET  

text[[760, 160, 876, 175]]
AL32UTF8  

text[[146, 199, 880, 321]]
- NLS_CHARACTERSET- This is for CHAR/VARCHAR2. Each character takes 1 to 4 bytes to store.- NLS_NCHAR_CHARACTERSET - This is for NCHAR/NVARCHAR2. Each character is either 2 or 4 bytes to store. So any character in NVARCHAR2 will not occupy less than 2 bytes.  

title[[118, 352, 284, 370]]
#### 2.2.2.Numeric:  

text[[117, 382, 881, 455]]
Use a numeric data type to store data that you will potentially need to use with mathematic functions, such as SUM, AVG, MAX, and MIN. Oracle supports three numeric data types:  

text[[146, 477, 339, 547]]
- NUMBER 
- BINARY_DOUBLE 
- BINARY_FLOAT  

text[[116, 572, 881, 746]]
For most situations, you will use the NUMBER data type for any type of number data. Its syntax is NUMBER (scale, precision) where scale is the total number of digits, and precision is the number of digits to the right of the decimal point. What sometimes confuses DBAs is that you can create a table with columns defined as INT, INTEGER, REAL, DECIMAL, and so on. These data types are all implemented by Oracle with a NUMBER data type. For example, a column specified as INTEGER is implemented as a NUMBER (38).  

text[[118, 751, 880, 795]]
The BINARY_DOUBLE and BINARY_FLOAT data types are used for scientific calculations. These map to the DOUBLE and FLOAT Java data types.

--- Page 11 ---

sub_title[[118, 108, 210, 124]]
## Example:  

text[[115, 132, 878, 227]]
With a number defined as NUMBER (5, 2) you can store values +/- 999.99. That is a total of five digits, with two used for precision to the right of the decimal point. If defined as NUMBER (5) the values can be to the right or left of the decimal with a total of five digits, this value will fit, 2.4563 as would 55,555.  

sub_title[[118, 262, 173, 277]]
## Note:  

text[[116, 285, 878, 380]]
Oracle allows a maximum of 38 digits for a NUMBER data type. This is almost always sufficient for any type of numeric application. So, unless your application is performing rocket science calculations, then use the NUMBER data type for all your numeric requirements.  

title[[118, 414, 299, 432]]
#### 2.2.3. Date/Time:  

text[[117, 445, 535, 463]]
Oracle supports three date- related data types:  

sub_title[[116, 494, 174, 508]]
## Date  

text[[115, 514, 878, 632]]
The DATE data type contains a date component as well as a time component that is granular to the second. By default, if you do not specify a time component when inserting data, then the time value defaults to midnight (0 hour at the 0 second). If you need to track time at a more granular level than the second, then use TIMESTAMP; otherwise, feel free to use DATE.  

sub_title[[118, 663, 242, 678]]
## TIMESTAMP  

text[[115, 684, 878, 827]]
The TIMESTAMP data type contains a date component and a time component that is granular to fractions of a second. When you define a TIMESTAMP, you can specify the fractional second precision component. For instance, if you wanted five digits of fractional precision to the right of the decimal point, you would specify that as TIMESTAMP (5) The maximum fractional precision is 9; the default is 6. If you specify 0 fractional precision, then you have the equivalent of the DATE data type.  

text[[116, 836, 876, 880]]
The TIMESTAMP data type comes in two additional variations: TIMESTAMP WITH TIME ZONE and TIMESTAMP WITH LOCAL TIME ZONE. These are time zone-

--- Page 12 ---

text[[117, 106, 880, 150]]
aware data types, meaning that when the user selects the data, the time value is adjusted to the time zone of the user's session.  

sub_title[[118, 180, 227, 195]]
## INTERVAL  

text[[117, 201, 881, 264]]
Oracle also provides an INTERVAL data type. This is meant to store a duration, or interval, of time. There are two types: INTERVAL YEAR TO MONTH and INTERVAL DAY TO SECOND.  

title[[118, 294, 245, 311]]
#### 2.2.4. RAW:  

text[[115, 324, 881, 446]]
The RAW data type allows you to store binary data in a column. This type of data is sometimes used for storing globally unique identifiers or small amounts of encrypted data. You can declare a RAW to have a maximum size of 32,767 bytes. The data are displayed in hexadecimal format, using characters 0- 9 and A- F. When inserting data into a RAW column, the built- in HEXTORAW is implicitly applied.  

title[[118, 478, 271, 495]]
#### 2.2.5.ROWID:  

text[[117, 508, 880, 551]]
ROWID (row identifier) is a pseudocolumn provided with every table row that contains the physical location of the row on disk.  

title[[118, 586, 405, 605]]
#### 2.2.6.LOB (Large Objects):  

text[[117, 616, 880, 660]]
Oracle supports storing large amounts of data (4 GB) in a column via a LOB data type. Oracle supports the following types of LOBS:  

sub_title[[118, 691, 174, 705]]
## CLOB  

text[[117, 711, 881, 780]]
If you have textual data that do not fit within the confines of a VARCHAR2, then you should use a CLOB to store these data. A CLOB is useful for storing large amounts of character data, such as log files.

--- Page 13 ---

sub_title[[117, 104, 188, 119]]
## NCLOB  

text[[116, 125, 880, 168]]
An NCLOB is similar to a CLOB but allows for information encoded in the nation character set of the database.  

sub_title[[117, 172, 173, 187]]
## BLOB  

text[[116, 193, 880, 237]]
BLOBs are large amounts of binary data that usually are not meant to be human readable. Typical BLOB data include images, audio, and video files.  

sub_title[[117, 266, 188, 282]]
## BFILE  

text[[116, 287, 882, 405]]
BFILE columns store a pointer to a file on the OS that is outside the database. When it is not feasible to store a large binary file within the database, then use a BFILE. BFILES do not participate in database transactions and are not covered by Oracle security or backup and recovery. If you need those features, then use a BLOB and not a BFILE.  

sub_title[[117, 440, 188, 456]]
## Notes:  

text[[146, 464, 882, 559]]
1. CLOBs, NCLOBs, and BLOBs are known as internal LOBs. This is because they are stored inside the Oracle database. These data types reside within data files associated with the database. Whereas BFILES are known as external LOBs.  

text[[142, 566, 879, 586]]
2. The LONG and LONG RAW data types are deprecated and should not be used.  

sub_title[[117, 619, 254, 637]]
## 2.2.7.JSON:  

text[[116, 648, 882, 845]]
Previous versions of Oracle had procedures to be able to convert table data into JSON or read JSON into the database. The JSON can be put into the database tables with JSON columns. The schema or any other details about the JSON data does not need to be known, and it can be stored in the table with other data and queried using SQL. There is definitely more to working with JSON, and there are packages to make handling the data in the database simplified. It allows for data APIs in JSON to be pulled and put into the database. Storing the JSON data in a column will allow for simple queries to be run against the database to work with other data columns.

--- Page 14 ---

sub_title[[119, 107, 214, 123]]
## Examples  

text[[117, 132, 641, 149]]
Here is an example to create a table with a JSON column:  

text[[118, 172, 724, 263]]
SQL> CREATE TABLE dept (deptno NUMBER(10) ,dname VARCHAR2(14 CHAR) ,dprojects VARCHAR2(32767) CONSTRAINT ensure_jon CHECK (dprojects is JSON));  

text[[117, 286, 880, 330]]
JSON can be inserted into the column with the other columns using an SQL INSERT statement, and the JSON data can be queried also using SQL:  

text[[118, 351, 876, 405]]
SELECT dept.deptno, dept.dprojects.projectID, dept.dprojects.projectName from dept;  

text[[117, 429, 884, 474]]
This will pull out of the JSON data the projectID and projectName for each of the projects contained in the data.

--- Page 15 ---

sub_title[[119, 109, 358, 129]]
## 3. Creating a Table:  

text[[117, 142, 853, 160]]
Listed next are the general factors that you should consider when creating a table:  

text[[147, 167, 882, 444]]
- Type of table (heap organized, temporary, index organized, partitioned, and so on)- Naming conventions- Column data types and sizes- Constraints (primary key, foreign keys, and so on)- Index requirements- Initial storage requirements- Special features (virtual columns, read-only, parallel, compression, no logging, invisible columns, and so on)- Growth requirements- Tablespace(s) for the table and its indexes  

sub_title[[119, 475, 515, 493]]
## 3.1. Creating a Heap-Organized Table:  

text[[117, 504, 882, 598]]
You use the CREATE TABLE statement(s), and data types and lengths associated with the columns. The Oracle default table type is heap organized. The term heap means that the data are not stored in a specific order in the table (instead, they're a heap of data).  

sub_title[[119, 632, 355, 649]]
## Create table in SQL Plus  

text[[117, 658, 670, 676]]
Here is a simple example of creating a heap- organized table:  

text[[118, 697, 398, 770]]
SQL> CREATE TABLE dept (deptno NUMBER(10) ,dname VARCHAR2(14 CHAR), loc VARCHAR2(14 CHAR));  

text[[117, 795, 882, 890]]
If you do not specify a tablespace, then the table is created in the default permanent tablespace of the user that creates the table. Allowing the table to be created in the default permanent tablespace is fine for a few small test tables. For anything more sophisticated, you should explicitly specify the tablespace in which you want tables

--- Page 16 ---

text[[117, 105, 880, 152]]
created. For reference, here are the creation scripts for two sample tablespaces: HR_DATA and HR_INDEX:  

text[[116, 171, 747, 330]]
SQL> CREATE TABLESPACE hr_data DATAFILE '/u01/dbfile/018C/hr_data01.dbf' SIZE 1000m EXTENT MANAGEMENT LOCAL UNIFORM SIZE 512k SEGMENT SPACE MANAGEMENT AUTO;  

text[[117, 327, 746, 430]]
Usually, when you create a table, you should also specify constraints, such as the primary key. The following code shows the most common features you use when creating a table. This DDL defines primary keys, foreign keys, tablespace information, and comments:  

text[[118, 468, 396, 484]]
SQL> CREATE TABLE dept  

text[[119, 487, 402, 502]]
(deptno NUMBER(10)  

text[[120, 505, 406, 519]]
dname VARCHAR2(14 CHAR)  

text[[121, 523, 376, 537]]
loc VARCHAR2(14 CHAR)  

text[[119, 541, 600, 556]]
CONSTRAINT dept_pk PRIMARY KEY (deptno)  

text[[120, 559, 501, 574]]
USING INDEX TABLESPACE hr_index  

text[[121, 578, 373, 592]]
TABLESPACE hr_data;  

text[[119, 611, 147, 622]]
--  

text[[118, 625, 712, 641]]
SQL> COMMENT ON TABLE dept IS 'Department table';  

text[[120, 646, 145, 656]]
--  

text[[119, 670, 696, 705]]
SQL> CREATE UNIQUE INDEX dept_uk1 ON dept(dname) TABLESPACE hr_index;  

text[[121, 712, 147, 722]]
--  

text[[120, 735, 376, 750]]
SQL> CREATE TABLE emp  

text[[122, 754, 320, 768]]
(empno NUMBER(10)  

text[[121, 772, 405, 786]]
ename VARCHAR2(10 CHAR)  

text[[120, 790, 363, 804]]
job VARCHAR2 (9 CHAR)  

text[[122, 809, 282, 823]]
mgr NUMBER(4)  

text[[121, 827, 288, 840]]
hiredate DATE  

text[[120, 845, 304, 859]]
sal NUMBER(7,2)  

text[[122, 863, 319, 877]]
comm NUMBER(7,2)

--- Page 17 ---

text[[117, 103, 673, 352]]
,deptno NUMBER(10) ,CONSTRAINT emp_pk PRIMARY KEY (empno) USING INDEX TABLESPACE hr_index ) TABLESPACE hr_data; SQL> COMMENT ON TABLE emp IS 'Employee table'; -- SQL> ALTER TABLE emp ADD CONSTRAINT emp_fkl FOREIGN KEY (deptno) REFERENCES dept(deptno); -- SQL> CREATE INDEX emp_fkl ON emp(deptno) TABLESPACE hr_index;  

sub_title[[119, 380, 385, 397]]
## Create table in Toad (video)  

text[[117, 405, 798, 423]]
If you use Toad of Oracle to create table, you will follow the following steps:  

text[[119, 431, 553, 448]]
Choose create table from menu as the following:  

image[[122, 476, 865, 759]]  

text[[117, 786, 879, 828]]
Then choose SCHEMA and TABLE NAME and TABLE TYPE and the physical attributes as the following:

--- Page 18 ---

image[[128, 98, 867, 380]]  

text[[119, 408, 613, 426]]
The following figure to the Additional attributes - step1:  

image[[129, 453, 866, 730]]  

text[[120, 759, 615, 777]]
The following figure to the Additional attributes - step2:

--- Page 19 ---

image[[138, 98, 864, 376]]  

text[[117, 404, 613, 421]]
The following figure to the Additional attributes - step3:  

image[[139, 425, 865, 703]]  

text[[116, 730, 880, 775]]
The following figure to see the SQL Statement of the create table as per the previous steps:

--- Page 20 ---

image[[117, 101, 930, 407]]  

title[[119, 438, 484, 456]]
#### 3.2. Implementing Virtual Columns:  

text[[116, 468, 882, 562]]
Virtual column is based on one or more existing columns from the same table or a combination of constants, SQL functions, and user- defined PL/SQL functions, or both. Virtual columns are not stored on disk; they are evaluated at runtime, when the SQL query executes. Virtual columns can be indexed and have stored statistics.  

sub_title[[119, 596, 362, 613]]
## simulate a virtual column  

text[[117, 621, 881, 690]]
Prior to Oracle Database 11g, you could simulate a virtual column via a SELECT statement or in a view definition. For example, this next SQL SELECT statement generates a virtual value when the query is executed:  

text[[116, 711, 663, 782]]
SQL> select inv_id, inv_count, case when inv_count <= 100 then 'GETTING LOW' when inv_count > 100 then 'OKAY' end from inv;

--- Page 21 ---

sub_title[[118, 106, 424, 123]]
## Advantages of virtual columns  

text[[117, 132, 640, 149]]
Why use a virtual column? The of doing so are as follows:  

text[[146, 157, 881, 330]]
You can create an index on a virtual column; internally, Oracle creates a function- based index.- You can store statistics in a virtual column that can be used by the cost- based optimizer (CBO).- Virtual columns can be referenced in WHERE clauses.- Virtual columns are permanently defined in the database; there is one central definition of such a column.  

sub_title[[118, 361, 586, 379]]
## example of creating a table with a virtual column  

text[[117, 401, 880, 476]]
SQL> create table inv(inv_id number,inv_count number,inv_status generated always as ( case when inv_count \(< = 100\) then 'GETTING LOW' when inv_count \(>\) 100 then 'OKAY' end));  

text[[117, 498, 844, 517]]
To view values generated by virtual columns, first insert some data into the table:  

text[[118, 542, 795, 560]]
SQL> insert into inv (inv_id, inv_count) values (1,100);  

text[[117, 583, 613, 601]]
Next, select from the table to view the generated value:  

text[[118, 626, 402, 643]]
SQL> select \* from inv;  

text[[119, 668, 377, 685]]
Here is some sample output:  

table[[117, 710, 590, 770]]

<table>INV_IDINV_COUNTINV_STATUS1100GETTING LOW</table>  

text[[118, 792, 596, 809]]
You can also alter a table to contain a virtual column:  

text[[117, 830, 795, 867]]
SQL> alter table inv add( inv_comm generated always as (inv_count \* 0.1) virtual );

--- Page 22 ---

text[[117, 106, 690, 123]]
And, you can change the definition of an existing virtual column:  

text[[116, 127, 830, 220]]
SQL> alter table inv modify inv_status generated always as( case when inv_count \(< = 50\) then 'NEED MORE' when inv_count >50 and inv_count <=200 then 'GETTING LOW' when inv_count > 200 then 'OKAY' end);  

text[[117, 242, 880, 286]]
suppose you want to update a permanent column based on the value in a virtual column:  

text[[118, 308, 820, 325]]
SQL> update inv set inv_count=100 where inv_status='OKAY';  

sub_title[[119, 350, 508, 367]]
## caveats associated with virtual columns:  

text[[147, 375, 881, 572]]
You can only define a virtual column on a regular, heap- organized table. You cannot define a virtual column on an index- organized table, an external table, a temporary table, object tables, or cluster tables.- Virtual columns cannot reference other virtual columns.- Virtual columns can only reference columns from the table in which the virtual column is defined.- The output of a virtual column must be a scalar value (i.e., a single value, not a set of values).  

sub_title[[120, 610, 444, 629]]
### 3.3. Making Read-Only Tables:  

text[[118, 640, 881, 683]]
There are several reasons why you may require the read- only feature at the table level:  

text[[147, 691, 882, 840]]
The data in the table are historical and should never be updated in normal circumstances.- You are performing some maintenance on the table and want to ensure that it does not change while it is being updated.- You want to drop the table, but before you do, you want to better determine if any users are attempting to update the table.

--- Page 23 ---

text[[117, 107, 747, 125]]
Use the ALTER TABLE statement to place a table in read- only mode:  

text[[118, 147, 493, 163]]
SQL> alter table inv read only;  

text[[116, 188, 802, 206]]
You can verify the status of a read- only table by issuing the following query:  

text[[117, 227, 880, 263]]
SQL> select table_name, read_only from user_tables where read_only='YES';  

text[[118, 286, 718, 304]]
To modify a read- only table to read/write, issue the following SQL:  

text[[117, 325, 505, 342]]
SQL> alter table inv read write;

--- Page 24 ---

sub_title[[119, 109, 372, 129]]
## 4.Modifying a Table:  

text[[116, 142, 881, 237]]
4. Modifying a Table:Altering a table is a common task. New requirements frequently mean that you need to rename, add, drop, or change column data types. When you modify a table, you must have an exclusive lock on the table. One issue is that if a DML transaction has a lock on the table, you cannot alter it. In this situation, you receive this error:  

text[[117, 258, 880, 294]]
ORA- 00054: resource busy and acquire with NOWAIT specified or timeout expired  

sub_title[[118, 319, 292, 335]]
## Renaming a Table  

text[[119, 344, 583, 362]]
There are a couple of reasons for renaming a table:  

text[[147, 370, 779, 413]]
Make the table conform to standards Better determine whether the table is being used before you drop it  

text[[118, 421, 607, 438]]
This example renames a table, from INV to INV_OLD:  

text[[119, 461, 445, 477]]
SQL> rename inv to inv_old;  

text[[117, 502, 510, 519]]
If successful, you should see this message:  

text[[118, 543, 288, 557]]
Table renamed.  

sub_title[[119, 590, 289, 607]]
## Adding a Column  

text[[117, 616, 880, 659]]
Use the ALTER TABLE ... ADD statement to add a column to a table. This example adds a column to the INV table:  

text[[118, 682, 636, 698]]
SQL> alter table inv add(inv_count number);  

text[[117, 722, 510, 739]]
If successful, you should see this message:  

text[[119, 763, 288, 778]]
Table altered.

--- Page 25 ---

sub_title[[119, 108, 300, 124]]
## Altering a Column  

text[[117, 133, 880, 202]]
You need to alter a column to adjust its size or change its data type. Use the ALTER TABLE ... MODIFY statement to adjust the size of a column. This example changes the size of a column to 256 characters:  

text[[117, 224, 790, 241]]
SQL> alter table inv modify inv_desc varchar2(256 char);  

text[[116, 265, 880, 309]]
If you decrease the size of a column, first ensure that no values exist that are greater than the decreased size value:  

text[[117, 329, 800, 348]]
SQL> select max(length(<column_name>) from <table_name>);  

text[[116, 370, 880, 415]]
When you change a column to NOT NULL, there must be a valid value for each column. First, verify that there are no NULL values:  

text[[117, 437, 879, 472]]
SQL> select <column_name> from <table_name> where <column_name> is null;  

text[[116, 495, 880, 565]]
If any rows have a NULL value for the column you are modifying to NOT NULL, then you must first update the column to contain a value. Here is an example of modifying a column to NOT NULL:  

text[[117, 586, 686, 604]]
SQL> alter table inv modify (inv_desc not null);  

sub_title[[118, 610, 313, 627]]
## Renaming a Column  

text[[116, 635, 800, 672]]
Use the ALTER TABLE ... RENAME statement to rename a column: SQL> alter table inv rename column inv_count to inv_amt;  

sub_title[[118, 679, 309, 695]]
## Dropping a Column  

text[[117, 704, 705, 721]]
To drop a column, use the ALTER TABLE ... DROP statement:  

text[[116, 744, 566, 761]]
SQL> alter table inv drop (inv_name);

--- Page 26 ---

sub_title[[119, 108, 364, 129]]
## 5. Dropping a Table:  

text[[117, 143, 359, 159]]
Dropping a table removes:  

text[[147, 169, 429, 286]]
Data- Table structure- Database triggers- Corresponding indexes- Associated object privileges  

text[[116, 294, 880, 338]]
If you want to remove an object, such as a table, from a user, use the DROP TABLE statement. This example drops a table named INV:  

text[[117, 359, 360, 376]]
SQL> drop table inv;  

text[[116, 401, 498, 419]]
You should see the following confirmation:  

text[[118, 442, 287, 458]]
Table dropped.  

text[[117, 483, 881, 526]]
If you attempt to drop a parent table that has either a primary key or unique key referenced as a foreign key in a child table, you see an error such as:  

text[[116, 547, 880, 583]]
ORA- 02449: unique/primary keys in table referenced by foreign keys.  

text[[117, 607, 881, 652]]
You need to either drop the referenced foreign key constraint(s) or use the CASCADE CONSTRAINT option when dropping the parent table:  

text[[116, 673, 596, 689]]
SQL> drop table inv cascade constraints;  

text[[117, 714, 881, 784]]
You must be the owner of the table or have the DROP ANY TABLE system privilege to drop a table. If you have the DROP ANY TABLE privilege, you can drop a table in a different schema by prepending the schema name to the table name:  

text[[117, 806, 465, 822]]
SQL> drop table inv_mgmt.inv;  

text[[116, 847, 880, 889]]
If you do not prepend the table name to a user name, Oracle assumes you are dropping a table in your current schema.

--- Page 27 ---

sub_title[[118, 108, 393, 129]]
## 6. Undropping a Table:  

text[[117, 141, 880, 185]]
Suppose you accidentally drop a table, and you want to restore it. First, verify that the table you want to restore is in the recycle bin:  

text[[118, 206, 374, 222]]
SQL> show recyclebin;  

text[[117, 248, 377, 264]]
Here is some sample output:  

table[[120, 282, 863, 382]]

<table>ORIGINAL NAMERECYCLEBIN NAMEOBJECT TYPEDROP TIMEINVBIN$0F27WtJGbXngQ4TQTwq5Hw ==$0TABLE2012-12-08:12:56:45</table>  

text[[117, 402, 881, 445]]
Next, use the FLASHBACK TABLE...TO BEFORE DROP statement to recover the dropped table:  

text[[116, 467, 563, 485]]
SQL> flashback table inv to before drop;

--- Page 28 ---

sub_title[[120, 108, 504, 128]]
## 7. Removing Data from a Table:  

text[[116, 142, 881, 210]]
You can use either the DELETE statement or the TRUNCATE statement to remove records from a table. You need to be aware of some important differences between these two approaches:  

table[[181, 239, 815, 398]]

<table>FeaturesDELETETRUNCATEChoice of COMMIT or ROLLBACKYESNOGenerates undoYESNOResets the high-water mark to 0NOYESAffected by foreign key constraintsNOYESPerforms well with large amounts of dataNOYES</table>  

sub_title[[117, 429, 259, 445]]
## Using DELETE  

text[[116, 453, 880, 498]]
One big difference is that the DELETE statement can be either committed or rolled back. Committing a DELETE statement makes the changes permanent:  

text[[117, 519, 351, 556]]
SQL> delete from inv; SQL> commit;  

text[[116, 580, 880, 624]]
If you issue a ROLLBACK statement instead of COMMIT, the table contains data as they were before the DELETE was issued.  

sub_title[[117, 657, 281, 673]]
## Using TRUNCATE  

text[[116, 681, 881, 853]]
TRUNCATE is a DDL statement. This means that Oracle automatically commits the statement (and the current transaction) after it runs, so there is no way to roll back a TRUNCATE statement. If you need the option of choosing to roll back (instead of committing) when removing data, then you should use the DELETE statement. However, the DELETE statement has the disadvantage of generating a great deal of undo and redo information. Thus, for large tables, a TRUNCATE statement is usually the most efficient way to remove data:  

text[[117, 875, 530, 892]]
SQL> truncate table computer_systems;

--- Page 29 ---

text[[117, 106, 883, 177]]
Oracle deallocates all space used for the table, except the space defined by the MINEXTENTS table- storage parameter. If you do not want the TRUNCATE statement to deallocate the extents, use the REUSE STORAGE parameter:  

text[[117, 199, 685, 217]]
SQL> truncate table computer_systems reuse storage;  

text[[116, 240, 883, 360]]
The TRUNCATE statement sets the high- water mark of a table back to 0. When you use a DELETE statement to remove data from a table, the high- water mark does not change. One advantage of using a TRUNCATE statement and resetting the high- water mark is that full- table scans only search for rows in blocks below the high- water mark. This can have significant performance implications.  

image[[163, 386, 825, 655]]

--- Page 30 ---

sub_title[[117, 108, 682, 129]]
## 8. Viewing and Adjusting the High-Water Mark:  

text[[116, 141, 884, 261]]
Oracle defines the high- water mark of a table as the boundary between used and unused space in a segment. When you create a table, Oracle allocates a number of extents to the table, defined by the MINEXTENTS table- storage parameter. Each extent contains a number of blocks. Before data are inserted into the table, none of the blocks have been used, and the high- water mark is 0.  

text[[116, 268, 883, 362]]
As data are inserted into a table, and extents are allocated, the high- water mark boundary is raised. A DELETE statement does not reset the high- water mark. You need to be aware of a couple of performance- related issues regarding the high- water mark:  

text[[147, 369, 454, 413]]
SQL query full- table scans Direct- path load- space usage

--- Page 31 ---

sub_title[[117, 108, 497, 129]]
## 9. Creating a Temporary Table:  

text[[116, 143, 279, 160]]
A temporary table  

text[[146, 167, 881, 286]]
Provides storage of data that is automatically cleaned up when the session or transaction ends Provides private storage of data for each session Is available for use to all sessions without affecting the private data of each session  

text[[116, 294, 825, 312]]
You can create the following on temporary tables: Indexes, Views and Triggers  

text[[117, 320, 588, 337]]
The following clauses control the lifetime of the rows:  

text[[146, 345, 881, 440]]
ON COMMIT DELETE ROWS: To specify that the lifetime of the inserted rows is for the duration of the transaction only ON COMMIT PRESERVE ROWS: To specify that the lifetime of the inserted rows is for the duration of the session  

text[[116, 448, 880, 492]]
The rows will be retained until the user either explicitly deletes the data or terminates the session:  

text[[115, 514, 620, 589]]
SQL> create global temporary table today_regs on commit preserve rows as select \* from f_registrations where create_dtt > sysdate - 1;  

text[[116, 612, 769, 631]]
The records should be deleted at the end of each committed transaction:  

text[[115, 653, 629, 707]]
create global temporary table temp_output( temp_row varchar2(30)) on commit delete rows;  

text[[116, 732, 880, 776]]
Note: If you do not specify a commit method for a global temporary table, then the default is ON COMMIT DELETE ROWS.

--- Page 32 ---

sub_title[[119, 108, 593, 129]]
## 10. Creating an Index-Organized Table:  

text[[117, 142, 881, 210]]
Index- organized tables (IOTs) are efficient objects when the table data are typically accessed through querying on the primary key. Use the ORGANIZATION INDEX clause to create an IOT as illustrated in the example  

text[[115, 217, 884, 573]]
An IOT stores the entire contents of the table's row in a B- tree index structure. IOTs provide fast access for queries that have exact matches or range searches, or both, on the primary key. All columns specified, up to and including the column specified in the INCLUDING clause, are stored in the same block as the PROD_SKU_ID primary key column. SQL> create table prod_sku (prod_sku_id number, sku varchar2(256), create_dtt timestamp(5), constraint prod_sku_pk primary key(prod_sku_id) ) organization index including sku pctthreshold 30 tablespace inv_data overflow tablespace inv_data;

--- Page 33 ---

sub_title[[120, 108, 435, 128]]
## 11.Managing Constraints:  

text[[117, 141, 881, 212]]
Constraints provide a mechanism for ensuring that data conform to certain business rules. You must be aware of what types of constraints are available and when it is appropriate to use them. Oracle offers several types of constraints:  

sub_title[[118, 245, 234, 262]]
## Primary key  

text[[117, 269, 881, 366]]
When you implement a database, most tables you create require a primary key constraint to guarantee that every record in the table can be uniquely identified. There are multiple techniques for adding a primary key constraint to a table. The first example creates the primary key inline with the column definition:  

text[[117, 386, 416, 444]]
SQL> create table dept( dept_id number primary key ,dept_desc varchar2(30));  

text[[116, 467, 881, 537]]
If you select the CONSTRAINT_NAME from USER_CONSTRAINTS, note that Oracle generates a cryptic name for the constraint (such as SYS_CO03682). Use the following syntax to explicitly give a name to a primary key constraint:  

text[[116, 558, 880, 636]]
SQL> create table dept( dept_id number constraint dept_pk primary key using index tablespace users, dept_desc varchar2(30));  

text[[115, 657, 881, 780]]
Note When you create a primary key constraint, Oracle also creates a unique index with the same name as the constraint. You can control which tablespace the unique index is placed in via the USING INDEX TABLESPACE clause. The next example creates the primary key when the table is created, but not inline with the column definition:  

text[[115, 801, 559, 895]]
SQL> create table dept( dept_id number, dept_desc varchar2(30), constraint dept_pk primary key (dept_id) using index tablespace users);

--- Page 34 ---

text[[117, 106, 877, 150]]
If the table has already been created, and you want to add a primary key constraint, use the ALTER TABLE statement:  

text[[116, 174, 646, 228]]
SQL> alter table dept add constraint dept_pk primary key (dept_id) using index tablespace users;  

sub_title[[117, 259, 223, 275]]
## Unique key  

text[[116, 283, 881, 430]]
You should create unique constraints on any combinations of columns that should always be unique within a table. A unique key guarantees uniqueness on the defined column(s) within a table. You can define only one primary key per table, but there can be several unique keys. Also, a primary key does not allow a NULL value in any of its columns, whereas a unique key allows NULL values. you can use several methods to create a unique column constraint:  

text[[117, 453, 432, 489]]
SQL> create table dept( dept_id number  

text[[118, 492, 480, 508]]
dept_desc varchar2(30) unique);  

text[[116, 513, 808, 531]]
If you want to explicitly name the constraint, use the CONSTRAINT keyword:  

text[[117, 534, 430, 587]]
SQL> create table dept( dept_id number ,dept_desc varchar2(30) constraint dept_desc_uk1 unique);  

text[[116, 611, 880, 654]]
You can specify inline the tablespace information to be used for the associated unique index:  

text[[117, 678, 699, 751]]
SQL> create table dept( dept_id number ,dept_desc varchar2(30) constraint dept_desc_uk1 unique using index tablespace users);  

text[[116, 777, 621, 794]]
You can also alter a table to include a unique constraint:  

text[[117, 818, 641, 872]]
SQL> alter table dept add constraint dept_desc_uk1 unique (dept_desc) using index tablespace users;

--- Page 35 ---

text[[117, 106, 880, 150]]
And you can create an index on the columns of interest before you define a unique key constraint:  

text[[116, 171, 881, 246]]
SQL> create index dept_desc_uk1 on dept(dept_desc) tablespace users; SQL> alter table dept add constraint dept_desc_uk1 unique (dept_desc);  

sub_title[[118, 275, 235, 293]]
## Foreign key  

text[[117, 301, 883, 420]]
Using a foreign key constraint is an efficient way of enforcing that data be a predefined value before an insert or update is allowed. suppose the EMP table is created with a DEPT_ID column. To ensure that each employee is assigned a valid department, you can create a foreign key constraint that enforces the rule that each DEPT_ID in the EMP table must exist in the DEPT table:  

text[[118, 442, 444, 496]]
SQL> create table dept( dept_id number primary key, dept_desc varchar2(30));  

text[[117, 520, 780, 539]]
creates a foreign key constraint on the DEPT_ID column in the EMP table:  

text[[118, 562, 751, 636]]
SQL> create table emp( emp_id number, name varchar2(30), dept_id constraint emp_dept_fk references dept(dept_id));  

text[[117, 659, 881, 703]]
You can also specify the foreign key definition out of line from the column definition in the CREATE TABLE statement:  

text[[118, 727, 880, 842]]
SQL> create table emp( emp_id number, name varchar2(30), dept_id number, constraint emp_dept_fk foreign key (dept_id) references dept(dept_id));

--- Page 36 ---

text[[117, 106, 693, 185]]
You can alter an existing table to add a foreign key constraint: SQL> alter table emp add constraint emp_dept_fk foreign key (dept_id) references dept(dept_id);  

sub_title[[119, 214, 182, 230]]
## Check  

text[[116, 239, 881, 410]]
A check constraint works well for lookups when you have a short list of fairly static values, such as a column that can be either Y or N. The list of values most likely won't change, and no information needs to be stored other than Y or N, so a check constraint is the appropriate solution. If you have a long list of values that needs to be periodically updated, then a table and a foreign key constraint are a better solution. You can define a check constraint when you create a table. The following enforces the ST_FLG column to contain either a 0 or 1:  

text[[117, 432, 596, 508]]
SQL> create table emp( emp_id number, emp_name varchar2(30), st_flg number(1) CHECK (st_flg in (0,1)) );  

text[[118, 531, 683, 550]]
A slightly better method is to give the check constraint a name:  

text[[117, 572, 845, 649]]
SQL> create table emp( emp_id number, emp_name varchar2(30), st_flg number(1) constraint st_flg_chk CHECK (st_flg in (0,1));  

text[[118, 671, 880, 715]]
You can also alter an existing column to include a constraint. The column must not contain any values that violate the constraint being enabled:  

text[[117, 737, 510, 776]]
SQL> alter table emp add constraint st_flg check (st_flg in (0,1));

--- Page 37 ---

sub_title[[117, 108, 222, 123]]
## NOT NULL  

text[[115, 133, 880, 203]]
Another common condition to check for is whether a column is null; you use the NOT NULL constraint to do this. The NOT NULL constraint can be defined in several ways. The simplest technique is shown here:  

text[[117, 225, 473, 282]]
SQL> create table emp( emp_id number, emp_name varchar2(30) not null);  

text[[115, 304, 881, 373]]
Naming the constraint will allow you to see what the constraint is for instead of a system generated constraint, which might be confused with a primary or foreign key constraint:  

text[[117, 396, 730, 454]]
SQL> create table emp( emp_id number, emp_name varchar2(30) constraint emp_name_nn not null);  

text[[115, 476, 881, 545]]
Use the ALTER TABLE command if you need to modify a column for an existing table. For the following command to work, there must not be any NULL values in the column being defined as NOT NULL:  

text[[117, 568, 650, 588]]
SQL> alter table emp modify (emp_name not null);  

text[[115, 610, 880, 656]]
Note: If there are currently NULL values in a column that is being defined as NOT NULL, you must first update the table so that the column has a value in every row.  

sub_title[[118, 688, 285, 704]]
## Constraint States  

text[[117, 713, 880, 757]]
Every constraint is either enabled or disabled, and validated or not validated. Any combination of these is syntactically possible:  

text[[144, 764, 881, 857]]
- ENABLE VALIDATE: It is not possible to enter rows that would violate the constraint, and all rows in the table conform to the constraint.- DISABLE NOVALIDATE: Any data (conforming or not) can be entered, and there may already be non-conforming data in the table.

--- Page 38 ---

text[[147, 106, 881, 151]]
- ENABLE NOVALIDATE: There may already be non-conforming data in the table, but all data entered now must conform.  

text[[148, 158, 880, 229]]
- DISABLE VALIDATE: An impossible situation: all data in the table conforms to the constraint, but new rows need not. The end result is that the table is locked against DML commands.  

image[[175, 252, 816, 427]]  

text[[115, 455, 880, 501]]
Use the ALTER TABLE statement to disable constraints on a table. In this case, there is only one foreign key to disable/enable:  

text[[116, 520, 695, 558]]
SQL> alter table emp disable constraint emp_dept_fk; SQL> alter table emp enable constraint emp_dept_fk;  

text[[115, 581, 880, 627]]
You can disable a primary key and all dependent foreign key constraints with the CASCADE option of the DISABLE clause:  

text[[116, 646, 808, 665]]
SQL> alter table dept disable constraint dept_pk cascade;  

text[[115, 688, 746, 705]]
Note1: Keep in mind that there is no ENABLE...CASCADE statement.  

text[[116, 714, 775, 732]]
Note2: You can get information about constraints in dba_constraints.

--- Page 39 ---

sub_title[[119, 108, 231, 128]]
## 12. Quiz:  

text[[117, 141, 870, 187]]
1. Which of these statements will fail because the table name is not legal? (Choose all correct answers).  

text[[147, 193, 508, 314]]
a) create table "SELECT" (col1 date);  
b) create table "lower case" (col1 date);  
c) create table number1 (col1 date);  
d) create table 1number(col1 date);  
e) create table update(col1 date);  

text[[117, 345, 870, 391]]
2. Which of the following is not supported by Oracle as an internal datatype? (Choose the correct answer).  

text[[147, 398, 258, 507]]
a) CHAR  
b) FLOAT  
c) INTEGER  
d) STRING  

text[[117, 544, 740, 563]]
3. Some types of constraint require an index. (Choose all that apply).  

text[[147, 571, 319, 682]]
a) CHECK  
b) NOT NULL  
c) PRIMARY KEY  
d) UNIQUE  

text[[117, 717, 822, 736]]
4. Which of the following statements is incorrect about Schema object naming?  

text[[147, 743, 627, 839]]
a) Names can use letters, numbers  
b) Names can use underscore (_), the dollar sign (\$)  
c) Names can use the hash symbol (#)  
d) Names can use the slash (/) and back slash ()

--- Page 40 ---

text[[117, 106, 877, 150]]
5. Constraints inspect data as they're inserted, updated, and deleted to ensure that no business rules are violated.  

text[[147, 158, 230, 202]]
a) True 
b) False  

text[[117, 234, 520, 252]]
6. Which of the following is not a table type?  

text[[146, 260, 333, 354]]
a) Heap Organized  
b) Temporary  
c) Partial  
d) Index organized  

text[[117, 386, 736, 405]]
7. Collection of database objects that are owned by a particular user.  

text[[147, 413, 230, 457]]
a) True 
b) False  

text[[116, 490, 768, 508]]
8. Which of the following character data types is not available in Oracle?  

text[[146, 517, 410, 626]]
a) STRING  
b) VARCHAR2  
c) CHAR  
d) NVARCHAR2 and NCHAR  

text[[117, 661, 880, 705]]
9. When you define a VARCHAR2 column, what are two ways to specify a length. There are two ways to do this: BYTE and CHAR? (Choose the two correct ways).  

text[[146, 714, 291, 825]]
a) BYTE  
b) KILO MEGA  
c) CHAR  
d) KILO GIGA

--- Page 41 ---

text[[117, 106, 654, 124]]
10. What is the incorrect date/time type from the following?  

text[[147, 134, 279, 242]]
a) DATE 
b) TIMESTAMP 
c) TIME 
d) INTERVAL 

text[[117, 278, 405, 296]]
11. Choose the external LOBs?  

text[[146, 305, 241, 407]]
a) BLOB 
b) CLOB 
c) NCLOB 
d) BFILE 

text[[117, 447, 619, 466]]
12. Choose the internal LOBs? (Choose all the options)  

text[[146, 475, 340, 581]]
a) BLOB and CLOB 
b) NCLOB 
c) KCLOB 
d) BFILE 

text[[117, 619, 449, 637]]
13. The Oracle default table type is?  

text[[146, 646, 324, 740]]
a) Heap organized 
b) Partitioned 
c) Index organized 
d) Temporary

--- Page 42 ---

text[[117, 106, 720, 124]]
14. If you do not specify a tablespace, then the table is created in?  

text[[147, 132, 746, 227]]
a) Default Temporary tablespace  
b) Default permanent tablespace of the user that creates the table  
c) Default permanent tablespace of the user SYS  
d) Default Temporary tablespace of the user  

text[[117, 259, 608, 277]]
15. You can only define a virtual column on a regular?  

text[[147, 285, 379, 378]]
a) Index-organized table  
b) Heap-organized table  
c) External table  
d) Temporary table  

text[[117, 412, 777, 431]]
16. Which of the following features is true after you use delete statement?  

text[[147, 439, 546, 533]]
a) Generates undo  
b) Resets the high-water mark to 0  
c) Affected by foreign key constraints  
d) Performs well with large amounts of data  

text[[117, 565, 802, 583]]
17. Which of the following features is false after you use truncate statement?  

text[[147, 591, 546, 686]]
a) Affected by foreign key constraints  
b) Resets the high-water mark to 0  
c) Generates undo  
d) Performs well with large amounts of data  

text[[117, 719, 780, 737]]
18. Virtual columns are not stored on disk; they are evaluated at runtime?  

text[[147, 745, 232, 786]]
a) True  
b) False

--- Page 43 ---

text[[117, 105, 780, 123]]
19. Which combination of the constraint states is syntactically impossible?  

text[[147, 133, 388, 149]]
a) ENABLE VALIDATE  

text[[148, 164, 399, 181]]
b) DISABLE NOVALIDATE  

text[[150, 195, 390, 211]]
c) ENABLE NOVALIDATE  

text[[149, 225, 378, 242]]
d) DISABLE VALIDATE  

text[[148, 256, 377, 273]]
e) DISABLE CREATION  

text[[117, 308, 880, 352]]
20. When you create a primary key constraint, Oracle also creates a unique index with the same name as the constraint?  

text[[148, 360, 226, 377]]
a) True  

text[[149, 385, 230, 402]]
b) False

--- Page 44 ---

table[[184, 127, 803, 683]]
<table><td colspan="2">Quiz answers – chapter 81d, e2d3c, d4d5a6c7a8a9a, c10c11d12a, b13a14b15b16a17c18a19e20a</table>

--- Page 45 ---

sub_title[[119, 108, 260, 126]]
## References:  

sub_title[[117, 142, 182, 158]]
## Books  

text[[147, 167, 883, 339]]
1. Oracle Database Administrator's Guide, 18c (Oracle University), March 2019, Primary Author: Rajesh Bhatiya, Randy Urbano  
2. database-new-features-guide (Oracle University), 18c E88909-01 February 2018, Primary Authors: Tanaya Bhattacharjee, Sunil Surabhi, Mark Baue  
3. The Cloud DBA-Oracle: Managing Oracle Database in the Cloud - First Edition, Abhinivesh Jain and Niraj Mahajan. Apress - ISBN-13 (pbk): 978-1-4842-2634-6 ISBN-13 (electronic): 978-1-4842-2635-3  

sub_title[[117, 370, 217, 386]]
## Web Sites  

text[[147, 395, 817, 516]]
1. https://docs.oracle.com/database  
2. https://docs.oracle.com/en/database/oracle/oracle-database/19/whats-new.html  
3. http://www.oracle.com/technetwork/database/enterprise-edition/downloads/index.html
