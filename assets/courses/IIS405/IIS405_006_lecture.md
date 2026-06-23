--- Page 1 ---

title[[120, 308, 876, 351]]
# Oracle Database Administration  

text[[484, 373, 513, 403]]
I  

text[[145, 454, 853, 528]]
Chapter 6: Managing Control Files, OnlineRedo Logs, and Archive logs

--- Page 2 ---

sub_title[[732, 148, 887, 170]]
## :محتويات الفصل 

text[[117, 210, 880, 226]]
Objectives ............................................................................................................................................. 2 

text[[118, 235, 881, 251]]
1. Managing Control Files ............................................................................................................ 3 

text[[140, 260, 882, 276]]
1.1. Control File Contents ....................................................................................................... 3 

text[[139, 284, 880, 300]]
1.2. Getting Information about Control File ........................................................................... 3 

text[[138, 308, 881, 324]]
1.3. Multiplexing the Control File ............................................................................................ 5 

text[[139, 332, 880, 348]]
1.4. Adding a Control File........................................................................................................... 5 

text[[117, 355, 881, 371]]
2. Online Redo Logs ..................................................................................................................... 8 

text[[138, 379, 882, 395]]
2.1. Multiplexing the Redo Log ................................................................................................... 8 

text[[139, 403, 881, 419]]
2.2. Log Switch Description ............................................................................................................ 9 

text[[138, 426, 880, 442]]
2.3. Mechanisms log files to protect your database ..................................................................... 10 

text[[139, 450, 881, 466]]
2.4. Adding Online Redo Log Groups ............................................................................................ 12 

text[[138, 473, 880, 489]]
2.5. Adding Online Redo Log Members ....................................................................................... 13 

text[[139, 497, 881, 513]]
2.6. Dropping Online Redo Log Groups .......................................................................................... 13 

text[[138, 520, 880, 536]]
2.7. Dropping Online Redo Log Members....................................................................................... 14 

text[[139, 544, 881, 560]]
2.8. Obtaining Log files Information ............................................................................................. 15 

text[[117, 567, 880, 583]]
3. Implementing Archivelog Mode ................................................................................................... 16 

text[[118, 591, 879, 607]]
4. Quiz .............................................................................................................................................. 19 

text[[119, 615, 881, 631]]
References ............................................................................................................................................. 25

--- Page 3 ---

sub_title[[117, 108, 253, 127]]
## Objectives:  

text[[148, 140, 556, 285]]
1. Multiplex control file  
2. Add new control file  
3. Multiplex Redo log files  
4. Understand log switch operations  
5. Manage redo log files  
6. Implement the database in Archive mode

--- Page 4 ---

sub_title[[120, 108, 435, 128]]
## 1.Managing Control Files:  

text[[117, 141, 879, 185]]
We are going to discusses typical control file maintenance tasks, such as adding, moving, and removing control files.  

text[[116, 218, 881, 287]]
A control file is a small binary file that describes the structure of the database and it is created when the DB is created. It must be available for writing by the Oracle server whenever the database is mounted or opened..  

text[[117, 295, 880, 364]]
Without this file, the database cannot be mounted, and recovery or re- creation of the control file is required. Your database should have a minimum of two control files on different storage devices to minimize the impact of a loss of one control file.  

text[[117, 370, 881, 467]]
The loss of a single control file causes the instance to fail because all control files must be available at all times. However, recovery can be a simple matter of copying one of the other control files. The loss of all control files is slightly more difficult to recover from but is not usually catastrophic..  

sub_title[[120, 500, 393, 518]]
## 1.1.Control File Contents:  

text[[117, 531, 506, 548]]
A control file contains the following entries:.  

text[[147, 557, 570, 700]]
Database name Names and locations of data files Names and locations of online redo log files Current online redo log sequence number Checkpoint information Names and locations of RMAN backup files  

sub_title[[120, 735, 566, 753]]
## 1.2.Getting Information about Control File:  

text[[116, 765, 881, 885]]
Every Oracle database must have at least one control file. When you start your database in nonmount mode, the instance is aware of the location of the control files from the CONTROL_FILES initialization parameter in the spfile or init.ora file. When you issue a STARTUP NOMOUNT command, Oracle reads the parameter file and starts the background processes and allocates memory structures:

--- Page 5 ---

text[[117, 103, 783, 136]]
- - locations of control files are known to the instance SQL> startup nomount;  

text[[116, 156, 880, 199]]
At this point, the control files have not been touched by any processes. When you alter your database into mount mode, the control files are read and opened for use:  

text[[117, 219, 437, 251]]
- - control files opened SQL> alter database mount;  

text[[116, 270, 880, 315]]
If any of the control files listed in the CONTROL_FILES initialization parameter are not available, then you cannot mount your database.  

text[[117, 322, 881, 366]]
When you successfully mount your database, the instance is aware of the locations of the data files and online redo logs but has not yet opened them.  

text[[116, 372, 882, 492]]
After the database has been opened, Oracle will frequently write information to the control files, such as when you make any physical modifications (e.g., creating a tablespace, adding/removing/resizing a data file). Oracle writes to all control files specified by the CONTROL_FILES initialization parameter. If Oracle cannot write to one of the control files, an error is thrown:  

text[[117, 510, 715, 527]]
ORA- 00210: cannot open the specified control file  

text[[116, 548, 880, 590]]
You can query much of the information stored in the control file from data dictionary views.  

text[[117, 599, 881, 640]]
This example displays the types of information stored in the control file by querying v\$controlfile_record_section:  

text[[118, 652, 842, 670]]
SQL> select distinct type from v\$controlfile_record_section;  

text[[119, 689, 446, 706]]
Here is a partial listing of the output:  

text[[117, 727, 169, 741]]
TYPE  

text[[118, 777, 339, 886]]
FILENAME TABLESPACE RMAN CONFIGURATION BACKUP CORRUPTION PROXY COPY

--- Page 6 ---

text[[117, 103, 411, 192]]
FLASHBACK LOG REMOVABLE RECOVERY FILES AUXILIARY DATAFILE COPY DATAFILE  

text[[116, 203, 880, 248]]
If your database is in a monument state, a mounted state, or an open state, you can view the names and locations of the control files, as follows:  

text[[117, 266, 520, 284]]
SQL> show parameter control_files  

text[[116, 302, 880, 347]]
You can also view control file location and name information by querying the V\$CONTROLFILE view. This query works while your database is mounted or open:  

text[[117, 364, 554, 381]]
SQL> select name from v\$controlfile;  

sub_title[[119, 411, 465, 430]]
### 1.3. Multiplexing the Control File:  

text[[116, 442, 881, 511]]
Since control file is critical for the database operation, Oracle recommends a minimum of two control files. Multiplexing is defined as keeping a copy of the same control file in different locations  

sub_title[[120, 544, 398, 563]]
### 1.4. Adding a Control File:  

text[[117, 575, 636, 593]]
The basic procedure for adding a control file is as follows:  

text[[147, 601, 881, 744]]
1. After the initialization file CONTROL_FILES parameter to include the new location and name of the control file. 
2. Shut down your database. 
3. Use an OS command to copy an existing control file to the new location and name. 
4. Restart your database.  

text[[116, 753, 881, 797]]
Depending on whether you use a spfile or an init.ora file, the previous steps vary slightly:  

sub_title[[117, 806, 267, 823]]
## Spfile Scenario  

text[[115, 832, 880, 875]]
If your database is open, you can quickly determine whether you are using a spfile with the following SQL statement:

--- Page 7 ---

text[[117, 103, 442, 119]]
SQL> show parameter spfile  

text[[116, 139, 881, 183]]
When you have determined that you are using a spfile, use the following steps to add a control file:  

text[[148, 191, 721, 208]]
1. Determine the CONTROL_FILES parameter's current value:  

text[[180, 228, 574, 244]]
SQL> show parameter control_files  

text[[147, 263, 881, 358]]
2. Alter your CONTROL_FILES parameter to include the new control file that you want to add, but limit the scope of the operation to the spfile (you cannot modify this parameter in memory). Make sure you also include any control files listed in step A:  

text[[179, 376, 613, 424]]
SQL> alter system set control_files = '/u01/dbfile/o18c/control01. . ctl','/u01/dbfile/o18c/control02. ctl' scope=spfile;  

text[[147, 447, 416, 463]]
3. Shut down your database:  

text[[180, 484, 471, 499]]
SQL> shutdown immediate;  

text[[179, 519, 881, 562]]
Copy an existing control file to the new location and name. In this example, a new control file named control02. ctl is created via the OS cp command:  

text[[180, 582, 815, 614]]
\$ cp /u01/dbfile/o18c/control01. ctl /u01/dbfile/o18c/ control02. ctl  

text[[147, 635, 393, 651]]
4. Start up your database:  

text[[180, 673, 330, 688]]
SQL> startup;  

text[[179, 708, 805, 752]]
You can verify that the new control file is being used by displaying the CONTROL_FILES parameter:  

text[[181, 772, 580, 788]]
SQL> show parameter control_files  

sub_title[[119, 794, 301, 809]]
## Init.ora Scenario  

text[[116, 818, 881, 861]]
Run the following statement to verify that you are using an init. ora file. If you are not using a spfile, the VALUE column is blank:

--- Page 8 ---

text[[117, 103, 432, 118]]
SQL> show parameter sfile  

text[[119, 120, 164, 132]]
NAME  

text[[121, 135, 163, 147]]
spfile  

text[[282, 122, 330, 133]]
TYPE  

text[[284, 136, 329, 148]]
string  

text[[615, 120, 666, 132]]
VALUE  

text[[119, 187, 385, 202]]
To add a control file when using a text init.ora file, perform the following steps:  

text[[149, 212, 416, 227]]
1. Shut down your database:  

text[[177, 233, 467, 248]]
SQL> shutdown immediate;  

text[[148, 253, 881, 347]]
2. Edit your init.ora file with an OS utility (such as vi), and add the new control file location and name to the CONTROL_FILES parameter. This example opens the init.ora file, using vi, and adds control02.ctl to the CONTROL_FILES parameter:  

text[[177, 352, 580, 367]]
\$ vi $ORACLE_HOME/dbs/init01g.c.ora  

text[[176, 373, 878, 389]]
Listed next is the CONTROL_FILES parameter after control02.ctl is added:  

text[[177, 408, 746, 441]]
control_files='/u01/dbfile/o18c/control01.ctl', '/u01/dbfile/o18c /control02.ctl'  

text[[148, 462, 878, 504]]
3. From the OS, copy the existing control file to the location and name of the control file being added:  

text[[177, 509, 604, 540]]
\$ cp /u01/dbfile/o18c/control01.ctl /u01/dbfile/o18c/control02.ctl  

text[[148, 562, 392, 578]]
4. Start up your database:  

text[[177, 599, 334, 614]]
SQL> startup;  

text[[176, 635, 878, 676]]
You can view the control files in use by displaying the CONTROL_FILES parameter:  

text[[178, 682, 580, 697]]
SQL> show parameter control_files

--- Page 9 ---

sub_title[[118, 108, 382, 129]]
## 2. Online Redo Logs:  

text[[116, 141, 881, 210]]
We are going to examine DBA activities related to online redo log files, such as renaming, adding, dropping, and relocating these critical files. Online redo logs store a record of transactions that have occurred in your database.  

text[[118, 218, 484, 236]]
These logs serve the following purposes:  

text[[147, 243, 883, 444]]
Provide a mechanism for recording changes to the database so that in the event of a media failure, you have a method of recovering transactions Ensure that in the event of total instance failure, committed transactions can be recovered (crash recovery) even if committed data changes have not yet been written to the data files Allow administrators to inspect historical database transactions through the Oracle LogMiner utility They are read by Oracle tools such as GoldenGate or Streams to replicate data  

sub_title[[118, 474, 446, 493]]
### 2.1. Multiplexing the Redo Log:  

text[[115, 504, 881, 601]]
You are required to have at least two online redo log groups in your database. Each online redo log group must contain at least one online redo log member. The member is the physical file that exists on disk. You can create multiple members in each redo log group, which is known as multiplexing your online redo log group.  

text[[115, 605, 880, 675]]
It is highly recommended that you multiplex your online redo log groups and, if possible, have each member on a separate physical device governed by a separate controller.  

image[[209, 700, 780, 878]]

--- Page 10 ---

text[[117, 105, 881, 150]]
Multiplexing redo logs may impact overall database performance as it increases database I/O.  

text[[115, 181, 883, 303]]
The log- writer process flashes log buffer (in the SGA) to the online redo log files (on disk). The redo record has a system change number (SCN) assigned to it in order to identify the transaction redo information. There are committed and uncommitted records written to the redo logs. The log writer flushes the contents of the redo log buffer when any of the following are true:  

text[[147, 309, 501, 404]]
A COMMIT is issued A log switch occurs Three seconds go by The redo log buffer is one- third full.  

text[[117, 412, 881, 483]]
Since this is a database process, the container database (CDB) will manage the redo logs. PDBs do not have their own redo logs, which also means that planning for space and sizing of the redo logs is at the CDB level and includes all of the PDB transactions.  

title[[118, 514, 415, 533]]
#### 2.2. Log Switch Description:  

text[[115, 544, 883, 666]]
The online redo log group that the log writer is actively writing to is the current online redo log group. The log writer writes simultaneously to all members of a redo log group. The log writer needs to successfully write to only one member in order for the database to continue operating. The database ceases operating if the log writer cannot write successfully to at least one member of the current group.  

text[[115, 672, 881, 767]]
When the current online redo log group fills up, a log switch occurs, and the log writer starts writing to the next online redo log group. A log sequence number is assigned to each redo log when a switch occurs to be used for archiving. The log writer writes to the online redo log groups in a round- robin fashion:

--- Page 11 ---

image[[198, 100, 796, 349]]  

text[[114, 377, 881, 469]]
Because you have a finite number of online redo log groups, eventually the contents of each online redo log group are overwritten. If you want to save a history of the transaction information, you must place your database in archivelog mode.  

text[[114, 478, 881, 575]]
When your database is in archivelog mode, after every log switch the archiver background process copies the contents of the online redo log file to an archived redo log file. In the event of a failure, the archived redo log files allow you to restore the complete history of transactions that have occurred since your last database backup.  

sub_title[[116, 608, 640, 628]]
### 2.3. Mechanisms log files to protect your database:  

text[[114, 637, 881, 707]]
The contents of the current online redo log files are not archived until a log switch occurs. This means that if you lose all members of the current online redo log file, you lose transactions. Listed next are several mechanisms log files:  

text[[145, 716, 881, 886]]
- Multiplex the groups- Consider setting the ARCHIVE_LAG_TARGET initialization parameter to ensure that the online redo logs are switched at regular intervals- If possible, never allow two members of the same group to share the same physical disk- Ensure that OS file permissions are set appropriately (restrictive, that only the owner of the Oracle binaries has permissions to write and read).

--- Page 12 ---

text[[148, 105, 881, 150]]
- Use physical storage devices that are redundant (i.e., RAID [redundant array of inexpensive disks])  

text[[149, 157, 880, 201]]
- Appropriately size the log files, so that they switch and are archived at regular intervals  

text[[115, 208, 851, 226]]
Please click on the button to see how to choose and monitor Redolog groups from  

text[[117, 234, 263, 251]]
Toad for Oracle  

text[[116, 259, 880, 303]]
The following figure shows how to choose monitoring Redolog groups from Toad for Oracle:  

image[[115, 330, 971, 654]]  

text[[117, 680, 841, 698]]
The following figure shows how to monitor Redolog groups from Toad for Oracle:

--- Page 13 ---

sub_title[[114, 418, 514, 437]]
## 2.4. Adding Online Redo Log Groups:  

image[[169, 475, 825, 759]]  

text[[115, 781, 881, 850]]
You specify the name and location of the members with the file specification. The value of the GROUP parameter can be selected for each redo log file group. If you omit this parameter, the Oracle server generates its value automatically.

--- Page 14 ---

sub_title[[116, 106, 534, 125]]
## 2.5. Adding Online Redo Log Members:  

image[[119, 160, 863, 443]]  

text[[114, 468, 884, 584]]
Use the fully specified name of the log file members; otherwise the files are created in a default directory of the database server. If the file already exists, it must have the same size, and you must specify the REUSE option. You can identify the target group either by specifying one or more members of the group or by specifying the group number.  

sub_title[[117, 620, 534, 640]]
## 2.6. Dropping Online Redo Log Groups:  

image[[232, 675, 759, 863]]

--- Page 15 ---

text[[115, 106, 881, 150]]
To increase or decrease the size of online redo log groups, add new online redo log groups (with the new size) and then drop the old ones.  

sub_title[[116, 159, 227, 175]]
## Restrictions  

text[[146, 184, 883, 278]]
An instance requires at least two groups of online redo log files An active or current group cannot be dropped When an online redo log group is dropped, the operating system files are not deleted  

sub_title[[116, 310, 550, 329]]
### 2.7. Dropping Online Redo Log Members:  

image[[225, 366, 775, 631]]  

text[[117, 669, 227, 684]]
Restrictions  

text[[146, 692, 883, 888]]
If the member you want to drop is the last valid member of the group, you cannot drop that member If the group is current, you must force a log file switch before you can drop the member. If the database is running in ARCHIVELOG mode and the log file group to which the member belongs is not archived, then the member cannot be dropped When an online redo log member is dropped, the operating system file is not deleted

--- Page 16 ---

sub_title[[117, 107, 495, 125]]
## 2.8. Obtaining Log files Information:  

text[[116, 138, 880, 181]]
Use the V$LOG and V\$LOGFILE views to display information about online redo log groups and corresponding members:  

table[[117, 183, 879, 302]]

<table>SELECT a.group# ,a.thread#,a.status grp_status,b.member member ,b.status mem status,a.bytes/1024/1024 mbytesFROM v$log a, v$logfile bWHERE a.group# = b.group#ORDER BY a.group#, b.member;</table>  

sub_title[[117, 309, 646, 326]]
## Status for Online Redo Log Groups in the V\$LOG View:  

table[[60, 354, 900, 696]]

<table>StatusMeaningCURRENTThe log group is currently being written to by the log writer.ACTIVEThe log group is required for crash recovery and may or may not have beenCLEARINGThe log group is being cleared out by an ALTER DATABASE CLEARCLEARING_CURRENTThe current log group is being cleared of a closed thread.INACTIVEThe log group is not required for crash recovery and may or may not haveUNUSEDThe log group has never been written to; it was recently created.</table>  

title[[117, 697, 730, 714]]
# Status for Online Redo Log File Members in the V\$LOGFILE View:  

table[[118, 745, 849, 876]]

<table>StatusMeaningINVALIDThe log file member is inaccessible or has been recently created.DELETEDThe log file member is no longer in use.STALEThe log file member&#x27;s contents are not complete.NULLThe log file member is being used by the database.</table>

--- Page 17 ---

sub_title[[117, 108, 528, 129]]
## 3. Implementing Archivelog Mode:  

text[[115, 142, 880, 186]]
We are going to ensure that the architectural aspects of enabling and implementing archiving are covered.  

sub_title[[117, 218, 444, 236]]
## Creating Archived Redo Log Files  

text[[116, 243, 881, 288]]
To preserve redo information and configure your database for maximum recoverability, create archived copies of redo log files by performing the following steps:  

text[[147, 294, 641, 362]]
Specify archived redo log file- naming convention Specify one or more archived redo log file locations Place the database in ARCHIVELOG mode  

image[[150, 394, 939, 847]]

--- Page 18 ---

sub_title[[119, 106, 356, 124]]
## Archived Redo Log Files  

text[[114, 131, 884, 359]]
Archiveloq mode preserves redo data for the long term by employing an archiver background process to copy the contents of a filled online redo log to what is termed an archive redo log file. The trail of archive redo log files is crucial to your ability to recover the database with all changes intact, right up to the precise point of failure. The process of switching from one online redo log group to another is called a log switch. The ARCn process initiates archiving of the filled log group at every log switch. It automatically archives the online redo log group before the log group can be reused so that all the changes made to the database are preserved. This enables recovery of the database to the point of failure even if a disk drive is damaged.  

text[[117, 361, 881, 407]]
One of the important decisions that a DBA must make is whether to configure the database to operate in ARCHIVELOG mode or in NOARCHIVELOG mode.  

text[[145, 412, 883, 580]]
In NOARCHIVELOG mode, the online redo log files are overwritten each time a log switch occurs. This is the default mode of any created database. recovery is possible only until the time of the last backup. All transactions made after that backup are lost In ARCHIVELOG mode, inactive groups of filled online redo log files must be archived before they can be used again. recovery is possible until the time of the last commit. Most production databases are operated in ARCHIVELOG mode  

text[[115, 589, 881, 635]]
Note: Back up your database after switching to ARCHIVELOG mode because your database is recoverable only from the first backup taken in that mode.  

text[[117, 641, 727, 660]]
Information about archived logs can be obtained from V\$INSTANCE.  

text[[118, 664, 565, 681]]
SQL> SELECT archiver FROM v\$instance;  

sub_title[[119, 700, 380, 717]]
## Some Archiving Parameters  

text[[117, 725, 881, 770]]
LOG_ARCHIVE_DEST: Destination to write archive log files, it must be a valid directory in the server where the database is located  

text[[118, 777, 785, 796]]
LOG_ARCHIVE_START: Whether oracle should enable automatic archiving  

text[[117, 802, 881, 847]]
Note: To set the value of the previous parameters, use alter system set command.  

text[[119, 853, 373, 871]]
Enable ARCHIVELOG Mode

--- Page 19 ---

text[[148, 108, 399, 123]]
- Shutdown the database  

text[[149, 133, 485, 150]]
- Set up the appropriate parameters  

text[[151, 159, 355, 174]]
- STARTUP MOUNT  

text[[148, 185, 493, 201]]
- ALTER DATABASE ARCHIVELOG  

text[[149, 211, 419, 226]]
- ALTER DATABASE OPEN  

sub_title[[117, 236, 379, 252]]
## Disable ARCHIVELOG Mode  

text[[148, 261, 399, 276]]
- Shutdown the database  

text[[149, 286, 355, 301]]
- STARTUP MOUNT  

text[[150, 311, 520, 326]]
- ALTER DATABASE NOARCHIVELOG  

text[[148, 336, 419, 351]]
- ALTER DATABASE OPEN

--- Page 20 ---

sub_title[[119, 110, 217, 129]]
## 4. Quiz:  

text[[118, 142, 416, 160]]
1. When the control file is read?  

text[[147, 169, 412, 263]]
a) Nomount stage 
b) Open stage 
c) Mount stage 
d) None of the other options  

text[[116, 293, 880, 442]]
2. Which of these operations cannot be accomplished while the database is open? (Choose all correct answers.) a) Adding a controlfile copy b) Adding an online log file member c) Changing the location of the flash recovery area d) Changing the archivelog mode of the database  

text[[116, 472, 881, 517]]
3. There are several steps involved in transitioning to archivelog mode. Put these in the correct order:  

text[[207, 525, 499, 670]]
1. alter database archivelog 
2. alter database open 
3. alter system archive log start 
4. full backup 
5. shutdown immediate 
6. startup mount  

text[[147, 678, 447, 799]]
a) 5, 6, 1, 2, 4; 3 not necessary 
b) 5, 4, 6, 1, 2, 3 
c) 6, 1, 3, 5, 4, 2 
d) 1, 5, 4, 6, 2; 3 not necessary 
e) 5, 6, 1, 2, 3; 4 not necessary

--- Page 21 ---

text[[117, 106, 880, 150]]
4. A control file is a small binary file that describes the structure of the database and it is created by DBA after the DB is created.  

text[[147, 158, 232, 202]]
a) True 
b) False  

text[[117, 234, 880, 278]]
5. A control file must be available for writing by the Oracle server whenever the database is mounted or opened?  

text[[147, 285, 232, 329]]
a) True 
b) False  

text[[117, 360, 504, 378]]
6. The loss of a single control file causes:  

text[[146, 386, 832, 482]]
a) The instance to continue starting up  
b) The instance to continue mounting  
c) All the other options  
d) The instance to fail because all control files must be available at all times  

text[[117, 513, 802, 532]]
7. What is the incorrect statement related to the contents of the control file?  

text[[146, 540, 574, 663]]
a) Database name  
b) Names and locations of data files  
c) Names and locations of online redo log files  
d) Current online redo log sequence number  
e) None of the other options  

text[[117, 694, 782, 712]]
8. In any state you can view the names and locations of the control files?  

text[[146, 720, 360, 815]]
a) nomount state  
b) Mount state  
c) open state  
d) all the other options

--- Page 22 ---

text[[117, 106, 730, 124]]
9. What does Oracle do if it cannot write to one of the control files?  

text[[147, 133, 462, 227]]
a) Continue normally  
b) An error is thrown  
c) Try to create a new control file  
d) Try to delete that control file  

text[[118, 259, 876, 329]]
10. Online Redo logs Provide a mechanism for recording changes to the database so that in the event of a media failure, you have a method of recovering transactions?  

text[[147, 337, 230, 380]]
a) True  
b) False  

text[[118, 412, 863, 432]]
11. You are required to have at least two online redo log groups in your database?  

text[[146, 439, 438, 533]]
a) Three online redo log groups  
b) One online redo log groups  
c) Two online redo log groups  
d) Four online redo log groups  

text[[118, 565, 876, 610]]
12. Why Multiplexing redo logs may impact overall database performance as it increases database I/O?  

text[[147, 617, 592, 713]]
a) As it increases database I/O  
b) As it decreases database I/O  
c) Because it causes writing in all data files  
d) Because it causes writing in all redolog groups  

text[[118, 744, 876, 789]]
13. The log-writer process flashes log buffer (in the SGA) to the online redo log files (on disk)?  

text[[147, 797, 230, 840]]
a) True  
b) False

--- Page 23 ---

text[[117, 105, 880, 151]]
14. The log-writer process flashes log buffer (in the SGA) to the online redo log files (on disk)?  

text[[147, 158, 504, 254]]
a) To the related data files (on disk) 
b) To the online redo log files (on disk) 
c) To the related tablespaces (on disk) 
d) To the related segments (on disk)  

text[[118, 284, 446, 302]]
15. When does a log switch occur?  

text[[147, 310, 610, 405]]
a) There is no log switch as there is one log group 
b) When the current data file fills up 
c) When the current control file fills up 
d) When the current online redo log group fills up  

text[[118, 439, 842, 458]]
16. The log writer writes to the online redo log groups in a round-robin fashion?  

text[[147, 466, 230, 508]]
a) True 
b) False  

text[[118, 540, 877, 559]]
17. What is the name of the view that gives the status for Online Redo Log Groups?  

text[[147, 567, 387, 660]]
a) V\$LOGFILE View 
b) V\$LOG View 
c) V\$LOGSESSION View 
d) V\$LOGIINSTANCE View  

text[[118, 693, 880, 737]]
18. What is the name of the view that gives the status for Online Redo Log File Members?  

text[[147, 746, 387, 839]]
a) V\$LOGFILE View 
b) V\$LOG View 
c) V\$LOGSESSION View 
d) V\$LOGIINSTANCE View

--- Page 24 ---

text[[119, 105, 870, 124]]
19. What is the step that doesn't belong to create archived copies of redo log files?  

text[[148, 131, 620, 150]]
a) Specify archived redo log file-naming convention.  

text[[149, 157, 645, 176]]
b) Specify one or more archived redo log file locations.  

text[[151, 183, 572, 201]]
c) Place the database in ARCHIVELOG mode.  

text[[150, 209, 578, 227]]
d) Place the BACKUP plan for each tablespace  

text[[117, 259, 765, 278]]
20. What is the statement that doesn't related to ARCHIVELOG mode?  

text[[148, 285, 880, 400]]
a) inactive groups of filled online redo log files must be archived before they can be used again  
b) Recovery is possible until the time of the last commit  
c) The online redo log files are overwritten each time a log switch occurs  
d) Most production databases are operated in ARCHIVELOG mode.

--- Page 25 ---

table[[184, 99, 805, 656]]
<table><td colspan="2">Quiz answers – chapter 61c2a, d3a4b5a6d7e8d9b10a11c12a13a14b15d16a17b18a19d20c</table>

--- Page 26 ---

sub_title[[120, 108, 260, 126]]
## References:  

sub_title[[119, 142, 183, 158]]
## Books  

text[[147, 166, 884, 340]]
1. Oracle Database Administrator's Guide, 18c (Oracle University), March 2019, Primary Author: Rajesh Bhatiya, Randy Urbano  
2. database-new-features-guide (Oracle University), 18c E88909-01 February 2018, Primary Authors: Tanaya Bhattacharjee, Sunil Surabhi, Mark Baue  
3. The Cloud DBA-Oracle: Managing Oracle Database in the Cloud - First Edition, Abhinivesh Jain and Niraj Mahajan. Apress - ISBN-13 (pbk): 978-1-4842-2634-6 ISBN-13 (electronic): 978-1-4842-2635-3  

sub_title[[118, 370, 217, 387]]
## Web Sites  

text[[147, 395, 824, 516]]
1. https://docs.oracle.com/database  
2. https://docs.oracle.com/en/database/oracle/oracle-database/19/whats-new.html  
3. http://www.oracle.com/technetwork/database/enterprise-edition/downloads/index.html
