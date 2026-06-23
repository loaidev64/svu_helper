--- Page 1 ---

title[[120, 308, 878, 351]]
# Oracle Database Administration  

text[[483, 373, 515, 403]]
I  

text[[135, 455, 861, 484]]
Chapter 10: Data Dictionary Fundamentals

--- Page 2 ---

sub_title[[730, 149, 883, 170]]
محتويات الفصل: 

text[[117, 210, 878, 227]]
Objectives ........................................................................................................................................ 2 

text[[118, 234, 879, 251]]
1. Data Dictionary Architecture ................................................................................................ 3 

text[[139, 259, 880, 276]]
1.1. Static Views ..................................................................................................................... 4 

text[[138, 282, 881, 299]]
1.2. Dynamic Performance Views.......................................................................................... 6 

text[[117, 306, 879, 322]]
2. A Different View of Metadata ................................................................................................ 8 

text[[118, 329, 880, 346]]
3. A Few Creative Uses of the Data Dictionary ........................................................................ 10 

text[[117, 352, 881, 369]]
4. Quiz....................................................................................................................... 17 

text[[117, 375, 879, 392]]
References .......................................................................................................................... 22

--- Page 3 ---

sub_title[[117, 108, 253, 127]]
## Objectives: 

text[[118, 142, 375, 157]]
1. Data Dictionary Contents 

text[[116, 169, 261, 184]]
2. Static Views 

text[[115, 195, 406, 210]]
3. Dynamic Performance Views 

text[[114, 221, 542, 236]]
4. Problem solving using data dictionary views

--- Page 4 ---

sub_title[[119, 108, 493, 128]]
## 1. Data Dictionary Architecture:  

text[[117, 141, 880, 186]]
The Oracle data dictionary is the metadata of the database and contains the names and attributes of all objects in the database.  

text[[118, 194, 298, 211]]
The data dictionary:  

text[[145, 218, 881, 389]]
- Is used by the Oracle Database server to find information about users, objects, constraints, and storage- Is maintained by the Oracle Database server as object structures or definitions are modified- Is available for use by any user to query information about the database- Is owned by the sys user- Should never be modified directly using SQL  

image[[250, 413, 746, 684]]  

text[[115, 712, 883, 857]]
Oracle's data dictionary is vast and robust. Almost every conceivable piece of information about your database is available for retrieval. The data dictionary stores critical information about the physical characteristics of the database, users, objects, and dynamic performance metrics. A senior- level DBA must possess an expert knowledge of the data dictionary. Oracle provides two general categories of read- only data dictionary views:

--- Page 5 ---

text[[147, 106, 883, 252]]
- The contents of your database, such as users, tables, indexes, constraints, and privileges. These are sometimes referred to as the static CDB/DBA/ALL/USER data dictionary views, and they are based on internal tables stored in the SYSTEM tablespace. The term static, in this sense, means that the information within these views only changes as you make changes to your database, such as adding a user, creating a table, or modifying a column.  

text[[147, 259, 883, 405]]
- A real-time view of activity in the database, such as users connected to the database, SQL currently executing, memory usage, locks, and I/O statistics. These views are based on virtual memory tables and are referred to as the dynamic performance views. The information in these views is continuously updated by Oracle as events take place within the database. The views are also sometimes called the V\$ or GV\$ views.  

sub_title[[119, 440, 301, 457]]
### 1.1. Static Views:  

text[[115, 470, 883, 613]]
Oracle refers to a subset of the data dictionary views as static. These views are based on physical tables maintained internally by Oracle. These views are static in the sense that the data they contain do not change at a rapid rate (at least, not compared with the dynamic V\$ and GV\$ views). It is important to understand this architectural when querying the data dictionary. there are four levels that is applicable when using the container/pluggable database feature:  

sub_title[[117, 644, 172, 658]]
## USER  

text[[116, 664, 881, 733]]
The USER views contain information available to the current user. For example, the USER_TABLES view contains information about tables owned by the current user. No special privileges are required to select from the USER- level views.  

sub_title[[117, 764, 158, 778]]
## ALL  

text[[115, 783, 881, 876]]
The ALL views show you all object information the current user has access to. For example, the ALL_TABLES view displays all database tables on which the current user can perform any type of DML operation. No special privileges are required to query from the ALL- level views.

--- Page 6 ---

sub_title[[118, 103, 163, 117]]
## DBA  

text[[116, 123, 881, 193]]
The DBA views contain metadata describing all objects in the database (regardless of ownership or access privilege). To access the DBA views, a DBA role or SELECT_CATALOG_ROLE must be granted to the current user.  

sub_title[[118, 221, 163, 236]]
## CDB  

text[[116, 241, 881, 364]]
The CDB- level views are only applicable if you are using the pluggable database feature. This level provides information about all pluggable databases within a container database (hence the acronym CDB). You will notice that many of the static data dictionary and dynamic performance views have a new column, CON_ID. This column uniquely identifies each pluggable database within a container database.  

text[[116, 368, 881, 437]]
The static views are based on internal Oracle tables, such as USER\$, TAB\$, and IND\$. If you have access to the SYS schema, you can view underlying tables directly via SQL.  

text[[115, 444, 882, 590]]
The data dictionary tables (such as USER\$, TAB\$, IND\$) are created during the execution of the CREATE DATABASE command. As part of creating a database, the sql.bsq file is executed, which builds these internal data dictionary tables. The sql.bsq file is generally located in the ORACLE_HOME/rdbms/admin directory; you can view it via an OS editing utility (such as vi, in Linux/Unix, or Notepad, in Windows).  

text[[118, 572, 636, 590]]
The process of creating the static data dictionary views is:  

image[[116, 618, 887, 824]]

--- Page 7 ---

text[[117, 106, 881, 152]]
You can view the creation scripts of the static views by querying the TEXT column of DBA_VIEWS:  

text[[116, 169, 845, 207]]
SQL> set long 5000 SQL> select text from dba_views where view_name='DBA_VIEWS';  

sub_title[[119, 235, 468, 254]]
### 1.2. Dynamic Performance Views:  

text[[117, 265, 881, 362]]
The dynamic performance data dictionary views are colloquially referred to as the V\\(and GV\)\mathbb{S}\$ views. These views are constantly updated by Oracle and reflect the current condition of the instance and database. Dynamic views are critical for diagnosing real- time performance issues.  

text[[115, 391, 883, 612]]
The V\\(and GV\)\mathbb{S}\$ views are indirectly based on underlying X\$ tables, which are internal memory structures that are instantiated when you start your Oracle instance. Some of the V\\(views are available the moment the Oracle instance is started. For example, V\)\mathbb{P}ARAMETER\(contains meaningful data after the STARTUP NOMOUNT command has been issued, and does not require the database to be mounted or open. Other dynamic views (such as V\$CONTROLFILE) depend on information in the control file and therefore contain significant information only after the database has been mounted. Some V\)\mathbb{S}\$ views (such as V\$BH) provide kernel- processing information and thus have useful results only after the database has been opened.  

text[[115, 620, 881, 791]]
At the top layer, the V\\(views are actually synonyms that point to underlying SYS.V\)\mathbb{S}\$ views. At the next layer down, the SYS.V\$ objects are views created on top of another layer of SYS.V\$ views. The SYS.V\$ views in turn are based on the SYS.GV\$ views. At the bottom layer, the SYS.GV\$ views are based on the X\$ memory structures. The top- level V\$ synonyms and SYS.V\$ views are created when you run the catalog.sql script, which you usually do after the database is initially created. The process of creating the Dynamic performance views is:

--- Page 8 ---

image[[160, 104, 832, 284]]  

text[[114, 309, 883, 534]]
Accessing the V$ views through the topmost synonyms is usually adequate for dynamic performance information needs. On rare occasions, you will want to query internal information that may not be available through the V$ views. If you work with Oracle RAC, you should be familiar with the GVS global views. These views provide global dynamic performance information regarding all instances in a cluster (whereas the V$ views are instance specific). The GVS views contain an INST_ID column for identifying specific instances in a clustered environment. You can display the V$ and GVS view definitions by querying the VIEW_DEFINITION column of the $FIXED_VIEW_DEFINITION view:  

text[[116, 553, 507, 605]]
SQL> select view definition from v$fixed_view_definition where view_name='V$CONTROLFILE';

--- Page 9 ---

sub_title[[119, 108, 498, 128]]
## 2. A Different View of Metadata:  

text[[117, 142, 664, 159]]
DBAs commonly face the following types of database issues:  

text[[147, 168, 880, 443]]
An insert into a table fails because a tablespace cannot extend The database is refusing connections because the maximum number of sessions is exceeded An application is hung, apparently because of some sort of locking issue A PL/SQL statement is failing, with a memory error RMAN backups have not succeeded for two days A user is trying to update a record, but a unique key constraint violation is thrown An SQL statement has been running for hours longer than normal Application users have reported that performance seems sluggish and that something must be wrong with the database  

text[[115, 450, 882, 772]]
if a table cannot extend because a tablespace is full, what knowledge do you rely on to solve this problem? You need to understand that when a database is created, it contains multiple logical space containers called tablespaces. Each tablespace consists of one or more physical data files. Each data file consists of many OS blocks. Each table consists of a segment, and every segment contains one or more extents. As a segment needs space, it allocates additional extents within a physical data file. Once you understand the logical and physical concepts involved, you intuitively look in data dictionary views such as DBA_TABLES, DBA_SEGMENTS, DBA_TABLESPACES, and DBA_DATA_FILES to pinpoint the issue and add space as required. In a wide variety of troubleshooting scenarios, your understanding of the relationships of various logical and physical constructs will allow you to focus on querying views that will help you quickly resolve the problem at hand. The following data dictionary views may very closely to almost all the logical and physical elements of an Oracle database:

--- Page 10 ---

image[[141, 103, 842, 465]]  

text[[117, 494, 881, 562]]
This diagram does provide you with a secure foundation on which to build your understanding of how to leverage the data dictionary views to get the data you need to do your job.  

text[[118, 570, 880, 616]]
Note: There are several thousand CDB/DBA/ALL/USER static views and more than 700 V\$ dynamic performance views.

--- Page 11 ---

sub_title[[117, 108, 674, 128]]
## 3. A Few Creative Uses of the Data Dictionary:  

title[[116, 142, 485, 159]]
# Problem Solving using data dictionary  

text[[115, 167, 881, 237]]
if you are troubleshooting an issue regarding materialized views, and you cannot remember the exact names of the data dictionary views associated with materialized views, you can do this:  

text[[116, 258, 466, 330]]
SQL> select object_name from dba_objects where object_name like '%MV%' and owner='SYS';  

text[[115, 353, 880, 420]]
Often you need more information about each view. This is when the DICTIONARY and DICT_COLUMNS views can be invaluable. The DICTIONARY view stores the names of the data dictionary views. It has two columns:  

text[[116, 442, 360, 488]]
SQL> desc dictionary Name Null?  

text[[117, 491, 241, 519]]
TABLE_NAME COMMENTS  

text[[466, 460, 530, 475]]
Type  

text[[465, 490, 642, 520]]
VARCHAR2(30) VARCHAR2(4000)  

text[[115, 541, 880, 584]]
The previous query that gets the name of views related to materialized view can be written with dictionary:  

text[[116, 606, 510, 658]]
SQL> select table_name, comments from dictionary where table_name like '%MV%';  

text[[118, 686, 330, 701]]
some lines of results  

table[[115, 723, 880, 854]]

<table>TABLE_NAMECOMMENTSDBA_MVIEW_LOGSAll materialized view logs in the databaseDBA_MVIEWSAll materialized views in the databaseDBA_MVIEW_ANALYSIS to dbaDescription of the materialized views accessibleDBA_MVIEW_COMMENTS databaseComments on all materialized views in the</table>

--- Page 12 ---

text[[117, 106, 880, 150]]
If that does not give you enough information regarding the column names, you can query the DICT_COLUMNS view:  

text[[118, 172, 529, 225]]
SQL> select column_name, comments from dict_columns where table_name='DBA_MVIEWS';  

text[[119, 251, 425, 268]]
- Here is a fraction of the output:  

table[[115, 288, 787, 418]]

<table>COLUMN_NAMECOMMENTSOWNEROwner of the materialized viewMVIEW NAMEName of the materialized viewCONTAINER_NAMEName of the materialized view container tableQUERYThe defining query that the materialized viewInstantiates</table>  

sub_title[[119, 444, 386, 461]]
## Displaying User Information  

text[[117, 469, 880, 513]]
You can run the following types of SQL commands to verify the currently connected user and database information:  

table[[118, 533, 759, 606]]

<table>SQL&gt; show user;<br>SQL&gt; select * from user_users;<br>SQL&gt; select name from v$database;<br>SQL&gt; select instance_name, host_name from v$instance;</table>  

text[[117, 628, 880, 672]]
You can also use the SYS_CONTEXT built- in SQL function to extract information from the data dictionary regarding details about your currently connected session:  

text[[118, 694, 801, 784]]
SQL > select sys_context('USERENV','CURRENT_USER') usr ,sys_context('USERENV','AUTHENTICATION_METHOD') auth_mth ,sys_context('USERENV','HOST') host ,sys_context('USERENV','INSTANCE_NAME') inst from dual;

--- Page 13 ---

text[[114, 106, 656, 123]]
Useful USERENV Parameters Available with SYS_CONTEXT: 

table[[100, 125, 895, 878]]
<table>Parameter NameDescriptionAUTHENTICATED_IDENTITYIdentity used in authenticationAUTHENTICATION_METHODMethod of authenticationCDB_NAMEReturns the name of the CDB; otherwise returns nullCLIENT_IDENTIFIERReturns an identifier that is set by the applicationCLIENT_INFOUser session informationCON_IDContainer identifierCON_NAMEContainer nameCURRENT_USERUsername for the currently active sessionDB_NAMEName specified by the DB_NAME initialization parameterDB_UNIQUE_NAMEName specified by the DB_UNIQUE_NAME initialization parameterHOSTHOST Hostname for the machine on which the client initiated the database connectionINSTANCE_NAMEInstance nameIP_ADDRESS IPIP address of the machine on which the client initiated the database connectionISDBATRUE if the user authenticated with DBA privileges through the OS or password file</table>

--- Page 14 ---

table[[102, 103, 895, 415]]

<table>NLS_DATE_FORMATDate format for the sessionOS_USEROS user from the machine on which the client initiated the database connectionSERVER_HOSTHostname of the machine on which the database instance is runningSERVICE_NAMEService name for the connectionSIDSession identifierTERMINALOS identifier for the client terminal</table>  

sub_title[[114, 444, 400, 462]]
## Displaying Table Row Counts  

text[[113, 469, 882, 565]]
If you have accurate statistics, you can query the NUM_ROWS column of the CDB/DBA/ALL/USER_TABLES views. This column normally has a close row count if statistics are generated on a regular basis. The following query selects NUM_ROWS from the USER_TABLES view:  

text[[113, 581, 715, 599]]
SQL> select table_name, num_rows from user_tables;  

text[[114, 618, 882, 663]]
if you have partitioned tables and want to show row counts by partition, use the next few lines of SQL and PL/SQL code to generate the SQL required:  

text[[113, 683, 885, 884]]
SQL> UNDEFINE user SQL> SET SERVEROUT ON SIZE 1000000 VERIFY OFF SQL> SPO part_count_&user..txt SQL> DECLARE counter NUMBER; sql_stmt VARCHAR2(1000); CURSOR c1 IS SELECT table_name, partition_name FROM dba_tab_partitions WHERE table_owner = UPPER('&user'); BEGIN FOR r1 IN c1 LOOP

--- Page 15 ---

text[[117, 100, 865, 268]]
sql_stmt := 'SELECT COUNT(*) FROM &user..' || rl.table_name||' PARTITION (''||rl.partition_name||')'; EXECUTE IMMEDIATE sql_stmt INTO counter; DBMS_OUTPUT.PUT_LINE(RPAD(rl.table_name ||'(r|rl.partition_name||'),30) ||'||TO_CHAR(counter)); END LOOP; END; / SPO OFF  

text[[117, 291, 787, 310]]
You can generate statistics for all objects for a user with the following code:  

text[[116, 330, 879, 424]]
SQL> exec dbms_stats.gather_schema_stats(ownname => 'MV_MAINT', - estimate_percent => DBMS_STATS.AUTO_SAMPLE_SIZE,- degree => DBMS_STATS.AUTO_DEGREE, - cascade => true);  

text[[116, 447, 881, 566]]
The prior code instructs Oracle to estimate the percentage of the table to be sampled with the ESTIMATE_PERCENT parameter, using DBMS_STATS.AUTO_SAMPLE_SIZE. Oracle also chooses the appropriate degree of parallelism with the DEGREE parameter setting of DBMS_STATS.AUTO_DEGREE. The CASCADE parameter instructs Oracle to generate statistics for indexes.  

sub_title[[118, 599, 625, 619]]
## Showing Primary Key and Foreign Key Relationships  

text[[117, 624, 881, 720]]
It is useful to display data dictionary information regarding what primary key constraint is associated with a foreign key constraint. The following script queries the DBA_CONSTRAINTS data dictionary view to determine the parent primary key constraints that are related to child foreign key constraints:  

text[[117, 742, 825, 887]]
SQL> select a.constraint_type cons_type,a.table_name child_table ,a.constraint_name child_cons,b.table_name parent_table ,b.constraint_name parent_cons,b.constraint_type cons_type from dba_constraints a,dba_constraints b where a.owner \(=\) upper('&owner') and a.table_name \(=\) upper('&table_name') and a.constraint_type \(=\) 'R'

--- Page 16 ---

text[[117, 103, 646, 140]]
and a.r_owner = b.owner and a.r_constraint_name = b.constraint_name;  

text[[116, 145, 871, 189]]
The preceding script prompts you for two SQL\*Plus ampersand variables (OWNER, TABLE_NAME);  

text[[117, 208, 877, 278]]
When the CONSTRAINT_TYPE column (of DBA/ALL/USER_CONSTRAINTS) contains an R value, this indicates that the row describes a referential integrity constraint, which means that the child table constraint references a primary key constraint.  

text[[117, 283, 877, 354]]
The next script takes the primary key record and looks to see if it has any child records with a constraint type of R. When you run this script, you are prompted for the primary key table owner and name:  

text[[116, 374, 876, 542]]
SQL> select b.table_name primary_key_table, a.table_name fk_child_table ,a.constraint_name fk_child_table_constraint from dba_constraints a, dba_constraints b where a.r_constraint_name = b.constraint_name and a.r_owner = b.owner and a.constraint_type = 'R' and b.owner = upper('&table_owner') and b.table_name = upper('&table_name');  

sub_title[[119, 563, 429, 581]]
## Displaying Object Dependencies  

text[[117, 588, 877, 707]]
Say you need to drop a table, but before you drop it, you want to display any objects that are dependent on it. Before making the change, you want to review what other objects are dependent on the table. You can use the DBA_DEPENDENCIES data dictionary view to display object dependencies. The following query prompts you for a username and an object name:  

text[[117, 729, 876, 895]]
SQL> select '+|||lpad('','level+2)||type||'||owner|| '.'||name dep_tree from dba_dependencies connect by prior owner = referenced_owner and prior name = referenced_name and prior type = referenced_type start with referenced_owner = upper('&object_owner') and referenced_name = upper('&object_name') and owner is not null;

--- Page 17 ---

sub_title[[118, 106, 270, 123]]
## The DUAL table  

text[[116, 131, 881, 227]]
The DUAL table is part of the data dictionary. This table contains one row and one column and is useful when you want to return exactly one row, and you do not have to retrieve data from a particular table. In other words, you just want to return a value. For example, you can perform arithmetic operations, as follows:  

text[[116, 246, 469, 320]]
SQL> select \(34*\) .15 from dual; \(34*\) .15  

text[[118, 304, 157, 317]]
5.1  

text[[117, 343, 881, 388]]
Other common uses are selecting from DUAL to show the current date or to display some text within an SQL script.

--- Page 18 ---

sub_title[[118, 108, 216, 127]]
## 4. Quiz:  

text[[117, 141, 656, 159]]
1. Which of these statements about data dictionary is false?  

text[[146, 167, 881, 313]]
a) The data dictionary stores critical information about the physical characteristics of the database  
b) The data dictionary stores critical information about the users  
c) The data dictionary stores critical information about the objects  
d) The data dictionary stores critical information about the operating system hotspots  

text[[117, 344, 880, 390]]
2. Is used by the Oracle Database server to find information about users, objects, constraints, and storage  

text[[146, 397, 343, 492]]
a) System privileges.  
b) Roles  
c) Object privileges  
d) Data dictionary  

text[[117, 523, 881, 569]]
3. Which of these statements is incorrect regarding Data Dictionary? (Choose the best answer).  

text[[146, 575, 817, 671]]
a) Is available for use by any user to query information about the database  
b) Is owned by the SYS user  
c) Should be modified directly using SQL  
d) Should never be modified directly using SQL  

text[[117, 701, 881, 747]]
4. Static views of data dictionary will have information about Changes to your database, such as:  

text[[146, 754, 395, 849]]
a) SQL currently executing  
b) Adding a user  
c) Memory usage  
d) Locks

--- Page 19 ---

text[[117, 106, 880, 150]]
5. The data dictionary stores critical information about the physical characteristics of the database, users, objects, and dynamic performance metrics.a) Trueb) False  

text[[147, 158, 235, 176]]
a) True  

text[[148, 185, 230, 202]]
b) False  

text[[117, 234, 880, 278]]
6. Dynamic performance Views of data dictionary will have information about Changes to your database, such as:  

text[[147, 285, 354, 378]]
a) Adding a user 
b) Memory usage 
c) Creating a table 
d) Modifying a column  

text[[117, 412, 725, 431]]
7. Dynamic performance Views of data dictionary sometimes called:  

text[[147, 440, 374, 534]]
a) The USER_Viewsb) The V$ or GV\$ Viewsc) The DBA_Viewsd) The All_Views  

text[[117, 566, 580, 584]]
8. Static Views of data dictionary sometimes called:  

text[[147, 593, 488, 687]]
a) The V\$ Viewsb) The GV\$ Viewsc) The USER/ALL/DBA/CDB_Viewsd) The V_$ Views  

text[[117, 709, 877, 752]]
9. USER_TABLES view contains information about tables owned by the current user, is it?  

text[[147, 761, 488, 855]]
a) From Static Viewsb) From Dynamic Performance Viewsc) From Bothd) Doesn't belong to Data Dictionary

--- Page 20 ---

text[[117, 106, 878, 149]]
10. ALL_TABLES view contains information about tables accessed by the current user, is it?  

text[[147, 158, 490, 255]]
a) From Dynamic Performance Views  
b) From Static Views  
c) From Both  
d) Doesn't belong to Data Dictionary  

text[[117, 284, 855, 304]]
11. DBA_TABLES view contains information about all tables of the database, is it?  

text[[147, 311, 490, 406]]
a) From Dynamic Performance Views  
b) From Both  
c) From Static Views  
d) Doesn't belong to Data Dictionary  

text[[117, 439, 880, 482]]
12. CDB_TABLES view contains information about all tables of the pluggable database, is it?  

text[[147, 490, 488, 584]]
a) From Dynamic Performance Views  
b) From Both  
c) Doesn't belong to Data Dictionary  
d) From Static Views  

text[[117, 616, 880, 660]]
13. V\Parameter view contains information about the initialization parameters that are currently in effect for the session, is it?  

text[[147, 667, 488, 761]]
a) From Dynamic Performance Views  
b) From Both  
c) Doesn't belong to Data Dictionary  
d) From Static Views

--- Page 21 ---

text[[117, 106, 786, 125]]
14. To access the DBA views, the current user must be granted the roles?  

text[[147, 133, 538, 230]]
a) A CONNECT role and RESOURCE role  
b) A DBA role or SELECT_CATALOG_ROLE  
c) A CONNECT role or RESOURCE role  
d) A AUDIT_ADMIN and AQ_USER_ROLE  

text[[117, 259, 789, 278]]
15. What is the View that contains the names of the data dictionary views?  

text[[147, 287, 351, 377]]
a) DICTIONARY  
b) DBA_MVIEW_LOGS  
c) V\$PARAMETER  
d) V\$LOCK  

text[[117, 409, 879, 454]]
16. What is the View that contains the names of the data dictionary views and their column names?  

text[[147, 463, 323, 549]]
a) DICTIONARY  
b) DICT_COLUMNS  
c) V\$PARAMETER  
d) V\$LOCK  

text[[117, 577, 692, 596]]
17. Why do you use the SYS_CONTEXT built-in SQL function?  

text[[147, 603, 879, 725]]
a) To extract information from the data dictionary regarding Memory structures  
b) To extract information from the data dictionary regarding database files  
c) To extract information from the data dictionary regarding details about your currently connected session  
d) To extract general information from the data dictionary  

text[[117, 754, 730, 773]]
18. You can use the DBA_DEPENDENCIES data dictionary view to:  

text[[147, 781, 439, 875]]
a) Display SYSTEM object only  
b) Display SYS object only  
c) Display constraint references  
d) Display object dependencies

--- Page 22 ---

text[[117, 107, 620, 125]]
19. The DUAL table is not a part of the data dictionary?  

text[[147, 134, 226, 151]]
a) True  

text[[148, 160, 230, 177]]
b) False  

text[[117, 208, 870, 253]]
20. The data dictionary tables (such as USER#, TAB$, IND$) are created during the execution of the CREATE DATABASE command?  

text[[148, 260, 226, 278]]
a) True  

text[[149, 286, 230, 303]]
b) False  

table[[181, 336, 806, 890]]

<table><td colspan="2">Quiz answers – chapter 101d2d3c4b5a6b7b8c9a10b11c12d13a14b15a16b17c18d19b20a</table>

--- Page 23 ---

sub_title[[119, 108, 260, 126]]
## References:  

sub_title[[117, 142, 182, 158]]
## Books  

text[[146, 166, 884, 338]]
1. Oracle Database Administrator's Guide, 18c (Oracle University), March 2019, Primary Author: Rajesh Bhatiya, Randy Urbano  
2. database-new-features-guide (Oracle University), 18c E88909-01 February 2018, Primary Authors: Tanaya Bhattacharjee, Sunil Surabhi, Mark Baue  
3. The Cloud DBA-Oracle: Managing Oracle Database in the Cloud - First Edition, Abhinivesh Jain and Niraj Mahajan. Apress - ISBN-13 (pbk): 978-1-4842-2634-6 ISBN-13 (electronic): 978-1-4842-2635-3  

sub_title[[117, 370, 217, 386]]
## Web Sites  

text[[147, 395, 796, 516]]
1. https://docs.oracle.com/database  
2. https://docs.oracle.com/en/database/oracle/oracle-database/19/whats-new.html  
3. http://www.oracle.com/technetwork/database/enterprise-edition/downloads/index.html
