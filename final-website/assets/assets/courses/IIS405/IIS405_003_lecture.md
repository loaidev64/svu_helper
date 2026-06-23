--- Page 1 ---

title[[120, 307, 878, 403]]
# Oracle Database Administration I  

text[[230, 455, 765, 484]]
Chapter 3: Creating a Database

--- Page 2 ---

sub_title[[732, 147, 887, 170]]  

text[[114, 205, 883, 811]]
Objectives 2 Introduction 3 1. Setting OS Variables.. 4 2. Creating a Database... 5 3. Oracle Database Architecture Overview.. 10 4. Overview of the Oracle Instance .11 4.1. System Global Area. 12 4.2. Program Global Area. 17 4.3. Background Processes.. 20 5. Oracle database. 29 5.1. Database Data Files... 29 5.2. Database System Files. 30 6. Creating a Password File .33 7. Starting and Stopping the Database. 35 7.1. Starting Up an Oracle Database Instance.. 35 7.2. Startup Options- Examples. 37 7.3. Shutdown Modes... 37 7.4. Shutdown Modes- comparison ..38 7.5. Shutdown Options: Examples. 39 8. Initialization parameters. .40 8.1. Parameters files.. 40 8.2. Types of Values for Initialization Parameters. 40 8.3. View Initialization parameters... 42 8.4. Changing Initialization Parameter Values. 44 8.5. Changing Parameter Values- Examples. 44 9. Quiz. .45

--- Page 3 ---

sub_title[[118, 108, 245, 127]]
## Objectives  

text[[176, 140, 878, 160]]
1. Create a database by using the Database Configuration Assistant (DBCA).  

text[[177, 167, 572, 186]]
2. Oracle Database Architecture Overview.  

text[[178, 193, 478, 210]]
3. Oracle instance components.  

text[[176, 217, 607, 236]]
4. Starting Up and Shutting Down a database.  

text[[177, 243, 577, 260]]
5. Modify database initialization parameters.

--- Page 4 ---

sub_title[[117, 109, 263, 127]]
## Introduction  

text[[116, 142, 674, 159]]
There are a few standard ways for creating Oracle databases:  

text[[147, 167, 880, 262]]
Use the Database Configuration Assistant (dbca) utility Run a CREATE DATABASE statement from any SQL Tool like: SQL\\*Plus/Toad For Oracle Clone a database from an existing database  

text[[115, 269, 882, 491]]
Oracle's dbca utility has a graphical interface from which you can configure and create databases. This visual tool is easy to use and has a very intuitive interface. If you need to create a development database and get going quickly, then this tool is more than adequate. The dbca utility also allows you to create a database in silent mode, without the graphical component. Using dbca in silent mode with a response file is an efficient way to create databases in a consistent and repeatable manner. The dbca tool can run in silent mode after the binary installation or launched separately. SQL\\*Plus/Toad for Oracle works no matter how slow the network connection is, and it isn't dependent on a graphical component.

--- Page 5 ---

sub_title[[119, 108, 411, 128]]
## 1. Setting OS Variables:  

text[[114, 141, 881, 210]]
Before creating a database, you need to know a bit about OS variables, often called environment variables. Before you run SQL\\*Plus (or any other Oracle utility), you must set several OS variables:  

text[[142, 218, 330, 287]]
ORACLE_HOME ORACLE_SID PATH  

text[[113, 294, 881, 413]]
The ORACLE_HOME variable defines the starting point directory for the default location for the initialization file, which is on Windows ORACLE_HOME\database. The ORACLE_HOME variable is also important because it defines the starting point directory for locating the Oracle binary files (such as sqlplus, dbca, netca, rman, and so on) that are in ORACLE_HOME/bin.  

text[[113, 420, 880, 490]]
The ORACLE_SID variable defines the default name of the database you're attempting to create. ORACLE_SID is also used as the default name for the parameter file, which is init<ORACLE_SID>.ora or spfile<ORACLE_SID>.ora.  

text[[113, 497, 880, 567]]
The PATH variable specifies which directories are looked in by default when you type a command from the OS prompt. In almost all situations, ORACLE_HOME/bin (the location of the Oracle binaries) must be included in your PATH variable.  

image[[122, 571, 866, 871]]

--- Page 6 ---

sub_title[[117, 108, 398, 128]]
## 2. Creating a Database:  

text[[115, 141, 882, 210]]
use the dbca utility to create a database. This utility works in two modes: graphical and silent. We can start dbca from command line or from start Menu \(\rightarrow\) All programs then choose the related icon of dbca button in windows:  

image[[334, 235, 660, 666]]  

text[[124, 697, 503, 714]]
and the following screen will appear soon:

--- Page 7 ---

image[[197, 100, 797, 420]]  

text[[117, 425, 878, 468]]
Choose create a database option as a performed operation. Then press Next button at the bottom:  

image[[198, 496, 796, 818]]

--- Page 8 ---

text[[117, 105, 880, 149]]
Choose Advanced configuration option as a Database Creation Mode. Then press Next button at the bottom:  

image[[192, 153, 800, 476]]  

image[[185, 495, 807, 828]]

--- Page 9 ---

text[[116, 106, 880, 149]]
Choose General Purpose or Transaction Processing option as a template for you database and choose Oracle Single Instance database as database type:  

image[[208, 154, 788, 465]]  

text[[115, 494, 876, 536]]
Enter the name of your database SID and Global database name. and choose to create as container database.  

image[[187, 564, 803, 892]]

--- Page 10 ---

text[[117, 106, 590, 123]]
Choose File System as Database files storage type.  

image[[135, 128, 857, 513]]  

text[[116, 541, 880, 584]]
This Step is to set the fast recovery area and determine its folder on the files system in the operating system.  

text[[117, 616, 881, 687]]
Then continue till you finished all the required steps to find your database is successfully created and implemented. You can refer to chapter 2- Installing the Oracle Binaries to see the other steps in details.

--- Page 11 ---

sub_title[[117, 108, 623, 128]]
## 3. Oracle Database Architecture Overview:  

text[[115, 141, 883, 312]]
An Oracle database is a collection of data treated as a unit. The purpose of a database is to store and retrieve related information. A database server is the key to solving the problems of information management. In general, a server reliably manages a large amount of data in a multiuser environment so that many users can concurrently access the same data. All this is accomplished while delivering high performance. A database server also prevents unauthorized access and provides efficient solutions for failure recovery.  

text[[115, 319, 883, 389]]
An Oracle database server consists of an Oracle database (physical structures and logical structures), and an Oracle instance (memory structures and background processes).  

text[[117, 396, 660, 414]]
The following figure shows the Oracle database architecture:  

image[[225, 444, 753, 832]]

--- Page 12 ---

sub_title[[117, 108, 538, 128]]
## 4. Overview of the Oracle Instance:  

text[[115, 141, 882, 210]]
Every time a database is started, a system global area (SGA) is allocated and Oracle background processes are started. The combination of the background processes and memory buffers is called an Oracle instance.  

text[[116, 217, 883, 363]]
Instance existence is transient, in your RAM and on your CPU(s). When you shut down the running instance, all trace of its existence goes away at the same time. The database consists of physical files on disk. Whether running or stopped, these remain. Thus the lifetime of the instance is only as long as it exists in memory: it can be started and stopped. By contrast, the database, once created, persists indefinitely—until you deliberately delete the files that are associated with the database:  

sub_title[[138, 392, 320, 409]]
## Database Instance  

image[[145, 428, 860, 727]]

--- Page 13 ---

text[[115, 105, 882, 227]]
A database instance contains a set of Oracle Database background processes and memory structures. The main memory structures are the System Global Area (SGA) and the Program Global Areas (PGAs). The background processes operate on the stored data (data files) in the database and use the memory structures to do their work. A database instance exists only in memory.  

text[[115, 258, 882, 379]]
Oracle Database also creates server processes to handle the connections to the database on behalf of client programs,and to perform the work for the client programs; for example, parsing and running SQL statements, and retrieving and returning results to the client programs. These types of server processes are also referred to as foreground processes.  

sub_title[[118, 414, 379, 433]]
### 4.1. System Global Area:  

image[[138, 442, 855, 656]]  

text[[115, 684, 880, 755]]
All server and background processes share the SGA. When you start a database instance, the amount of memory allocated for the SGA is displayed. The SGA includes the following data structures:

--- Page 14 ---

title[[118, 108, 320, 126]]
#### 4.1.1.Shared pool:  

text[[115, 137, 884, 258]]
Caches various constructs that can be shared among users; for example, the shared pool stores parsed SQL, PL/SQL code, system parameters, and data dictionary information. The shared pool is involved in almost every operation that occurs in the database. For example, if a user executes a SQL statement, then Oracle Database accesses the shared pool.  

image[[174, 284, 817, 533]]  

title[[118, 567, 368, 586]]
#### 4.1.2.Flashback buffer:  

text[[115, 597, 881, 717]]
Is an optional component in the SGA.When Flashback Database is enabled,the background process called Recovery Writer Process (RVWR) is started.RVWR periodically copies modified blocks from the buffer cache to the flashback buffer,and sequentially writes Flashback Database data from the flashback buffer to the Flashback Database logs, which are circularly reused.  

text[[115, 725, 881, 819]]
Database buffer cache: Is the memory area that stores copies of data blocks read from data files. A buffer is a main memory address in which the buffer manager temporarily caches a currently or recently used data block. All users concurrently connected to a database instance share access to the buffer cache.

--- Page 15 ---

image[[139, 10, 217, 53]]  

text[[72, 60, 214, 83]]
A  

title[[114, 309, 486, 327]]
#### 4.1.3. Database Smart Flash cache:  

image[[128, 233, 280, 266]]  

text[[298, 230, 336, 264]]
Buffer Cache extention  

title[[520, 110, 698, 123]]
# System Global Area (SGA)  

image[[362, 125, 842, 277]]  

sub_title[[117, 567, 356, 585]]
#### 4.1.4. Redo log buffer:  

text[[115, 601, 881, 725]]
Is a circular buffer in the SGA that holds information about changes made to the database. This information is stored in redo entries. Redo entries contain the information necessary to reconstruct (or redo) changes that are made to the database by data manipulation language (DML), data definition language (DDL), or internal operations. Redo entries are used for database recovery if necessary.

--- Page 16 ---

title[[119, 108, 309, 126]]
#### 4.1.5.Large pool:  

text[[115, 137, 882, 283]]
4.1.5. Large pool:Is an optional memory area intended for memory allocations that are larger than is appropriate for the shared pool. The large pool can provide large memory allocations for the User Global Area (UGA) for the shared server and the Oracle XA interface (used where transactions interact with multiple databases), message buffers used in the parallel execution of statements, buffers for Recovery Manager (RMAN) I/O slaves, and deferred inserts.  

image[[142, 311, 850, 593]]  

title[[119, 624, 365, 643]]
#### 4.1.6.In-Memory Area:  

text[[115, 653, 882, 825]]
4.1.6. In- Memory Area:Is an optional component that enables objects (tables, partitions, and other types) to be stored in memory in a new format known as the columnar format. This format enables scans, joins, and aggregates to perform much faster than the traditional on- disk format, thus providing fast reporting and DML performance for both OLTP and DW environments. This feature is particularly useful for analytic applications that operate on a few columns returning many rows rather than for OLTP, which operates on a few rows returning many columns.

--- Page 17 ---

image[[147, 0, 911, 365]]  

title[[119, 395, 385, 414]]
#### 4.1.7. Memoptimize Pool:  

text[[114, 426, 884, 624]]
Is an optional component that provides high performance and scalability for key- based queries. The Memoptimize Pool contains two parts, the memoptimize buffer area and the hashindex. Fast lookup uses the hash index structure in the memoptimize pool providing fast access to the blocks of a given table (enabled for MEMOPTIMIZE FOR READ) permanently pinned in the buffer cache to avoid disk I/O. The buffers in the memoptimize pool are completely separate from the database buffer cache. The hash index is created when the Memoptimized Row store is configured, and is maintained automatically by Oracle Database.  

title[[117, 657, 500, 676]]
#### 4.1.8. Shared I/O pool (SecureFiles):  

text[[116, 687, 881, 756]]
Is used for large I/O operations on SecureFile Large Objects (LOBs). LOBS are a set of data types that are designed to hold large amounts of data. SecureFile is an LOB storage parameter that allows deduplication, encryption, and compression.

--- Page 18 ---

title[[120, 108, 337, 126]]
#### 4.1.9. Streams pool:  

text[[117, 137, 882, 258]]
Is used by Oracle Streams, Data Pump, and GoldenGate integrated capture and apply processes. The Streams pool stores buffered queue messages, and it provides memory for Oracle Streams capture processes and apply processes. Unless you specifically configure it, the size of the Streams pool starts at zero. The pool size grows dynamically as needed when Oracle Streams is used.  

title[[120, 292, 313, 310]]
#### 4.1.10. Java pool:  

text[[117, 322, 880, 390]]
Is used for all session- specific Java code and data in the Java Virtual Machine (JVM). Java pool memory is used in different ways, depending on the mode in which Oracle Database is running.  

title[[120, 424, 325, 442]]
#### 4.1.11. Fixed SGA:  

text[[119, 455, 880, 500]]
Is an internal housekeeping area containing general information about the state of the database and database instance, and information communicated between processes.  

title[[120, 533, 393, 551]]
#### 4.2. Program Global Area:  

image[[204, 584, 789, 884]]

--- Page 19 ---

text[[115, 105, 883, 278]]
The Program Global Area (PGA) is a non- shared memory region that contains data and control information exclusively for use by server and background processes. Oracle Database creates server processes to handle connections to the database on behalf of client programs. In a dedicated server environment, one PGA gets created for each server and background process that is started. Each PGA consists of stack space, hash area, bitmap merge area and a User Global Area (UGA). A PGA is deallocated when the associated server or background process using it is terminated.  

text[[145, 284, 881, 354]]
In a shared server environment, multiple client users share the server process. The UGA is moved into the large pool, leaving the PGA with only stack space, hash area, and bitmap merge area.  

text[[147, 360, 869, 380]]
In a dedicated server session, the PGA consists of the following components:  

text[[176, 386, 881, 431]]
1. SQL work areas: The sort area is used by functions that order data, such as ORDER BY and GROUP BY.  

text[[177, 438, 880, 533]]
2. Session memory: This user session data storage area is allocated for session variables, such as logon information, and other information required by a database session. The OLAP pool manages OLAP data pages, which are equivalent to data blocks.  

text[[177, 540, 881, 686]]
3. Private SQL area: This area holds information about a parsed SQL statement and other session-specific information for processing. When a server process executes SQL or PL/SQL code, the process uses the private SQL area to store bind variable values, query execution state information, and query execution work areas. Multiple private SQL areas in the same or different sessions can point to a single execution plan in the SGA.  

text[[177, 693, 650, 711]]
The persistent area contains bind variable values.  

text[[179, 720, 762, 738]]
The run- time area contains query execution state information.  

text[[178, 745, 880, 839]]
A cursor is a name or handle to a specific area in the private SQL area. You can think of a cursor as a pointer on the client side and as a state on the server side. Because cursors are closely associated with private SQL areas, the terms are sometimes used interchangeably.

--- Page 20 ---

text[[177, 105, 835, 124]]
1. Stack space is memory allocated to hold session variables and arrays.  

text[[176, 132, 702, 150]]
2. The hash area is used to perform hash joins of tables.  

text[[177, 158, 880, 202]]
3. The bitmap merge area is used to merge data retrieved from scans of multiple bitmap indexes.  

text[[147, 234, 881, 278]]
- SQL work areas: The sort area is used by functions that order data, such as ORDER BY and GROUPBY.  

text[[148, 286, 880, 380]]
- Session memory: This user session data storage area is allocated for session variables, such as logon information, and other information required by a database session. The OLAP pool managesOLAP data pages, which are equivalent to data blocks.  

text[[148, 387, 881, 533]]
- Private SQL area: This area holds information about a parsed SQL statement and other session-specific information for processing. When a server process executes SQL or PL/SQL code, the process uses the private SQL area to store bind variable values, query execution state information, and query execution work areas. Multiple private SQL areas in the same or different sessions can point to a single execution plan in the SGA. 0  

text[[179, 565, 643, 583]]
- The persistent area contains bind variable values.  

text[[180, 592, 763, 610]]
- The run-time area contains query execution state information.  

text[[181, 618, 880, 712]]
- A cursor is a name or handle to a specific area in the private SQL area. You can think of a cursor as a pointer on the client side and as a state on the server side. Because cursors are closely associated with private SQL areas, the terms are sometimes used interchangeably.  

text[[148, 719, 880, 763]]
- Stack space: Stack space is memory allocated to hold session variables and arrays.  

text[[149, 772, 727, 790]]
- Hash area: This area is used to perform hash joins of tables.  

text[[148, 798, 880, 841]]
- Bitmap merge area: This area is used to merge data retrieved from scans of multiple bitmap indexes

--- Page 21 ---

sub_title[[117, 106, 413, 124]]
### 4.3. Background Processes:  

image[[160, 161, 840, 430]]  

text[[114, 462, 881, 657]]
Background processes are part of the database instance and perform maintenance tasks required to operate the database and to maximize performance for multiple users. Each background process performs a unique task, but works with the other processes. Oracle Database creates background processes automatically when you start a database instance. The background processes that are present depend on the features that are being used in the database. When you start a database instance, mandatory background processes automatically start. You can start optional background processes later as required.  

text[[114, 664, 881, 888]]
Mandatory background processes are present in all typical database configurations. These processes run by default in a read/write database instance started with a minimally configured initialization parameter file. A read- only database instance disables some of these processes. Mandatory background processes include the Process Monitor Process (PMON), Process Manager Process (PMAN), Listener Registration Process (LREG), System Monitor Process (SMON), Database Writer Process (DBWn), Checkpoint Process (CKPT), Manageability Monitor Process (MMON), Manageability Monitor Lite Process (MMNL), Recoverer Process (RECO), and LogWriter Process (LGWR).

--- Page 22 ---

text[[114, 105, 884, 253]]
Most optional background processes are specific to tasks or features. Some common optional processes include Archiver Processes (ARCn), Job Queue Coordinator Process (CJQ0), Recovery Writer Process (RVWR), Flashback Data Archive Process (FBDA), and Space Management Coordinator Process (SMCO). Slave processes are background processes that perform work on behalf of other processes; for example, the Dispatcher Process (Dnn) and Shared Server Process (Snnn).  

title[[117, 284, 541, 304]]
#### 4.3.1. Process Monitor Process (PMON):  

image[[223, 313, 769, 565]]  

text[[114, 594, 884, 740]]
Process Monitor Process (PMON) is a background process that periodically scans all processes to find any that have died abnormally. PMON is then responsible for coordinating cleanup performed by the Cleanup MainProcess (CLMN) and the Cleanup Slave Process slaves (CLnn). PMON runs as an operating system process, and not as a thread. In addition to database instances, PMON also runs on Oracle Automatic Storage Management (ASM) instances and Oracle ASM Proxy instances.

--- Page 23 ---

title[[117, 106, 550, 125]]
#### 4.3.2. Process Manager Process (PMAN):  

image[[138, 160, 863, 354]]  

text[[114, 383, 883, 555]]
Process Manager Process (PMAN) is a background process that monitors, spawns, and stops the following as needed: Dispatcher and shared server processes Connection broker and pooled server processes for database resident connection pools Job queue processes Restartable background processes. PMAN runs as an operating system process, and not as a thread. In addition to database instances, PMAN also runs on Oracle Automatic Storage Management (ASM) instances and Oracle ASM Proxy instances.  

title[[117, 588, 582, 608]]
#### 4.3.3. Listener Registration Process (LREG):  

image[[245, 616, 749, 711]]  

text[[114, 744, 883, 863]]
Listener Registration Process (LREG) is a background process that notifies the listeners about instances, services, handlers, and endpoints. LREG can run as a thread or an operating system process. In addition to database instances, LREG also runs on Oracle Automatic Storage Management (ASM) instances and Oracle Real Application Clusters (RAC).

--- Page 24 ---

sub_title[[117, 106, 533, 126]]
### 4.3.4. System Monitor Process (SMON):  

image[[138, 160, 861, 382]]  

text[[116, 412, 881, 458]]
System Monitor Process (SMON) is a background process that performs many database maintenance tasks, including the following:  

text[[147, 464, 883, 632]]
- Creates and manages the temporary tablespace metadata, and reclaims space used by orphaned temporary segments. Maintains the undo tablespace by onlining, offlining, and shrinking the undo segments based on undospace usage statistics- Cleans up the data dictionary when it is in a transient and inconsistent state.- Maintains the System Change Number (SCN) to time mapping table used to support Oracle Flashback features.SMON is resilient to internal and external errors raised during background activities. SMON can run as a thread or an operating system process. In an Oracle Real Application Clusters (RAC) database, the SMON process of one instance can perform instance recovery for other instances that have failed.  

text[[147, 640, 881, 735]]
SMON is resilient to internal and external errors raised during background activities. SMON can run as a thread or an operating system process. In an Oracle Real Application Clusters (RAC) database, the SMON process of one instance can perform instance recovery for other instances that have failed.

--- Page 25 ---

title[[117, 106, 537, 125]]
#### 4.3.5. Database Writer Process (DBWn):  

image[[138, 158, 862, 362]]  

text[[114, 388, 884, 739]]
Database Writer Process (DBWn) is a background process that primarily writes data blocks to disk. It also handles checkpoints, file open synchronization, and logging of Block Written records. DBWn also writes to the Database Smart Flash Cache (Flash Cache), when Flash Cache is configured. In many cases the blocks that DBWn writes are scattered throughout the disk. Thus, the writes tend to be slower than the sequential writes performed by the Log Writer Process (LGWR). DBWn performs multi- block writes when possible to improve efficiency. The number of blocks written in a multi- block write varies by operating system. The DB_WRITER_PROCESSES initialization parameter specifies the number of Database Writer Processes. There can be 1 to 100 Database Writer Processes. The names of the first 36 Database Writer Processes are DBW0- DBW9 and DBWA- DBWz. The names of the 37th through 100th Database Writer Processes are BW36- BW99. The database selects an appropriate default setting for the DB_WRITER_PROCESSES parameter or adjusts a user- specified setting based on the number of CPUs and processor groups.

--- Page 26 ---

title[[117, 106, 484, 125]]
#### 4.3.6. Checkpoint Process (CKPT):  

image[[207, 158, 783, 380]]  

text[[115, 409, 882, 606]]
Checkpoint Process (CKPT) is a background process that, at specific times, starts a checkpoint request by messaging Database Writer Process (DBWn) to begin writing dirty buffers. On completion of individual checkpoint requests, CKPT updates data file headers and control files to record the most recent check point. CKPT checks every three seconds to see whether the amount of memory exceeds the value of the PGA_AGGREGATE_LIMIT initialization parameter, and if so, takes action. CKPT can run as a thread or an operating system process. In addition to database instances, CKPT also runs on Oracle Automatic Storage Management (ASM) instances.

--- Page 27 ---

sub_title[[117, 106, 481, 125]]
### 4.3.7. Log Writer Process (LGWR):  

image[[135, 160, 850, 380]]  

text[[114, 415, 884, 767]]
Log Writer Process (LGWR) is a background process that writes redo log entries sequentially into a redo log file. Redo log entries are generated in the redo log buffer of the System Global Area (SGA). If the database has a multiplexed redo log, then LGWR writes the same redo log entries to all of the members of a redo log file group. LGWR handles the operations that are very fast, or must be coordinated, and delegates operations to the LogWriter Worker helper processes (LGnn) that could benefit from concurrent operations, primarily writing the redo from the log buffer to the redo log file and posting the completed write to the foreground process that is waiting. The Redo Transport Slave Process (TT00- zz) ships redo from the current online and standby redo logs to remote standby destinations configured for Asynchronous (ASYNC) redo transport. LGWR can run as a thread or as an operating system process. In addition to database instances, LGWR also runs on Oracle ASM instances. Each database instance in an Oracle Real Application Clusters (RAC) configuration has its own set of redo log files

--- Page 28 ---

sub_title[[117, 107, 455, 126]]
#### 4.3.8. Archiver Process (ARCn):  

image[[179, 158, 808, 419]]  

text[[114, 451, 884, 776]]
Archiver Processes (ARCn) are background processes that exist only when the database is in ARCHIVELOG mode and automatic archiving is enabled, in which case ARCn automatically archives online redo log files. LogWriter Process (LGWR) cannot reuse and overwrite an online redo log group until it has been archived. The database starts multiple archiver processes as needed to ensure that the archiving of filled online redo logs does not fall behind. Possible processes include ARCO- ARC9 and ARCA- ARCT (31 possible destinations). The LOG_ARCHIVE_MAX_PROCESSES initialization parameter specifies the number of ARCn processes that the database initially invokes. If you anticipate a heavy workload for archiving, such as during bulk loading of data, you can increase the maximum number of archiver processes. There can also be multiple archive log destinations. It is recommended that there be at least one archiver process for each destination. ARCn can run as a thread or as an operating system process.

--- Page 29 ---

sub_title[[117, 105, 837, 125]]
### 4.3.9. Dispatcher Process (Dnnn) and Shared Server Process (Snnn):  

image[[138, 158, 849, 289]]  

text[[115, 319, 884, 590]]
In a shared server architecture, clients connect to a Dispatcher Process (Dnnn), which creates a virtual circuit for each connection. When the client sends data to the server, the dispatcher receives the data into the virtual circuit and places the active circuit on the common queue to be picked up by an idle Shared Server process (Snnn). The Snnn then reads the data from the virtual circuit and performs the database work necessary to complete the request. When the Snnn must send data to the client, the Snnn writes the data back into the virtual circuit and the Dnnn sends the data to the client. After the Snnn completes the client request, it releases the virtual circuit back to the Dnnn and is free to handle other clients. Both Snnn and Dnnn can run as threads or as operating system processes. In addition to database instances, Dnnn also runs on shared servers

--- Page 30 ---

sub_title[[117, 109, 358, 128]]
## 5. Oracle database:  

title[[116, 142, 385, 160]]
#### 5.1. Database Data Files:  

image[[135, 195, 856, 493]]  

text[[114, 527, 881, 622]]
A database is a set of physical files that store user data and metadata. The metadata consists of structural, configuration, and control information about the database server. You can design your database to be a multitenant container database (CDB) or a non- - container database (non- CDB).  

text[[114, 628, 881, 747]]
A CDB is made up of one CDB root container (also called the root), exactly one seed pluggable database (seedPDB), zero or more user- created pluggable databases (simply referred to as PDBs), and zero or more application containers. The entire CDB is referred to as the system container. To a user or application, PDBs appear logically as separate databases.  

text[[114, 755, 881, 849]]
The CDB root, named CDB\*ROOT, contains multiple data files, control files, redo log files, flashback logs, and archived redo log files. The data files store Oracle- supplied metadata and common users (users that are known in every container), which are shared with all PDBs.

--- Page 31 ---

text[[114, 105, 881, 150]]
The seed PDB, named PDB\$SEED, is a system- supplied PDB template containing multiple data files that you can use to create new PDBs.  

text[[113, 157, 883, 277]]
The regular PDB contains multiple data files that contain the data and code required to support an application; for example, a Human Resources application. Users interact only with the PDBs, and not the seed PDB or root container. You can create multiple PDBs in a CDB. One of the goals of the multitentant architecture is that each PDB has a one- to- one relationship with an application.  

text[[114, 283, 881, 380]]
An application container is an optional collection of PDBs within a CDB that stores data for an application. The purpose of creating an application container is to have a single master application definition. You can have multiple application containers in a CDB.  

text[[114, 386, 881, 431]]
A database is divided into logical storage units called tablespaces, which collectively store all the database data. Each tablespace represents one or more data files.  

text[[115, 437, 880, 483]]
The root container and regular PDBs have a SYSTEM, SYSAUX, USERS, TEMP, and UNDO tablespace (optional in a regular PDB).  

text[[114, 489, 827, 508]]
A seed PDB has a SYSTEM, SYSAUX, TEMP, and optional UNDO tablespace.  

sub_title[[117, 540, 407, 559]]
### 5.2. Database System Files:  

image[[222, 568, 777, 781]]  

text[[114, 814, 881, 884]]
The following database system files are used during the operation of an Oracle Database and reside on the database server. Note that data files are physical files that belong to database containers and are not described here.

--- Page 32 ---

text[[115, 106, 882, 253]]
Control files: A control file is a required file that stores metadata about the data files and online redo logfiles; for example, their names and statuses. This information is required by the database instance to open the database. Control files also contain metadata that must be accessible when the database is not open. It is highly recommended that you make several copies of the control file in your database server for high availability.  

text[[115, 259, 881, 331]]
Parameter file: This required file defines how the database instance is configured when it starts up. It can be either an initialization parameter file (pfile) or a server parameter file (spfile).  

text[[116, 337, 880, 381]]
Online redo log files: These required files store changes to the database as they occur and are used for data recovery.  

text[[115, 387, 881, 557]]
Automatic Diagnostic Repository (ADR): The ADR is a file- based repository for database diagnostic data, such as traces, dumps, the alert log, health monitor reports, and more. It has a unified directory structure across multiple instances and multiple products. The database, Oracle Automatic Storage Management (Oracle ASM), the listener, Oracle Clusterware, and other Oracle products or components store all diagnostic data in the ADR. Each instance of each product stores diagnostic data underneath its own home directory within the ADR.  

text[[115, 565, 881, 634]]
Backup files: These optional files are used for database recovery. You typically restore a backup file when a media failure or user error has damaged or deleted the original file.  

text[[116, 641, 882, 737]]
Archived redo log files: These optional files contain an ongoing history of the data changes that are generated by the database instance. Using these files and a backup of the database, you can recover a lost data file. That is, archive logs enable the recovery of restored data files.  

text[[116, 744, 881, 813]]
Password file: This optional file enables users using the SYSDBA, SYSOPER, SYSBACKUP, SYSDG, SYSKM, SYSRAC, and SYSASM roles to connect remotely to the database instance and perform administrative tasks.  

text[[116, 820, 881, 890]]
Wallets: For large- scale deployments where applications use password credentials to connect to databases, it is possible to store such credentials in a client- side Oracle wallet. An Oracle wallet is a secure software container that is used to store

--- Page 33 ---

text[[117, 105, 883, 201]]
authentication and signing credentials. Possible wallets include an Oracle wallet for user credentials, Encryption Wallet for Transparent Data Encryption (TDE), and an Oracle Public Cloud (OPC) wallet for the database backup cloud module. A wallet is optional, but recommended.  

text[[117, 208, 883, 325]]
Block change tracking file: Block change tracking improves the performance of incremental backups by recording changed blocks in the block change tracking file. During an incremental backup, instead of scanning all data blocks to identify which blocks have changed, Oracle Recovery Manager (RMAN) uses this file to identify the changed blocks that need to be backed up. A block change tracking file is optional.  

text[[117, 333, 883, 480]]
Flashback logs: Flashback Database is similar to conventional point- in- time recovery in its effects. It enables you to return a database to its state at a time in the recent past. Flashback Database uses its own logging mechanism, creating flashback logs and storing them in the fast recovery area. You can use Flashback Database only if flashback logs are available. To take advantage of this feature, you must setup your database in advance to create flashback logs. Flashback logs are optional.  

text[[117, 487, 881, 555]]
Control files, online redo log files, and archive redo log files can be multiplexed, which mean that two or more identical copies can be automatically maintained in separate locations.

--- Page 34 ---

sub_title[[117, 108, 465, 129]]
## 6. Creating a Password File:  

text[[116, 141, 880, 185]]
Creating a password file is optional. There are some good reasons for requiring a password file:  

text[[146, 193, 881, 313]]
You want to assign non- sys users sys\\* privileges (sysdba, sysoper, sysbackup, and so on). You want to connect remotely to your database via Oracle Net with sys\\* privileges. An Oracle feature or utility requires the use of a password file.  

text[[117, 345, 624, 364]]
Perform the following steps to implement a password file:  

text[[176, 371, 634, 390]]
1. Create the password file with the orapwd utility.  

text[[175, 397, 881, 441]]
2. Set the initialization parameter REMOTE_LOGIN_PASSWORDFILE to EXCLUSIVE.  

text[[117, 475, 725, 492]]
The following example shows the syntax in a Windows environment:  

text[[116, 496, 846, 529]]
c:\> cd %ORACLE_HOME%\database c:\> orapwd file=PWD<ORACLE_SID>.ora password=<sys password>  

text[[117, 556, 881, 626]]
To enable the use of the password file, set the initialization parameter REMOTE_LOGIN_PASSWORDFILE to EXCLUSIVE (this is the default value). If the parameter is not set to EXCLUSIVE, then you'll have to modify your parameter file:  

text[[117, 653, 878, 688]]
SQL> alter system set remote_login_passwordfile='EXCLUSIVE' scope=spfile;  

text[[116, 691, 744, 709]]
You need to stop and start the instance to instantiate the prior setting.  

text[[117, 717, 881, 864]]
You can add users to the password file via the GRANT <any SYS privilege> statement. You want to be careful with these privileges and use of the password file for secure configurations. Only the accounts that need these privileges should be granted along with access to the password file. The following example grants SYSDBA privileges to the heera user (and thus adds heera to the password file):

--- Page 35 ---

text[[117, 105, 881, 176]]
Enabling a password file also allows you to connect to your database remotely with SYS\*- level privileges via an Oracle Net connection. This example shows the syntax for a remote connection with SYSDBA- level privileges:  

text[[118, 203, 880, 237]]
\$ sqlplus <username>/<password>@<database connection string> as sysdba  

text[[117, 265, 881, 362]]
This allows you to do remote maintenance with sys\* privileges (sysdba, sysoper, sysbackup, and so on) that would otherwise require your logging in to the database server physically. You can verify which users have sys\* privileges by querying the V\$PWFILE_USERS view:  

text[[118, 387, 530, 405]]
SQL> select \* from v\$pfile_users;  

text[[117, 424, 881, 518]]
The concept of a privileged user is also important to RMAN backup and recovery. Like SQL\*Plus, RMAN uses OS authentication and password files to allow privileged users to connect to the database. Only a privileged account is allowed to back up, restore, and recover a database.

--- Page 36 ---

sub_title[[117, 108, 587, 129]]
## 7. Starting and Stopping the Database:  

title[[118, 142, 596, 161]]
#### 7.1. Starting Up an Oracle Database Instance:  

text[[115, 198, 881, 267]]
The database instance and database go through stages as the database is made available for access by users. The database instance is started, the database is mounted, and then the database is opened.  

image[[204, 278, 791, 490]]  

sub_title[[117, 523, 223, 540]]
## NOMOUNT  

text[[115, 548, 881, 620]]
An instance is typically started only in NOMOUNT mode during database creation, during re- creation of control files, or in certain backup and recovery scenarios. When an instance is started, the following takes place:  

text[[145, 624, 880, 670]]
Searching $SORACLE_HOME/database for a file of a particular name in this sequence:  

text[[181, 676, 456, 694]]
1. Search for spfile<SID>.ora.  

text[[179, 701, 666, 719]]
2. If spfile<SID>.ora is not found, search for spfile.ora.  

text[[181, 727, 641, 745]]
3. If spfile.ora is not found, search for init<SID>.ora  

text[[179, 752, 880, 797]]
This is the file that contains initialization parameters for the instance. Specifying the PFILE parameter with STARTUP overrides the default behavior.  

text[[146, 804, 353, 822]]
Allocating the SGA  

text[[145, 830, 488, 847]]
Starting the background processes  

text[[143, 854, 807, 872]]
Opening the alert <SID>. log file and the trace files alert <SID>.

--- Page 37 ---

text[[115, 106, 874, 125]]
Note: SID is the system ID, which identifies the instance name (for example, ORCL).  

sub_title[[116, 158, 194, 175]]
## MOUNT  

text[[117, 183, 504, 201]]
Mounting a database includes the following:  

text[[146, 208, 881, 330]]
- Associating a database with a previously started instance- Locating and opening all the control files specified in the parameter file- Reading the control files to obtain the names and statuses of the data files and online redo log files. (However, no checks are performed to verify the existence of the data files and online redo log files at this time.)  

text[[116, 336, 878, 380]]
To perform specific maintenance operations, start an instance and mount a database, but do not open the database.  

text[[117, 387, 877, 431]]
For example, the database must be mounted but must not be opened during the following tasks:  

text[[146, 438, 878, 533]]
- Renaming data files. (Data files for an offline tablespace can be renamed when the database is open.)- Enabling and disabling online redo log file archiving options- Performing full database recovery  

text[[115, 540, 880, 658]]
Note: A database may be left in MOUNT mode even though an OPEN request has been made. This may be because the database needs to be recovered in some way. If recovery is performed while in the MOUNT state, the redo logs are open for reads and the data files are open as well to read the blocks needing recovery and to write blocks if required during recovery.  

sub_title[[117, 695, 167, 710]]
## open  

text[[116, 719, 880, 790]]
A normal database operation means that an instance is started and the database is mounted and opened. With a normal database operation, any valid user can connect to the database and perform typical data access operations.  

text[[117, 797, 520, 815]]
Opening the database includes the following:  

text[[147, 822, 471, 865]]
- Opening the data files- Opening the online redo log files

--- Page 38 ---

text[[115, 105, 880, 149]]
If any of the data files or online redo log files are not present when you attempt to open the database, the Oracle server returns an error.  

text[[116, 157, 881, 227]]
During this final stage, the Oracle server verifies that all data files and online redo log files can be opened, and checks the consistency of the database. If necessary, the System Monitor (SMON) background process initiates instance recovery.  

text[[116, 234, 881, 278]]
You can start up a database instance in restricted mode so that only Oracle Database users with the RESTRICTED SESSION system privilege can connect to the database.  

sub_title[[118, 310, 456, 329]]
### 7.2. Startup Options - Examples:  

text[[147, 341, 427, 359]]
Using the SQL\*Plus utility:  

text[[177, 367, 339, 384]]
1. SQL> startup  

text[[176, 392, 468, 410]]
2. SQL> alter database mount;  

text[[175, 419, 458, 436]]
3. SQL> alter database open;  

text[[174, 445, 432, 462]]
4. SQL> startup nomount  

text[[147, 490, 629, 507]]
Using the Server Control utility with Oracle Restart  

text[[176, 530, 666, 547]]
\$ svctl start database - d orcl - o mount  

sub_title[[118, 577, 352, 595]]
### 7.3. Shutdown Modes:  

table[[78, 628, 920, 760]]

<table>Shutdown ModesAbortImmediateTransactionalNormalAllows new connectionsNoNoNoNoWaits until current sessions endNoNoNoYesWaits until current transactions endNoNoYesYesForces a checkpoint and closes filesNoYesYesYes</table>

--- Page 39 ---

text[[117, 105, 881, 149]]
Shutdown modes are progressively more accommodating of current activity in this order:  

sub_title[[118, 158, 198, 174]]
## ABORT:  

text[[116, 183, 882, 303]]
Performs the least amount of work before shutting down. Because this mode requires recovery before startup, use it only when necessary. It is typically used when no other form of shutdown works, when there are problems with starting the instance, or when you need to shut down immediately because of an impending situation (such as notice of a power outage within seconds).  

sub_title[[118, 335, 238, 350]]
## IMMEDIATE:  

text[[117, 360, 792, 378]]
Is the most typically used option. Uncommitted transactions are rolled back.  

sub_title[[119, 413, 296, 430]]
## TRANSACTIONAL:  

text[[118, 440, 840, 458]]
Allows existing transactions to finish, but does not allow new transactions to start  

text[[117, 491, 510, 508]]
NORMAL: Waits for sessions to disconnect  

sub_title[[119, 542, 492, 560]]
### 7.4. Shutdown Modes- comparison:  

text[[116, 571, 882, 641]]
If you consider the amount of time that it takes to perform the shutdown, you find that ABORT is the fastest and NORMAL is the slowest. NORMAL and TRANSACTIONAL can take a long time depending on the number of sessions and transactions.

--- Page 40 ---

image[[219, 100, 767, 598]]  

sub_title[[120, 637, 478, 655]]
### 7.5. Shutdown Options: Examples:  

text[[148, 668, 508, 786]]
- Using SQL\*Plus:  
SQL> shutdown  
SQL> shutdown immediate  
SQL> shutdown abort  
SQL> shutdown transactional  

text[[149, 811, 654, 857]]
- Using the SRVCTL utility with Oracle Restart  
\$ svctl stop database -d orcl -o abort

--- Page 41 ---

sub_title[[118, 108, 444, 128]]
## 8.Initialization parameters:  

title[[117, 142, 347, 160]]
#### 8.1.Parameters files:  

text[[116, 172, 880, 217]]
When you start the instance, an initialization parameter file is read. There are two types of parameter files.  

text[[143, 222, 881, 373]]
Server parameter file (SPFILE): This is the preferred type of initialization parameter file. It is a binary file that can be written to and read by the database server and must not be edited manually. It resides on the server on which the Oracle instance is executing; it is persistent across shutdown and startup. The default name of this file, which is automatically sought at startup, is spfile<SID>.ora.  

text[[143, 400, 881, 548]]
Text initialization parameter file: This type of initialization parameter file can be read by the database server, but it is not written to by the server. The initialization parameter settings must be set and changed manually by using a text editor so that they are persistent across shutdown and startup. The default name of this file (which is automatically sought at startup if an SPFILE is not found) is init<SID>.ora.  

text[[116, 554, 880, 599]]
It is recommended that you create an SPFILE as a dynamic way to maintain initialization parameters.  

sub_title[[117, 632, 627, 652]]
### 8.2. Types of Values for Initialization Parameters:  

sub_title[[118, 664, 367, 681]]
## Derived Parameter Values  

text[[115, 688, 881, 834]]
Some initialization parameters are derived, meaning that their values are calculated from the values of other parameters. Normally, you should not alter values for derived parameters. But if you do, the value that you specify overrides the calculated value. For example, the default value of the SESSIONS parameter is derived from the value of the PROCESSES parameter. If the value of PROCESSES changes, the default value of SESSIONS changes as well, unless you override it with a specified value.

--- Page 42 ---

sub_title[[117, 105, 577, 123]]
## Operating System-Dependent Parameter Values  

text[[115, 131, 883, 277]]
The valid values or value ranges of some initialization parameters depend on the host operating system. For example, the DB_FILE_MULTIBLOCK_READ_COUNT parameter specifies the maximum number of blocks that are read in one I/O operation during a sequential scan; this parameter is platform dependent. The size of those blocks, which is set by DB_BLOCK_SIZE, has a default value that depends on the operating system.  

sub_title[[118, 310, 360, 326]]
## Setting Parameter Values  

text[[115, 334, 883, 634]]
Initialization parameters offer the most potential for improving system performance. Some parameters set capacity limits but do not affect performance. For example, when the value of OPEN_CURSORS is 10, a user process attempting to open its eleventh cursor receives an error. Other parameters affect performance but do not impose absolute limits. For example, reducing the value of OPEN_CURSORS does not prevent work even though it may slow performance. Increasing the values of parameters may improve your system's performance, but increasing most parameters also increases the System Global Area (SGA) size. A larger SGA can improve database performance up to a point. An SGA that is too large can degrade performance if it is swapped in and out of memory. Operating system parameters that control virtual memory working areas should be set with the SGA size in mind. The operating system configuration can also limit the maximum size of the SGA.

--- Page 43 ---

sub_title[[116, 108, 479, 125]]
## 8.3. View Initialization parameters:  

title[[117, 139, 282, 154]]
# Using SQL\*Plus:  

image[[127, 160, 868, 489]]  

sub_title[[116, 524, 344, 540]]
## Using Toad For Oracle:  

image[[117, 544, 905, 842]]

--- Page 45 ---

sub_title[[117, 106, 590, 125]]
## 8.4.Changing Initialization Parameter Values:  

text[[118, 138, 542, 155]]
There are two types of initialization parameters.  

text[[149, 164, 351, 181]]
Static parameters:  

text[[179, 190, 596, 207]]
Can be changed only in the parameter file  

text[[180, 215, 663, 233]]
Require restarting the instance before taking effect  

text[[149, 241, 371, 257]]
Dynamic parameters:  

text[[179, 265, 578, 282]]
Can be changed while database is online  

text[[180, 291, 654, 307]]
Can be altered at: Session level and System level  

text[[181, 316, 740, 333]]
Are valid for duration of session or based on SCOPE setting  

text[[179, 342, 879, 382]]
Are changed by using the ALTER SESSION and ALTER SYSTEM commands  

sub_title[[117, 419, 579, 438]]
## 8.5.Changing Parameter Values-Examples:  

text[[118, 449, 341, 465]]
SQL> ALTER SESSION  

text[[116, 472, 564, 489]]
2 SET NLS_DATE_FORMAT ='mon dd yyyy';  

text[[117, 517, 315, 533]]
Session altered.  

text[[115, 563, 481, 580]]
SQL> SELECT SYSDATE FROM dual;  

text[[116, 610, 205, 625]]
SYSDATE  

text[[117, 652, 256, 666]]
oct 17 2012  

text[[115, 702, 374, 718]]
SQL> ALTER SYSTEM SET  

text[[153, 725, 568, 742]]
2 SEC_MAX_FAILED_LOGIN_ATTEMPTS=2  

text[[154, 749, 636, 766]]
3 COMMENT='Reduce for tighter security.'  

text[[155, 773, 338, 788]]
4 SCOPE=SPFILE;  

text[[116, 805, 300, 821]]
System altered.

--- Page 46 ---

sub_title[[117, 108, 215, 127]]
## 9. Quiz:  

text[[116, 141, 878, 187]]
1. The memory region that contains data and control information for a server or background process is called:  

text[[147, 194, 344, 289]]
a) Shared pool 
b) PGA 
c) Buffer cache 
d) User session data  

text[[116, 319, 680, 338]]
2. What is read into the database buffer cache from data files?  

text[[147, 345, 261, 441]]
a) Rows 
b) Changes 
c) Blocks 
d) SQL  

text[[116, 474, 766, 493]]
3. Which of the following components is not part of an Oracle instance?  

text[[147, 500, 513, 593]]
a) SGA 
b) Control file 
c) Database Writer Background process 
d) PGA  

text[[116, 627, 881, 699]]
4. You are in emergency situation at your organization. There is no time to notify database users, and you need to stop the Oracle database processes immediately Which of the following would you perform?  

text[[147, 707, 468, 804]]
a) SHUTDOWN ABORT 
b) SHUTOWN TRANSACTIONAL 
c) SHUTOWN 
d) SHUTOWN NOW

--- Page 47 ---

text[[117, 106, 880, 150]]
5. You are administering an Oracle database using Shared Server. The LARGE_POOL_SIZE is 50MB. You issue the command:  

text[[146, 157, 782, 176]]
ALTER SYSTEM SET LARGE_POOL_SIZE = 100M SCOPE=MEMORY;  

text[[147, 184, 880, 227]]
You then shutdown and restart the database. What will the LARGE_POOL_SIZE be?  

text[[148, 235, 424, 328]]
a) 50 MB 
b) 100 MB 
c) database will fail to startup 
d) all the other options  

text[[117, 360, 618, 379]]
6. Which of the following is not a valid database state?  

text[[148, 387, 270, 483]]
a) Open 
b) Mount 
c) Nomount 
d) Temporary  

text[[117, 514, 880, 558]]
7. All the following are database management options within the Database Configuration Assistant except which?  

text[[148, 565, 559, 660]]
a) Change Database Initialization Parameters 
b) Create a Database 
c) Manage Templates 
d) Delete a Database  

text[[117, 692, 880, 736]]
8. What is the name of the piece of shared memory that client connections are bound to during communications via Shared Server?  

text[[148, 744, 390, 838]]
a) Program Global Area 
b) System Global Area 
c) Virtual Circuit 
d) Database Buffer Cache

--- Page 48 ---

text[[117, 106, 877, 150]]
9. You would like to limit access to only the DBA staff during testing tables. Which of the following startup options should you use?  

text[[146, 157, 533, 252]]
a) STARTUP NOMOUNT RESTRICT  
b) STARTUP RESTRICT  
c) STARTUP MOUNT RESTRICT  
d) STARTUP MOUNT FORCE RESTRICT  

text[[118, 284, 880, 328]]
10. Which of the following Oracle accounts are automatically configured by the DBCA?  

text[[146, 336, 721, 456]]
a) SYS  
b) SYSTEM  
c) SYSMAN  
d) DBSNMP  
e) All the other accounts are configured automatically by DBCA  

text[[118, 489, 880, 532]]
11. For which database operation would you need the database to be in the MOUNT state?  

text[[146, 540, 479, 635]]
a) Renaming the control files  
b) Dropping a user in your database  
c) Applying maintenance operation  
d) Re-creating the control files  

text[[118, 667, 821, 685]]
12. Identify the memory component from which memory may be allocated for:  

text[[146, 693, 522, 840]]
Session memory for the shared server Buffers for I/O slaves a) Large Pool b) Redo Log Buffer c) Database Buffer Cache d) Program Global Area (PGA)

--- Page 49 ---

text[[118, 105, 881, 202]]
13. You plan to implement the distributed database system in your company. You invoke Database Configuration Assistant (DBCA) to create a database on the server. During the installation, DBCA prompts you to specify the Global Database Name. What must this name be made up of?  

text[[147, 208, 881, 354]]
a) It must be made up of a database name and a domain name 
b) It must be made up of the value in ORACLE_SID and HOSTNAME 
c) It must be made up of the value that you plan to assign for INSTANCE_NAME and HOSTNAME 
d) It must be made up of the value that you plan to assign for ORACLE_SID and SERVICE_NAMES  

text[[118, 385, 880, 434]]
14. Which two statements regarding the server parameter file (SPFILE) are true? (Choose two)  

text[[147, 440, 881, 557]]
a) An SPFILE is a binary file 
b) An SPFILE cannot contain static parameters 
c) An SPFILE can store changes persistently across instance restarts 
d) An SPFILE can be read by the database server, but it is not written to by the server.  

text[[118, 589, 880, 637]]
15. Checkpoint Process (CKPT) Records checkpoint information in? (Choose two correct Answers)  

text[[147, 644, 375, 737]]
a) SGA 
b) Control file 
c) Redolog buffer cache 
d) Each data file header

--- Page 50 ---

text[[117, 105, 881, 150]]
16. Which are the initialization parameters that we should set their values to manage memory automatically and tune it simply? (Choose two correct answers)  

text[[147, 157, 412, 253]]
a) MEMORY_TARGET 
b) SHARED_POOL 
c) LARGE_POOL 
d) MEMORY_MAX_TARGET  

text[[117, 284, 790, 303]]
17. Dynamic parameters Can be altered at: (Choose Two correct answers)  

text[[147, 311, 310, 404]]
a) Listener level 
b) Network level 
c) Session level 
d) System level  

text[[117, 439, 812, 458]]
18. What is the wrong statement regarding NOMOUNT mode during startup?  

text[[147, 465, 824, 559]]
a) NOMOUNT mode is used during database creation 
b) NOMOUNT mode is used during re-creation of control files 
c) NOMOUNT mode is used during certain backup and recovery scenarios 
d) NOMOUNT mode is used when database is open  

text[[117, 590, 880, 637]]
19. What are the correct names of a node where Oracle Database is installed? (Choose Two correct answers)?  

text[[147, 644, 378, 763]]
a) Sequence server 
b) Stored procedure server 
c) Host server 
d) Database server 
e) Group/Domain server

--- Page 51 ---

text[[117, 106, 854, 124]]
20. Which is the false statement about Database Initialization Parameters Types? 

text[[150, 133, 466, 151]]
a) Dictionary-managed tablespace 

text[[149, 158, 364, 176]]
b) Derived Parameters 

text[[148, 184, 556, 202]]
c) Operating System-Dependent Parameters 

text[[150, 210, 409, 227]]
d) Setting Parameter Values 

table[[187, 253, 807, 808]]
<table>Quiz answers - chapter 31b2c3b4a5a6d7a8b9b10e11c12a13a14a, c15b, d16a, d17c, d18d19c, d20a</table>
