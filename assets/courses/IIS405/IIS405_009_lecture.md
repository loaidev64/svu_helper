--- Page 1 ---

title[[120, 308, 878, 351]]
# Oracle Database Administration  

text[[485, 373, 514, 403]]
I  

text[[123, 453, 876, 528]]
Chapter 9: Schema Objects: Indexes, Views, Synonyms, and Sequences

--- Page 2 ---

sub_title[[732, 148, 887, 170]]
## :محتويات الفصل 

text[[117, 210, 880, 228]]
Objectives ........................................................................................................................................ 2 

text[[118, 236, 881, 253]]
1. Deciding When to Create an Index? .................................................................................... 3 

text[[116, 260, 883, 277]]
2. Types of Indexes ..................................................................................................................... 5 

text[[137, 284, 884, 301]]
2.1. B-tree index .......................................................................................................................... 5 

text[[138, 308, 885, 324]]
2.2. Bitmap index ....................................................................................................................... 6 

text[[116, 331, 883, 348]]
3. Creating Separate Tablespaces for Indexes ........................................................................... 8 

text[[117, 355, 884, 371]]
4. Creating Indexes ..................................................................................................................... 9 

text[[118, 378, 881, 395]]
5. Maintaining Indexes ............................................................................................................ 13 

text[[116, 401, 883, 418]]
6. Implementing Views ........................................................................................................... 15 

text[[117, 424, 884, 441]]
7. Managing Synonyms ............................................................................................................. 21 

text[[118, 448, 881, 465]]
8. Managing Sequences ............................................................................................................ 23 

text[[116, 471, 883, 488]]
9. Quiz ........................................................................................................................................... 27 

text[[117, 495, 884, 511]]
References ............................................................................................................................. 33

--- Page 3 ---

sub_title[[117, 106, 254, 126]]
Objectives: 

text[[150, 140, 319, 156]]
1. Create indexes 

text[[149, 167, 294, 183]]
2. Create views 

text[[148, 193, 340, 209]]
3. Create Synonyms 

text[[147, 220, 344, 235]]
4. Create sequences

--- Page 4 ---

sub_title[[119, 108, 571, 128]]
## 1. Deciding When to Create an Index?  

sub_title[[117, 142, 254, 158]]
## What is index  

text[[115, 167, 882, 262]]
An index is an optionally created database object used primarily to increase query performance. Indexes can also limit the amount of data that is returned in the results without having to retrieve all of data columns of a table. This can help keep results in memory and bring back results faster.  

text[[115, 268, 881, 339]]
Without indexes, the entire table is scanned (full table scan) with each DML operation on the table. Indexes are created automatically when a primary or unique keys are defined. Indexes allow for excellent scalability, even with very large data sets.  

sub_title[[117, 372, 347, 388]]
## When to create indexes  

text[[115, 397, 882, 567]]
If indexes are so important to database performance, why not place them on all tables and column combinations? The answer is short: indexes are not free. They consume disk space and system resources. As column values are modified, any corresponding indexes must also be updated. In this way, indexes use storage, I/O, CPU, and memory resources. A poor choice of indexes leads to wasted disk usage and excessive consumption of system resources. This results in a decrease in database performance and greater cost for DML statements.  

text[[117, 574, 881, 617]]
There are usually two different situations in which DBAs and developers decide to create indexes:  

text[[145, 625, 882, 720]]
- Proactively, when first deploying an application; the DBAs/developers make an educated guess as to which tables and columns to index.- Reactively, when application performance bogs down, and users complain of poor performance  

sub_title[[117, 755, 285, 771]]
## Indexes in oracle  

text[[115, 780, 882, 873]]
Oracle allows you to create an index that contains more than one column. Multicolumn indexes are known as concatenated indexes (also called composite indexes). These indexes are especially effective when you often use multiple columns in the WHERE clause when accessing a table.

--- Page 5 ---

text[[116, 105, 884, 250]]
Columns included in the SELECT and WHERE clauses are also potential candidates for indexes. Sometimes, a covering index in a SELECT clause results in Oracle using the index structure itself (and not the table) to satisfy the results of the query. Also consider creating indexes on columns used in the ORDER BY, GROUP BY, UNION, and DISTINCT clauses. This may result in greater efficiency for queries that frequently use these SQL constructs.

--- Page 6 ---

sub_title[[119, 108, 370, 129]]
## 2. Types of Indexes:  

title[[117, 142, 309, 160]]
#### 2.1.B-tree index:  

sub_title[[118, 173, 371, 190]]
## Definition of B-tree index  

text[[116, 198, 882, 268]]
Default index; good for columns with high cardinality (i.e., high degree of distinct values). Use a normal B- tree index unless you have a concrete reason to use a different index type or feature.  

sub_title[[118, 300, 370, 317]]
## Structure of B-tree index:  

text[[116, 325, 880, 368]]
At the top of the index is the root, which contains entries that point to the next level in the index.  

text[[145, 376, 881, 522]]
- At the next level are branch blocks, which in turn point to blocks at the next level in the index.- At the lowest level are the leaf nodes, which contain the index entries that point to rows in the table.- The leaf blocks are doubly linked to facilitate the scanning of the index in an ascending as well as descending order of key values.  

sub_title[[118, 555, 391, 572]]
## Format of Index Leaf Entries  

text[[116, 581, 525, 599]]
An index entry has the following components:  

text[[145, 606, 881, 730]]
- Entry header: Stores the number of columns and locking information- Key column length-value pairs: Define the size of a column in the key followed by the value for the column (The number of such pairs is the maximum of the number of columns in the index.)- ROWID: Row ID of a row that contains the key values

--- Page 7 ---

image[[205, 106, 780, 375]]  

sub_title[[117, 408, 395, 425]]
## When to use B-Tree indexes  

text[[116, 434, 720, 452]]
The cardinality (the number of distinct values) in the column is high  

text[[146, 460, 560, 478]]
- The number of rows in the table is high, and  

text[[147, 487, 696, 504]]
- The column is used in WHERE clauses or JOIN conditions  

sub_title[[118, 537, 311, 555]]
### 2.2. Bitmap index:  

sub_title[[119, 567, 370, 584]]
## Definition of Bitmap index  

text[[116, 592, 881, 688]]
Excellent in data warehouse environments with low cardinality (i.e., low degree of distinct values) columns and SQL statements using many AND or OR operators in the WHERE clause. Bitmap indexes are not appropriate for OLTP databases in which rows are frequently updated. You cannot create a unique bitmap index.  

sub_title[[119, 721, 380, 737]]
## Structure of a Bitmap Index  

text[[116, 745, 880, 839]]
A bitmap index is also organized as a B- tree, but the leaf node stores a bitmap for each key value instead of a list of row IDs. Each bit in the bitmap corresponds to a possible row ID, and if the bit is set, this means that the row with the corresponding row ID contains the key value.

--- Page 8 ---

text[[117, 106, 826, 125]]
As shown in the diagram, the leaf node of a bitmap index contains the following:  

text[[147, 132, 835, 150]]
An entry header that contains the number of columns and lock information.  

text[[148, 158, 878, 227]]
Key values consisting of length and value pairs for each key column (In the slide example, the key consists of only one column; the first entry has a key value of Blue).  

text[[147, 234, 876, 280]]
Start ROWID, which in the example specifies block number 10, row number 0, and file number 3  

text[[148, 287, 875, 332]]
End ROWID, which in the example specifies block number 12, row number 8, and file number 3  

text[[147, 338, 878, 434]]
A bitmap segment consisting of a string of bits (The bit is set when the corresponding row contains the key value and is unset when the row does not contain the key value. The Oracle server uses a patented compression technique to store bitmap segments.)  

image[[197, 462, 741, 716]]  

sub_title[[117, 744, 394, 761]]
## When to use Bitmap indexes  

text[[147, 769, 760, 840]]
The cardinality (the number of distinct values) in the column is low The number of rows in the table is high The column is used in Boolean algebra operations

--- Page 9 ---

sub_title[[117, 107, 668, 128]]
## 3. Creating Separate Tablespaces for Indexes:  

text[[115, 140, 883, 287]]
Space consumption and object growth have a direct impact on database availability. If you run out of space, your database will become unavailable. The best way to manage space in the database is by creating tablespaces tailored to space requirements and then creating objects in specified tablespaces that you have designed for those objects. It is recommended that you separate tables and indexes into different tablespaces. Consider the following reasons:  

text[[147, 293, 883, 466]]
Doing so allows for differing backup and recovery requirements Tables and indexes often have different storage requirements (such as extent size and logging) When running maintenance reports, it is sometimes easier to manage tables and indexes when the reports have sections separated by tablespace Doing so increase the performance of actions especially, when the different tablespaces are on separate controllers

--- Page 10 ---

sub_title[[119, 109, 363, 128]]
## 4. Creating Indexes:  

sub_title[[118, 143, 351, 159]]
## Creating B-tree Indexes  

text[[116, 168, 876, 213]]
Creating indexes on the wrong columns or using features in the wrong situations can cause dramatic performance degradation.  

text[[117, 220, 713, 237]]
To create index in Toad of Oracle please follow steps in this video  

text[[116, 269, 558, 287]]
Choose create index from menu as the following:  

image[[157, 313, 824, 570]]  

text[[115, 595, 876, 639]]
Then you enter the name of the index and its schema beside the basic info including the tables name and type of index:

--- Page 11 ---

text[[117, 105, 715, 121]]
Then you enter the columns of table that related to the new index:  

image[[130, 125, 863, 400]]  

text[[119, 430, 728, 447]]
Then you enter the Physical Attributes that related to the new index:

--- Page 12 ---

text[[116, 105, 800, 122]]
Finally, you can see the SQL statement that related to create the new index:  

image[[131, 126, 855, 405]]  

text[[115, 432, 846, 450]]
To create a B- tree index on an existing table, use the CREATE INDEX statement:  

text[[116, 469, 688, 487]]
SQL> CREATE INDEX cust_idx1 ON cust(last_name);  

text[[115, 504, 881, 573]]
Oracle will create a B- tree index as default index type in your default permanent tablespace. For manageability reasons, you want to create the index in a specific tablespace:  

text[[116, 594, 880, 631]]
SQL> CREATE INDEX cust_idx1 ON cust(last_name) TABLESPACE reporting_index;  

text[[115, 652, 881, 696]]
Oracle provides two types of views containing details about the structure of B- tree indexes:  

text[[146, 720, 423, 757]]
INDEX_STATS DBA/ALL/USER_INDEXES  

text[[115, 779, 881, 874]]
The INDEX_STATS view contains information regarding the HEIGHT (number of blocks from root to leaf blocks), LF_ROWS (number of index entries), and so on. The INDEX_STATS view is only populated after you analyze the structure of the index; for example,

--- Page 13 ---

text[[117, 102, 699, 119]]
SQL> analyze index cust_idx1 validate structure;  

text[[115, 123, 882, 219]]
The DBA/ALL/USER_INDEXES views contain statistics, such as BLEVEL (number of blocks from root to branch blocks; this equals HEIGHT- 1); LEAF_BLOCKS (number of leaf blocks); and so on. The DBA/ALL/USER_INDEXES views are populated automatically when the index is created and refreshed via the DBMS_STATS package.  

sub_title[[118, 250, 424, 268]]
## Creating Concatenated Indexes  

text[[115, 276, 882, 421]]
Oracle allows you to create an index that contains more than one column, Multicolumn indexes are known as concatenated indexes. These indexes are especially effective when you often use multiple columns in the WHERE clause when accessing a table. Also, there can be only one visible index for the same combination of columns. Any other indexes created on that same set of columns must be declared invisible; for example:  

text[[115, 442, 876, 496]]
SQL> create index cust_idx2 on cust(first_name, last_name); SQL> create bitmap index cust_bmx1 on cust(first_name, last_name) invisible;  

sub_title[[118, 518, 356, 535]]
## Creating Unique Indexes  

text[[117, 543, 559, 560]]
Use the UNIQUE clause to create a unique index:  

text[[115, 579, 876, 614]]
SQL> create unique index cust_uk1 on cust(first_name, last_name);  

text[[117, 632, 880, 677]]
When you create a primary key constraint or a unique key constraint, Oracle automatically creates a unique index and a corresponding constraint that is visible in DBA/ALL/USER_CONSTRAINTS.  

text[[118, 685, 876, 729]]
You have to look at DBA_INDEXES and DBA_IND_COLUMNS to view the details of the unique index that has been created:  

text[[117, 775, 870, 864]]
SQL> select a.owner, a.index_name, a.uniqueness, b.column_name from dba_indexes a, dba_ind_columns b where a.index_name='CUST_UK1' and a.table_owner = b.table_owner and a.index_name = b.index_name;

--- Page 14 ---

sub_title[[120, 108, 406, 128]]
## 5. Maintaining Indexes:  

text[[117, 142, 309, 159]]
Renaming an Index  

text[[116, 168, 773, 186]]
Use the ALTER INDEX ... RENAME TO statement to rename an index:  

text[[118, 205, 711, 221]]
SQL> alter index cust_idx1 rename to cust_index1;  

sub_title[[119, 242, 428, 259]]
## Displaying the DDL for an index  

text[[117, 268, 881, 310]]
You can use the DBMS_METADATA package to display the DDL required to re- create an Index:  

text[[118, 330, 354, 345]]
SQL> set long 10000  

text[[117, 346, 881, 377]]
SQL> select dbms_metadata.get_ddl('INDEX','CUST_IDX1') from dual;  

text[[118, 397, 471, 414]]
- Here is a partial listing of the output:  

text[[117, 434, 881, 485]]
SQL> CREATE INDEX "MV_MAINT"."CUST_IDX1" ON "MV_MAINT"."CUST" ("CUST ID") PCTFREE 10 INITRANS 2 MAXTRANS 255 INVISIBLE COMPUTE STATISTICS  

text[[118, 504, 553, 521]]
To show all index DDL for a user, run this query:  

text[[117, 541, 881, 573]]
SQL> select dbms_metadata.get_ddl('INDEX','index_name') from user_indexes;  

sub_title[[119, 594, 312, 611]]
## Rebuilding an Index  

text[[118, 620, 524, 636]]
Use the REBUILD clause to rebuild an index:  

text[[117, 657, 539, 673]]
SQL> alter index cust_idx1 rebuild;  

text[[116, 693, 881, 762]]
Oracle attempts to acquire a lock on the table and rebuild the index online. If there are any active transactions that haven't committed, Oracle will not be able to obtain a lock, and the following error will be thrown:  

text[[117, 782, 879, 814]]
ORA- 00054: resource busy and acquire with NOWAIT specified or timeout expired  

text[[116, 834, 881, 877]]
You can either wait until there is little activity in the database or try setting the DDL_LOCK_TIMEOUT parameter:

--- Page 15 ---

text[[117, 103, 646, 119]]
SQL> alter session set ddl_lock_timeout=15;  

sub_title[[118, 148, 365, 165]]
## Making Indexes Unusable  

text[[115, 173, 881, 300]]
If you have identified an index that is no longer being used, you can mark it UNUSABLE. The advantage of marking the index UNUSABLE (rather than dropping it) is that if you later determine that the index is being used, you can alter it to a USABLE state and rebuild it without needing the DDL on hand Here is an example of marking an index UNUSABLE:  

text[[118, 311, 553, 329]]
SQL> alter index cust_idx1 unusable;  

text[[117, 350, 543, 368]]
You can verify that it is unusable via this query:  

text[[116, 386, 711, 404]]
SQL> select index_name, status from user_indexes;  

text[[115, 424, 880, 469]]
If you determine that the index is needed (before you drop it), then it must be rebuilt to become usable again:  

text[[117, 487, 543, 504]]
SQL> alter index cust_idx1 rebuild;  

sub_title[[118, 525, 347, 542]]
## Monitoring Index Usage  

text[[115, 549, 881, 592]]
Use the ALTER INDEX...MONITORING USAGE statement to enable basic index monitoring:  

text[[117, 611, 651, 629]]
SQL> alter index cust_idx1 monitoring usage;  

text[[115, 648, 849, 666]]
To report which indexes are being monitored and have been used, run this query:  

text[[116, 685, 543, 702]]
SQL> select \* from dba_index_usage;  

sub_title[[118, 722, 301, 739]]
## Dropping an Index  

text[[117, 747, 569, 764]]
Use the DROP INDEX statement to drop an index:  

text[[116, 785, 434, 801]]
SQL> drop index cust_idx1;

--- Page 16 ---

sub_title[[119, 108, 397, 128]]
## 6. Implementing Views:  

text[[116, 141, 882, 261]]
Views are representations of queries of data from one or more tables or other views. Views are stored queries because they can hide very complex conditions and joins as well as other complex expressions and SQL constructs. Views do not actually contain data; instead, they derive their data from the tables on which they are based. These tables are referred to as the base tables of the view.  

text[[116, 268, 883, 387]]
Like tables, views can be queried, updated, inserted into, and deleted from- - with some restrictions. All operations performed on a view actually affect the base tables of the view. Views provide an additional level of security by restricting access to a predetermined set of rows and columns of a table. They also hide data complexity and store complex queries. The common uses for views:  

text[[147, 394, 799, 492]]
Create an efficient method of storing an SQL query for reuse Provide an interface layer between an application and physical tables Hide the complexity of an SQL query from an application Report to a user only a subset of columns or rows, or both  

sub_title[[118, 524, 271, 541]]
## Creating a View  

text[[116, 549, 802, 593]]
To Create view in Toad of Oracle please follow the steps shown in the video Choose create view from menu as the following:

--- Page 17 ---

image[[282, 100, 725, 530]]  

text[[114, 557, 873, 600]]
Then you can enter the schema name and the view name and the select statement - step1:  

image[[128, 602, 869, 876]]

--- Page 18 ---

text[[117, 106, 873, 149]]
Then you can enter the schema name and the view name and the select statement - step2:  

image[[130, 151, 865, 431]]  

text[[119, 457, 690, 474]]
Finally, you can see the statement of creating the new view the:  

image[[150, 477, 847, 739]]  

text[[120, 766, 520, 783]]
Or, you can create views directly as follows:  

text[[122, 792, 535, 809]]
Assume that we have the following base table:  

text[[119, 829, 880, 866]]
SQL> create table sales(sales_id number primary key , amnt number, state varchar2(2), sales_person_id number);

--- Page 19 ---

text[[117, 106, 765, 124]]
Also assume that the table has the following data initially inserted into it:  

text[[116, 144, 729, 181]]
SQL> insert into sales values(1,222,'CO',8773); SQL> insert into sales values(20,827,'FL',9222);  

text[[117, 202, 881, 270]]
Then, the CREATE VIEW statement is used to create a view. The following code creates a view (or replaces it if the view already exists) that selects a subset of columns and rows from the SALES table:  

text[[116, 290, 656, 364]]
SQL> create or replace view sales_rockies as select sales_id, amnt, state from sales where state in ('CO','UT','WY','ID','AZ');  

text[[117, 385, 881, 431]]
When you select from SALES_ROCKIES, it executes the view query and returns data from the SALES table as appropriate:  

text[[116, 450, 515, 468]]
SQL> select \* from sales_rockies;  

text[[117, 486, 881, 530]]
Given the view query, it is intuitive that the output shows only the following columns and one row:  

table[[116, 550, 515, 609]]

<table>SALES_IDAMNTST1222CO</table>  

text[[117, 630, 881, 674]]
The following insert statement against the view results in the insertion of a record in the SALES table:  

text[[116, 694, 753, 730]]
SQL> insert into sales_rockies(sales_id, amnt, state) values (2,100,'CO');  

text[[117, 751, 881, 817]]
You can grant DML privileges to other users on the view. For instance, you can grant SELECT, INSERT, UPDATE, and DELETE privileges on the view to another user, which will allow the user to select and modify data referencing the view:  

text[[117, 838, 496, 892]]
SQL> insert into sales_rockies( sales_id, amnt, state) values (3,123,'CA');

--- Page 20 ---

text[[117, 102, 530, 136]]
SQL> select \* from sales_rockies; SALES_ID AMNT ST  

text[[116, 160, 228, 194]]
1 222 CO 2 100 CO  

text[[115, 214, 881, 258]]
the query on the underlying table shows that rows exist that are not returned by the view:  

table[[114, 280, 746, 412]]

<table>SQL&gt; select * from sales;<br>SALES_IDAMNTSTSALES_PERSON_ID1222CO877320827FL92222100CO3123CA</table>  

sub_title[[118, 440, 382, 458]]
## Creating Read-Only Views  

text[[115, 466, 884, 587]]
If you do not want a user to be able to perform INSERT, UPDATE, or DELETE operations on a view, then do not grant those object privileges on the view to that user. Furthermore, you should also create a view with the WITH READ ONLY clause for any views for which you do not want the underlying tables to be modified. The default behavior is that a view is updatable (assuming the object privileges exist).  

text[[118, 593, 695, 611]]
This example creates a view with the WITH READ ONLY clause:  

text[[116, 629, 654, 721]]
SQL> create or replace view sales_rockies as select sales_id, amnt, state from sales where state in ('CO','UT','WY','ID','AZ') with read only;  

sub_title[[118, 743, 522, 761]]
## Displaying the SQL Used to Create a View  

text[[117, 768, 676, 786]]
To display the text associated with a particular view for a user:  

text[[116, 809, 570, 888]]
SQL> select view_name, text from dba_views where owner = upper('&owner') and view_name like upper('&view_name');

--- Page 21 ---

text[[117, 107, 881, 150]]
You can also query ALL_VIEWS/USER_VIEWS for the text of any view you have access to:  

text[[118, 173, 480, 244]]
SQL> select text from all_views where owner='MV_MAINT' and view_name='SALES_ROCKIES';  

sub_title[[119, 268, 279, 285]]
## Dropping a View  

text[[117, 293, 881, 386]]
Before you drop a view, consider renaming it. If you are certain that a view is not being used anymore, then it makes sense to keep your schema as clean as possible and drop any unused objects. Use the DROP VIEW statement to drop a view: SQL> drop view sales_rockies_old;

--- Page 22 ---

sub_title[[120, 108, 407, 129]]
## 7. Managing Synonyms:  

text[[115, 141, 880, 186]]
Synonyms provide a mechanism for creating an alternate name or alias for an object. You can create synonyms for the following types of database objects:  

text[[146, 194, 585, 416]]
Tables Views, object views Other synonyms Remote objects via a database link PL/SQL packages, procedures, and functions Materialized views Sequences Java class schema object User- defined object types  

sub_title[[118, 450, 314, 467]]
## Creating a Synonym  

text[[115, 475, 881, 542]]
A user must be granted the CREATE SYNONYM system privilege before creating a synonym. Once that privilege is granted, use the CREATE SYNONYM command to create an alias for another database object.  

text[[116, 550, 880, 618]]
For example, say USER1 is the currently connected user, and USER1 has select access to USER2's EMP table. Without a synonym, USER1 must select from USER2's EMP table, as follows:  

text[[117, 637, 468, 654]]
SQL> select \* from user2. emp;  

text[[115, 675, 878, 693]]
Assuming it has the CREATE SYNONYM system privilege, USER1 can do the following:  

text[[117, 713, 578, 729]]
SQL> create synonym emp for user2. emp;  

text[[116, 750, 688, 767]]
Now, USER1 can transparently select from USER2's EMP table:  

text[[118, 787, 395, 803]]
SQL> select \* from emp;

--- Page 23 ---

sub_title[[117, 105, 454, 123]]
## Dynamically Generating Synonyms  

text[[116, 131, 881, 201]]
You can also define a synonym as public synonyms, which means that any user in the database has access to the synonym. Sometimes, an inexperienced DBA does the following:  

text[[117, 220, 747, 256]]
SQL> grant all on sales to public; SQL> create public synonym sales for mv_maint.sales;  

text[[116, 277, 881, 345]]
Any user that can connect to the database can perform any INSERT, UPDATE, DELETE, or SELECT operation on the SALES table that exists in the MV_MAINT schema.  

sub_title[[118, 378, 407, 397]]
## Displaying Synonym Metadata  

text[[116, 404, 881, 448]]
The DBA/ALL/USER_SYNONYMS views contain information about synonyms in the database:  

text[[117, 468, 824, 523]]
SQL> select synonym_name, table_owner, table_name, db_link from user_synonyms order by 1;  

sub_title[[118, 547, 322, 565]]
## Dropping a Synonym  

text[[117, 572, 681, 590]]
Use the DROP SYNONYM statement to drop a private synonym:  

text[[119, 609, 385, 626]]
SQL> drop synonym inv;  

text[[116, 644, 805, 662]]
If it is a public synonym, then you need to specify PUBLIC when you drop it:  

text[[117, 682, 518, 698]]
SQL> drop public synonym inv_pub;

--- Page 24 ---

sub_title[[119, 108, 416, 129]]
## 8.Managing Sequences:  

text[[117, 141, 881, 186]]
A sequence is a database object that users can access to select unique integers. A sequence is a mechanism for automatically generating integers that follow a pattern.  

text[[147, 193, 880, 338]]
- A sequence has a name, which is how it is referenced when the next value is requested- A sequence is not associated with any particular table or column- The progression can be ascending or descending- The interval between numbers can be of any size- A sequence can cycle when a limit is reached  

sub_title[[118, 371, 322, 388]]
## Creating a Sequence  

text[[117, 396, 593, 414]]
Here is a summary of the sequence creation options:  

text[[147, 421, 718, 440]]
- Name: Name of the sequence, which is how it is referenced  

text[[148, 448, 478, 466]]
Schema: Owner of the sequence  

text[[146, 473, 881, 590]]
Maximum Value: Specifies the maximum value that the sequence can generate. This integer value can have 28 or fewer digits. It must be greater than Minimum Value and Initial. Using Unlimited indicates the maximum value of 1027 for an ascending sequence or \(- 1\) for a descending sequence. The default is Unlimited.  

text[[147, 599, 881, 721]]
Minimum Value: Specifies the minimum value of the sequence. This integer value can have 28 or fewer digits. It must be less than or equal to Initial and less than Maximum Value. Using Unlimited indicates the minimum value of 1 for an ascending sequence or \(- 1026\) for a descending sequence. The default is Unlimited.  

text[[147, 728, 880, 798]]
Interval: Specifies the interval between sequence numbers. This integer value can be any positive or negative integer, but it cannot be 0. It can have 28 or fewer digits. The default value is 1.  

text[[146, 805, 881, 875]]
Initial: Specifies the first sequence number to be generated. Use this clause to start an ascending sequence at a value greater than its minimum or to start a descending sequence at a value less than its maximum.

--- Page 25 ---

text[[147, 106, 883, 225]]
- Cycle Values: After an ascending sequence reaches its maximum value, it generates its minimum value. After a descending sequence reaches its minimum, it generates its maximum value. If you do not choose this option, an error is returned when you attempt to retrieve a value after the sequence has been exhausted.  

text[[147, 234, 883, 402]]
- Order Values: Guarantees that sequence numbers are generated in the order of request. This clause is useful if you are using sequence numbers as time stamps. Guaranteeing order is usually not important for sequences that are used to generate primary keys. This option is necessary only to guarantee ordered generation if you are using the CACHE option with Oracle Database with Real Application Clusters. If you are not caching, the sequence is in order by default.  

text[[147, 411, 881, 556]]
- Cache Options: Specifies how many values of the sequence the Oracle database pre-allocates and keeps in memory for faster access. This integer value can have 28 or fewer digits. The minimum value for this parameter is 2. For sequences that cycle, this value must be less than the number of values in the cycle. You cannot cache more values than would fit in a given cycle of sequence numbers.  

text[[115, 592, 880, 635]]
The following command creates a sequence with a starting value of 1,000 and a maximum value of 1,000,000:  

text[[113, 654, 878, 710]]
SQL> create sequence inv_seq2 start with 10000 maxvalue 1000000; You can see information about user's sequences via this query:  

text[[115, 730, 877, 783]]
SQL> select sequence_name, min_value, increment_by, cache_size, max_value from user_sequences;  

sub_title[[117, 814, 435, 831]]
## Using Sequence Pseudocolumns  

text[[115, 840, 718, 856]]
You can use two pseudo columns to access the sequence's value:

--- Page 26 ---

text[[147, 106, 269, 143]]
- NEXTVAL 
- CURVAL  

text[[117, 165, 881, 234]]
You can reference these pseudo columns in any SELECT, INSERT, or UPDATE statements. To retrieve a value from the INV_SEQ sequence, access the NEXTVAL value, as shown:  

text[[116, 252, 578, 271]]
SQL> select inv_seq.nextval from dual;  

text[[117, 289, 881, 335]]
Now that a sequence number has been retrieved for this session, you can use it multiple times by accessing the CURVAL value:  

text[[116, 351, 578, 370]]
SQL> select inv_seq.curval from dual;  

text[[117, 387, 881, 433]]
The sequence can be accessed directly in the INSERT statement. The first time you access the sequence, use the NEXTVAL pseudo column:  

text[[116, 451, 878, 487]]
SQL> insert into inv(inv_id,inv_desc) values (inv_seq.nextval,'Book');  

text[[117, 504, 881, 574]]
If you want to reuse the same sequence value, you can reference it via the CURVAL pseudo column. Next, a record is inserted into a child table that uses the same value for the foreign key column as its parent primary key value:  

text[[117, 591, 529, 664]]
SQL> insert into inv_lines (inv_line_id,inv_id,inv_item_desc) values (1,inv_seq.curval,'Tomel');  

sub_title[[119, 695, 387, 712]]
## Viewing Sequence Metadata  

text[[117, 721, 467, 739]]
To extracts the DDL for INV_SEQ use:  

text[[116, 757, 881, 793]]
SQL> select dbms_metadata.get_ddl('SEQUENCE','INV_SEQ') from dual;  

text[[117, 811, 880, 856]]
If you want to display the DDL for all sequences for the currently connected user, run this SQL:

--- Page 27 ---

text[[117, 103, 875, 138]]
SQL> select dbms_metadata.get_ddl('SEQUENCE',sequence_name) from user_sequences;  

sub_title[[118, 168, 326, 186]]
## Dropping a Sequence  

text[[117, 194, 643, 212]]
To drop a sequence, use the DROP SEQUENCE statement:  

text[[116, 231, 445, 248]]
SQL> drop sequence inv_seq;

--- Page 28 ---

sub_title[[117, 108, 214, 127]]
## 9. Quiz:  

text[[118, 141, 881, 186]]
1. Which of the following statements is correct about indexes? (Choose the best answer).  

text[[146, 193, 883, 360]]
a) An index can be based on multiple columns of a table, but the columns must be of the same datatype.b) An index can be based on multiple columns of a table, but the columns must be adjacent and specified in the order that they are defined in the table.c) An index cannot have the same name as a table, unless the index and the table are in separate schemas.d) None of the above statements is correct.  

text[[117, 395, 626, 413]]
2. Which of these statements about indexes is incorrect?  

text[[146, 421, 881, 540]]
a) Indexes can limit the amount of data that is returned in the results.b) Indexes are mandatory objects for each column in a table.c) Indexes can help keep results in memory and bring back results faster.d) Without indexes, the entire table is scanned (full table scan) with each DML operation on the table.  

text[[117, 574, 881, 618]]
3. Why do not place indexes on all tables and column combinations? (Choose the best answer).  

text[[146, 625, 699, 720]]
a) Because indexes are free.b) Because they have no impact on performance and space.c) Because indexes are mandatory.d) Because indexes have impact on performance and space.

--- Page 29 ---

text[[117, 105, 844, 124]]
4. Which of the following statements is not a part of the structure of B-tree index?  

text[[147, 131, 880, 279]]
a) Root, which contains entries that point to the next level.b) Branch blocks, which in turn point to blocks at the next level.c) A bitmap segment consisting of a string of bitsd) The leaf blocks are doubly linked to facilitate the scanning of the index in an ascending as well as descending order of key values.e) The leaf nodes, which contain the index entries that point to rows in the table.  

text[[117, 309, 880, 354]]
5. An index is an optionally created database object used primarily to increase query performance.  

text[[147, 362, 232, 405]]
a) True 
b) False  

text[[118, 439, 482, 457]]
6. Bitmap indexes should not be used if:  

text[[146, 464, 783, 559]]
a) The cardinality (the number of distinct values) in the column is low 
b) The cardinality (the number of distinct values) in the column is high 
c) The number of rows in the table is high 
d) The column is used in Boolean algebra operations  

text[[117, 590, 880, 635]]
7. Multicollumn indexes are especially effective when you often use multiple columns in the WHERE clause when accessing a table?  

text[[147, 643, 232, 686]]
a) True 
b) False  

text[[117, 720, 780, 758]]
8. What is the type of the index that is created by the following command: SQL> CREATE INDEX cust_idx1 ON cust(last_name);  

text[[147, 763, 330, 854]]
a) Bitmap index 
b) B-tree index 
c) Partitioned index 
d) Memory index.

--- Page 30 ---

text[[117, 106, 668, 124]]
9. For the same combination of columns; There can be only?  

text[[148, 132, 408, 227]]
a) Only two visible indexes  
b) Only one visible index  
c) Only three visible indexes  
d) Only four visible indexes  

text[[119, 259, 688, 277]]
10. What will Oracle do when trying to rebuild the index online?  

text[[148, 285, 600, 380]]
a) Oracle attempts to rollback on the table  
b) Oracle attempts to commit on the table  
c) Oracle attempts to acquire a lock on the table  
d) Oracle attempts to unlock any lock on the table  

text[[119, 412, 880, 456]]
11. Choose the correct statement after executing DROP VIEW statement to drop a view:  

text[[148, 464, 557, 559]]
a) The related data will be deleted  
b) The related base table will be dropped too  
c) The view will be dropped alone  
d) The related triggers will be dropped  

text[[119, 590, 785, 609]]
12. Which of the following types of database objects can't have synonym?  

text[[148, 617, 280, 710]]
a) Tables  
b) views  
c) Sequences  
d) indexes  

text[[119, 744, 878, 762]]
13. It is recommended that you separate tables and indexes into different tablespaces?  

text[[148, 771, 232, 814]]
a) True  
b) False

--- Page 31 ---

text[[117, 105, 715, 123]]
14. Which statements are true about Cycle Values of a sequence?  

text[[147, 131, 880, 280]]
a) After an ascending sequence reaches its maximum value, you have to drop it.b) After an ascending sequence reaches its maximum value, it generates its minimum value.c) After a descending sequence reaches its minimum, it generates its maximum value.d) After a descending sequence reaches its minimum, you have to drop it.  

text[[117, 309, 715, 327]]
15. Which statement is false about Cache Options of a sequence?  

text[[147, 335, 880, 459]]
a) Specifies how many values of the sequence pre-allocates and keeps in memory for faster access.b) This integer value can have 28 or fewer digits.c) The minimum value for this parameter is 20d) The minimum value for this parameter is 2  

text[[117, 489, 879, 532]]
16. The following SQL statement is used to display the "INV_SEQ" sequence DDL statement:  

text[[176, 552, 880, 586]]
select dbms_metadata.get_ddl('SEQUENCE','INV_SEQ') from dual;  

text[[148, 607, 226, 647]]
a) True 
b) False  

text[[117, 681, 764, 698]]
17. What are the two pseudo columns to access the sequence's value?  

text[[147, 707, 301, 802]]
a) Forwardval 
b) Nextval 
c) Retreivedval 
d) Currval

--- Page 32 ---

text[[118, 105, 880, 150]]
18. Views are stored queries as well as other complex expressions and SQL constructs?  

text[[148, 158, 232, 175]]
a) True  

text[[149, 184, 230, 201]]
b) False  

text[[118, 233, 881, 280]]
19. Choose the correct statements that describe the common uses of views (choose the two statements):  

text[[148, 285, 444, 303]]
a) Adding privileges to the user  

text[[149, 311, 535, 329]]
b) Creation a User Account with password  

text[[147, 336, 800, 354]]
c) Provide an interface layer between an application and physical tables.  

text[[148, 361, 693, 380]]
d) Hide the complexity of an SQL query from an application.  

text[[118, 412, 702, 431]]
20. Any user in the database has access to the public synonym?  

text[[149, 439, 230, 456]]
a) True  

text[[148, 464, 232, 481]]
b) False

--- Page 33 ---

table[[184, 100, 805, 655]]
<table><td colspan="2">Quiz answers - chapter 91d2b3d4c5a6b7a8b9b10c11c12d13a14b, c15c16a17b, d18a19c, d20a</table>

--- Page 34 ---

sub_title[[119, 108, 260, 126]]
## References:  

sub_title[[117, 142, 182, 158]]
## Books  

text[[147, 167, 881, 340]]
1. Oracle Database Administrator's Guide, 18c (Oracle University), March 2019, Primary Author: Rajesh Bhatiya, Randy Urbano  
2. database-new-features-guide (Oracle University), 18c E88909-01 February 2018, Primary Authors: Tanaya Bhattacharjee, Sunil Surabhi, Mark Baue  
3. The Cloud DBA-Oracle: Managing Oracle Database in the Cloud - First Edition, Abhinivesh Jain and Niraj Mahajan. Apress - ISBN-13 (pbk): 978-1-4842-2634-6 ISBN-13 (electronic): 978-1-4842-2635-3  

sub_title[[117, 370, 217, 387]]
## Web Sites  

text[[147, 395, 817, 519]]
1. https://docs.oracle.com/database  
2. https://docs.oracle.com/en/database/oracle/oracle-database/19/whats-new.html  
3. http://www.oracle.com/technetwork/database/enterprise-edition/downloads/index.html
