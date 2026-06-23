--- Page 1 ---

title[[120, 308, 878, 351]]
# Oracle Database Administration  

text[[484, 373, 514, 403]]
I  

text[[174, 454, 821, 526]]
Chapter 12: Moving Data: Data Pump, SQL\*Loader

--- Page 2 ---

sub_title[[733, 148, 887, 170]]
## :  

text[[117, 207, 881, 825]]
Objectives .2 1. ways to move data and Data Pump Architecture.. 3 1.1. Moving Data: General Architecture. 3 1.2. Oracle Data Pump: Overview .. 4 1.3. Oracle Data Pump: Benefits ... 5 1.4. Directory Objects for Data Pump... .6 1.5. Creating Directory Objects. 7 2. Taking an Export/Import.. 8 2.1. Data Pump Export and Import Clients: Overview. 8 2.2. Data Pump Utility: Interfaces and Modes .. 9 2.3. Performing a Data Pump Export... .10 2.4. Performing a Data Pump Import ... 11 2.5. Data Pump Import: Transformations.. 12 3. Use SQL\\*Loader to load data from a non- Oracle database. 13 3.1. SQL\\*Loader: Overview. 13 3.2. SQL\\*Loader Control File... .15 3.3. Comparing Direct and Conventional Path Loads .. 17 3.4. Performing SQL\\*Loader for one table export/import using Toad for Oracle ... 18 4. Unloading and Loading Data Using an External Table.. 26 4.1. External Table: overview... .26 4.2. External Table: Benefits. 27 4.3. Defining an External Tables with ORACLE_LOADER ..28 4.4. External Table Population with ORACLE_DATAPUMP. 29 4.5. Using External Tables.. 30 5. Data Dictionary Views... .31 6. Quiz... .32 References. .37

--- Page 3 ---

sub_title[[117, 108, 253, 127]]
## Objectives:  

text[[149, 140, 660, 235]]
1. Data Pump Architecture  
2. Exporting and Importing with Granularity  
3. Use SQL\*Loader to load data  
4. Unloading and Loading Data Using an External Table

--- Page 4 ---

sub_title[[119, 108, 724, 128]]
## 1. ways to move data and Data Pump Architecture:  

title[[117, 142, 528, 160]]
#### 1.1. Moving Data: General Architecture:  

text[[116, 172, 880, 215]]
You can find in the following figure major functional components involved in moving data:  

image[[154, 243, 840, 540]]  

sub_title[[117, 568, 307, 586]]
## DBMS_DATAPUMP:  

text[[116, 594, 880, 637]]
Contains the API for high- speed export and import utilities for bulk data and metadata movement.  

sub_title[[117, 670, 353, 688]]
## Direct Path API (DPAPI):  

text[[116, 695, 879, 739]]
Oracle Database supports a Direct Path API interface that minimizes data conversion and parsing at both unload and load time.  

sub_title[[117, 773, 305, 790]]
## DBMS_METADATA:  

text[[116, 799, 879, 842]]
Used by worker processes for all metadata unloading and loading. Database object definitions are stored using XML rather than SQL.

--- Page 5 ---

text[[117, 106, 884, 202]]
External Table API: With the ORACLE_DATAPUMP and ORACLE_LOADER access drivers, you can store data in external tables (that is, in platform- independent files). The SELECT statement reads external tables as though they were stored in an Oracle database.  

text[[117, 234, 881, 279]]
SQL\*Loader: Has been integrated with external tables, providing automatic migration of loader control files to external table access parameters  

text[[118, 311, 882, 355]]
expdp and impdp: Thin layers that make calls to the DBMS_DATAPUMP package to initiate and monitor Data Pump operations.  

text[[117, 387, 881, 458]]
Other clients: Applications (such as replication, transportable tablespaces, and user applications) that benefit from this infrastructure. SQL\*Plus may also be used as a client of DBMS_DATAPUMP for simple status queries against ongoing operations.  

sub_title[[120, 490, 469, 508]]
### 1.2. Oracle Data Pump: Overview:  

text[[117, 520, 881, 564]]
As a server- based facility for high- speed data and metadata movement, Oracle Data Pump:  

text[[147, 573, 464, 590]]
Is callable via DBMS_DATAPUMP  

text[[148, 599, 430, 616]]
Provides the following tools:  

text[[185, 622, 276, 656]]
expdp impdp  

text[[184, 663, 807, 681]]
GUI interface in Enterprise Manager Cloud Control/Toad for Oracle  

text[[147, 693, 530, 709]]
Provides four data movement methods:  

text[[185, 718, 369, 810]]
Data file copying Direct path External tables Network link support  

text[[146, 820, 649, 837]]
Detaches from and re- attaches to long- running jobs  

text[[147, 847, 403, 863]]
Restarts Data Pump jobs

--- Page 6 ---

text[[114, 105, 881, 251]]
Data Pump is often described as an upgraded version of the old exp/imp utilities. Oracle Data Pump enables very high- speed data and metadata loading and unloading of Oracle databases. The Data Pump infrastructure is callable via the DBMS_DATAPUMP/DBMS_METADATA PL/SQL packages. Thus, custom data movement utilities can be built by using Data Pump. Oracle Database provides the following tools:  

text[[146, 259, 881, 327]]
- Command-line export and import clients called expdp and impdp, respectively 
- Export and import interface in Enterprise Manager Cloud Control/Toad for Oracle  

text[[114, 335, 882, 582]]
Data Pump automatically decides the data access methods to use; these can be either direct path or external tables. Data Pump uses direct path load and unload when a table's structure allows it and when maximum single- stream performance is desired. However, if there are clustered tables, referential integrity constraints, encrypted columns, or several other items, Data Pump uses external tables rather than direct path to move the data. The ability to detach from and re- attach to long- running jobs without affecting the job itself enables you to monitor jobs from multiple locations while they are running. All stopped Data Pump jobs can be restarted without loss of data as long as the metainformation remains undisturbed. It does not matter whether the job is stopped voluntarily or involuntarily due to a crash.  

sub_title[[119, 616, 459, 634]]
### 1.3. Oracle Data Pump: Benefits:  

text[[116, 647, 668, 665]]
Data Pump offers many benefits and many features, such as:  

text[[146, 673, 617, 869]]
- Fine-grained object and data selection 
- Explicit specification of database version 
- Parallel execution 
- Estimation of export job space consumption 
- Network mode in a distributed environment 
- Remapping capabilities 
- Data sampling and metadata compression 
- Compression of data during a Data Pump export

--- Page 7 ---

text[[147, 106, 634, 177]]
- Security through encryption  
- Ability to export XML Type data as CLOBs  
- Legacy mode to support old import and export files  

text[[117, 208, 881, 252]]
The EXCLUDE, INCLUDE, and CONTENT parameters are used for fine- grained object and data selection.  

text[[115, 259, 882, 330]]
You can specify the database version for objects to be moved (using the VERSION parameter) to create a dump file set that is compatible with a previous release of Oracle Database that supports Data Pump.  

text[[117, 336, 881, 380]]
You can use the PARALLEL parameter to specify the maximum number of threads of active execution servers operating on behalf of the export job.  

text[[115, 387, 880, 431]]
You can estimate how much space an export job would consume (without actually performing the export) by using the ESTIMATE_ONLY parameter.  

text[[117, 437, 881, 482]]
Network mode enables you to export from a remote database directly to a dump file set. This can be done by using a database link to the source system.  

text[[115, 488, 882, 658]]
During import, you can change the target data file names, schemas, and tablespaces. In addition, you can specify a percentage of data to be sampled and unloaded from the source database when performing a Data Pump export. This can be done by specifying the SAMPLE parameter. You can use the COMPRESSION parameter to indicate whether the metadata should be compressed in the export dump file so that it consumes less disk space. If you compress the metadata, it is automatically uncompressed during import.  

sub_title[[119, 693, 509, 712]]
### 1.4. Directory Objects for Data Pump:  

text[[115, 724, 882, 869]]
Directory objects are logical structures that represent a physical directory on the server's file system. They contain the location of a specific operating system directory. This directory object name can be used in Enterprise Manager/Toad for Oracle so that you do not need to hard- code directory path specifications. This provides greater flexibility for file management. Directory objects are owned by the SYS user. Directory names are unique across the database because all the directories are located in a

--- Page 8 ---

text[[117, 106, 881, 175]]
single name space (that is, SYS). Directory objects are required when you specify file locations for Data Pump because it accesses files on the server rather than on the client.  

text[[118, 183, 880, 227]]
In Enterprise Manager Cloud Control, select Schema > Database Objects > Directory Objects.  

text[[117, 234, 878, 253]]
To edit or delete a directory object, select the object and click the appropriate button.  

sub_title[[120, 285, 448, 304]]
### 1.5. Creating Directory Objects:  

text[[117, 310, 865, 366]]
CREATE DIRECTORY "EXT_TAB_LOGDIR" AS 'C:\Oracle\labs\extab1'; GRANT READ O DIRECTORY "EXT_TAB_LOGDIR" TO "HR"; GRANT WRITEO DIRECTORY "EXT_TAB_LOGDIR" TO "HR";  

text[[150, 388, 567, 407]]
1. On the Directory Objects page, click Create.  

text[[148, 414, 881, 511]]
2. Enter the name of the directory object and the OS path to which it maps. OS directories should be created before they are used. You can test this by clicking Test File System. For the test, provide the host login credentials (the OS user who has privileges on this OS directory).  

text[[148, 517, 881, 636]]
3. Permissions for directory objects are not the same as OS permissions on the physical directory on the server file system. You can manage user privileges on individual directory objects. This increases the level of security and gives you granular control over these objects. On the Privileges page, click Add to select the user to which you give read or write privileges (or both).  

text[[148, 642, 878, 660]]
4. Click Show SQL to view the underlying statements. Click Return when finished.  

text[[149, 668, 439, 685]]
5. Click OK to create the object.

--- Page 9 ---

sub_title[[117, 108, 446, 129]]
## 2. Taking an Export/Import:  

title[[116, 142, 668, 160]]
#### 2.1. Data Pump Export and Import Clients: Overview:  

text[[115, 173, 881, 242]]
Data Pump Export is a utility for unloading data and metadata into a set of operating system files called dump file sets. Data Pump Import is used to load metadata and data stored in an export dump file set into a target system.  

image[[158, 270, 835, 601]]  

text[[115, 628, 881, 749]]
The Data Pump API accesses its files on the server rather than on the client. These utilities can also be used to export from a remote database directly to a dump file set, or to load the target database directly from a source database with no intervening files. This is known as network mode. This mode is particularly useful to export data from a read- only source database.  

text[[115, 757, 881, 851]]
At the center of every Data Pump operation is the master table (MT), which is a table created in the schema of the user running the Data Pump job. The MT maintains all aspects of the job. The MT is built during a file- based export job and is written to the dump file set as the last step. Conversely, loading the MT into the current user's

--- Page 10 ---

text[[117, 105, 881, 150]]
schema is the first step of a file- based import operation and is used to sequence the creation of all objects imported.  

text[[115, 156, 883, 227]]
Note: The MT is the key to Data Pump's restart capability in the event of a planned or unplanned stopping of the job. The MT is dropped when the Data Pump job finishes normally.  

sub_title[[117, 260, 586, 280]]
### 2.2. Data Pump Utility: Interfaces and Modes:  

text[[146, 291, 540, 309]]
- Data Pump Export and Import interfaces:  

text[[176, 316, 663, 411]]
- Command line  
- Parameter file  
- Interactive command line  
- Enterprise Manager Cloud Control/Toad for Oracle  

text[[146, 419, 519, 436]]
- Data Pump Export and Import modes:  

text[[176, 444, 432, 588]]
- Full  
- Schema  
- Table  
- Tablespace  
- Transportable tablespace  
- Transportable database  

text[[117, 622, 880, 666]]
You can interact with Data Pump Export and Import by using one of the following interfaces:  

text[[146, 674, 881, 869]]
- Command-line interface: Enables you to specify most of the export parameters directly on the command line  
- Parameter file interface: Enables you to specify all command–line parameters in a parameter file. The only exception is the PARFILE parameter.  
- Interactive–command interface: Stops logging to the terminal and displays the export or import prompts, where you can enter various commands. This mode is enabled by pressing Ctrl + C during an export operation that is started with the command–line interface or the parameter file interface. Interactive–

--- Page 11 ---

text[[174, 106, 876, 150]]
command mode is also enabled when you attach to an executing or stopped job.  

text[[142, 158, 875, 202]]
- GUI interface: Select Schema > Database Export/Import. In the menu, select the export or import operation you want to execute.  

text[[113, 209, 878, 305]]
Data Pump Export and Import provide different modes for unloading and loading different portions of the database. The mode is specified on the command line by using the appropriate parameter. The available modes are listed in the slide and are the same as in the original export and import utilities.  

sub_title[[114, 337, 502, 355]]
### 2.3. Performing a Data Pump Export:  

text[[113, 366, 878, 438]]
You can make a Data Pump export by Using Enterprise Manager Cloud Control or Toad for Oracle. The former provides a wizard to guide you through the process of performing a Data Pump export and import procedure  

sub_title[[114, 472, 207, 487]]
## Example:  

text[[113, 496, 603, 513]]
The example in the figure shows a Data Pump export.  

image[[154, 543, 832, 888]]

--- Page 12 ---

text[[116, 105, 882, 225]]
From the Database home page, expand the Schema menu, select Database Export/Import, and then select Export to Export Files to begin a Data Pump export session. The next window that appears enables the selection of export type. If a privileged user is connected to the database instance, the export types include the following:  

text[[147, 234, 269, 327]]
- Database- Schemas- Tables- Tablespace  

text[[116, 335, 876, 353]]
If a non- administrative account is used, the export type list is limited to the following:  

text[[147, 361, 266, 402]]
Schemas- Tables  

text[[117, 412, 494, 429]]
Click Continue to proceed with the export.  

sub_title[[118, 465, 500, 483]]
### 2.4. Performing a Data Pump Import:  

text[[116, 495, 882, 563]]
Oracle Database also includes Data Pump command- line clients for import and export operations. There are some parameters that are available only by using the command- line interface. For a complete list of options, refer to Oracle Database Utilities.  

text[[117, 596, 808, 615]]
The following example illustrates a Data Pump import using the impdp utility.  

text[[116, 636, 691, 782]]
\$ impdp hr DIRECTORY=DATA_PUMP_DIR \ DUMPFILE=HR_SCHEMA.DMP \ PARALLEL=1 \ CONTENT=ALL \ TABLES="EMPLOYEES" \ LOGFILE=DATA_PUMP_DIR:import_hr_employees.log \ JOB_NAME=importHR \ TRANSFORM=STORAGE:n

--- Page 13 ---

sub_title[[117, 106, 541, 125]]
### 2.5. Data Pump Import: Transformations:  

text[[118, 138, 258, 154]]
You can remap  

text[[147, 163, 574, 284]]
Data files by using REMAP_DATAFILE Tablespaces by using REMAP_TABLESPACE Schemas by using REMAP_SCHEMA Tables by using REMAP_TABLE Data by using REMAP_DATA  

sub_title[[118, 305, 204, 322]]
## Example:  

text[[117, 341, 493, 358]]
REMAP_TABLE = 'EMPLOYEES': 'EMP'  

text[[116, 387, 881, 458]]
Because object metadata is stored as XML in the dump file set, it is easy to apply transformations when DDL is being formed during import. Data Pump Import supports several transformations:  

text[[146, 467, 883, 663]]
REMAP_DATAFILE is useful when moving databases across platforms that have different file- system semantics REMAP_TABLESPACE enables objects to be moved from one tablespace to another REMAP_SCHEMA provides the old FROMUSER /TOUSER capability to change object ownership REMAP_TABLE provides the ability to rename entire tables REMAP_DATA provides the ability to remap data as it is being inserted

--- Page 14 ---

sub_title[[116, 108, 848, 128]]
## 3. Use SQL\*Loader to load data from a non-Oracle database:  

title[[117, 142, 410, 159]]
#### 3.1. SQL\*Loader: Overview:  

text[[114, 172, 884, 268]]
SQL\*Loader loads data from external files into tables of an Oracle database. It has a powerful data parsing engine that puts little limitation on the format of the data in the data file. SQL\*Loader uses the files illustrated in the figure (please click on the markers on the figure for more information)  

image[[150, 293, 831, 650]]  

sub_title[[116, 684, 263, 700]]
## Input data files  

text[[114, 708, 882, 854]]
SQL\*Loader reads data from one or more files (or operating system equivalents of files) that are specified in the control file. From SQL\*Loader's perspective, the data in the data file is organized as records. A particular data file can be in fixed record format, variable record format, or stream record format. The record format can be specified in the control file with the INFILE parameter. If no record format is specified, the default is stream record format.

--- Page 15 ---

sub_title[[118, 107, 230, 123]]
## Control file  

text[[117, 131, 881, 227]]
The control file is a text file that is written in a language that SQL\\*Loader understands. The control file indicates to SQL\\*Loader where to find the data, how to parse and interpret the data, where to insert the data, and so on. Although not precisely defined, a control file can be said to have three sections.  

text[[146, 234, 825, 252]]
The first section contains such session- wide information as the following:  

text[[176, 259, 878, 307]]
Global options, such as the input data file name and records to be skipped INFILE clauses to specify where the input data is located  

text[[177, 313, 380, 328]]
Data to be loaded  

text[[146, 337, 881, 434]]
The second section consists of one or more INTO TABLE blocks. Each of these blocks contains information about the table (such as the table name and the columns of the table) into which the data is to be loaded The third section is optional and, if present, contains input data  

text[[146, 454, 196, 470]]
Log file  

text[[117, 489, 881, 558]]
When SQL\\*Loader begins execution, it creates a log file. If it cannot create a log file, execution terminates. The log file contains a detailed summary of the load, including a description of any errors that occurred during the load.  

text[[117, 589, 881, 737]]
Bad file: The bad file contains records that are rejected, either by SQL\\*Loader or by the Oracle database. Data file records are rejected by SQL\\*Loader when the input format is invalid. After a data file record is accepted for processing by SQL\\*Loader, it is sent to the Oracle database for insertion into a table as a row. If the Oracle database determines that the row is valid, the row is inserted into the table. If the row is determined to be invalid, the record is rejected and SQL\\*Loader puts it in the bad file.  

text[[117, 770, 881, 888]]
Discard file: This file is created only when it is needed and only if you have specified that a discard file should be enabled. The discard file contains records that are filtered out of the load because they do not match any record- selection criteria specified in the control file. For more information about SQL\\*Loader, see the Oracle Database Utilities guide.

--- Page 16 ---

sub_title[[118, 107, 432, 126]]
### 3.2. SQL\\*Loader Control File:  

text[[117, 138, 634, 156]]
The SQL\\*Loader control file instructs SQL\\*Loader about:  

text[[147, 164, 496, 337]]
- Location of the data to be loaded- Data format- Configuration details:- Memory management- Record rejection- Interrupted load handling details- Data manipulation details  

text[[117, 366, 880, 410]]
The SQL\\*Loader control file is a text file that contains data definition language (DDL) instructions. DDL is used to control the following aspects of a SQL\\*Loader session:  

text[[147, 418, 881, 563]]
- Where SQL\\*Loader finds the data to load- How SQL\\*Loader expects that data to be formatted- How SQL\\*Loader is being configured (including memory management, selection and rejection criteria, interrupted load handling, and so on) as it loads the data- How SQL\\*Loader manipulates the data being loaded  

text[[147, 590, 570, 879]]
1. -- This is a sample control file 
2. LOAD DATA 
3. INFILE 'SAMPLE.DAT' 
4. BADFILE 'sample.bad' 
5. DISCARD FILE 'sample.dsc' 
6. APPEND 
7. INTO TABLE emp 
8. WHEN (57) = '.'. 
9. TRAILING NULLCOLS 
10. (hiredate SYSDATE, deptno POSITION(1:2) INTEGER EXTERNAL(3) NULLIF deptno=BLANKS, job POSITION(7:14) CHAR TERMINATED BY WHITESPACE NULLIF job=BLANKS "UPPER(:job)",

--- Page 17 ---

text[[176, 101, 880, 288]]
mgr POSITION(28:31) INTEGER EXTERNAL TERMINATED BY WHITESPACE, NULLIF mgr=BLANKS, ename POSITION(34:41) CHAR TERMINATED BY WHITESPACE "UPPER(:ename)", empno POSITION(45) INTEGER EXTERNAL TERMINATED BY WHITESPACE, sal POSITION(51) CHAR TERMINATED BY WHITESPACE "TO_NUMBER(:sal,'\\$99,999.99')", comm INTEGER EXTERNAL ENCLOSED BY '(' AND '%'":comm \* 100")  

text[[117, 308, 775, 327]]
The explanation of this sample control file (by line numbers) is as follows:  

text[[116, 333, 881, 863]]
1. Comments can appear anywhere in the command section of the file, but they must not appear in the data. Precede any comment with two hyphens. All text to the right of the double hyphen is ignored until the end of the line.  
2. The LOAD DATA statement indicates to SQL\*Loader that this is the beginning of a new data load. If you are continuing a load that has been interrupted in progress, use the CONTINUE LOAD DATA statement.  
3. The INFILE keyword specifies the name of a data file containing data that you want to load.  
4. The BADFILE keyword specifies the name of a file into which rejected records are placed.  
5. The DISCARDFILE keyword specifies the name of a file into which discarded records are placed.  
6. The APPEND keyword is one of the options that you can use when loading data into a table that is not empty. To load data into a table that is empty, use the INSERT keyword.  
7. The INTO TABLE keyword enables you to identify tables, fields, and data types. It defines the relationship between records in the data file and tables in the database.  
8. The WHEN clause specifies one or more field conditions that each record must match before SQL\*Loader loads the data. In this example, SQL\*Loader loads the record only if the 57th character is a decimal point. That decimal point delimits

--- Page 18 ---

text[[147, 106, 871, 149]]
dollars and cents in the field and causes records to be rejected if SAL has no value.  

text[[117, 158, 870, 202]]
9. The TRAILING NULLCOLS clause prompts SQL\*Loader to treat any relatively positioned columns that are not present in the record as null columns.  

text[[118, 209, 871, 253]]
10. The remainder of the control file contains the field list, which provides information about column formats in the table that is being loaded.  

sub_title[[117, 286, 664, 305]]
### 3.3. Comparing Direct and Conventional Path Loads:  

image[[115, 338, 912, 450]]  

table[[86, 475, 893, 814]]

<table>Conventional LoadDirect Path LoadUses COMMITUses data saves (faster operation)Always generates redo entriesGenerates redo only under specific conditionsEnforces all constraintsEnforces only PRIMARY KEY, UNIQUE, and NOT NULLFires INSERT triggersDoes not fire INSERT triggersCan load into clustered tablesDoes not load into clustersAllows other users to modify tables during load operationPrevents other users from making changes to tables during load operationMaintains index entries on each insertMerges new index entries at the end of the load</table>

--- Page 19 ---

text[[114, 105, 876, 352]]
A conventional path load executes SQL INSERT statements to populate tables in an Oracle database. A direct path load eliminates much of the Oracle database overhead by formatting Oracle data blocks and writing the data blocks directly to the database files. A direct load does not compete with other users for database resources, so it can usually load data at close to disk speed. Conventional path loads use SQL processing and a database COMMIT operation for saving data. The insertion of an array of records is followed by a COMMIT operation. Each data load may involve several transactions. Direct path loads use data saves to write blocks of data to Oracle data files. This is why the direct path loads are faster than the conventional ones. The following features differentiate a data save from COMMIT:  

text[[145, 360, 832, 506]]
During a data save, only full database blocks are written to the database The blocks are written after the high- water mark (HWM) of the table After a data save, the HWM is moved Internal resources are not released after a data save A data save does not end the transaction Indexes are not updated at each data save  

sub_title[[114, 540, 873, 586]]
### 3.4. Performing SQL\\*Loader for one table export/import using Toad for Oracle:  

text[[115, 599, 639, 617]]
From Schema Browser. Choose tables of Logon Schema:

--- Page 20 ---

text[[116, 105, 880, 150]]
Then choose a table such AUDIT_ACTIONS from the actual schema "SYS", and click on the "Data" page in the right side: 

image[[117, 177, 928, 488]]
 

text[[116, 514, 849, 531]]
Next step, choose "EXPORT Dataset" icon and choose the file type to export type: 

image[[118, 558, 930, 864]]

--- Page 21 ---

text[[120, 106, 438, 122]]
Choose the file with full path folder:  

image[[305, 127, 690, 559]]  

text[[119, 585, 671, 603]]
The next figure shows the result of export and the control file:

--- Page 22 ---

text[[119, 107, 376, 122]]
The content of control file is:  

image[[242, 127, 752, 519]]  

text[[117, 546, 874, 589]]
Run the command line to run the sqlldr.exe file to import the exported data to another database or another schema:

--- Page 23 ---

text[[117, 106, 724, 123]]
The use of sqlldr tool with user name and password and control file:  

image[[116, 127, 910, 425]]  

text[[115, 450, 880, 494]]
This is the last step - I where the execution file with using sqlldr is finishing import data:  

image[[117, 499, 911, 672]]  

text[[116, 703, 881, 747]]
This is the last step - 2 where the execution file with using sqlldr is finishing import data:

--- Page 24 ---

image[[128, 103, 856, 360]]  

text[[117, 382, 880, 425]]
This is the last step -3 where the execution file with using sqlldr is finishing import data:  

image[[138, 429, 855, 680]]  

text[[119, 705, 867, 723]]
This is the last step where the result of execution log file and bad file are appeared:

--- Page 25 ---

image[[141, 100, 857, 377]]  

text[[117, 381, 495, 398]]
The content of log file is like the following:  

table[[160, 426, 835, 854]]

<table>sqldr_control.log - NotepadFile Edit Format View HelpSQL*Loader: Release 19.0.0.0.0 - Production on Tue Feb 18 21:18:00 2020<br>Version 19.3.0.0.0Copyright (c) 1982, 2019, Oracle and/or its affiliates. All rights reserved.<br>Control File: D:\sqldr_folder\sqlldr_control.txt<br>Data File: D:\sqldr_folder\sqlldr_control.txt<br>Bad File: ./sqldr_control.BAD<br>Discard File: ./sqldr_control.DSC<br>(Allow all discards)<br>Number to load: ALL<br>Number to skip: 0<br>Errors allowed: 50<br>Bind array: 250 rows, maximum of 1048576 bytes<br>Continuation: none specified<br>Path used: ConventionalTable SYS_AUDIT_ACTIONS, loaded from every logical record.<br>Insert option in effect for this table: APPENDColumn Name Position Len Term Encl DatatypeACTION FIRST * ; O(&quot; CHARACTER NULL if ACTION = 0X4e554c4c (character &#x27;NULL&#x27;) NAME NEXT * ; O(&quot; CHARACTER Record 1: Rejected - Error on table SYS_AUDIT_ACTIONS.<br>ORA-00001: unique constraint (SYS_I_AUDIT_ACTIONS) violated</table>

--- Page 26 ---

text[[120, 106, 512, 123]]
The content of BAD file is like the following:  

image[[189, 126, 805, 597]]

--- Page 27 ---

sub_title[[117, 108, 789, 129]]
## 4. Unloading and Loading Data Using an External Table:  

sub_title[[118, 143, 436, 160]]
### 4.1. External Table: overview:  

text[[115, 173, 883, 216]]
External tables are read- only tables stored as files on the operating system outside of the Oracle database.  

image[[161, 246, 827, 507]]  

text[[114, 533, 881, 654]]
External tables access data in external sources as if it were in a table in the database. You can connect to the database and create metadata for the external table using DDL. The DDL for an external table consist of two parts: one part that describes the Oracle Database column types, and another part that describes the mapping of the external data to the Oracle Database data columns.  

text[[114, 661, 881, 830]]
An external table does not describe any data that is stored in the database. Nor does it describe how data is stored in the external source. Instead, it describes how the external table layer must present the data to the server. It is the responsibility of the access driver and the external table layer to do the necessary transformations required on the data in the external file so that it matches the external table definition. External tables are read only; therefore, no DML operations are possible, and no index can be created on them.  

text[[115, 840, 881, 883]]
There are two access drivers used with external tables. The ORACLE_LOADER access driver can be used only to read table data from an external table and load it into the

--- Page 28 ---

text[[115, 106, 883, 227]]
database. It uses text files as the data source. The ORACLE_DATAPUMP access driver can both load table data from an external file into the database and also unload data from the database into an external file. It uses binary files as the external files. The binary files have the same format as the files used by the Data Pump Import and Export utilities and can be interchanged with them.  

sub_title[[119, 246, 423, 264]]
### 4.2. External Table: Benefits:  

text[[146, 276, 881, 397]]
- Data can be used directly from the external file or loaded into another database- External data can be queried and joined directly in parallel with tables residing in the database, without requiring it to be loaded first- The results of a complex query can be unloaded to an external file- You can combine generated files from different sources for loading purposes  

image[[438, 416, 562, 565]]
image_caption[[211, 495, 426, 512]]
<center>From Oracle Database </center>  

text[[115, 583, 883, 753]]
The data files created for the external table can be moved and used as the data files for another external table in the same database or different database. External data can be queried and joined directly in parallel to tables residing in the database, without requiring the data to be loaded first. You can choose to have your applications directly access external tables with the SELECT command, or you can choose to have data loaded first into a target database. The results of a complex query can be unloaded to an external file using the ORACLE_DATAPUMP access driver.  

text[[115, 760, 881, 853]]
Data files that are populated by different external tables can all be specified in the LOCATION clause of another external table. This provides an easy way of aggregating data from multiple sources. The only restriction is that the metadata for all the external tables must be exactly the same.

--- Page 29 ---

sub_title[[119, 107, 705, 126]]
### 4.3. Defining an External Tables with ORACLE_LOADER:  

text[[117, 138, 880, 256]]
The metadata for an external table is created using the SQL language in the database. The ORACLE_LOADER access driver uses the SQL\*Loader syntax to define the external table. This command does not create the external text files. Best- practice tip: If you have a lot of data to load, enable PARALLEL for the load operation:  

text[[118, 276, 525, 292]]
ALTER SESSION ENABLE PARALLEL DML;  

text[[117, 313, 880, 435]]
The following example shows three directory objects (EXTAB_DAT_DIR, EXTAB_BAD_DIR, and EXTAB_LOG_DIR) that are created and mapped to existing OS directories to which the user is granted access. When the EXTAB_EMPLOYEES table is accessed, SQL\*Loader functionality is used to load the table, and at that instance the log file and bad file are created.  

text[[117, 454, 753, 767]]
CREATE TABLE extab_employees (employee_id NUMBER(4), first_name VARCHAR2(20), last_name VARCHAR2(25), hire_date DATE) ORGANIZATION EXTERNAL ( TYPE ORACLE_LOADER DEFAULT DIRECTORY extab_dat_dir ACCESS PARAMETERS ( records delimited by newline badfile extab_bad_dir:'empxt%a_%p.bad' logfile extab_log_dir:'empxt%a_%p.log' fields terminated by ', missing field values are null ( employee_id, first_name, last_name, hire_date char date_format date mask "dd- mon- yyyy") ) LOCATION ('empxt1.dat', 'empxt2.dat') PARALLEL REJECT LIMIT UNLIMITED;

--- Page 30 ---

sub_title[[118, 106, 715, 126]]
### 4.4. External Table Population with ORACLE_DATAPUMP:  

text[[115, 137, 882, 282]]
Because the external table can be large, you can use a parallel populate operation to unload your data to an external table. As opposed to a parallel query from an external table, the degree of parallelism of a parallel populate operation is constrained by the number of concurrent files that can be written to by the access driver. There is never more than one parallel execution server writing into one file at a particular point in time.  

text[[115, 289, 882, 410]]
The number of files in the LOCATION clause must match the specified degree of parallelism because each input/output (I/O) server process requires its own file. Any extra files that are specified are ignored. If there are not enough files for the specified degree of parallelism, the degree of parallelization is lowered to match the number of files in the LOCATION clause.  

sub_title[[117, 445, 172, 460]]
## Note:  

text[[115, 470, 882, 588]]
The external table is read- only after is has been populated. The SELECT command can be very complex, allowing specific information to be populated in the external table. The external table, having the same file structure as binary Data Pump files, can then be migrated to another system, and imported with the impdp utility or read as an external table.  

text[[117, 596, 880, 640]]
For more information about the ORACLE_DATAPUMP access driver parameters, see the Oracle Database Utilities guide.  

text[[115, 673, 882, 743]]
This following example shows you how the external table population operation can help to export a selective set of records resulting from the join of the EMPLOYEES and DEPARTMENTS tables.  

text[[117, 772, 595, 862]]
CREATE TABLE ext_emp_query_results (first_name, last_name, department_name) ORGANIZATION EXTERNAL ( TYPE ORACLE_DATAPUMP DEFAULT DIRECTORY ext_dir

--- Page 31 ---

text[[117, 103, 710, 250]]
LOCATION ('emp1. exp', 'emp2. exp', 'emp3. exp') ) PARALLEL AS SELECT e.first_name,e.last_name,d.department_name FROM employees e, departments d WHERE e.department_id = d.department_id AND d.department_name in ('Marketing','Purchasing');  

sub_title[[120, 280, 400, 299]]
### 4.5. Using External Tables:  

text[[147, 310, 880, 380]]
- External tables are queried just like internal database tables. The following example illustrates querying an external table named EXTAB_EMPLOYEES and only displaying the results. The results are not stored in the database:  

text[[176, 399, 602, 418]]
SQL> SELECT \* FROM extab_employees;  

text[[147, 444, 881, 512]]
- The following example shows the joining of an internal table named DEPARTMENTS with an external table named EXTAB_EMPLOYEES and only displaying the results:  

text[[176, 532, 841, 588]]
SQL> SELECT e.employee_id, e.first_name, e.last_name, d.department_name FROM departments d, extab_employees e WHERE d.department_id = e.department_id;  

text[[147, 610, 880, 656]]
- The following example illustrates the direct appending of an internal table data with the query and load of data from an external table.  

text[[176, 676, 700, 712]]
SQL> INSERT /*+ APPEND */ INTO hr.employees SELECT \* FROM extab_employees;

--- Page 32 ---

sub_title[[120, 108, 426, 128]]
## 5.Data Dictionary Views:  

text[[117, 142, 880, 211]]
A quick way to determine whether a Data Pump job is running is to check the DBA_DATAPUMP_JOBS view for anything running with a STATE that has an EXECUTING status:  

text[[118, 232, 643, 268]]
select job_name, operation, job_mode, state from dba_datapump_jobs;  

text[[119, 291, 546, 308]]
click here to see some sample output.  

table[[120, 333, 869, 430]]

<table>JOB_NAMEOPERATIONJOB_MODESTATE----SYS_IMPORT_TABLE_04IMPORTTABLEEXECUTINGSYS_IMPORT_FULL_02IMPORTFULLNOT RUNNING</table>  

text[[118, 451, 880, 495]]
You can also query the DBA_DATAPUMP_SESSIONS view for session information via the following query:  

text[[119, 515, 690, 587]]
select sid, serial#, username, process, program from v\$session s, dba_datapump_sessions d where s.saddr = d.saddr;  

text[[118, 613, 880, 650]]
click here to see some sample output, showing that several Data Pump sessions are in use.  

table[[148, 674, 783, 800]]

<table>SIDSERIAL#USERNAMEPROCESSPROGRAM10496451STAGING11306oracle@xengdb (DM00)105833126STAGING11338oracle@xengdb (DW01)104850508STAGING11396oracle@xengdb (DW02)</table>

--- Page 33 ---

sub_title[[117, 109, 214, 128]]
## 6. Quiz:  

text[[118, 142, 444, 159]]
1. Oracle Data Pump is callable via:  

text[[145, 168, 542, 263]]
a) DBMS_DATAPUMP and DBMS_METADATA 
b) DBMS_METADATA only 
c) SQL\*Loader 
d) transportable tablespaces  

text[[115, 293, 878, 312]]
2. Which of these statements about system privileges is not a data movement method:  

text[[145, 320, 364, 441]]
a) Data file copying 
b) Direct path 
c) New Tablespace 
d) External tables 
e) Network link support  

text[[115, 473, 880, 517]]
3. If there are clustered tables, referential integrity constraints, encrypted columns, or several other items, to move data Data Pump uses:  

text[[145, 525, 456, 618]]
a) Direct path 
b) Direct path and External tables 
c) None of the other options 
d) External tables  

text[[115, 650, 880, 694]]
4. When a table's structure allows load and unload and when maximum single-stream performance is desired, to move data; DataPump uses:  

text[[145, 702, 456, 796]]
a) Direct path 
b) Direct path and External tables 
c) None of the other options 
d) External tables

--- Page 34 ---

text[[117, 106, 880, 150]]
5. Like other database objects, directory objects are owned by the user that creates them unless another schema is specified during creation.  

text[[147, 158, 232, 200]]
a) True 
b) False  

text[[117, 234, 880, 278]]
6. What is the parameter that will not be used for fine-grained object and data selection:  

text[[146, 286, 277, 377]]
a) EXCLUDE 
b) INCLUDE 
c) CONTENT 
d) PARALLEL  

text[[117, 409, 827, 428]]
7. The master table MT is dropped when the Data Pump job finishes normally?  

text[[146, 437, 232, 479]]
a) True 
b) False  

text[[116, 511, 736, 530]]
8. When the Data Pump job finishes normally, The master table MT?  

text[[147, 538, 568, 632]]
a) Is stored in a temporary directory for history 
b) Needs user's action to be dropped 
c) Is dropped automatically 
d) Is truncated automatically  

text[[116, 665, 880, 683]]
9. What is the statement that is wrong related to Data Pump Export and Import modes?  

text[[146, 691, 285, 811]]
a) Full 
b) Schema 
c) Table 
d) Tablespace 
e) Extent

--- Page 35 ---

text[[117, 106, 880, 150]]
10. If a privileged user is connected to the database instance, the export types include the following?  

text[[148, 157, 591, 255]]
a) Database, Schemas, Tables, and Tablespace  
b) Database only  
c) Schemas and Tables only  
d) Tablespace only  

text[[117, 284, 880, 329]]
11. If unprivileged user (non-administrative account) is connected to the database instance, the export types include the following?  

text[[148, 335, 591, 433]]
a) Database, Schemas, Tables, and Tablespace  
b) Database only  
c) Schemas and Tables only  
d) Tablespace only  

text[[118, 464, 424, 481]]
12. SQL\*Loader loads data from:  

text[[148, 490, 635, 586]]
a) Views in the database to related tables  
b) Stored procedure to a table  
c) One segment to another one in the same database  
d) External files into tables of an Oracle database  

text[[118, 616, 881, 661]]
13. REMAP_SCHEMA; in the import utility impdp; provides the old FROMUSER /TOUSER capability to change object ownership?  

text[[148, 668, 226, 710]]
a) True  
b) False  

text[[118, 746, 333, 763]]
14. External tables are:  

text[[147, 770, 881, 890]]
a) Tables stored in the operational database  
b) Read-only tables stored as files on the operating system outside of the Oracle database  
c) Tables stored in the Data warehouse database  
d) Views stored in the operational database

--- Page 36 ---

text[[117, 105, 840, 124]]
15. The external table, having the same file structure as binary Data Pump files?  

text[[147, 133, 228, 176]]
a) True 
b) False  

text[[118, 208, 880, 253]]
16. What is the name of the text file that is written in a language that SQL\*Loader understands?  

text[[147, 260, 292, 353]]
a Bad File 
b Control File 
c) Log File 
d Discard File  

text[[118, 386, 878, 431]]
17. What is the name of the text file that contains records that are rejected, either by SQL\*Loader or by the Oracle database?  

text[[147, 439, 292, 534]]
a) Bad File 
b) Control File 
c) Log File 
d Discard File  

text[[118, 566, 880, 610]]
18. Using the VERSION parameter, You can specify the database version for objects to be moved?  

text[[147, 618, 232, 661]]
a) True 
b) False  

text[[118, 694, 835, 712]]
19. Data Dictionary Views that are related to Data Pump jobs and sessions are:  

text[[146, 721, 687, 817]]
a) dba_datapump_session and dba_datapump_job 
b) V\$_datapump_session and V\$_datapump_job 
c) V\$_datapump_sessions and V\$_datapump_jobs 
d) dba_datapump_sessions and dba_datapump_jobs

--- Page 37 ---

text[[117, 105, 567, 123]]
20. An index can be created on an external table. 

text[[150, 131, 228, 149]]
a) True 

text[[152, 157, 234, 174]]
b) False 

table[[206, 202, 779, 757]]
<table><td colspan="2">Quiz answers – chapter 121a2c3d4a5b6d7a8c9e10a11c12d13a14b15a16b17a18a19d20b</table>

--- Page 38 ---

sub_title[[120, 108, 260, 126]]
## References:  

sub_title[[119, 142, 190, 158]]
## Books:  

text[[147, 167, 884, 340]]
1. Oracle Database Administrator's Guide, 18c (Oracle University), March 2019, Primary Author: Rajesh Bhatiya, Randy Urbano  
2. database-new-features-guide (Oracle University), 18c E88909-01 February 2018, Primary Authors: Tanaya Bhattacharjee, Sunil Surabhi, Mark Baue  
3. The Cloud DBA-Oracle: Managing Oracle Database in the Cloud – First Edition, Abhinivesh Jain and Niraj Mahajan. Apress - ISBN-13 (pbk): 978-1-4842-2634-6 ISBN-13 (electronic): 978-1-4842-2635-3  

sub_title[[119, 370, 223, 387]]
## Web Sites:  

text[[147, 395, 817, 519]]
1. https://docs.oracle.com/database  
2. https://docs.oracle.com/en/database/oracle/oracle-database/19/whats-new.html  
3. http://www.oracle.com/technetwork/database/enterprise-edition/downloads/index.html
