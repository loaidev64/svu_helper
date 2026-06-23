--- Page 1 ---

title[[120, 307, 878, 351]]
# Oracle Database Administration  

text[[484, 372, 515, 403]]
I  

text[[273, 454, 723, 483]]
Chapter 11: Large Objects

--- Page 2 ---

sub_title[[732, 149, 884, 170]]
## :محتويات الفصل 

text[[117, 210, 880, 230]]
Objectives ........................................................................................................................................ 2 

text[[118, 236, 881, 254]]
1. Describing LOB Types ............................................................................................................ 3 

text[[116, 261, 882, 279]]
2. Illustrating LOB Locators, Indexes, and Chunks ........................................................................ 5 

text[[117, 285, 881, 303]]
3. Distinguishing Between BasicFiles and SecureFiles........................................................................ 7 

text[[116, 309, 882, 327]]
4. Creating a Table with a LOB Column ............................................................................................ 9 

text[[117, 333, 881, 351]]
5. Maintaining LOB Columns ........................................................................................................ 15 

text[[118, 357, 880, 374]]
6. Measuring LOB Space Consumed .................................................................................................. 20 

text[[116, 380, 882, 398]]
7. Reading BFILEs ............................................................................................................................ 24 

text[[117, 404, 881, 422]]
8. Quiz ............................................................................................................................................. 25 

text[[118, 428, 880, 445]]
References ........................................................................................................................................ 31

--- Page 3 ---

sub_title[[117, 108, 253, 127]]
## Objectives:  

text[[148, 140, 280, 157]]
1. LOB Types  

text[[147, 166, 600, 185]]
2. Illustrating LOB Locators, Indexes, and Chunks  

text[[149, 192, 410, 209]]
3. Table with a LOB Column  

text[[148, 218, 484, 235]]
4. Measuring LOB Space Consumed

--- Page 4 ---

sub_title[[120, 108, 435, 130]]
## 1. Describing LOB Types:  

text[[117, 141, 881, 260]]
LOB are a data type that is suited to storing large and unstructured data, such as text, log, image, video, sound, and spatial data. A LOB can hold up to a maximum size ranging from 8 terabytes to 128 terabytes depending on how your database is configured. Storing data in LOBs enables you to access and manipulate the data efficiently in your application.  

text[[117, 268, 518, 287]]
Oracle supports the following types of LOBs:  

table[[54, 313, 940, 681]]

<table>Data TypeDescriptionMaximum SizeCLOBCharacter large object for storing character documents, such as big text files, log files, XML files, and so on(4GB-1)* block sizeNCLOBNational character large object; stores data in national character set format; supports characters with varying widths(4GB-1)* block sizeBLOBBinary large object for storing unstructured bitstream data (images, video, and so on). they participate in database transactions and can be backed up, restored, and recovered by Oracle(4GB-1)* block sizeBFILEBinary file large object stored on the filesystem outside of database; read-only; are not covered by any Oracle security, backup and recovery, replication, or disaster recovery mechanisms.2^64-1 bytes (OS may impose a size limit that is less than this)</table>  

sub_title[[117, 706, 483, 724]]
## Using LOBs for Semi-Structured Data  

text[[116, 732, 880, 827]]
Examples of semi- structured data include document files such as json, XML documents or word processor, and log files. These kinds of documents contain data in a logical structure that is processed or interpreted by an application, and is not broken down into smaller logical units when stored in the database.

--- Page 5 ---

text[[114, 105, 883, 253]]
Applications involving semi- structured data typically use large amounts of character data. The Character Large Object (CLOB) and National Character Large Object (NCLOB) data types are ideal for storing and manipulating this kind of data. Binary File objects (data types) can also store character data. You can use BFILES to load read- only data from operating system files into CLOB or NCLOB instances that you then manipulate in your application.  

sub_title[[117, 284, 448, 302]]
## Using LOBs for Unstructured Data  

text[[114, 309, 881, 456]]
Unstructured data cannot be decomposed into standard components. For example, data about an employee can be structured into a name, which is stored as a string; an identifier, such as an ID number, a salary and so on. A photograph, on the other hand, consists of a long stream of 1s and 0s. These bits are used to switch pixels on or off so that you can see the picture on a display, but are not broken down into any finer structure for database storage.  

text[[114, 463, 881, 559]]
Also, unstructured data such as text, graphic images, still video clips, full motion video, and sound waveforms tends to be large in size. A typical employee record may be a few hundred bytes, while even small amounts of multimedia data can be thousands of times larger.  

text[[114, 565, 881, 610]]
SQL data types that are ideal for large amounts of unstructured binary data include the BLOB data type (Binary Large Object) and the BFILE data type (Binary File object).

--- Page 6 ---

sub_title[[117, 108, 724, 129]]
## 2. Illustrating LOB Locators, Indexes, and Chunks:  

text[[115, 141, 883, 287]]
Internal LOBs (CLOB, NCLOB, BLOB) store data in pieces called chunks. A chunk is the smallest unit of allocation for a LOB and is made up of one or more database blocks. LOB locators are stored in rows containing a LOB column. The LOB locator points to a LOB index. The LOB index stores information regarding the location of LOB chunks. When a table is queried, the database uses the LOB locator and associated LOB index to locate the appropriate LOB chunks.  

text[[117, 294, 878, 338]]
Please check figure1 to see the relationship between a table, a row, a LOB locator, and a LOB locator's associated index and chunks:  

text[[115, 345, 880, 413]]
In External LOBs; The LOB locator for a BFILE stores the directory path and file name on the OS. Please check figure2 to see a BFILE LOB locator that references a file on the OS:  

text[[115, 422, 877, 441]]
Note: The DBMS_LOB package performs operations on LOBs through the LOB locator.  

image[[174, 471, 817, 867]]

--- Page 7 ---

image[[120, 100, 926, 448]]

--- Page 8 ---

sub_title[[117, 108, 770, 129]]
## 3. Distinguishing Between BasicFiles and SecureFiles:  

text[[116, 141, 881, 186]]
Several significant improvements were made to LOBs. Oracle now distinguishes between two different types of underlying LOB architecture:  

sub_title[[117, 220, 227, 236]]
## Basic Files  

text[[116, 244, 883, 363]]
Basic Files is the name Oracle gives to the LOB architecture available prior to Oracle Database 11g. It is still important to understand the Basic Files LOBs because many shops use Oracle versions that do not support Secure Files. Be aware that in Oracle Database 11g, the default type of LOB is still Basic Files. However, now, the default type of LOB is now Secure Files and should be used as the way to store LOBs.  

sub_title[[117, 397, 240, 414]]
## Secure Files  

text[[116, 422, 881, 468]]
Secure Files is the recommended option to use with the LOB architecture. It includes the following enhancements (over Basic Files LOBs):  

text[[145, 475, 732, 543]]
Encryption (requires Oracle Advanced Security option) Compression (requires Oracle Advanced Compression option) Deduplication (requires Oracle Advanced Compression option)  

text[[115, 550, 883, 670]]
Secure Files encryption lets you transparently encrypt LOB data (just like other data types). The compression feature allows for significant space savings. The deduplication feature eliminates duplicate LOBs that otherwise would be stored multiple times. You need to do a small amount of planning before using Secure Files. Specifically, use of Secure Files requires the following:  

text[[145, 678, 883, 822]]
A Secure Files LOB must be stored in a tablespace, using ASSM. The DB_SECUREFILE initialization parameter controls whether a Secure Files file can be used and also defines the default LOB architecture for your database. A Secure Files LOB must be created within a tablespace using ASSM. To create an ASSM- enabled tablespace, specify the SEGMENT SPACE MANAGEMENT AUTO clause; for example,  

text[[116, 845, 618, 879]]
SQL> create tablespace lob_data datafile '/u01/dbfile/o18c/lob_data01.dbf'

--- Page 9 ---

text[[117, 103, 480, 176]]
size 1000m extent management local uniform size 1m segment space management auto;  

text[[116, 198, 882, 269]]
If you have existing tablespaces, you can verify the use of ASSM by querying the DBA_TABLESPACES view. The SEGMENT_SPACE_MANAGEMENT column should have a value of AUTO for any tablespaces that you want to use with Secure Files:  

text[[117, 288, 702, 324]]
select tablespace_name, segment_space_management from dba_tablespaces;  

text[[116, 344, 881, 440]]
Also, Secure Files usage is governed by the DB_SECUREFILE database parameter. You can use either ALTER SYSTEM or ALTER SESSION to modify the value of DB_SECUREFILE. The following table describes the valid values for DB_SECUREFILE:  

table[[74, 466, 920, 730]]

<table>DB_SECUREFILE SettingDescriptionNEVERCreates the LOB as a BasicFiles type, regardless of whether the SECUREFILE option is specifiedPERMITTEDAllows creation of SecureFiles LOBsPREFERREDDefault value; specifies that all LOBs are created as a SecureFiles type, unless otherwise statedALWAYSCreates the LOB as a SecureFiles type, unless the underlying tablespace is not using ASSMIGNOREIgnores the SecureFiles option, along with any SecureFiles settings</table>

--- Page 10 ---

sub_title[[117, 108, 593, 128]]
## 4. Creating a Table with a LOB Column:  

text[[116, 141, 882, 210]]
The default underlying LOB architecture is Secure Files. It is recommended to create a LOB as a Secure Files. As discussed previously, Secure Files allows you to use features such as compression and encryption.  

sub_title[[118, 244, 458, 262]]
## Creating a Basic Files LOB Column  

text[[116, 269, 881, 338]]
To create a LOB column, you have to specify a LOB data type. It is best to explicitly specify the STORE AS BASICFILE clause in order to avoid confusion as to which LOB architecture is implemented. Listed next is such an example:  

text[[116, 360, 540, 450]]
SQL> create table patchmain( patch_id number ,patch_desc clob) tablespace users lob(patch_desc) store as basicfile;  

text[[117, 475, 880, 519]]
When you create a table with a LOB column, you must be aware of some technical underpinnings. Review the following list, and be sure you understand each point:  

text[[146, 526, 881, 825]]
Prior to Oracle Database 12c, LOBs, by default, are created as the Basic Files type Oracle creates a LOB segment and a LOB index for each LOB column The LOB segment has a name of this format: SYS_LOB<string> The LOB index has a name of this format: SYS_IL<string> The <string> is the same for each LOB segment and its associated index The LOB segment and index are created in the same tablespace as the table, unless you specify a different tablespace A LOB segment and a LOB index are not created until a record is inserted into the table (the so- called deferred segment creation feature). This means that DBA/ALL/USER_SEGMENTS and DBA/ALL/USER_EXTENTS have no information in them until a row is inserted into the table

--- Page 11 ---

text[[117, 106, 880, 176]]
Oracle creates a LOB segment and a LOB index for each LOB column. The LOB segment stores the data. The LOB index keeps track of where the chunks of LOB data are physically stored and in what order they should be accessed.  

text[[117, 183, 880, 226]]
You can query the DBA/ALL/USER_LOBS view to display the LOB segment and LOB index names:  

text[[116, 248, 879, 286]]
SQL> select table_name, segment_name, index_name, securefile, in_row from user_lobs;  

text[[118, 309, 437, 326]]
Here is the output for this example:  

text[[123, 330, 871, 387]]
TABLE_NAME SEGMENT_NAME INDEX_NAME SEC IN_ PATCHMAIN SYS_LOB000002233200002$$ SYS_IL0000022332C000002$$ NO YES  

text[[117, 411, 880, 530]]
You can also query DBA/USER/ALL_SEGMENTS to view information regarding LOB segments. As mentioned earlier, an initial segment is not created until you insert a row into the table (deferred segment creation). This can be confusing because you may expect a row to be present in DBA/ALL/USER_SEGMENTS immediately after you create the table:  

text[[117, 553, 876, 683]]
SQL> select segment_name, segment_type, segment_subtype, bytes/1024/1024 meg_bytes from user_segments where segment_name IN ('&table_just_created', '&lob_segment_just_created', '&lob_index_just_created');  

text[[117, 706, 802, 724]]
The prior query prompts for the segment names. The output shows no rows:  

text[[118, 746, 314, 761]]
no rows selected  

text[[116, 782, 699, 800]]
Next, insert a record into the table that contains the LOB column:  

text[[117, 818, 710, 835]]
SQL> insert into patchmain values(1,'clob text');

--- Page 12 ---

text[[117, 106, 881, 150]]
Rerunning the query against USER_SEGMENTS shows that three segments have been created—one for the table, one for the LOB segment, and one for the LOB index:  

table[[118, 170, 878, 237]]

<table>SEGMENT NAMESEGMENT TYPESEGMENT SUMEG BYTESPATCHMAINTABLEASSM.0625SYS_IL0000022332C00002&#x27;$LOBINDEXASSM.0625SYS_LOB0000022332C00002&#x27;$LOBSEGMENTASSM.0625</table>  

sub_title[[117, 321, 550, 339]]
## Implementing a LOB in a Specific Tablespace  

text[[116, 347, 881, 468]]
By default, the LOB segment is stored in the same tablespace as its table. You can specify a separate tablespace for a LOB segment by using the LOB...STORE AS clause of the CREATE TABLE statement. The next table creation script creates the table in a tablespace and creates separate tablespaces for the CLOB and BLOB columns:  

text[[117, 487, 677, 615]]
SQL> create table patchmain (patch_id number ,patch_desc clob ,patch blob ) tablespace users lob (patch_desc) store as (tablespace lob_data); ,lob (patch) store as (tablespace lob_data);  

text[[118, 636, 734, 654]]
The following query verifies the associated tablespaces for this table:  

text[[117, 674, 815, 788]]
SQL> select table_name, tablespace_name, 'N/A' column_name from user_tables where table_name='PATCHMAIN' union select table_name, tablespace_name, column_name from user_lobs where table_name='PATCHMAIN';  

text[[118, 809, 288, 825]]
Here is the output:  

table[[117, 844, 739, 893]]

<table>TABLE_NAMETABLESPACE_NAMECOLUMN_NAME---------------------------------------------------PATCHMAINLOB_DATAPATCH</table>

text[[118, 920, 303, 932]]
Chapter 11: Large Objects

--- Page 13 ---

text[[117, 104, 240, 135]]
PATCHMAIN PATCHMAIN  

text[[351, 103, 460, 134]]
LOB_DATA USERS  

text[[630, 102, 745, 133]]
PATCH_DESC N/A  

text[[117, 155, 883, 249]]
If you think the LOB segment will require different storage characteristics (such as size and growth patterns), then it is recommended that you create the LOB in a separated tablespace from that of the table data. This allows you to manage the LOB column storage separately from the regular table data storage.  

sub_title[[118, 256, 472, 274]]
## Creating a Secure Files LOB Column  

text[[117, 281, 883, 400]]
As discussed previously, the default LOB architecture is Secure Files. Having said that, I recommend that you explicitly state which LOB architecture to implement in order to avoid any confusion. As mentioned earlier, the tablespace that contains the Secure File LOB must be ASSM managed. Here is an example that creates a Secure Files LOB:  

text[[117, 422, 464, 492]]
SQL> create table patchmain( patch_id number ,patch_desc clob) lob(patch_desc) store as securefile (tablespace lob_data);  

text[[118, 515, 881, 610]]
Before viewing the data dictionary details regarding the LOB column, insert a record into the table to ensure that segment information is available (owing to the deferred segment allocation feature in Oracle Database 11g Release 2 and higher); for example:  

text[[118, 628, 710, 646]]
SQL> insert into patchmain values(l,'clob text');  

text[[117, 667, 842, 684]]
You can now verify a LOB's architecture by querying the USER_SEGMENTS view:  

text[[118, 704, 775, 736]]
SQL> select segment_name, segment_type, segment_subtype from user_segments;  

text[[117, 755, 853, 774]]
Here is some sample output, indicating that a LOB segment is a Secure Files type:  

table[[118, 792, 846, 865]]

<table>SEGMENT_NAMESEGMENT_TYPESEGMENT_SUPATCHMAINTABLEASSMSYS_IL0000022340C00002&#x27;$LOBINDEXASSMSYS_LOB0000022340C00002&#x27;$LOBSEGMENTSECUREFILE</table>

--- Page 14 ---

text[[114, 106, 880, 125]]
You can also query the USER_LOBs view to verify the Secure Files LOB architecture:  

text[[116, 144, 878, 181]]
SQL> select table_name, segment_name, index_name, securefile, in_row from user_lobs;  

title[[118, 202, 288, 218]]
# Here is the output:  

text[[120, 221, 865, 253]]
TABLE_NAME SEGMENT NAME INDEX_NAME SEC IN PATCHMAIN SYS_LOB0000022340C00002$$SYS_IL0000022340C00002$$ YES YES  

text[[116, 289, 881, 360]]
Note: With the SecureFiles architecture, you no longer need to specify the following options: CHUNK, PCTVERSION, FREEPOOLS, FREELIST, and FREELIST GROUPS.  

sub_title[[118, 367, 428, 385]]
## Implementing a Partitioned LOB  

text[[116, 392, 881, 462]]
You can create a partitioned table that has a LOB column. Doing so lets you spread a LOB across multiple tablespaces. Such partitioning helps with balancing I/O, maintenance, and backup and recovery operations.  

text[[115, 470, 882, 540]]
You can partition LOBs by RANGE, LIST, or HASH. The next example creates a LIST- Partitioned table in which LOB column data are stored in tablespaces separate from those of the table data:  

text[[116, 558, 652, 889]]
SQL> CREATE TABLE patchmain( patch_id NUMBER ,region VARCHAR2(16) ,patch_desc CLOB) LOB(patch_desc) STORE AS (TABLESPACE patch1) PARTITION BY LIST (REGION) ( PARTITION p1 VALUES ('EAST') LOB(patch_desc) STORE AS SECUREFILE (TABLESPACE patchl COMPRESS HIGH) TABLESPACE inv_data1, PARTITION p2 VALUES ('WEST') LOB(patch_desc) STORE AS SECUREFILE (TABLESPACE patch2 DEDUPLICATE NCOMPRESS) TABLESPACE inv_data2, PARTITION p3 VALUES (DEFAULT) LOB(patch_desc) STORE AS SECUREFILE (TABLESPACE patch3 COMPRESS LOW) TABLESPACE inv_data3

--- Page 15 ---

text[[117, 101, 147, 115]]  

text[[116, 140, 880, 184]]
Note that each LOB partition is created with its own storage options. You can view the details about the LOB partitions as shown:  

text[[118, 205, 876, 260]]
SQL> select table_name, column_name, partition_name, tablespace_name, compression, deduplication from user_lob_partitions;  

title[[119, 284, 377, 302]]
# Here is some sample output:  

text[[122, 319, 864, 431]]
TABLE_NAM COLUMN_NAME PARTITION TABLESPACE_NAM COMPR DEDUPLICATIO E E E N PATCHMAIN PATCH_DESC P1 PATCHI HIGH NO PATCHMAIN PATCH_DESC P2 PATCH2 NO LOB PATCHMAIN PATCH_DESC P3 PATCH3 LOW NO  

text[[117, 452, 881, 497]]
Note: You can also view DBA/ALL_USER_PART_LOBS for information about partitioned LOBS.  

text[[116, 503, 880, 574]]
You can change the storage characteristics of a partitioned LOB column after it is created. To do so, use the ALTER TABLE ... MODIFY PARTITION statement. This example alters a LOB partition to have a high degree of compression:  

text[[117, 591, 679, 629]]
SQL> alter table patchmain modify partition p2 lob (patch_desc) (compress high);  

text[[118, 648, 880, 693]]
The next example modifies a partitioned LOB not to keep duplicate values (via the DEDUPLICATE clause):  

text[[117, 712, 679, 749]]
SQL> alter table patchmain modify partition p3 lob (patch_desc) (deduplicate lob);  

text[[116, 770, 881, 838]]
Note: Partitioning and Advanced Compression, which have been discussed in this chapter, are extra cost options that are available only with the Oracle Enterprise Edition.

--- Page 16 ---

sub_title[[119, 108, 469, 129]]
## 5. Maintaining LOB Columns:  

text[[117, 142, 881, 210]]
Some common maintenance tasks that are performed on LOB columns or that otherwise involve LOB columns, including moving columns between tablespaces and adding new LOB columns to a table.  

sub_title[[119, 245, 338, 262]]
## Moving a LOB Column  

text[[116, 269, 881, 440]]
If you create a table with a LOB column and do not specify a tablespace, then, by default, the LOB is created in the same tablespace as its table. This happens sometimes in environments in which the DBAs do not plan ahead very well; only after the LOB column has consumed large amounts of disk space does the DBA wonder why the table has grown so big. You can use the ALTER TABLE...MOVE...STORE AS statement to move a LOB column to a tablespace separate from that of the table. Here is the basic syntax:  

text[[117, 462, 880, 499]]
SQL> alter table <table_name> move lob(<lob_name>) store as (tablespace <new_tablespace);  

text[[118, 520, 764, 538]]
The next example moves the LOB column to the LOB_DATA tablespace:  

text[[117, 557, 626, 611]]
SQL> alter table patchmain move lob(patch_desc) store as securefile (tablespace lob_data);  

text[[118, 632, 709, 650]]
You can verify that the LOB was moved by querying USER_LOBS:  

text[[117, 670, 880, 705]]
SQL> select table_name, column_name, tablespace_name from user_lobs;  

text[[116, 727, 881, 820]]
To summarize, if the LOB column is populated with large amounts of data, you almost always want to store the LOB in a tablespace separate from that of the rest of the table data. In these scenarios, the LOB data have different growth and storage requirements and are best maintained in their own tablespace.

--- Page 17 ---

sub_title[[119, 106, 350, 124]]
## Adding a LOB Column  

text[[117, 132, 881, 200]]
Adding a LOB ColumnIf you have an existing table to which you want to add a LOB column, use the ALTER TABLE...ADD statement. The next statement adds the INV_IMAGE column to a table:  

text[[119, 220, 684, 238]]
SQL> alter table patchmain add(inv_image blob);  

text[[117, 256, 881, 329]]
This statement is fine for quickly adding a LOB column to a development environment. For anything else, you should specify the storage characteristics. For instance, this command specifies that a SecureFiles LOB be created in the LOB_DATA tablespace:  

text[[117, 346, 797, 383]]
SQL> alter table patchmain add(inv_image blob) lob(inv_image) store as securefile(tablespace lob_data);  

sub_title[[119, 412, 364, 430]]
## Removing a LOB Column  

text[[117, 438, 881, 507]]
You may have a scenario in which your business requirements change, and you no longer need a column. Before you remove a column, consider renaming it so that you can better identify whether any applications or users are still accessing it:  

text[[117, 524, 881, 561]]
SQL> alter table patchmain rename column patch_desc to patch_desc_old;  

text[[119, 582, 880, 625]]
After you determine that nobody is using the column, use the ALTER TABLE...DROP statement to drop it:  

text[[117, 644, 699, 662]]
SQL> alter table patchmain drop(patch_desc_old);  

text[[116, 681, 883, 828]]
You can also remove a LOB column by dropping and re- creating a table (without the LOB column). This, of course, permanently removes any data as well. Also keep in mind that if your recycle bin is enabled, then when you do not drop a table with the PURGE clause, space is still consumed by the dropped table. If you want to remove the space associated with the table, use the PURGE clause, or purge the recycle bin after dropping the table.

--- Page 18 ---

sub_title[[118, 107, 263, 124]]
## Caching LOBs  

text[[115, 132, 881, 201]]
By default, when reading and writing LOB columns, Oracle does not cache LOBs in memory. You can change the default behavior by setting the cache- related storage options. This example specifies that Oracle should cache a LOB column in memory:  

text[[115, 222, 759, 295]]
SQL> create table patchmain( patch_id number ,patch_desc clob) lob(patch_desc) store as (tablespace lob_data cache);  

text[[117, 319, 545, 336]]
You can verify the LOB caching with this query:  

text[[115, 357, 821, 375]]
SQL> select table_name, column_name, cache from user_lobs;  

text[[118, 394, 380, 411]]
Here is some sample output:  

table[[120, 430, 833, 499]]

<table>TABLE_NAMECOLUMN_NAMECACHE------PATCHMAINPATCH_DESCYES</table>  

text[[115, 515, 881, 609]]
If you have LOBs that are frequently read and written to, consider using the CACHE option. If your LOB column is read frequently but rarely written to, then the CACHE READS setting is more appropriate. If the LOB column is infrequently read or written to, then the NOCACHE setting is suitable.  

sub_title[[118, 642, 447, 660]]
## Storing LOBs In- and Out of Line  

text[[115, 667, 881, 788]]
By default, up to approximately 4,000 characters of a LOB column are stored inline with the table row. If the LOB is more than 4,000 characters, then Oracle automatically stores it outside the row data. The main advantage of storing a LOB in row is that small LOBs (fewer than 4,000 characters) require less I/O, because Oracle does not have to search out of row for the LOB data.  

text[[115, 796, 881, 889]]
However, storing LOB data in row is not always desirable. The disadvantage of storing LOBs in row is that the table row sizes are potentially longer. This can affect the performance of full- table scans, range scans, and updates to columns other than the LOB column.

--- Page 19 ---

text[[117, 106, 873, 150]]
In these situations, you may want to disable storage in the row. For example, you explicitly instruct Oracle to store the LOB outside the row with the DISABLE STORAGE  

text[[118, 160, 273, 176]]
IN ROW clause:  

text[[117, 197, 456, 344]]
SQL> create table patchmain( patch_id number ,patch_desc clob ,log_file blob) lob(patch_desc, log_file) store as ( tablespace lob_data disable storage in row);  

text[[118, 368, 873, 413]]
If you want to store up to 4,000 characters of a LOB in the table row, use the ENABLE STORAGE IN ROW clause when creating the table:  

text[[117, 431, 456, 578]]
SQL> create table patchmain( patch_id number ,patch_desc clob ,log_file blob) lob(patch_desc, log_file) store as ( tablespace lob_data enable storage in row);  

text[[118, 599, 645, 618]]
Note: The LOB locator is always stored inline with the row.  

text[[117, 650, 873, 720]]
You cannot modify the LOB storage in a row after the table has been created. The only ways to alter storage in row are to move the LOB column or drop and re- create the table. This example alters the storage in row by moving the LOB column:  

text[[117, 742, 512, 796]]
SQL> alter table patchmain move lob(patch_desc) store as (enable storage in row);  

text[[118, 821, 775, 839]]
You can verify the in- row storage via the IN_ROW column of USER_LOBS:  

text[[117, 860, 842, 895]]
SQL> select table_name, column_name, tablespace_name, in_row from user_lobs;

--- Page 20 ---

text[[117, 106, 610, 123]]
A value of YES indicates that the LOB is stored in row: 

table[[122, 142, 852, 225]]
<table>TABLE_NAMECOLUMN_NAMETABLESPACE_NAMEIN_ROW----PATCHMAINLOG_FILELOB_DATAYESPATCHMAINPATCH_DESCLOB_DATAYES</table>

--- Page 21 ---

sub_title[[117, 108, 559, 129]]
## 6. Measuring LOB Space Consumed:  

text[[116, 141, 883, 263]]
As discussed previously, a LOB consists of an in- row lob locator, a LOB index, and a LOB segment that is made up of one or more chunks. The space used by the LOB index is usually negligible compared with the space used by the LOB segment. You can view the space consumed by a segment by querying the BYTES column of DBA/ALL/USER_SEGMENTS (just like any other segment in the database).  

sub_title[[117, 294, 210, 311]]
## Example:  

text[[116, 334, 786, 389]]
SQL> select segment_name, segment_type, segment_subtype, bytes/1024/1024 meg_bytes from user_segments;  

text[[117, 412, 876, 432]]
You can modify the query to report on only LOBs by joining to the USER_LOBS view:  

text[[116, 453, 874, 546]]
SQL> select a.table_name, a.column_name, a.segment_name, a.index_name ,b.bytes/1024/1024 meg_bytes from user_lobs_a,user_segments b where a.segment_name = b.segment_name;  

text[[116, 567, 880, 637]]
You can also use the DBMS_SPACE.SPACE_USAGE package and procedure to report on the blocks being used by a LOB. This package only works on objects that have been created in an ASSM- managed tablespace.  

text[[117, 670, 879, 713]]
There are two different forms of the SPACE_USAGE procedure: one form reports on Basic Files LOBs, and the other reports on Secure Files LOBs.  

sub_title[[118, 746, 346, 764]]
## Basic Files Space Used  

text[[116, 772, 879, 814]]
Here is an example of how to call DBMS_SPACE.SPACE_USAGE for a Basic Files LOB:  

text[[117, 838, 351, 891]]
SQL> declare p_fs1_bytes number; p_fs2_bytes number;

--- Page 22 ---

text[[117, 100, 596, 725]]
p_fs3_bytes number; p_fs4_bytes number; p_fsl_blocks number; p_fs2_blocks number; p_fs3_blocks number; p_fs4_blocks number; p_full_bytes number; p_full_blocks number; p_unformatted_bytes number; p_unformatted_blocks number; begin dbms_space.space_usage( segment_owner => user, segment_name => 'SYS_L0B0000024082C00002$$', segment_type => 'LOB', fs1_bytes => p_fsl_bytes, fs1_blocks => p_fsl_blocks, fs2_bytes => p_fs2_bytes, fs2_blocks => p_fs2_blocks, fs3_bytes => p_fs3_bytes, fs3_blocks => p_fs3_blocks, fs4_bytes => p_fs4_bytes, fs4_blocks => p_fs4_blocks, full_bytes => p_full_bytes, full_blocks => p_full_blocks, unformatted_blocks => p_unformatted_blocks, unformatted_bytes => p_unformatted_bytes ); dbms_output.put_line('Full bytes = '||p_full_bytes); dbms_output.put_line('Full blocks = '||p_full_blocks); dbms_output.put_line('UF bytes = '||p_unformatted_bytes); dbms_output.put_line('UF blocks = '||p_unformatted_blocks); end; /  

text[[117, 735, 880, 779]]
In this PL/SQL, you need to modify the code so that it reports on the LOB segment in your environment.

--- Page 23 ---

sub_title[[119, 106, 366, 123]]
## Secure Files Space Used  

text[[116, 132, 876, 151]]
Here is an example of how to call DBMS_SPACE.SPACE_USAGE for a Secure Files  

title[[117, 159, 169, 175]]
# LOB:  

text[[118, 181, 253, 196]]
SQL> DECLARE  

text[[176, 199, 577, 447]]
1_segment_owner varchar2(40);  1_table_name varchar2(40);  1_segment_name varchar2(40);  1_segment_size_blocks number;  1_segment_size_bytes number;  1_used_blocks number;  1_used_bytes number;  1_expired_blocks number;  1_expired_bytes number;  1_unexpired_blocks number;  1_unexpired_bytes number;  

text[[176, 421, 322, 436]]
CURSOR c1 IS  

text[[177, 440, 640, 456]]
SELECT owner, table_name, segment_name  

text[[178, 460, 343, 473]]
FROM dba_lobs  

text[[176, 477, 553, 492]]
WHERE table_name = 'PATCHMAIN';  

title[[118, 496, 185, 509]]
# BEGIN  

text[[139, 514, 343, 528]]
FOR r1 IN c1 LOOP  

text[[163, 532, 540, 600]]
1_segment_owner := rl.owner;  1_table_name := rl.table_name;  1_segment_name := rl.segment_name;  

text[[164, 604, 811, 620]]
dbms_output.put_line('---------------------');  

text[[163, 623, 810, 639]]
dbms_output.put_line('Table Name : ' || l_table_name);  

text[[162, 641, 863, 657]]
dbms_output.put_line('Segment Name : ' || l_segment_name);  

text[[164, 660, 187, 670]]
- -  

text[[163, 678, 459, 692]]
dbms_space.space_usage(  

text[[176, 696, 573, 711]]
segment_owner => l_segment_owner;  

text[[177, 715, 550, 730]]
segment_name => l_segment_name,  

text[[178, 734, 440, 748]]
segment_type => 'LOB',  

text[[176, 752, 455, 766]]
partition_name => NULL,  

text[[177, 770, 716, 785]]
segment_size_blocks => l_segment_size_blocks,  

text[[178, 788, 702, 803]]
segment_size_bytes => l_segment_size_bytes,  

text[[176, 807, 521, 821]]
used_blocks => l_used_blocks,  

text[[177, 825, 501, 840]]
used_bytes => l_used_bytes,  

text[[178, 844, 596, 858]]
expired_blocks => l_expired_blocks,  

text[[176, 861, 574, 876]]
expired_bytes => l_expired_bytes,

--- Page 24 ---

text[[117, 100, 650, 436]]
unexpired_blocks => l_unexpired_blocks, unexpired_bytes => l_unexpired_bytes ); dbsm_output.put_line('segment_size_blocks:''||l_segment_size_block oss); dbsm_output.put_line('segment_size_bytes:''||l_segment_size_bytes); dbsm_output.put_line('used_blocks : ''|| l_used_blocks); dbsm_output.put_line('used_bytes : ''|| l_used_bytes)); dbsm_output.put_line('expired_blocks : ''|| l_expired_blocks); dbsm_output.put_line('expired_bytes : ''|| l_expired_bytes); dbsm_output.put_line('unexpired_blocks : ''|| l_unexpired_blocks); dbsm_output.put_line('unexpired_bytes : ''|| l_unexpired_bytes); END LOOP; END; /  

text[[117, 456, 879, 500]]
Again, in this PL/SQL, you need to modify the code so that it reports on the table with the LOB segment in your environment.

--- Page 25 ---

sub_title[[120, 108, 351, 128]]
## 7.Reading BFILES:  

text[[116, 141, 882, 261]]
As discussed previously, a BFILE data type is simply a column in a table that stores a pointer to an OS file. A BFILE provides you with read- only access to a binary file on disk. To access a BFILE, you must first create a directory object. This is a database object that stores the location of an OS directory. The directory object makes Oracle aware of the BFILE location on disk.  

sub_title[[118, 270, 208, 286]]
## Example:  

text[[116, 295, 880, 339]]
In this example we will create first a directory object, then create a table with a BFILE column, and then we will use the DBMS_LOB package to access a binary file:  

text[[117, 357, 879, 391]]
SQL> create or replace directory load_lob as '/orahome/oracle/lob';  

text[[116, 410, 622, 428]]
Next, a table is created that contains a BFILE data type:  

text[[117, 449, 448, 502]]
SQL> create table patchmain (patch_id number ,patch_file bfile);  

text[[116, 523, 879, 590]]
For this example, a file named patch.zip is located in the aforementioned directory. You make Oracle aware of the binary file by inserting a record into the table using the directory object and the file name:  

text[[115, 612, 876, 649]]
SQL> insert into patchmain values(l, bfilename('LOAD_LOB','patch.zip'));  

text[[116, 673, 880, 716]]
Now, you can access the BFILE via the DBMS_LOB package. For instance, if you want to verify that the file exists or display the length of the LOB, you can do so as follows:  

text[[115, 740, 879, 813]]
SQL>select dbms_lob.fileexists(bfilename('LOAD_LOB','patch.zip')) from dual; SQL> select dbms_lob.getlength(path_file) from patchmain;  

text[[116, 836, 880, 878]]
In this manner, the binary file behaves like a BLOB. The big difference is that the binary file is not stored within the database.

--- Page 26 ---

sub_title[[118, 108, 217, 127]]
## 8. Quiz:  

text[[117, 141, 696, 160]]
1. What is the wrong statement related to supported LOB types?  

text[[147, 167, 542, 290]]
a) Character large object (CLOB) 
b) Date large object (DLOB) 
c) Binary large object (BLOB) 
d) Binary file (BFILE) 
e) National character large object (NCLOB)  

text[[117, 319, 880, 364]]
2. Which is the correct statements about LOB types that stores character documents, such as big text files, log files, XML files, and so on?  

text[[147, 371, 250, 466]]
a) BLOB 
b) NCLOB 
c) CLOB 
d) BFILE 

text[[117, 499, 880, 543]]
3. Which is the correct statements about LOB types that stores data in national character set format; supports characters with varying widths?  

text[[147, 550, 250, 644]]
a) BLOB 
b) NCLOB 
c) CLOB 
d) BFILE 

text[[117, 678, 880, 722]]
4. Which is the correct statements about LOB types that stores unstructured bitstream data (images, video, and so on)?  

text[[147, 729, 250, 823]]
a) BLOB 
b) NCLOB 
c) CLOB 
d) BFILE

--- Page 27 ---

text[[117, 105, 803, 124]]
5. LOBs are a data type that is suited to storing large and unstructured data.  

text[[147, 132, 228, 176]]
a) True 
b) False  

text[[116, 207, 880, 253]]
6. Which is the correct statements about LOB types that stores on the file system outside of database; read-only?  

text[[147, 260, 241, 353]]
a) BLOB 
b) NCLOB 
c) CLOB 
d) BFILE  

text[[117, 385, 881, 458]]
7. BFILES participate in database transactions and can be backed up, restored, and recovered by Oracle. In other words, all the Atomicity Consistency Isolation Durability (ACID) properties  

text[[147, 465, 228, 509]]
a) True 
b) False  

text[[117, 540, 880, 584]]
8. Which LOBs do participate in database transactions and can be backed up, restored, and recovered by Oracle?  

text[[147, 592, 362, 662]]
a) BLOB 
b) All the other options 
c) BFILE  

text[[116, 693, 880, 737]]
9. Which LOBs do not participate in database transactions and cannot be backed up, restored, and recovered by Oracle?  

text[[147, 745, 362, 814]]
a) BLOB 
b) All the other options 
c) BFILE

--- Page 28 ---

text[[117, 105, 881, 150]]
10. What is the ideal option for storing and manipulating semi-structured data include document files such as json, XML documents or word processor, and log files?  

text[[147, 157, 351, 253]]
a) BLOB 
b) CLOB only 
c) CLOB and NCLOB 
d) BFILE  

text[[117, 284, 881, 329]]
11. Which is the correct statement about LOBs where locators are stored in rows containing a LOB column?  

text[[147, 336, 426, 433]]
a) Internal LOBs 
b) Internal and External LOBs 
c) External LOBs 
d) None of the other options  

text[[117, 464, 880, 509]]
12. Which is the correct statement about LOBs where the LOB locator for a BFILE stores the directory path and file name on the OS?  

text[[147, 516, 479, 611]]
a) Internal LOBs 
b) Internal LOBs and External LOBs 
c) External LOBs 
d) None of the other options  

text[[117, 641, 881, 713]]
13. BLOBs participate in database transactions and can be backed up, restored, and recovered by Oracle. In other words, all the Atomicity Consistency Isolation Durability (ACID) properties  

text[[147, 720, 230, 762]]
a) True 
b) False

--- Page 29 ---

text[[117, 106, 862, 125]]
14. What is the default type of LOB that should be used as the way to store LOBs?  

text[[148, 133, 470, 227]]
a) BasicFiles 
b) None of the other options 
c) Both BasicFiles and SecureFiles 
d) SecureFiles  

text[[117, 259, 877, 302]]
15. What is the true statement about SecureFiles' enhancements over BasicFiles LOBs?  

text[[148, 310, 600, 405]]
a) Encryption and Compression and Deduplication 
b) Compression only 
c) Deduplication only 
d) Encryption and Compression only  

text[[117, 439, 790, 458]]
16. What is the meaning of the deduplication feature of SecureFiles LOBs?  

text[[148, 465, 825, 560]]
a) Eliminates extra data that LOBs contains over 6GB. 
b) Eliminates extra data that LOBs contains over 2GB. 
c) Eliminates duplicate LOBs that otherwise would be stored multiple times. 
d) Duplicates LOBs that otherwise would be stored multiple times.  

text[[117, 592, 880, 635]]
17. What is the command you can use to modify the value of DB_SECUREFILE parameter?  

text[[148, 643, 642, 738]]
a) ALTER SYSTEM only 
b) Either ALTER SYSTEM or ALTER SESSION 
c) ALTER SESSION only 
d) The value of DB_SECUREFILE cannot be changed  

text[[117, 770, 797, 788]]
18. Oracle creates a LOB segment and a LOB index for each LOB column?  

text[[148, 796, 230, 839]]
a) True 
b) False

--- Page 30 ---

text[[117, 105, 876, 123]]
19. Choose the correct statement that describe the implemented of partitioned LOB?  

text[[147, 131, 697, 227]]
a) Storage options are the same for all partitions  
b) No partitions for a LOB at all  
c) Only one partition is allowed for a LOB  
d) Each LOB partition is created with its own storage options  

text[[117, 257, 880, 303]]
20. When a table is queried, the database uses the LOB locator and associated LOB index to locate the appropriate LOB chunks.  

text[[147, 310, 227, 351]]
a) True  
b) False

--- Page 31 ---

table[[184, 100, 805, 656]]
<table><td colspan="2">Quiz answers - chapter 111b2c3b4a5a6d7b8a9c10c11a12c13a14d15a16c17b18a19d20a</table>

--- Page 32 ---

sub_title[[120, 108, 260, 126]]
## References:  

sub_title[[119, 142, 183, 158]]
## Books  

text[[147, 166, 883, 338]]
1. Oracle Database Administrator's Guide, 18c (Oracle University), March 2019, Primary Author: Rajesh Bhatiya, Randy Urbano  
2. database-new-features-guide (Oracle University), 18c E88909-01 February 2018, Primary Authors: Tanaya Bhattacharjee, Sunil Surabhi, Mark Baue  
3. The Cloud DBA-Oracle: Managing Oracle Database in the Cloud - First Edition, Abhinivesh Jain and Niraj Mahajan. Apress - ISBN-13 (pbk): 978-1-4842-2634-6 ISBN-13 (electronic): 978-1-4842-2635-3  

sub_title[[119, 370, 216, 386]]
## Web Sites  

text[[147, 395, 817, 515]]
1. https://docs.oracle.com/database  
2. https://docs.oracle.com/en/database/oracle/oracle-database/19/whats-new.html  
3. http://www.oracle.com/technetwork/database/enterprise-edition/downloads/index.html
