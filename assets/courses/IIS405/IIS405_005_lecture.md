--- Page 1 ---

title[[120, 307, 876, 351]]
# Oracle Database Administration  

text[[483, 373, 513, 402]]
I  

text[[174, 455, 823, 484]]
Chapter 5: Tablespaces and Data Files

--- Page 2 ---

sub_title[[732, 148, 887, 170]]
## :  

text[[114, 207, 883, 644]]
1. What Is a tablespoon? 3  
1.1. Data Block Format 5  
1.2. How Table Data Is Stored 6  
2. Understanding the First Five tablespoons 7  
3. Understanding the Need for More 10  
4. Creating Tablespoons 12  
4.1. Create Undo Tablespace 14  
4.2. Creating a Bigfile Tablespace 15  
4.3. Creating a Temporary Tablespace 16  
5. Managing Tablespaces 17  
5.1. Renaming a Tablespace 17  
5.2. Changing a Tablespace's Write Mode 17  
5.3. Dropping a Tablespace 18  
5.4. Altering Tablespace Size 20  
5.5. Moving or Renaming an Online Data File 21  
6. Oracle Managed File (OMF) 22  
7. Viewing Tablespace Information 24  
8. Understanding Pluggable Architecture 25  
9. Quiz 29

--- Page 3 ---

sub_title[[117, 108, 250, 127]]
## Objectives:  

text[[147, 140, 612, 235]]
1. Describe the storage of table row data in blocks  
2. Create and manage tablespaces  
3. Obtain tablespace information  
4. tablespace and data file relationship

--- Page 4 ---

sub_title[[120, 108, 413, 128]]
## 1.What Is a tablespace?  

text[[117, 142, 882, 237]]
A tablespace is a logical container that allows you to manage groups of data files, the physical files on disk that consume space. Once a tablespace is created, you can then create database objects (tables and indexes) within tablespaces, which results in space allocated on disk in the associated data files.  

text[[117, 243, 882, 340]]
A tablespace is logical in the sense that it is only visible through data dictionary views (such as DBA_TABLESPACES); you manage tablespaces through SQL\\*Plus or graphical tools (such as Toad for Oracle), or both. Tablespaces only exist while the database is up and running.  

text[[117, 345, 882, 468]]
Data files can also be viewed through data dictionary views DBA_DATA_FILES) but additionally have a physical presence, as they can be viewed outside the database through OS utilities (such as the command ls and dir in windows to list the files). Data files persist whether the database is open, or closed. files persist whether the database is open or closed.  

text[[117, 498, 880, 542]]
The following figure shows Relationships of logical storage objects and physical storage. Click on the blocks for more information.  

image[[57, 572, 890, 853]]

--- Page 5 ---

sub_title[[117, 106, 234, 123]]
## Tablespace:  

text[[115, 131, 881, 227]]
A database is divided into logical storage units called tablespaces. One tablespace can contain many segments and be made up of many datafiles. This means that any one segment may be spread across multiple datafiles, and any one datafile may contain all of or parts of many segments.The  

text[[117, 234, 613, 252]]
The database administrator (DBA) uses tablespaces to:  

text[[145, 259, 840, 381]]
Control disk space allocation for database data Assign specific space quotas for database users Control availability of data by taking individual tablespaces online or offline Perform partial database backup or recovery operations Allocate data storage across devices to improve performance  

sub_title[[117, 414, 222, 430]]
## Segments:  

text[[115, 439, 881, 557]]
The segment entity represents any database object that stores data and therefore requires space in a tablespace. Your typical segment is a table, but there are other segment types, notably index segments and undo segments. Any one segment can exist in only one tablespace, but the tablespace can spread it across all the files making up the tablespace.Data  

text[[117, 565, 880, 608]]
Data is stored in segments and every segment consists of one or more extents, consecutively numbered.  

text[[115, 616, 868, 635]]
The data dictionary view DBA_SEGMENTS describes every segment in the database.  

sub_title[[117, 668, 199, 683]]
## Extents:  

text[[116, 692, 880, 735]]
An extent is a set of consecutively numbered Oracle blocks within one datafile. Storage is allocated by Extent.  

sub_title[[117, 772, 199, 787]]
## Datafile:  

text[[115, 796, 775, 814]]
A datafile is, physically, made up of a number of operating system blocks.

--- Page 6 ---

sub_title[[117, 107, 223, 123]]
## OS Block:  

text[[115, 131, 881, 202]]
An operating system block is the unit of I/O for your file system. If the database block size is different from the operating system block size, ensure that the database block size is a multiple of the operating system block size.  

sub_title[[117, 236, 270, 252]]
## Database Block  

text[[115, 260, 881, 329]]
A data block is the smallest unit of data used by a database. The block size is controlled by the parameter DB_BLOCK_SIZE. This can never be changed after database creation.  

sub_title[[118, 362, 370, 380]]
### 1.1. Data Block Format:  

text[[115, 391, 881, 462]]
The Oracle data block format is similar regardless of whether the data block contains table, index, or clustered data. The following illustrates the format of a data block. Click on the different parts for more.  

image[[319, 487, 679, 661]]  

text[[115, 690, 881, 784]]
Block header: The block header contains the segment type (such as table or index), data block address, table directory, row directory, and transaction slots of approximately 23 bytes each, which are used when modifications are made to rows in the block. The block header grows downward from the top.  

text[[115, 792, 880, 835]]
Row data: This is the actual data for the rows in the block. Row data space grows upward from the bottom.  

text[[117, 843, 881, 886]]
Free space: Free space is in the middle of the block, enabling the header and the row data space to grow when necessary. Row data takes up free space as new rows

--- Page 7 ---

text[[115, 105, 881, 150]]
are inserted or as columns of existing rows are updated with larger values. Examples of events that cause header growth:  

text[[146, 158, 567, 176]]
- Row directories that need more row entries  

text[[147, 185, 666, 202]]
- More transaction slots required than initially configured  

text[[115, 210, 881, 280]]
Initially, the free space in a block is contiguous. However, deletions and updates may fragment the free space in the block. The free space in the block is coalesced by the Oracle server when necessary.  

sub_title[[118, 311, 436, 330]]
### 1.2. How Table Data Is Stored:  

image[[193, 362, 798, 632]]  

text[[115, 663, 883, 887]]
When a table is created, a segment is created to hold its data. A tablespace contains a collection of segments. Logically, a table contains rows of column values. A row is ultimately stored in a database block in the form of a row piece. It is called a row piece because, under some circumstances, the entire row may not be stored in one place. This happens when an inserted row is too large to fit into a single block (chained row) or when an update causes an existing row to outgrow the available free space of the current block (migrated row). Row pieces are also used when a table has more than 255 columns. In this case the pieces may be in the same block (intrablock chaining) or across multiple blocks.

--- Page 8 ---

sub_title[[116, 108, 645, 129]]
## 2. Understanding the First Five tablespaces:  

text[[114, 142, 883, 210]]
When you create a database, typically five tablespaces are created when you execute the CREATE DATABASE statement: SYSTEM, SYSAUX, UNDO, TEMP, USERS. Click on the diagram parts for more.  

image[[110, 235, 876, 533]]  

image[[114, 559, 905, 858]]

--- Page 9 ---

image[[117, 100, 931, 411]]  

sub_title[[118, 437, 202, 453]]
## SYSTEM  

text[[119, 462, 881, 532]]
The SYSTEM tablespace provides storage for the Oracle data dictionary objects. This tablespace is where all objects owned by the SYS user are stored. The SYS user should be the only user that owns objects created in the SYSTEM tablespace.  

sub_title[[119, 565, 205, 580]]
## SYSAUX  

text[[118, 589, 881, 760]]
The SYSAUX (system auxiliary) tablespace is created when you create the database. This is an auxiliary tablespace used as a data repository for Oracle database tools, such as Enterprise Manager, Statspack, LogMiner, Logical Standby, and so on. Audit logs are collected in the SYSAUX tablespace by default but should be configured to use another tablespace created for audit records. Even some of these other tools can be configured to use additional tablespaces depending on retention and separation rules and keep the data outside of the default system tablespaces.  

sub_title[[119, 795, 181, 811]]
## UNDO  

text[[118, 820, 881, 890]]
The UNDO tablespace stores the information required to undo the effects of a transaction (insert, update, delete, or merge). This information is required in the event a transaction is purposely rolled back (via a ROLLBACK statement). The undo

--- Page 10 ---

text[[116, 105, 882, 176]]
information is also used by Oracle to recover from unexpected instance crashes and to provide read consistency for SQL statements. Additionally, some database features, such as Flashback Query, use the undo information.  

sub_title[[118, 209, 177, 225]]
## TEMP  

text[[115, 234, 884, 582]]
Some Oracle SQL statements require a sort area, either in memory or on disk. For example, the results of a query may need to be sorted before being returned to the user. Oracle first uses memory to sort the query results, and when there is no longer sufficient memory, the TEMP tablespace extra temporary storage may also be required when creating or rebuilding indexes. The space is only used for transient data for the session, and no permanent objects can be stored in a TEMP tablespace. If temporary objects are needed for a process outside of one session, the object should be stored in a permanent user tablespace. When you create a database, typically you create the TEMP tablespace and specify it to be the default temporary tablespace for any users you create. There can be multiple temporary tablespaces, with different names, that can be assigned to different groups of users or applications to avoid conflicts between temp space usage. A tempfile is a file that belongs to a temporary tablespace; it is created with the TEMPFILE option. Temporary tablespaces cannot contain permanent database objects such as tables, and are typically used for sorting.  

sub_title[[118, 616, 190, 631]]
## USERS  

text[[116, 640, 881, 685]]
The USERS tablespace is not absolutely required but is often used as a default permanent tablespace for table and index data for users.  

text[[117, 692, 882, 762]]
This means that when a user attempts to create a table or index, if no tablespace is specified during object creation, by default the object is created in the default permanent tablespace.

--- Page 11 ---

sub_title[[119, 108, 557, 129]]
## 3. Understanding the Need for More:  

text[[117, 142, 883, 313]]
Although you could put every database user's data in the USERS tablespace, this usually isn't scalable or maintainable for any type of serious database application. Instead, it's more efficient to create additional tablespaces for application users. You typically create at least two tablespaces specific to each application using the database: one for the application table data and one for the application index data. For example, for the APP user APP_DATA and APP_INDEX for table and index data, respectively.  

text[[117, 320, 881, 416]]
DBAs used to separate table and index data for performance reasons. The thinking was that separating table data from index data would reduce input/output (I/O) contention. This is because the data files (for each tablespace) could be placed on different disks, with separate controllers.  

text[[117, 422, 881, 518]]
With modern storage configurations, which have multiple layers of abstraction between the application and the underlying physical storage devices, it's debatable whether you can realize any performance gains by creating multiple separate tablespaces. But, there still are valid reasons for creating multiple tablespaces for table and index data:  

text[[117, 525, 881, 670]]
- Backup and recovery requirements may be different for the tables and indexes 
- The indexes may have storage requirements different from those of the table data 
- Simplify management of objects by logically grouping tables and indexes separately  

text[[116, 677, 883, 874]]
In addition to separate tablespaces for data and indexes, you sometimes create separate tablespaces for objects of different sizes. For instance, if an application has very large tables, you can create an APP_DATA_LARGE tablespace that has a large extent size and a separate APP_DATA_SMALL tablespace that has a smaller extent size. This concept also extends to binary large object (LOB) data types. You may want to separate a LOB column in its own tablespace because you want to manage the LOB tablespace storage characteristics differently from those of the regular table data. Automatic Segment Space Management (ASSM) will be allocated extent size and

--- Page 12 ---

text[[115, 105, 881, 173]]
based on information of the objects stored. Even if not setting the large and smaller extents manually and using ASSM, the grouping of the objects in this way will assist in the management of the objects as well as the automated space management.

--- Page 13 ---

sub_title[[120, 108, 419, 128]]
## 4. Creating Tablespaces:  

text[[116, 141, 843, 159]]
Through Toad for Oracle you can create a table space as per the following steps:  

image[[114, 186, 971, 511]]  

text[[117, 537, 551, 555]]
In the page titled "Basic Info" You have to enter:  

text[[148, 563, 880, 709]]
- a name for the new tablespace- determine its type as per its content: Permanent, Temporary, Undo.- Then you have to choose the Extent Management: Dictionary Managed (deprecated), Allocated Managed (Recommended);- finally in this page to determine the allocation size: Auto Allocate Extent Sizes, Uniform Extent Sizes, and for Segments: Auto Segment Space Management.

--- Page 14 ---

image[[117, 98, 895, 394]]  

text[[116, 424, 880, 515]]
In the page titled "Data Files" You have to enter a Datafile name with its full path and then its initial datafile size. And if it is Auto Extent, you have to determine the Additional space to allocate to this datafile as needed, and if it has Maximum size unlimited or not.  

image[[117, 544, 920, 850]]

--- Page 15 ---

text[[117, 105, 881, 150]]
After entering you choices and requirements, you can see the SQL command that is generated automatically to be executed when pressing the button "OK".  

image[[118, 176, 920, 481]]  

text[[119, 509, 489, 526]]
A tablespace must have at least one file.  

text[[120, 534, 775, 552]]
Extent Allocation: The extents can be allocated in one of these two ways:  

text[[147, 560, 881, 632]]
- Automatic: Also called autoallocate it specifies that the sizes of the extents in the autoallocate, tablespace are system managed. You cannot specify Automatic for a temporary tablespace.  

text[[148, 638, 880, 707]]
- Uniform: It specifies that the tablespace is managed with uniform extents of a size that you specify. The default size is 1 MB. All extents of temporary tablespaces are uniform. You cannot specify Uniform for an undo tablespace.  

sub_title[[120, 742, 428, 759]]
### 4.1. Create Undo Tablespace:  

text[[148, 772, 881, 892]]
- Used to store undo segments  
- Cannot contain any other objects  
- Locally managed tablespaces with automatic extent allocation  
- Can only use the DATAFILE and EXTENT MANAGEMENT clauses of the CREATE TABLESPACE command

--- Page 16 ---

text[[117, 118, 879, 154]]
CREATE UNDO TABLESPACE undo1 DATAFILE 'C:\oradata\undo101.dbf' SIZE 40M;  

text[[115, 195, 883, 317]]
Although a database may have many undo tablespaces, only one of them at a time can be designated as the current undo tablespace for any instance in the database. Undo segments are automatically created and always owned by SYS. Because the undo segments act as a circular buffer, each segment has a minimum of two extents. Undo tablespaces are permanent.  

sub_title[[117, 350, 475, 369]]
### 4.2. Creating a Bigfile Tablespace:  

text[[115, 379, 883, 500]]
The bigfile feature allows you to create a tablespace with a very large data file assigned to it. The advantage of using the bigfile feature is this potential to create very large files. With an 8KB block size, you can create a data file as large as 32TB. With a 32KB block size, you can create a data file up to 128TB. Use the BIGFILE clause to create a bigfile tablespace:  

text[[115, 529, 652, 639]]
create bigfile tablespace inv_big_data datafile 'c:\dbfile\o19c\inv_big_data01.dbf' size 10g extent management local uniform size 128k segment space management auto;  

text[[115, 670, 883, 814]]
One potential disadvantage of using a bigfile tablespace is that if, for any reason, you run out of space on a file system that supports the data file associated with the bigfile, you can't expand the size of the tablespace (unless you can add space to the file system). You can't add more data files to a bigfile tablespace if they're placed on separate mount points. A bigfile tablespace allows only one data file to be associated with it.

--- Page 17 ---

sub_title[[118, 107, 520, 126]]
### 4.3. Creating a Temporary Tablespace:  

text[[147, 139, 533, 208]]
- Used for sort operations- Cannot contain any permanent objects- Locally managed extents recommended  

text[[117, 225, 632, 276]]
CREATE TEMPORARY TABLESPACE temp TEMPFILE 'c:\oradata\temp01.tmp' SIZE 500M EXTENT MANAGEMENT LOCAL UNIFORM SIZE 10M;  

text[[116, 319, 881, 389]]
You can manage space for sort operations more efficiently by designating temporary tablespaces exclusively for sort segments. No permanent schema objects can reside in a temporary tablespace.  

text[[117, 396, 882, 492]]
Sort, or temporary, segments are used when a segment is shared by multiple sort operations. Temporary tablespaces provide performance improvements when you have multiple sorts that are too large to fit into memory. The sort segment of a given temporary tablespace is created at the time of the first sort operation of the instance.  

text[[117, 524, 882, 618]]
When creating a database without a default temporary tablespace the default tablespace, assigned to any user created without a TEMPORARY TABLESPACE clause is the SYSTEM tablespace. A default temporary tablespace can be set by creating a temporary tablespace and then altering the database:  

text[[118, 636, 702, 654]]
ALTER DATABASE DEFAULT TEMPORARY TABLESPACE temp

--- Page 18 ---

sub_title[[119, 109, 435, 130]]
## 5.Managing Tablespaces:  

title[[118, 143, 422, 161]]
#### 5.1.Renaming a Tablespace:  

text[[115, 173, 883, 294]]
Sometimes you need to rename a tablespace. You may want to do this because a tablespace was initially erroneously named, or you may want the tablespace name to better conform to your database naming standards. Use the ALTER TABLESPACE statement to rename a tablespace. The following statement renames a tablespace from TOOLS to TOOLS_DEV:  

text[[115, 317, 695, 334]]
SQL> alter tablespace tools rename to tools_dev;  

text[[116, 362, 881, 407]]
When you rename a tablespace, Oracle updates the name of the tablespace in the data dictionary, control files, and data file headers.  

text[[115, 414, 800, 432]]
Note: You can't rename the SYSTEM tablespace or the SYSAUX tablespace.  

title[[116, 466, 557, 485]]
#### 5.2.Changing a Tablespace's Write Mode:  

text[[115, 497, 881, 591]]
In environments such as data warehouses, you may need to load data into tables and then never modify the data again. To enforce that no objects in a tablespace can be modified, you can alter the tablespace to be read- only. To do this, use the ALTER TABLESPACE statement:  

text[[115, 616, 578, 633]]
SQL> alter tablespace Tools read only;  

text[[116, 660, 881, 732]]
One advantage of a read- only tablespace is that you only have to back it up once. You should be able to restore the data files from a read- only tablespace no matter how long ago the backup was made.  

text[[115, 738, 854, 757]]
If you need to modify the tablespace out of read- only mode, you do so as follows:  

text[[116, 791, 588, 808]]
SQL> alter tablespace Tools read write;  

text[[115, 835, 880, 878]]
Make sure you re- enable backups of a tablespace after you place it in read/write mode.

--- Page 19 ---

text[[115, 106, 883, 176]]
Note: You can't make a tablespace that contains active rollback segments read- only. For this reason, the SYSTEM tablespace can't be made read- only because it contains the SYSTEM rollback segment.  

sub_title[[119, 215, 411, 233]]
### 5.3. Dropping a Tablespace:  

text[[115, 244, 881, 341]]
If you have a tablespace that is unused, it is best to drop it so it does not clutter your database, consume unnecessary resources, and potentially confuse DBAs who are not familiar with the database. Before dropping a tablespace, it is a good practice to first take it offline:  

text[[115, 365, 553, 382]]
SQL> alter tablespace Tools offline;  

text[[114, 407, 881, 530]]
You may want to wait to see if anybody screams that an application is broken because it can no longer write to a table or index in the tablespace to be dropped. Depending on the reason for dropping a tablespace, objects can be moved to another tablespace first before dropping. When you are sure the tablespace is not required, drop it, and delete its data files:  

text[[115, 564, 835, 583]]
SQL> drop tablespace Tools including contents and datafiles;  

text[[114, 608, 878, 654]]
Note: If you attempt to query a table in an offline tablespace, you receive this error: ORA- 00376: file can't be read at this time.  

text[[115, 686, 881, 759]]
Dropping a tablespace using INCLUDING CONTENTS AND DATAFILES permanently removes the tablespace and any of its data files. Make certain the tablespace does not contain any data you want to keep before you drop it.  

text[[114, 763, 880, 832]]
If you attempt to drop a tablespace that contains a primary key that is referenced by a foreign key associated with a table in a tablespace different from the one you are trying to drop, you receive this error:

--- Page 20 ---

text[[117, 102, 855, 145]]
ORA-02449: unique/primary keys in table referenced by foreign keys  

text[[116, 162, 876, 181]]
Run this query first to determine whether any foreign key constraints will be affected:  

table[[114, 199, 884, 555]]

<table>select p.owner,<br>    p.table_name,<br>    p.constraint_name,<br>    f.table_name referencing_table,<br>    f.constraint_name foreign_key_name,<br>    f.status fk_statusfrom dba_constraints p,<br>    dba_constraints f,<br>    dba_tables twhere p.constraint_name = f.r_constraint_name<br>and f.constraint_type = &#x27;R&#x27;<br>and p.table_name = t.table_name<br>and t.tablespace_name = UPPER(&#x27;&amp;amp;tablespace_name&#x27;)order by 1,2,3,4,5;</table>

text[[117, 575, 880, 669]]
If there are referenced constraints, you need to first drop the constraints or use the CASCADE CONSTRAINT clause of the DROP TABLESPACE statement. This statement uses CASCADE CONSTRAINTs to drop any affected constraints automatically:  

table[[118, 688, 878, 738]]

<table>SQL&gt; drop tablespace Tools including contents and data files<br>cascade constraints;</table>

text[[117, 765, 880, 807]]
This statement drops any referential integrity constraints from tables outside the tablespace being dropped that reference tables within the dropped tablespace.  

text[[118, 815, 879, 858]]
If you drop a tablespace that has required objects in a production system, the results can be catastrophic.

--- Page 21 ---

sub_title[[118, 107, 428, 126]]
### 5.4. Altering Tablespace Size:  

text[[115, 138, 881, 182]]
Use the ALTER DATABASE DATAFILE ... RESIZE command to increase the data file's size. This example resizes the data file to IGB:  

table[[110, 203, 884, 244]]

<table>SQL&gt; alter database datafile &#x27;c:\dbfile\o19c\users01.dbf&#x27;</table><br><br><table>&lt;nl&gt;</table>

text[[115, 267, 881, 333]]
If you don't have space on an existing mount point to increase the size of a data file, then you must add a data file. To add a data file to an existing tablespace, use the ALTER TABLESPACE ... ADD DATAFILE statement:  

table[[115, 351, 884, 400]]

<table>SQL&gt; alter tablespace users add datafile</table><br><br><table>&lt;nl&gt;</table>

text[[117, 430, 881, 473]]
To add space to a temporary tablespace, first query the V$TEMPFILE view to verify the current size and location of temporary data files:  

table[[115, 504, 884, 534]]

<table>SQL&gt; select name, bytes from v$tempfile;</table>

text[[117, 564, 741, 582]]
Then, use the TEMPFILE option of the ALTER DATABASE statement:  

table[[115, 613, 884, 654]]

<table>SQL&gt; alter database tempfile &#x27;/u01/dbfile/012C/temp01.dbf&#x27;</table>

text[[117, 678, 881, 719]]
You can also add a file to a temporary tablespace via the ALTER TABLESPACE statement:  

table[[115, 752, 884, 802]]

<table>SQL&gt; alter tablespace temp add tempfile</table><br><br><table>&lt;nl&gt;</table>

--- Page 22 ---

sub_title[[117, 108, 593, 126]]
## 5.5. Moving or Renaming an Online Data File:  

text[[118, 139, 385, 155]]
Relocating an online data file:  

text[[116, 181, 811, 232]]
SQL> alter database move datafile 'c:\myexample01.dbf' to 'd:\myexample01.dbf';  

text[[118, 263, 385, 280]]
Renaming an online data file:  

text[[116, 305, 524, 370]]
SQL> alter database move datafile '/u01/dbfile/012C/users01.dbf' to '/u01/dbfile/012C/users_dev01.dbf';

--- Page 23 ---

sub_title[[117, 108, 483, 129]]
## 6. Oracle Managed File (OMF):  

text[[115, 141, 881, 210]]
The Oracle Managed File (OMF) feature automates many aspects of tablespace management, such as file placement, naming, and sizing. You control OMF by setting the following initialization parameters:  

text[[145, 243, 508, 298]]
DB_CREATE_FILE_DEST DB_CREATE_ONLINE_LOG_DEST_N DB_RECOVERY_FILE_DEST  

text[[115, 324, 883, 470]]
If you set these parameters before you create the database, Oracle uses them for the placement of the data files, control files, and online redo logs. You can also enable OMF after your database has been created. Oracle uses the values of the initialization parameters for the locations of any newly added files. Oracle also determines the name of the newly added file. These parameters are set as part input in dbca for the creation of a database.  

text[[115, 478, 881, 546]]
The advantage of using OMF is that creating tablespaces is simplified. For example, the CREATE TABLESPACE statement does not need to specify anything other than the tablespace name.  

text[[114, 579, 850, 599]]
First, enable the OMF feature by setting the DB_CREATE_FILE_DEST parameter:  

text[[115, 626, 678, 644]]
SQL> alter system set db_create_file_dest='c:\;  

text[[114, 673, 566, 690]]
Now, issue the CREATE TABLESPACE statement:  

text[[117, 710, 456, 725]]
SQL> create tablespace inv1;  

text[[115, 746, 881, 815]]
This statement creates a tablespace named INV1, with a default data file size of 100MB. Keep in mind that you can override the default size of 100MB by specifying a size:  

text[[117, 844, 675, 860]]
SQL> create tablespace inv2 datafile size 20m;

--- Page 24 ---

text[[117, 106, 881, 176]]
To view the details of the associated data files, query the V\$DATAFILE view, and note that Oracle has created subdirectories beneath the c:\ directory and named the file with the OMF format:  

table[[115, 201, 880, 302]]

<table>SQL&gt; select name from v$datafile where name like &#x27;%inv%&#x27;;NAMEC:\018C\datafile\01_mf_invl_8b5163q6_.dbf<br>C:\018C\datafile\01_mf_inv2_8b51flfc_.dbf</table>  

text[[117, 328, 881, 397]]
One limitation of OMF is that you're limited to one directory for the placement of data files. If you want to add data files to a different directory, you can alter the location dynamically:

--- Page 25 ---

sub_title[[120, 108, 539, 128]]
## 7. Viewing Tablespace Information:  

text[[117, 141, 871, 159]]
Tablespace and data file information can also be obtained by querying the following:  

text[[147, 168, 393, 186]]
- Tablespace information:  

text[[177, 195, 392, 210]]
DBA TABLESPACES  

text[[179, 216, 359, 230]]
VSTABLESPACE  

text[[147, 238, 360, 254]]
- Data file information:  

text[[177, 263, 385, 278]]
DBA_DATA_FILES  

text[[179, 283, 330, 296]]
VSDATAFILE  

text[[147, 305, 377, 321]]
- Temp file information:  

text[[177, 331, 385, 345]]
DBA_TEMP_FILES  

text[[179, 352, 333, 366]]
VSTEMPFILE

--- Page 26 ---

sub_title[[117, 108, 609, 130]]
## 8. Understanding Pluggable Architecture:  

text[[114, 141, 884, 238]]
PDPs have some important architectural differences with a non- CDB database environment. The following Figure displays a container database, named CDB, which contains a root container, a seed database, and two PDPs named SALESPDB and HRPDB:  

image[[72, 259, 905, 602]]  

text[[114, 650, 881, 696]]
The following list highlights some key points to understand about the new architecture in the above figure:  

text[[145, 703, 883, 875]]
- A connection to the CDB database is synonymous with connecting to the CDB$ROOT root container. The main purpose of the root container is to provide the resources and house metadata for any associated PDPs.- You can access the root container via the SYS user, just as you would a non-CDB database. In other words, when logged in to the database server, you can use OS authentication to connect directly to the root container without specifying a username and password (sqlplus / as sysdba).

--- Page 27 ---

text[[145, 105, 881, 176]]
- The seed PDB (PDB\*SEED) only exists as a template for creating new PDBs. You can connect to the seed, but it is read-only, meaning you cannot issue transactions against it.  

text[[147, 183, 881, 230]]
- Besides the two default containers (root and seed), for this particular CDB, two additional PDBs have been manually created, named SALESPDB and HRPDB.  

text[[148, 235, 880, 331]]
- PDBs exist within individual namespaces. PDBs must be unique within the CDB, but objects within a PDB follow the namespace rules of a non-CDB database. For example, tablespace names and user names have to be unique within the individual PDBs, but not across other PDBs within the CDB.  

text[[148, 336, 880, 381]]
- Each PDB has its own SYSTEM and SYSAUX tablespaces and, optionally, a TEMP tablespace.  

text[[147, 387, 881, 432]]
- If a PDB does not have its own TEMP file, it can consume resources in the root container TEMP file.  

text[[148, 439, 880, 535]]
- The SYSTEM tablespace of each PDB contains information regarding the PDB metadata, such as its users and objects; these metadata are accessible via the DBA/ALL/USER-level views from the PDB and are visible via CDB-level views from the root container.  

text[[148, 540, 880, 585]]
- The CDB can house PDBs of different character sets (since version Oracle12 c R2).  

text[[147, 591, 881, 637]]
- You can set the time zones for the CDB and all associated PDBs, or you can set the time zone individually per PDB.  

text[[148, 642, 880, 715]]
- The CDB instance is started and stopped while connected as SYS to the root container. You cannot start/stop the CDB instance while connected to a PDB (separation of duties from system DBAs and application DBAs).  

text[[148, 720, 881, 817]]
- There is one initialization parameter file that is read by the instance when starting. A privileged user connected to the root container can modify all initialization parameters. In contrast, a privileged user connected to a PDB can only modify parameters applicable to the currently connected PDB.  

text[[148, 821, 880, 893]]
- When connected to a PDB and modifying initialization parameters, these modifications only apply to the currently connected PDB and persist for the PDB across database restarts. The ISPDB_MODIFIABLE column in VSPARAMETER

--- Page 28 ---

text[[174, 105, 880, 177]]
shows which parameters are modifiable while connected as a DBA to a PDB. (There are additional security permissions for locking parameters and configurations.)  

text[[148, 183, 881, 278]]
Application users can only access the PDBs via a network connection. Therefore, a listener must be running and listening for service names corresponding to associated PDBs. If a listener is not running, then there is no way for an application user to connect to a PDB.  

text[[148, 284, 881, 382]]
The individual PDBs are not stopped or started per se (not in the terms of a database instance). When you start/stop a PDB, you are not allocating memory or starting/stopping background processes. Rather, PDBs are either made available or not (open or closed).  

text[[148, 387, 880, 432]]
There is one set of control files for the CDB. The control files are managed while connected to the root container as a privileged user.  

text[[149, 438, 881, 508]]
There is one UNDO tablespace for the CDB. All PDBs within the CDB use the same UNDO tablespace (if RAC, then one active undo tablespace per instance).  

text[[148, 514, 880, 633]]
There is one thread of redo (per instance) that is managed while connected to the root container as a user with appropriate privileges. Only privileged connections to root can enable archiving or switching online logs. Connections of SYSDBA privileged users to PDBs cannot alter online redo or archiving settings.  

text[[148, 640, 880, 686]]
There is one alert log and set of trace files for a CDB. Any applicable database messages for associated PDBs are written to the common CDB alert log.  

text[[149, 692, 881, 786]]
Each container is assigned a unique container ID. The root container is assigned a container ID of 1; the seed database is assigned a container ID of 2. Each subsequently created PDB is assigned a unique sequential container ID.  

text[[148, 795, 880, 840]]
The Flashback Database feature is turned on and off via a privileged connection to the root container. You cannot enable flashback at the PDB level.

--- Page 29 ---

text[[148, 106, 881, 174]]
- Security options such as Database Vault can be enabled at a PDB level. The privileges in CDBs and PDBs provide another level of security and separation of duties.  

text[[117, 181, 883, 252]]
One of the main points here is that you can have dozens or more securely isolated PDBs housed within one CDB with only one instance (memory and background processes), one thread of redo, and one set of control files to manage.

--- Page 30 ---

sub_title[[117, 107, 215, 126]]
## 9. Quiz:  

text[[118, 141, 810, 159]]
1. What statements are correct about extents? (Choose all correct answers.)  

text[[147, 167, 702, 288]]
a) An extent is a grouping of several Oracle blocks.b) An extent is a grouping of several operating system blocks.c) An extent can be distributed across one or more datafiles.d) An extent can contain blocks from one or more segments.e) An extent can be assigned to only one segment.  

text[[117, 319, 760, 338]]
2. Which of these are types of segment? (Choose all correct answers.)  

text[[147, 345, 334, 465]]
a) Sequence 
b) Stored procedure 
c) Table 
d) Table partition 
e) View  

text[[117, 498, 880, 542]]
3. What operation cannot be applied to a tablespace after creation? (Choose the best answer.)  

text[[147, 550, 830, 568]]
a) Convert from dictionary extent management to local extent management.  

text[[148, 576, 880, 619]]
b) Convert from manual segment space management to automatic segment space management.  

text[[149, 627, 506, 644]]
c) Change the name of the tablespace.  

text[[147, 652, 727, 669]]
d) Reduce the size of the datafile(s) assigned to the tablespace.  

text[[149, 678, 541, 694]]
e) All the above operations can be applied.

--- Page 31 ---

text[[117, 105, 880, 150]]
4. When the database is in mount mode, what views must be queried to find what datafiles and tablespaces make up the database? (Choose all correct answers.)  

text[[147, 157, 377, 303]]
a) DBA_DATA_FILES 
b) DBA_TABLESPACES 
c) DBA_TEMP_FILES 
d) V\$DATABASE 
e) V\$DATAFILE 
f) V\$TABLESPACE  

text[[117, 334, 878, 379]]
5. A tablespace is a logical container that allows you to manage groups of data files, the physical files on disk that consume space?  

text[[147, 386, 230, 430]]
a) True 
b) False  

text[[118, 464, 369, 482]]
6. Tablespaces only exist?  

text[[146, 490, 535, 584]]
a) While the database is in monument stage  
b) While the database is in mount stage  
c) While the database is up and running  
d) While the database is close  

text[[118, 616, 880, 661]]
7. What are the incorrect statements related to the aspects of the database administrator (DBA) from tablespaces?  

text[[146, 668, 725, 764]]
a) Assign specific space quotas for database users  
b) Control operating system privileges  
c) Perform partial database backup or recovery operations  
d) Allocate data storage across devices to improve performance

--- Page 32 ---

text[[115, 105, 880, 123]]
8. An extent is a set of non-consecutively numbered Oracle blocks within one datafile?  

text[[147, 132, 230, 176]]
a) True 
b) False  

text[[115, 208, 782, 225]]
9. What is the wrong statement related to Segments, Extents and Blocks?  

text[[146, 234, 532, 329]]
a) Data is stored in segments 
b) Every segment has one or more extents 
c) Every extent has one or more segments 
d) Storage is allocated by Extent  

text[[117, 360, 724, 378]]
10. When a table is created, a segment is created to hold its data?  

text[[147, 387, 230, 431]]
a) True 
b) False  

text[[118, 464, 880, 508]]
11. What is the tablespace name that is not created when executing CREATE DATABASE Command?  

text[[146, 516, 262, 660]]
a) SYSTEM 
b) SYSAUX 
c) UNDO 
d) TEMP 
e) USERS 
f) HRTS  

text[[117, 693, 715, 711]]
12. When you Create a new tablespace, the database space will?  

text[[146, 720, 362, 814]]
a) Be enlarged 
b) Be squeezed 
c) No change in space 
d) All the other options

--- Page 33 ---

text[[117, 106, 684, 124]]
13. What is the correct statement related to Undo tablespace?  

text[[147, 132, 626, 227]]
a) Users can get their own quota on it  
b) Cannot contain any other objects  
c) Server process uses it to sort data  
d) Server process check it as a part of data dictionary  

text[[117, 259, 874, 277]]
14. What is the initialization parameter that hasn't any relation with controlling OMF?  

text[[147, 284, 527, 380]]
a) DB_CREATE_FILE_DEST  
b) DB_CREATE_ONLINE_LOG_DEST_N  
c) DB_RECOVERY_FILE_DEST  
d) MEMORY_TARGET  

text[[117, 412, 770, 431]]
15. What are the two tablespaces that you can't rename? (Choose two)  

text[[147, 438, 296, 558]]
a) SYSTEM  
b) SYSAUX  
c) USERS  
d) EXAMPLE  
e) INVENTORY  

text[[117, 590, 607, 608]]
16. What is the action of the following SQL statement:  

text[[147, 616, 742, 634]]
SQL> alter database datafile 'c:\dbfile\19\users\01.dbf' resize 1g;  

text[[148, 642, 530, 710]]
a) Resize the mentioned datafile to be 2G  
b) Resize the tablespace SYS to be 1G  
c) Resize the tablespace to be 1G  

text[[117, 744, 439, 762]]
17. What is the limitation of OMF?  

text[[147, 769, 724, 864]]
a) DBA is limited to one directory for the placement of data files  
b) There is no limitation  
c) DBA doesn't know where the data are located  
d) DBA must apply some commands in a specific time

--- Page 34 ---

text[[118, 106, 844, 124]]
18. What is the wrong statement related to the content of a container database?  

text[[148, 132, 530, 227]]
a) Contains a root container  
b) Contains a seed database  
c) Contains Only one pluggable database  
d) May contain Many pluggable databases  

text[[118, 259, 742, 277]]
19. You can issue transactions against the seed PDB (PDB\$SEED)?  

text[[148, 285, 232, 327]]
a) True  
b) False  

text[[117, 366, 483, 384]]
20. The Flashback Database feature is:  

text[[147, 392, 771, 489]]
a) Turned on and off via a privileged connection to the root container  
b) Turned on and off via the PDB level  
c) Can't be turned on and off  
d) Can be turned on via root level and off via PDB level

--- Page 35 ---

table[[184, 99, 804, 655]]
<table><td colspan="2">Quiz answers – chapter 51a, e2c, d3b4d, e5a6c7b8b9c10a11f12a13b14d15a, b16d17a18c19b20a</table>
