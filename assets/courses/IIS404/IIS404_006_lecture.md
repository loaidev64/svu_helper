--- Page 1 ---

# Bachelor of IT Program BAIT  

# MS SQL Server Administration IIS404  

Chapter six  

Performance Monitoring and Tuning in MS SQL Server  

Eng. Ayham Mohammad

--- Page 2 ---

## Contents  

1. Intro. 1  
2. SQL Server monitoring and tuning tools. 1  
2.1. Open Activity Monitor (SQL Server Management Studio) 2  
2.2. SQL Trace. 2  
2.3. SQL Server Profiler. 2  
2.4. Database Engine Tuning Advisor DTA. 2  
2.5. DBCC (Transact-SQL). 3  
2.5.1. DBCC CHECKDB. 3  
2.5.2. DBCC - DBCC SQLPERF. 4  
2.5.3. DBCC FREESYSTEMCACHE. 4  
2.6. Dynamic Management Views (DMVs). 4  
2.7. System Stored Procedures. 6  
2.8. SQL Server Extended Events. 7  
2.8.1. Benefits of SQL Server Extended Events. 7  
2.8.2. Extended Events Concepts. 7  
2.9. SQL Server Data Collector. 7  
2.10. Query Store. 8  
2.10.1. Enabling the Query Store. 8  
2.10.2. Information in the Query Store. 9  
2.11. Performance Dashboard. 10  
2.12. Windows Performance Monitor. 12

--- Page 3 ---

## 1. Intro 

- لمراقبة العمليات التي تتم من قبل المستخدمين على الـ DB نستطيع الإستعانة بتطبيقات خارجية مستقلة ( third party applications ) تكلف كثيرا و تقوم بمراقبة جميع العمليات ضمن الـ DB أو استخدام أدوات المراقبة الموجودة بشكل أساسي ضمن الـ SQL Server و من أهمها: 

Another mission of a DBA is monitoring the database, Microsoft SQL Server provides a comprehensive set of tools for monitoring events in SQL Server and for tuning the physical database design. The choice of tool depends on the type of monitoring or tuning to be done and the particular events to be monitored. There're a lot of techniques and third-party applications and they are in continual development, but here we will list some as an initial entry and then you can discover more. 

## 2. SQL Server monitoring and tuning tools 

- Open Activity Monitor. 

- SQL Trace. 

- SQL Server Profiler. 

- Database Engine Tuning Advisor DTA. 

- DBCC (Transact-SQL). 

- Dynamic Management Views DMVs. 

- System Stored Procedures (Transact-SQL). 

- SQL Server Extended Events. 

- SQL Server Data Collector. 

- Query Store 

- Performance Dashboard 

- Monitor Resource Usage (System Monitor).

--- Page 4 ---

## 2.1. Open Activity Monitor (SQL Server Management Studio) 

- هي أداة تحوي واجهة رسومية GUI، تقوم بعرض عدة 

- معلومات متعلقة بال SQL Server و ال DB. و عند 

- ضبط زمن التحديث بأقل من 10 ثواني سيتم التأثير على 

أداء السيرفر. 

- تحوي على خيار Active Expensive Queries الذي 

- يتيح إستهلاك كافة الموارد 

- كما تمكننا من فلترة النتائج على DB واحدة فقط من 

- الموجودات في SQL Server 

- يوفر خيار غير موجود لدى باقي الأدوات و هو إنهاء ال 

- أو ال Query التي تستهلك موارد كثيرة 

Activity Monitor runs queries on the monitored instance to obtain information for the Activity Monitor display panes. When the refresh interval is set to less than 10 seconds, the time that is used to run these queries can affect server performance. It can kill processes, but a user must be a member of the sysadmin or processadmin fixed server roles. 

Can open by CTRL + ALT + A (in 2017) 

 

## 2.2. SQL Trace 

- يقوم ب Capture لجميع ال Events التي تحدث على مستوى السيرفر 

- لتفعيله نقوم بكتابه على شكل كود مكون من مجموعة الإستدعانات لل system stored procedures 

مع تحديد أرقام ال Events التي نريد أن يتم لها capturing ( يجب أن نكون نعرف أرقام ال evets مسبقاً )

--- Page 5 ---

- يعد استعماله صعب لذلك قامت ميكروسوفت بإستبداله فيما بعد بأداة أخرى ذات واجهة رسومية إسمها SQL Server Profiler و نصحت جميع المستخدمين بالتوقف عن استعمال الـ Trace 

In SQL Trace, events are gathered if they are instances of event classes listed in the trace definition. 

These events can be filtered out of the trace or queued for their destination. The destination can be a file or SQL Server Management Objects (SMO), which can use the trace information in applications 

3 | P a g e

--- Page 6 ---

that manage SQL Server. 

Microsoft SQL Server provides Transact-SQL system stored procedures to create traces on an instance of the SQL Server Database Engine. These system stored procedures can be used from within your own applications to create traces manually, instead of using SQL Server Profiler. 

## 2.3. SQL Server Profiler 

- ممكن بواسطة الفترة لتضمين Events معينة عن DB مناسبة عن Database Engine Tuning Advisor، و من ثم فتحها بواسطة الأداة، Trace File. نستطيع حفظ النتائج الخاصة به كي DTA التي تقوم بتحليل جميع النتائج ضمن هذا الملف 

A graphical user interface to SQL Trace for monitoring an instance of the Database Engine or Analysis Services. You can capture and save data about each event to a file or table to analyze later. For example, you can monitor a production environment to see which stored procedures are affecting performance by executing too slowly. Open it from tools → SQL Server Profiler. 

## 2.4. Database Engine Tuning Advisor DTA 

- يقوم بتحليل ملفات ال Trace File أو أداء ال DB و اعطاء نصائح بناء عليها. Analyse with Database Engine Tuning. كما يمكننا تحديد أي Query لدينا بالضغط عليها باليمين و اختيار Advisor ليتم تحليلها بواسطة 

- من النصائح التي يعطها ممكن أن ينصح باستخدام Clustered Index لبعض الحقول مثلا مع إمكانية توفير الكود لإنشاء هذا ال Clustered Index في حال لا نعرف كيف 

- لا ينصح باستعماله في البيئة الحقيقية للعمل، لأنه يقوم بإنشاء Indexات إفتراضية (Hypothetical Indexes) لا يتم إزالتها إلا يدويا 

Analyzes databases and makes recommendations that you can use to optimize query performance. Can be used to select and create an optimal set of indexes, indexed views, or table partitions without

--- Page 7 ---

<table><tr><td>Command category</td><td>Perform</td></tr><tr><td>Maintenance</td><td>Maintenance tasks on a database, index, or filegroup.</td></tr><tr><td>Miscellaneous</td><td>Miscellaneous tasks such as enabling trace flags or removing a DLL from memory.</td></tr><tr><td>Informational</td><td>Tasks that gather and display various types of information.</td></tr><tr><td>Validation</td><td>Validation operations on a database, table, index, catalog, filegroup, or allocation of database pages.</td></tr></table>

من أهم التعليمات الخاصة بال DBCC هي: 

## 2.5.1. DBCC CHECKDB 

- تقوم بالتحقق من الحالة الإفتراضية و الفيزيائية لجميع الإغراض في الـ DB ( إستخدمناها سابقا في عملية ضرب من الـ DB للتحقق من حالة جميع الصفحات )
عن طريق التحقق من مجموعة نقاط منها: 

Checks the logical and physical integrity of all the objects in the specified database by performing the following operations:

--- Page 8 ---

- Runs DBCC CHECKALLOc on the database. 

- Checks the consistency of disk space allocation structures for a specified database. 

- Runs DBCC CHECKTABLE on every table and view in the database. 

- Checks the integrity of all the pages and structures that make up the table or indexed view 

- Runs DBCC CHECKCATALOG on the database. 

- Checks for catalog consistency within the specified database. The database must be online. 

- Validates the contents of every indexed view in the database. 

- Validates link-level consistency between table metadata and file system directories and files when storing varbinary (max) data in the file system using FILESTREAM. 

- Validates the Service Broker data in the database. 

## 2.5.2. DBCC - DBCC SQLPERF 

- توفر معلومات عن حجم ال log في كل ال Databases مع إعطاء نسبة عن استخدام القرص sys.dm_db_log_space_usage بالرغم من منفعتنا إال أن ميكروسوفت تتصح بعدم استخدامها و استخدام log المحلية فقط مع حجم ال DB حيث يقوم بتوفير نفس المعلومات و لكن خاصة بال 

- Provides transaction log space usage statistics for all databases. 

- Use sys.dm_db_log_space_usage DMV instead. 

## 2.5.3. DBCC FREESYSTEMCACHE 

- تقوم بتضيفية جميع المساحة الغير مستخدمة في ال cash مما يتيح مساحة إضافية في ال RAM Releases all unused cache entries from all caches. The SQL Server Database Engine proactively cleans up unused cache entries in the background to make memory available for current entries. However, you can use this command to manually remove unused entries from all caches or from a specified Resource Governor Pool cache. 

## 2.6. Dynamic Management Views (DMVs) 

- تستخدم لمراقبة أداء السيرفر و حالته 

Dynamic Management Views (DMVs) can be used to monitor SQL Server performance and troubleshoot issues.

--- Page 9 ---

من تعليماته sys.dm_exec_query_stats التي تقوم بعرض جميع ال Queries التي يتم تنفيذها حاليا في الواجهة و في 

ال background 

sys.dm_exec_query_stats – returns a row for every query statement in a cached query plan. It provides information about average, minimal, maximal, and total processor time used by the plan, along with other useful information for performance analysis

--- Page 10 ---

و تعليمية sys.dm_exec_sessions التي تقوم بعرض جميع الـ sessions المفتوحة مع معلومات عنها 

sys.dm_exec_sessions – returns a row for every session on the queried SQL Server instance, along with details such as the name of the program that initiated the session, session status, SQL Server login, various time counters, and more 

و تعليمية sys.dm_exec_requests التي تقوم بعرض جميع الـ Requests ( عمليات القراءة و الكتابة ) التي تتم حاليا مع الحالة الخاصة بها مثل Running أو Suspended أي بانتظار فك القفل عن البيانات المراد إستعمالها 

sys.dm_exec_requests – returns a row for every user and system request being executed on the SQL Server instance. To find the blocked requests, search for the requests where the status column value is 'suspended'. 

و تعليمية sys.dm_db_log_stats التي تقوم بعرض حالة الـ Log الخاصة بالـ DB ( عدد الـ VLF و حجم كل منها و عدد النشطة منها ) 

sys.dm_db_log_stats - This DMV returns information about the transaction log files. The information includes the recovery model of the database. 

select
db_NAME (database_id) dbname,
recovery_model,
current_vlf_size_mb,
total_vlf_count,
active_vlf_count,
active_log_size_mb,
log_truncation_holdup_reason,
log_since_last_checkpoint_mb
from
sys.dm_db_log_stats(5) 

<table><tr><td>Results</td><td>Messages</td><td></td><td></td><td></td><td></td><td></td></tr><tr><td>dbname</td><td>recovery_model</td><td>current_vlf_size_mb</td><td>total_vlf_count</td><td>active_vlf_count</td><td>active_log_size_mb</td><td>log_truncation_holdup_reason</td><td>log_since_last_checkpoint_mb</td></tr><tr><td>1</td><td>Python2017</td><td>FULL</td><td>1.9375</td><td>4</td><td>1</td><td>0.187988</td><td>0.187988</td></tr></table>

total log size 

It is this easy to project the data for the entire database by cross-joining with the sys.databases system view. The derived output gives very useful information about the database and the log structure. 

<table><tr><td>Results</td><td>Messages</td><td></td><td></td><td></td><td></td><td></td></tr><tr><td>name</td><td>recovery_model</td><td>current_vlf_size_mb</td><td>total_vlf_count</td><td>active_vlf_count</td><td>active_log_size_mb</td><td>log_truncation_holdup_reason</td><td>log_since_last_checkpoint_mb</td></tr><tr><td>1</td><td>master</td><td>SIMPLE</td><td>0.25</td><td>8</td><td>1</td><td>0.182617</td><td>0.182617</td></tr><tr><td>2</td><td>tempdb</td><td>SIMPLE</td><td>1.9375</td><td>4</td><td>1</td><td>0.296875</td><td>0.296875</td></tr><tr><td>3</td><td>model</td><td>FULL</td><td>1.875</td><td>6</td><td>1</td><td>0.060058</td><td>0.060058</td></tr><tr><td>4</td><td>mdb</td><td>SIMPLE</td><td>0.25</td><td>3</td><td>1</td><td>0.133789</td><td>0.133789</td></tr><tr><td>5</td><td>Python2017</td><td>FULL</td><td>1.9375</td><td>4</td><td>1</td><td>0.187988</td><td>0.187988</td></tr></table>

--- Page 11 ---

و تعليمية sys.dm_db_log_info على حدى بعكس القبله التي تقوم بعرض معلومات عن sys.dm_db_log_info تعطينا معلومات عن كل VLF 

sys.dm_db_log_info - The sys.dm_db_log_info also deals with the log files. It requires the database ID for input. This view specifically looks at virtual log files or VLFs. These make up the transaction log of the database and having a large number of VLFs can negatively impact the startup and recovery time of your database. With this view, we can see how many VLFs your database currently has, along with their size and status. This management view replaces the database console command, dbcc log info.

--- Page 12 ---

Many administrative and informational activities can be performed by using system stored procedures. Examples:

--- Page 13 ---

- Database Maintenance Plan Stored Procedures 

sp_add_maintenance_plan, sp_delete_maintenance_plan_db, sp_add_maintenance_plan_db, 

sp_delete_maintenance_plan_job, sp_add_maintenance_plan_job, sp_help_maintenance_plan, 

sp_delete_maintenance_plan 

- Database Engine Stored Procedures 

- SQL Server Profiler Stored Procedures 

## 2.8. SQL Server Extended Events 

منذ إصدار ال SQL Server Extended Events قامت ميكروسوفت بنصيحة المستخدمين باستخدامه عوضاً عن - ، بسبب استهلكه القليل للعوارد (Light Weight) مع إمتلكه تقريباً لنفس قدرة المراقبة مثل مراقبة ال most expensive queries, latches, deadlocks, locking 

حيث أن الإقفال المتبادل (Dead Lock) يتحدث عندما تنتظر مناقلتان كل منهما الأخرى لكي تحرر قفلها عن عنصر معطيات معيّن و لحل هذه المشكلة يقوم ال SQL Server بانهاء إحدى هذه المناقلات بشكل قسري 

SQL Server Extended Events has a highly scalable and highly configurable architecture that allows users to collect as much or as little information as is necessary to troubleshoot or identify a performance problem. 

### 2.8.1. Benefits of SQL Server Extended Events 

Extended Events is a light weight performance monitoring system that uses very few performance resources. Extended Events provides two graphical user interfaces (New Session Wizard and New Session) to create, modify, display, and analyze your session data. 

It allows collecting information useful for troubleshooting SQL Server performance issues, and enables finding the most expensive queries, latch, deadlock, and blocking causes, troubleshooting excessive processor usage. To use Extended Events for performance monitoring, determine which events you want to monitor, and create a session using SQL Server Management Studio options, or T-SQL. 

### 2.8.2. Extended Events Concepts 

SQL Server Extended Events (Extended Events) builds on existing concepts, such as an event or an event consumer, uses concepts from Event Tracing for Windows, and introduces new concepts.

--- Page 14 ---

## 2.9. SQL Server Data Collector 

يقوم بإنشاء Management Data Warehouse عن معلومات مراقبة الأداء الخاصة بهذه ال DB و DBs أخرى 

حيث لاستخدامها نقوم ب Enable لنا Data Collection 

ثم من ال Tasks الخاص بها نختار Configure Management Data Warehouse 

 

و بعد الإنتهاء من إنشائه، نقوم من نفس القائمة اختيار Configure Data Collection لاستخدامها في عرض المعلومات عن

--- Page 15 ---

SQL Server Data Collector is another SQL Server Management Studio feature that can be used for SQL Server performance monitoring and troubleshooting.

--- Page 16 ---

Data Collector can collect performance metrics on multiple SQL Server instances and store them in a single repository. Data collection is possible only if SQL Server Agent is running and Management Data Warehouse is configured. 

## 2.10. Query Store 

:الستخدامها

--- Page 17 ---

(مستار تنفيذها) Query الخاص بال Execution Plane تقوم بتوفير معلومات عن الـ 

مع اخبارنا عند تنفيذ الـ Query بمسار مختلف مع إمكانية المقارنة بينهما و إمكانية إجبار الـ Query لاستخدام أحد المسارات 

بشكل دائم لتحقيق أداء أعلى (و هذه الميزة غير موجودة غير في هذه الأداء) 

Query Store 

• The SQL Server Query Store features provides you with insight on query plan choice and performance. It simplifies performance troubleshooting by helping you quickly find performance differences caused by query plan changes. 

• Query Store automatically captures a history of queries, plans, and runtime statistics, and retains these for your review. It separates data by time windows so you can see database usage patterns and understand when query plan changes happened on the server. 

كما تقوم بتوفير Reports عن: – Regression Queries – استهلاك الموارد الكلي من قبل الـ Execution Plane لكل Query 

Overall Resource Consumption – استهلاك الموارد الكلي من قبل الـ Execution Plane لكل Query

--- Page 18 ---

The SQL Server Query Store feature provides you with insight on query plan choice and performance. It simplifies performance troubleshooting by helping you quickly find performance differences caused by query plan changes. Query Store automatically captures a history of queries, plans, and runtime statistics, and retains these for your review. It separates data by time windows so you can see database usage patterns and understand when query plan changes happened on the server.  

## 2.10.1. Enabling the Query Store  

Query Store is not active for new databases by default.  

1. Use the Query Store Page in SQL Server Management Studio  

- In the Database Properties dialog box, select the Query Store page.- In the Operation Mode (Requested) box, select Read Write.  

  

## 2. By Using T-SQL  

SQL  

ALTER DATABASE AdventureWorks2012 SET QJERY_STORE (OPERATION_MODE = READ_WRITE);

--- Page 19 ---

## 2.10.2. Information in the Query Store  

2.10.2. Information in the Query StoreExecution plans for any specific query in SQL Server typically evolve over time due to a number of different reasons such as statistics changes, schema changes, creation/deletion of indexes, etc. The procedure cache (where cached query plans are stored) only stores the latest execution plan. Plans also get evicted from the plan cache due to memory pressure. As a result, query performance regressions caused by execution plan changes can be non- trivial and time consuming to resolve.  

Common scenarios for using the Query Store feature are:  

Common scenarios for using the Query Store feature are:- Quickly find and fix a plan performance regression by forcing the previous query plan. Fix queries that have recently regressed in performance due to execution plan changes.- Determine the number of times a query was executed in a given time window, assisting a DBA in troubleshooting performance resource problems.- Identify top n queries (by execution time, memory consumption, etc.) in the past x hours.- Audit the history of query plans for a given query.- Analyze the resource (CPU, I/O, and Memory) usage patterns for a particular database.- Identify top n queries that are waiting on resources.- Understand wait nature for a particular query or plan.  

The query store contains three stores:  

A plan store for persisting the execution plan information. A runtime stats store for persisting the execution statistics information. A wait stats store for persisting wait statistics information.  

The following query returns information about queries and plans in the query store.  

SELECT Txt.query_text_id, Txt.query_sql_text, P1.plan_id, Qry.\\* FROM sys.query_store_plan AS P1 INNER JOIN sys.query_store_query AS Qry ON P1. query_id = Qry. query_id INNER JOIN sys.query_store_query_text AS Txt ON Qry. query_text_id = Txt. query_text_id ;

--- Page 20 ---

After enabling Query Store, a set of performance monitoring could be obtained as the following:  

  

### 2.11. Performance Dashboard  

SQL Server Management Studio version 17.2 and later includes the Performance Dashboard. This dashboard was designed to visually provide fast insight into the performance state of SQL Server (Starting with SQL Server 2008).  

The Performance Dashboard helps to quickly identify whether SQL Server is experiencing a performance bottleneck. And if a bottleneck is found, easily capture additional diagnostic data that may be necessary to resolve the problem. Some common performance problems which the Performance Dashboard can help identify include:  

- CPU bottlenecks (and what queries are consuming the most CPU)- I/O bottlenecks (and what queries are performing the most IO)- Index recommendations generated by the Query Optimizer (missing indexes)- Blocking- Resource contention (including latch contention)

--- Page 21 ---

The Performance Dashboard also helps to identify expensive queries that may have been executed before, and several metrics are available to define high cost: CPU, Logical Writes, Logical Reads, Duration, Physical Reads, and CLR Time.

--- Page 22 ---

## 2.12. Windows Performance Monitor 

هو أداة موجودة في ويندوز، مشكلته أنه يستهلك كثير من الموارد ليحلل استهلاك الموارد و أداء ال 

حيث لتفعيل مراقبة ال Server نغوم بإضافة Counter و تحديد نوعها ب SQL Server : 

 

<center>Database Administrator أكثر من ال System Administrator و تستخدم من قبل ال</center>

--- Page 23 ---

Windows Performance Monitor shows useful information in comprehensive real- time graphs and can save historical data for a long time, so it can be used for later analysis. Its disadvantages are that it cannot provide sufficient information for deep analysis nor show a trend line or a threshold in the graph.  

  

## References  

LeBlanc. P, Assaf. W, Jackson. B, Curnutt M; "SQL Server 2017 Administration Inside Out", Microsoft Press (2018).  

Microsoft SQL Server Mission- Critical Performance, Technical White Paper, Microsoft (2016)  

https://docs.microsoft.com/en- us/sql/sql- server/
