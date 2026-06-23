--- Page 1 ---

# Bachelor of IT Program BAIT  

# MS SQL Server Administration IIS404  

Chapter Seven  

Maintenance in MS SQL Server  

Eng. Ayham Mohammad

--- Page 2 ---

## Contents  

1. Managing Indexes 3  
2. Check Database Integrity Task 3  
3. Shrink a Database 3  
3.1. Limitations and Restrictions 3  
3.2. Recommendations 4  
4. Update statistics 4  
4.1. Permissions 5  
4.2. Using SSMS 5  
4.3. Using T-SQL 5  
4.3.1. To update a specific statistics object 5  
4.3.2. To update all statistics in a table 5  
4.3.3. To update all statistics in a database 5  
5. History Cleanup Task 6  
6. Fixing Database States 6  
6.1. DATABASE STATE DEFINITIONS 6  
7. Procedure to Recover SQL Database from SUSPECT Mode 8  
8. Maintenance Plans 10  
9. References 12

--- Page 3 ---

## 1. Managing Indexes 

Reorganize أو أقل نقوم ب %30 ، حيث إن كان Index ننقوم بقياس ال Framentation لإدارة ال 

Index ال Rebuild ننقوم بعمل %30 و في حال كان أكثر من 

In order to mange indexes you have first to measure fragmentation by the following piece of code: 

حيث نقوم بقياس ال Fragmentation :باستخدام 

Select avg_fragmentation_in_percent, fragment_count_from sys.dm_db_index_physical_stats(DB_ID('DatabaseName'), OBJECT_ID('IndexName'), 1, null, 'Limited'); 

As best practice, if the fragmentation is about 30 you can reorganize the index, but if above it's recommended to rebuild it. 

index will be rebuilt using the same columns, index type, uniqueness attribute, and sort order 

index leaf level will be reorganized 

ALTER INDEX {index_name | ALL}
ON [{database_name.[schema_name]. | schema_name.}]
{table_or_view_name}
{ REBUILD [WITH(<rebuild_index_option>[,...n])]
REORGANIZE [ WITH( LOB_COMPACTION = {ON | OFF})]
DISABLE
SET (<set_index_option>[,...n]) } 

Marks the index as disabled and unavailable for use by the Database Engine 

حيث نقوم ب Rebuild في حال الداعي لذلك، كالتالي: 

الكل جدول بجدوله ( Rebuild )

--- Page 4 ---

ALTER INDEX ALL ON [Forewin Go Live$Value Entry$VSIFT$6] Rebuild
ALTER INDEX ALL ON [Forewin Go Live$Value Entry$VSIFT$7] Rebuild
ALTER INDEX ALL ON [Forewin Go Live$Posted Whse_Re[eipt Line] Rebuild
ALTER INDEX ALL ON [Forewin Go Live$Cust_Ledger Entry] Rebuild
ALTER INDEX ALL ON [Forewin Go Live$Value Entry$VSIFT$11] Rebuild
ALTER INDEX ALL ON [Forewin Go Live$Value Entry$VSIFT$13] Rebuild
ALTER INDEX ALL ON [Forewin Go Live$Value Entry$VSIFT$14] Rebuild 

أو نقوم بالتعديل على جميع ال Tables دفعة واحدة: 

exec sp_msforeachtable 'alter index all on ? rebuild' 

- ينصح القيام بعملية ال Index Rebuild في فترات الليل بعد الدوام، حيث سينخفض الأداء كثيرا بسبب استهلاك الموارد في هذه العملية 

## 2. Check Database Integrity Task 

### DBCC يتم القيام بعملية تحقق من ال Database باستخدام تعليمية ال 

The Check Database Integrity task checks the allocation and structural integrity of all the objects in the specified database. The task can check a single database or multiple databases, and you can choose whether to also check the database indexes. 

The Check Database Integrity task encapsulates the DBCC CHECKDB statement. 

## 3. Shrink a Database 

### عملية ال Shrinking لقاعدة البيانات تهدف لتقليص مساحتها المستخدمة

--- Page 5 ---

Fragmentation النقطة السلبية الخاصة بها، أنه عند تقليص قاعدة البيانات يتم زيادة ال 

Indexes داخل ال 

Fragmentation لذلك يجب علينا المقايضة بين تقليص الحجم، و زيادة ال 

و للقيام بها تنبع الخطوات التالية: 

 

Shrinking data files recovers space by moving pages of data from the end of the file to unoccupied space closer to the front of the file. When enough free space is created at the end of the file, data pages at end of the file can be deallocated and returned to the file system.

--- Page 6 ---

- و يكون أغلب النفع عند تطبيق ال Shrinking على ملفات ال Log, و يتم عرض الحجم الذي سيحرر لدينا عند إختيار ملف معين أو قاعدة البيانات بأكملها: 

 

## 3.1. Limitations and Restrictions 

- الشريك العمليّة ال Shrinking

--- Page 7 ---

(1) لا يمكن القيام بـ Backup عند القيام بـ Shrinking أو العكس (2) لا يمكن تقليص حجم الـ DB لآقل من الحجم المضبوط عند إنشائها ، أو الحجم المضبوط لها باستخدام تعليمية DBCC 

• The database cannot be made smaller than the minimum size of the database. The minimum size is the size specified when the database was originally created, or the last explicit size set by using a file-size-changing operation, such as DBCC SHRINKFILE. For example, if a database was originally

--- Page 8 ---

created with a size of 10 MB and grew to 100 MB, the smallest size the database could be reduced to is 10 MB, even if all the data in the database has been deleted. 

- You cannot shrink a database while the database is being backed up. Conversely, you cannot backup a database while a shrink operation on the database is in process. 

## 3.2. Recommendations 

- نصائح يجب إخذها بعين الإعتبار عند القيام بـ: Shrinking 

(1) ينصح بالقيام بـ Shrinking بعد عملية تستهلك مساحة كبيرة، مثل Truncate table, drop table أو حذف أي كمية كبيرة من ال Data 

(2) القيام بعملية Shrinking بشكل متكرر خلال فترات متقاربة يعتبر مضيعة للوقت، حيث أن ال DB تحتاج لمساحة للعمليات اليومية 

(3) ينصح بعدم تفعيل خيار ال Auto_Shrinking لا في Auto_Shrinking 

(4) يجب تذكر أن عمليات ال Shrinking تزيد من ال Fragmentation في ال Database 

- To view the current amount of free (unallocated) space in the database: 

SELECT file_id, name, type_desc, physical_name, size, max_size FROM sys.database_files ; 

- Consider the following information when you plan to shrink a database: 

- A shrink operation is most effective after an operation that creates lots of unused space, such as a truncate table or a drop table operation. 

- Most databases require some free space to be available for regular day-to-day operations. If you shrink a database repeatedly and notice that the database size grows again, this indicates that the space that was shrunk is required for regular operations. In these cases, repeatedly shrinking the database is a wasted operation. 

- A shrink operation does not preserve the fragmentation state of indexes in the database, and generally increases fragmentation to a degree. This is another reason not to repeatedly shrink the database. 

- Unless you have a specific requirement, do not set the AUTO_SHRINK database option to ON. 

## 4. Update statistics 

- هي معلومات يخزنهها ال query Optimizer لإستخدامها في رسم و إعطاء ال Query Execution الأفضل Plan 

- يفضل القيام بها في أيام العطل و في فترات متباعدة لأنها تستهلك الكثير من الموارد و تقوم بتشغيل ال tempdb بشكل كثير 

- نستطيع القيام بـ Update Statistics ل: 

Object (1) معين 

Table (2) معين 

Database بشكل كامل (3) 

Statistics refers to the statistical information about the distribution of values in one or

--- Page 9 ---

SVU - BAIT - IIS404 - Ch07. Maintenance in MS SQL Server - Eng. Ayham Mohammad more columns of a table or an index. The SQL Server Query Optimizer uses this statistical information to estimate the cardinality, or number of rows, in the query result to be returned, which enables the SQL Server Query Optimizer to create a high- quality query execution plan. For example, based on these statistical information SQL Server Query Optimizer might decide whether to use the index seek operator or a more resource- intensive index scan operator in order to provide optimal query performance. In this article series, I am going to talk about statistics in detail.  

You can update query optimization statistics on a table or indexed view in SQL Server 2019 (15. x) by using SQL Server Management Studio or Transact- SQL. By default, the query optimizer already updates statistics as necessary to improve the query plan; in some cases you can improve query performance by using UPDATE

--- Page 10 ---

STATISTICS or the stored procedure sp_updatestats to update statistics more frequently than the default updates.  

Updating statistics ensures that queries compile with up- to- date statistics. However, updating statistics causes queries to recompile. We recommend not updating statistics too frequently because there is a performance tradeoff between improving query plans and the time it takes to recompile queries. The specific tradeoffs depend on your application. UPDATE STATISTICS can use tempdb to sort the sample of rows for building statistics.  

### 4.1. Permissions  

If using UPDATE STATISTICS or making changes through SQL Server Management Studio, requires ALTER permission on the table or view. If using sp_updatestats, requires membership in the sysadmin fixed server role, or ownership of the database (dbo).  

### 4.2. Using SSMS  

In Object Explorer, click the plus sign to expand the database in which you want to update the statistic. Click the plus sign to expand the Tables folder. Click the plus sign to expand the table in which you want to update the statistic. Click the plus sign to expand the Statistics folder. Right- click the statistics object you wish to update and select Properties. In the Statistics Properties - statistics_name dialog box, select the Update statistics for these columns check box and then click OK.  

### 4.3. Using T-SQL  

#### 4.3.1. To update a specific statistics object  

The following example updates the statistics for the AK_SalesOrderDetail_rowguid index of the SalesOrderDetail table. UPDATE STATISTICS Sales.SalesOrderDetail AK_SalesOrderDetail_rowguid;  

#### 4.3.2. To update all statistics in a table  

The following example updates the statistics for all indexes on the SalesOrderDetail table. UPDATE STATISTICS Sales.SalesOrderDetail;  

#### 4.3.3. To update all statistics in a database:

--- Page 11 ---

## 5. History Cleanup Task 

- هناك العديد من العمليات مثل عمليات ال Backup سواء الماتمة أم اليدوية، تقوم بترك ملفات في ...log من ال msdb الخاص بال History Table ال حيث يقوم ال SQL Server بالتحلص منهم بشكل دوري، ولكن في حال أردنا التلخص منهم بشكل يدوي نستطيع استخدام أداة ال History Cleanup استخدمها في أيام العملة - نستطيع أتمتة استخدام هذه الأداة، و يفضل استخدامها في أيام العملة 

The History Cleanup task deletes entries in the following history tables in the SQL Server msdb database. 

- backupfile 

- backupfilegroup 

- backupmediafamily 

- backupmediaset 

- backupset 

- restorefile 

- restorefilegroup 

- restorehistory 

By using the History Cleanup task, a package can delete historical data related to backup and restore activities, SQL Server Agent jobs, and database maintenance plans. 

This task encapsulates the sp_delete_backuphistory system stored procedure and passes the specified date to the procedure as an argument. 

## 6. Fixing Database States 

A database is always in one specific state. For example, these states include ONLINE, OFFLINE, or SUSPECT. To verify the current state of a database, select the state_desc column in the sys.databases catalog view or the Status property in the DATABASE.PROPERTYEX function. 

## 6.1. DATABASE STATE DEFINITIONS 

11 | P a g

--- Page 12 ---

<table><tr><td>State</td><td>Definition</td></tr><tr><td>ONLINE</td><td>هي الحالة الطبيعية ل DL التي تكون بها فعّالة<br/>Database is available for access. The primary filegroup is online, although the undo phase of recovery may not have been completed.</td></tr><tr><td>OFFLINE</td><td>ممكن أن تصبح بهذه الحالة نتيجة استخدام يدوي لتعليمه: ( لكي نعتل مكان ملف معيّن منها)<br/>Alter database database_name set offline<br/>أو نتيجة لعملية backup أو عملية أخرى.<br/>و تصبح بها ال DL غير قابلة للإستخدام<br/>Database is unavailable. A database becomes offline by explicit user action and remains offline until additional user action is taken. For example, the database may be taken offline in order to move a file to a new disk. The database is then brought back online after the move has been completed.</td></tr></table>

--- Page 13 ---

primarily used for troubleshooting purposes. For example, a database marked as suspect can be set to the EMERGENCY state. This could permit the system administrator read- only access to the database. Only members of the sysadmin fixed server role can set a database to the EMERGENCY state.  

When your database stucks in recovery, then you have to wait and monitor via SQL Server log.

--- Page 14 ---

3. Sometimes you get error trying point 2, so try to set the database in Emergency mode, but setting database in Emergency.  

ALTER DATABASE dutyfree SET EMERGENCY  

  

4. Sometimes you get the error while trying to set the database in Emergency mode, because the database is locked, so whenever you face a lock in the database while maintenance search for the reason session and kill it then proceed point 3.  

EXEC sp_ who2  

kill 58 (suppose the session is 58)  

4. then if you try point 2, an error message demands putting the database in single user mode before executing this command so you have to execute the following:  

Alter database DBName set single user  

  

Then proceed point 2:

--- Page 15 ---

Summary 

EXEC sp_resetstatus 'dutyfree'; 

ALTER DATABASE dutyfree SET EMERGENCY 

--01 

ALTER DATABASE dutyfree SET ONLINE --fail? 

--02 

DBCC CHECKDB ('Dutyfree', REPAIR_ALLOW_DATA_LOSS) WITH ALL_ERRORM$GS, NO_INFOM$GS; --fail? 

--03 

ALTER DATABASE dutyfree SET EMERGENCY --fail? 

--04 

EXEC sp_who2 

kill 58 

kill 59 

kill 61 

kill 51 

kill 53 

--05 

ALTER DATABASE dutyfree SET EMERGENCY 

--06 

alter database dutyfree set single_user 

DBCC CHECKDB ('Dutyfree', REPAIR_ALLOW_DATA_LOSS) WITH ALL_ERRORM$GS, NO_INFOM$GS; 

alter database dutyfree set multi_user 

Following the above steps will likely help you fix SQL database suspect mode issue. If the problem still persists, restore the database from clean and updated backup that you created before the database in suspect mode problem. Restoring db from backup is the best and fastest method to fix the problem. 

8. Maintenance Plans 

Maintenance plans create a workflow of the tasks required to make sure that your database is optimized, regularly backed up, and free of inconsistencies. 

SQL Server 2017 maintenance plans provide the following features: 

Agent  -  Maintenace Plans  -  Maintenace Plans 

SQL Server Maintenance Wizard  -  SQL Server Maintenance Wizard 

Maintenance tasks  -  Maintenace tasks 

10 | P a g e

--- Page 16 ---

ثم نحدد ال DB أو عدة DB التي نريد تطبيق هذه ال Help 

- Workflow creation using a variety of typical maintenance tasks. You can also create your own custom Transact-SQL scripts.

--- Page 17 ---

- Conceptual hierarchies. Each plan lets you create or edit task workflows. Tasks in each plan can be grouped into subplans, which can be scheduled to run at different times.- Support for multiserver plans that can be used in master server/target server environments.- Support for logging plan history to remote servers.- Support for Windows Authentication and SQL Server Authentication. When possible, use Windows Authentication.  

## Maintenance plans can be created to perform the following tasks:  

- Reorganize the data on the data and index pages by rebuilding indexes with a new fill factor. Rebuilding indexes with a new fill factor makes sure that database pages contain an equally distributed amount of data and free space. It also enables faster growth in the future.- Compress data files by removing empty database pages.- Update index statistics to make sure the query optimizer has current information about the distribution of data values in the tables. This enables the query optimizer to make better judgments about the best way to access data, because it has more information about the data stored in the database. Although index statistics are automatically updated by SQL Server periodically, this option can force the statistics to update immediately.- Perform internal consistency checks of the data and data pages within the database to make sure that a system or software problem has not damaged data.- Back up the database and transaction log files. Database and log backups can be retained for a specified period. This lets you create a history of backups to be used if you have to restore the database to a time earlier than the last database backup. You can also perform differential backups.- Run SQL Server Agent jobs. This can be used to create jobs that perform a variety of actions and the maintenance plans to run those jobs.- The results generated by the maintenance tasks can be written as a report to a text file or to the maintenance plan tables (sysmainplan_log and

--- Page 18 ---

sysmainplan_logdetail) in msdb. To view the results in the log file viewer, right- click Maintenance Plans, and then click View History.  

## 9. References  

https://docs.microsoft.com/en- us/sql/relational- databases/databases/database- states?view=sql- server- ver15  

https://docs.microsoft.com/en- us/sql/relational- databases/databases/shrink- adatabase?view=sql- server- ver15  

https://docs.microsoft.com/en- us/sql/relational- databases/statistics/update- statistics?view=sql- server- ver15  

https://docs.microsoft.com/en- us/sql/integration- services/control- flow/history- cleanup- task?view=sql- server-  

ver15#: \(\sim\) :text=The%20History%20Cleanup%20task%20deletes,the%20SQL%20Server%20msdb%20database,&text=By%20using%20the%20History%20Cleanup,jobs%20C%20and%20database%20maintenance%20plans.
