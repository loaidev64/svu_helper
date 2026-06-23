--- Page 1 ---

title[[120, 307, 878, 351]]
# Oracle Database Administration  

text[[484, 372, 515, 403]]
I  

text[[154, 454, 841, 485]]
Chapter 2: Installing the Oracle Binaries

--- Page 2 ---

sub_title[[732, 149, 884, 170]]
محتويات الفصل: 

text[[117, 210, 880, 226]]
Objectives ........................................................................................................................................ 2 

text[[115, 234, 881, 250]]
1. Describe your role as a database administrator (DBA) and explain typical tasks ............................ 3 

text[[117, 258, 880, 274]]
2. Plan managing database and tools ....................................................................................... 4 

text[[115, 282, 881, 297]]
3. Use Optimal Flexible Architecture (OFA) ........................................................................... 5 

text[[117, 305, 880, 320]]
4. Install Oracle Database 19c on Windows.................................................................................... 8 

text[[115, 328, 881, 343]]
5. User's Guide for: Toad for Oracle .......................................................................................... 23 

text[[117, 351, 880, 366]]
6. Quiz ........................................................................................................................................... 27

--- Page 3 ---

sub_title[[117, 108, 245, 127]]
## Objectives  

text[[147, 140, 880, 235]]
1. Describe your role as a database administrator (DBA) and explain typical tasks  
2. Plan an Oracle Database installation  
3. Use Optimal Flexible Architecture (OFA)  
4. Install the Oracle software by using Oracle Universal Installer (OUI)

--- Page 4 ---

sub_title[[117, 108, 880, 160]]
## 1. Describe your role as a database administrator (DBA) and explain typical tasks:  

text[[116, 172, 881, 217]]
The approach for designing, implementing, and maintaining an Oracle database involves the following tasks:  

text[[147, 223, 798, 448]]
1. Evaluating the database server hardware.  
2. Installing the Oracle software.  
3. Planning the database and security strategy.  
4. Creating, migrating, and opening the database.  
5. Backing up the database.  
6. Enrolling system users and planning for their Oracle Network access.  
7. Implementing the database design.  
8. Recovering from database failure.  
9. Monitoring database performance.

--- Page 5 ---

sub_title[[117, 108, 569, 129]]
## 2. Plan managing database and tools:  

text[[116, 141, 883, 236]]
Oracle database monitoring and management is not entirely different from the on premise database paradigm. In fact, many of the tools, such as SQL Developer, TOAD, and OEM 19c Cloud Control, allow you to connect to your cloud database and perform most of the tasks as before.  

text[[147, 243, 501, 492]]
- Oracle Universal Installer- Database Configuration Assistant- Database Upgrade Assistant- Oracle Net Manager- Oracle Enterprise Express Manager- SQL\*Plus- Recovery Manager- Data Pump- SQL\*Loader- Toad for Oracle

--- Page 6 ---

sub_title[[117, 109, 634, 131]]
## 3. Use Optimal Flexible Architecture (OFA):  

text[[116, 142, 880, 186]]
OFA is a file system directory structure that should make maintaining multiple versions of multiple Oracle products straightforward.  

text[[114, 193, 883, 464]]
The OFA standard provides ways to understand where log files are available on a consistent basis. If standards are followed, security, migrations, and automations are going to be easier to implement because of consistency across the environments. The consistent locations of the log files allow for the files to be used by other tools as well as being secured. The ORACLE_BASE directory in 19c provides a way to separate the ORACLE_HOME directories for read- only directories and have the writable files in the ORACLE_BASE. Read- only ORACLE_HOME directories allow for implementing separation of installation and configuration, which is important for the cloud and securing the environment. This simplifies patching as one image can be used for a mass rollout and distribute a patch to many servers and reduces downtime for patching and updating of the Oracle software.  

text[[116, 472, 881, 540]]
The following figures show the directory structures and file names used with the OFA standard. All the directories and files found in an Oracle environment appear in these figures:  

image[[114, 543, 846, 822]]

--- Page 7 ---

image[[138, 98, 858, 221]]  

text[[118, 450, 824, 468]]
The OFA standard includes several directories that you should be familiar with:  

text[[147, 476, 544, 545]]
- Oracle inventory directory- Oracle base directory (ORACLE_BASE)- Oracle home directory (ORACLE_HOME)

--- Page 8 ---

text[[150, 106, 590, 123]]
- Oracle network files directory (TNS_ADMIN) 

text[[152, 132, 601, 149]]
- Automatic Diagnostic Repository (ADR_HOME) 

text[[117, 158, 707, 174]]
See the below figure from windows registry related to Oracle 19c: 

table[[118, 201, 939, 552]]
<table><td colspan="3">Registry Editor- □ X<td colspan="3">File Edit View Favorites Help<td colspan="4">Computer\HKEY_LOCAL_MACHINE\SOFTWARE\ORACLE\KEY_ORAIDB19Home1Mozilla<br/>MozillaPlugins<br/>Nice Mak Computing<br/>ODBC<br/>OEM<br/>ORACLE<br/>KEY:OracleItem12Home1<br/>KEY:OracleItem18Home1<br/>KEY:OraDB19Home1<br/>ODE<br/>OLEDB<br/>OLEDBOLAP<br/>ODP.NET<br/>ODP.NET.Managed<br/>OracleMTSRecoveryServices<br/>Partner<br/>Policies<br/>Quest Software<br/>Realtek<br/>RegisterdApplications<br/>Smarttate Vision<br/>SoundResearch<br/>Synaptics<br/>TrendMicro<br/>WinRAR<br/>WOW6432Node<br/>SYSTEM<br/>HKEY\USERS<br/>HKEY_CURRENT_CONFIGName<br/>(Default)<br/>MSHELP.TOOLS<br/>MIS.LANG<br/>OLEDB<br/>OLEDBOLAP<br/>OMTSRECO.PORT<br/>ORA.ORCL_AUTOSTART<br/>ORA.ORCL_SHUTDOWN<br/>ORA.ORCL_SHUTDOWNTITLE,<br/>ORA.ORCL_SHUTDOWNTYPE<br/>ORACLE.BASE<br/>ORACLE.DIRBLNDE_NAME<br/>ORACLE.GROUP_NAME<br/>ORACLE.HOME<br/>ORACLE.HOME_KEY<br/>ORACLE.HOME_READONLY<br/>ORACLE.HOME_TYPE<br/>ORACLE.SID<br/>ORACLE.SYCCUSER<br/>ORACLE.SYCCUSER.PWDREQ<br/>ORACLE.SYCCUSER.TYPE<br/>RDBMS.ARCHIVE<br/>RDBMS.CONTROL<br/>SQLPATHType<br/>REG_SZ<br/>REG_SZ<br/>REG_SZ<br/>REG_SZ<br/>REG_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>REG_EXPAND_SZ<br/>

--- Page 9 ---

sub_title[[117, 108, 639, 128]]
## 4. Install Oracle Database 19c on Windows:  

text[[116, 142, 881, 210]]
We will learn how to install Oracle Database 19c on Windows 10 Enterprise Step By Step. Before we start installing, we need to know the minimum requirements for Oracle Database 19c:  

sub_title[[117, 215, 648, 234]]
## Windows x64 Minimum Hardware Requirements  

text[[146, 237, 767, 255]]
System Architecture: Processor: AMD64 and Intel EM64T at least  

text[[147, 263, 880, 333]]
Physical memory (RAM): 8 GB minimum to run the core processes normally without any impact on system performance, knowing that 2 GB is sufficient to run Oracle alone  

text[[148, 341, 390, 358]]
Virtual memory (swap):  

text[[176, 365, 880, 434]]
If physical memory is between 2 GB and 16 GB, then set virtual memory to 1 times the size of the RAM If physical memory is more than 16 GB, then set virtual memory to 16 GB  

text[[148, 443, 285, 459]]
Disk space:  

text[[177, 468, 501, 486]]
Typical Install Type total: 10 GB  

text[[178, 494, 535, 511]]
Advanced Install Types total: 10 GB  

text[[176, 519, 883, 587]]
Oracle recommends that you allocate approximately 100 GB to allow additional space for applying any future patches on top of the existing Oracle home.  

text[[148, 596, 413, 613]]
Video adapter: 256 colors  

text[[147, 621, 880, 663]]
Screen Resolution: At least \(1024 \times 768\) display resolution, which Oracle Universal Installer requires  

text[[148, 671, 879, 740]]
It's important to know that Oracle Database 19c is only available for 64 bit Windows systems (Workstation or Server). Therefore, we can't install Oracle Database 19c in our PC if it's running a 32 bit Windows OS.  

text[[148, 748, 880, 816]]
Oracle Database 19c is only available for Windows 10 Professional, Enterprise and Education Editions. This means we can't install Oracle Database 19c if we are using Windows 10 Home Edition  

text[[147, 824, 879, 867]]
To install Oracle Database 19c we have to download the software, which we can do by visiting the OTN page:

--- Page 10 ---

text[[173, 106, 803, 150]]
https://www.oracle.com/database/technologies/oracle- database- software- downloads.html#19c  

text[[148, 158, 881, 306]]
Before beginning the installation of Oracle Database 18c, we need to verify that we are connected to our Windows as an administration user. If we are not, we must log in to our Windows as an administrative user. Not doing so will cause an installation error and crash the entire process.- Mount point paths for the software binaries: Oracle recommends that you create an Optimal Flexible Architecture configuration  

text[[117, 336, 420, 353]]
Verifying Hardware Requirements  

text[[147, 361, 881, 583]]
1. Determine the physical RAM size: If the size of the physical RAM installed in the system is less than the required size, then you must install more memory before continuing.  
2. Determine the size of the configured virtual memory (also known as paging file size).  
3. Determine the amount of free disk space on the system.  
4. Determine the amount of disk space available in the temp directory. This is equivalent to the total amount of free disk space, minus what is required for the Oracle software to be installed.  

text[[117, 592, 400, 609]]
Oracle Universal Installer (OUI)  

text[[116, 616, 881, 686]]
To begin the installation of the Oracle Database 19c, we must first go to the Oracle19c folder; for example, in my case, D:\Oracle. and then locate the setup.exe file. Run the setup.exe file and choose run as administrator.

--- Page 11 ---

image[[163, 120, 775, 347]]  

text[[116, 361, 780, 378]]
Here we are presented with two installation options "Configuration Option":  

image[[173, 404, 816, 747]]  

text[[114, 776, 881, 868]]
The first is to "Create and configure a single instance database". Choosing this option will not only configure an Oracle Database Server on our machine but also create a starter database for us. We can choose this database for learning and practice purposes. This is our choice now

--- Page 12 ---

text[[116, 106, 880, 250]]
The second option is "Set Up Software Only". As the name suggests, it will only configure the Oracle Server software on our machine. No database will be created. We need to create the database manually using the DBCA utility. We choose this option when we are configuring a RAC or planning to perform an upgrade. Then we presented "System Class" options: Desktop class and Server Class as below:  

image[[228, 271, 766, 560]]  

text[[118, 588, 273, 605]]
Install Type step:  

image[[254, 632, 745, 893]]

--- Page 13 ---

sub_title[[117, 106, 374, 122]]
Database Edition Type step:  

image[[114, 147, 817, 403]]  

text[[116, 433, 291, 449]]
Oracle Home User:  

image[[132, 477, 847, 741]]

--- Page 14 ---

sub_title[[126, 106, 307, 121]]
Installation Location:  

image[[127, 152, 852, 422]]  

text[[118, 450, 295, 466]]
Configuration Type:  

image[[117, 496, 840, 762]]

--- Page 15 ---

text[[117, 106, 312, 122]]
Database Identifiers:  

image[[132, 152, 862, 419]]  

text[[116, 444, 881, 616]]
Global Database Name is the name that identifies the database. It must be unique to distinguish the database from all other databases in a network. The Oracle System Identifier will be the name of our database as well as serve as our database SID. We will need this while making connection with our database using tools such as SQLPLUS, Toad for Oracle. By default, it's set as ORCL. If we want, we can change and give it any other name, but make sure to remember it. It's a good practice to write it down somewhere as our Database SID.

--- Page 16 ---

sub_title[[119, 106, 397, 122]]
Configuration Options: Memory 

image[[138, 125, 841, 386]]

--- Page 17 ---

image[[150, 100, 837, 351]]  

image[[149, 374, 838, 635]]  

image[[173, 656, 819, 891]]

--- Page 18 ---

image[[150, 100, 846, 347]]  

image[[149, 370, 847, 630]]  

image[[160, 650, 845, 895]]

--- Page 19 ---

sub_title[[117, 106, 445, 123]]
## Minimum Password Requirements  

text[[115, 132, 878, 176]]
We must provide usernames and passwords that comply with the following requirements:  

text[[145, 184, 858, 302]]
- Password cannot exceed 30 characters- No empty password fields- Username cannot be the same character string as a password- The SYS account password cannot be change_on_install (case-insensitive)- Password Recommendations  

text[[115, 309, 800, 327]]
Oracle recommends the following guidelines when prompted for a password.  

text[[145, 336, 880, 506]]
- Contains at least one lowercase letter- Contains at least one uppercase letter- Contains at least one digit- Is at least 8 characters in length- Uses the database character set, which can include the underscore (_), dollar (\$), and pound sign (#) characters.- Should not be an actual word  

text[[115, 514, 880, 558]]
Oracle Universal Installer (OUI) will check the prerequisites, such as hardware compatibility:  

image[[126, 587, 870, 850]]

--- Page 20 ---

image[[116, 100, 905, 389]]  

text[[117, 413, 877, 457]]
The installation of Oracle Database 19c will start: this installation will take some time depending on our hardware.  

image[[114, 483, 889, 772]]

--- Page 21 ---

image[[166, 100, 832, 863]]

--- Page 22 ---

text[[118, 108, 332, 123]]
The installation is done.

text[[117, 135, 675, 149]]
The last thing that we need to do is to copy and save the link:

text[[116, 161, 376, 175]]
**https://localhost:5500/em**

text[[118, 187, 658, 200]]
This is the link for Oracle Database 19c Enterprise Manager

title[[117, 212, 852, 226]]
# Some Operating System Groups Created During Oracle Database Installation:

table[[69, 254, 928, 705]]

<table>Operating System<br>GroupRelated System PrivilegeDescriptionORA_DBASYSDBA system privileges for all Oracle Database<br>installations on the serverA special OSDBA group for the Windows operating system. Members of this group are granted SYSDBA<br>system privileges for all Oracle Databases installed on the server.ORA_OPERSYSOPER system privileges for all Oracle<br>Databases installed on the<br>serverA special OSOPER group for the Windows operating system.<br>Members of this group are granted SYSOPER system privileges all Oracle Databases installed on the server. This group does not have any members after installation, but you can manually add users to this group after the installation completes.</table>

--- Page 23 ---

image[[189, 100, 805, 405]]  

title[[117, 439, 866, 458]]
# Some Operating System Services Created During Oracle Database Installation:  

table[[188, 484, 807, 777]]

<table>FileActionViewHelp<td colspan="4">Services (Local)ServiceStatusStartup TypeD*OfficeScan NT ListenerRunningAutomaticROfficeScan NT RealTime ScanRunningAutomaticPOffline FilesManual (Trigger Start)TAOpenSSH Authentication AgentManualAOptimize drivesManualHOracleJobAdminulatorORCLRunningDisabledPOracleJobD19HomeIMTSRecoveryServiceRunningAutomaticROracleJobD19HomeITNSListenerRunningAutomaticAOracleRemExecServiceV2RunningAutomaticCOracleServiceORCLRunningAutomaticEOracleWSWInterORCLManualEHParental ControlsManual (Trigger Start)AEPayment and RPC/SEManagerRunningManualEPeer Name Resolution ProtocolRunningManualPPeer Networking GroupingRunningManualPPeer Networking Identity ManagerRunningManualEPerformance Counter DLL HostManualEPPerfomance I n o r &amp;amp; AlertsManualPC<td colspan="4">Extended Standard</table>

--- Page 24 ---

sub_title[[117, 108, 557, 128]]
## 5. User's Guide for: Toad for Oracle:  

text[[115, 141, 884, 286]]
We will use the tool: Toad for Oracle - 64 bit any version after Toad 12 as a principal tool to apply the database administration tasks. This is a very simple tool and has a lot of support hints and help to be satisfied during administration of your data base. In the following figures, there is a description to use Toad for Oracle step by step. The version Toad for Oracle 12 is accessible by all of the students in the first page of this subject on LMS on the SUV web site.  

text[[115, 318, 881, 387]]
- After installation of Oracle 19c - 64 bits described here above; and installation of Toad for Oracle, you will run it from start button in the windows 10 - 64bits as the following:  

image[[311, 412, 684, 855]]

--- Page 25 ---

text[[117, 106, 437, 123]]
You will prompt the following page:  

image[[150, 128, 849, 396]]  

text[[116, 420, 876, 490]]
So enter your user name "SYS" and its related your Password, and choose the database from the mentioned drop list beside the field of "Database". And as the user is "SYS" you have to select the value for the field "Connect as" "SYSDBA".  

image[[163, 516, 832, 892]]

--- Page 26 ---

text[[113, 106, 880, 252]]
You can change the tnsnames.ora by pressing the button "TNSNames Editor" and apply the changes or just review it if you want as a fast way to access this file. In the following step you can see the Toad for Oracle is ready to receive the various commands from your side. Notice that the current connection credential (SYS@ORCL) is appeared and the buttons of commit, rollback, new connections and disconnect the current connection are seen in the following image clearly:  

image[[181, 253, 811, 494]]  

text[[113, 519, 880, 588]]
There is a very useful tool in toad for Oracle; which is "Schema Browser" which let you access all the objects of the current user/Schema and other schema objects in a tree view to be very simple to access any object from any schema in one view:  

image[[128, 615, 863, 886]]

--- Page 27 ---

text[[115, 106, 881, 175]]
Now, return to "Editor" page which is used to write the SQL Statement or PL/SQL statements, procedures, functions, ...etc. you can open multiple "Editor" pages as you want and save each one as a separate folder on your operating system file system:  

image[[150, 200, 837, 465]]  

text[[115, 489, 881, 531]]
For administer and monitor the connected database you can find the below menu items:  

image[[152, 557, 835, 815]]  

text[[114, 845, 880, 888]]
In this quick user's Guide, you can continue explore the huge and simple capabilities of "Toad for Oracle" by yourself.

--- Page 28 ---

sub_title[[118, 109, 215, 128]]
## 6. Quiz:  

text[[145, 141, 880, 289]]
1. Which of these tools is not usually installed with the Oracle Universal Installer? (Choose the best answer).  
a) The Oracle Universal Installer itself  
b) SQL\*Plus  
c) SQL Developer  
d) Oracle Enterprise Express Manager  

text[[145, 319, 881, 366]]
2. What statement best describes the relationship between the Oracle Base and the Oracle Home? (Choose the best answer).  

text[[173, 372, 880, 517]]
a) The Oracle Base exists inside the Oracle Home.  
b) The Oracle Base can contain Oracle Homes for different products.  
c) One Oracle Base is required for each product, but versions of the product can exist in their own Oracle Homes within their Oracle Base.  
d) The Oracle Base is created when you run the orainstRoot.sh script, and contains a pointer to the Oracle Home.  

text[[145, 550, 880, 595]]
3. What does Optimal Flexible Architecture (OFA) describe? (Choose the best answer).  

text[[174, 602, 502, 697]]
a) A directory structure  
b) Distributed database systems  
c) Multitier processing architecture  
d) OFA encompasses all the above  

text[[145, 730, 586, 748]]
4. What is the statement that is not a DBA task?  

text[[174, 755, 602, 849]]
a) Evaluating the database server hardware  
b) Installing the Oracle software  
c) Shutdown and boot the OS  
d) Planning the database and security strategy

--- Page 29 ---

text[[147, 106, 647, 124]]
5. Monitoring database performance is not a DBA task?  

text[[177, 133, 262, 176]]
a) True 
b) False  

text[[146, 209, 657, 227]]
6. ORACLE_HOME directories for read-only directories?  

text[[178, 236, 261, 279]]
a) True 
b) False  

text[[147, 310, 824, 328]]
7. ORACLE_HOME directories for the writable files in the ORACLE_BASE?  

text[[177, 337, 261, 380]]
a) True 
b) False  

text[[147, 413, 870, 458]]
8. Which one of the following environment variables is not related to Oracle database server?  

text[[176, 466, 363, 559]]
a) ORACLE_HOME 
b) ORACLE_BASE 
c) ORACLE_SID 
d) W2kVersion  

text[[147, 592, 870, 636]]
9. Members of ORA_DBA group are granted SYSDBA system privileges for all Oracle Databases installed on the server?  

text[[177, 644, 261, 687]]
a) True 
b) False  

text[[147, 720, 870, 764]]
10. Which is the group that its members are granted SYSDBA system privileges for all Oracle Databases installed on the server?  

text[[177, 772, 363, 865]]
a) ORA_OPER 
b) ORA_INSTALL 
c) ORA_ASMOPER 
d) ORA_DBA

--- Page 30 ---

text[[147, 104, 879, 149]]
11. Members of ORA_DBA group are granted CREATE TABLE system privilege only for Oracle Database?  

text[[183, 157, 262, 202]]
a) True 
b) False  

text[[147, 234, 567, 253]]
12. Oracle Database 19c is only available for?  

text[[182, 260, 430, 355]]
a) 32 bit Windows systems  
b) 64 bit Windows systems  
c) Windows XP  
d) Windows Millenium  

text[[147, 386, 790, 406]]
13. Oracle Database 19c is only available for 64 bit Windows systems?  

text[[183, 413, 262, 458]]
a) True 
b) False  

text[[146, 490, 783, 509]]
14. What is the sufficient Physical memory (RAM) to run Oracle alone:  

text[[182, 516, 263, 609]]
a) 1 GB  
b) 4 GB  
c) 2GB  
d) 8 GB  

text[[146, 640, 872, 660]]
15. The configuration of Virtual memory (swap) size has relation with the size of:  

text[[182, 667, 364, 762]]
a) Physical memory  
b) Hard Drive  
c) CD Drive  
d) PGA

--- Page 31 ---

text[[147, 104, 880, 148]]
16. Oracle Database 19c is only available for Windows 10 Professional, Enterprise and Education Editions?  

text[[176, 157, 262, 202]]
a) True 
b) False  

text[[147, 234, 811, 253]]
17. Oracle Database 19c is only available for Windows 10 Home Edition?  

text[[177, 261, 263, 304]]
a) True 
b) False  

text[[148, 335, 668, 353]]
18. We can't install Oracle Database 19c if we are using:  

text[[176, 360, 449, 457]]
a) Windows 10 Professional  
b) Enterprise Edition  
c) Education Edition  
d) Windows 10 Home Edition  

text[[148, 489, 566, 507]]
19. The link https://localhost:5500/em is for:  

text[[176, 514, 586, 583]]
a) Oracle Database Configuration Assistance  
b) Oracle Database 19c Enterprise Manager  
c) Oracle Network Configuration Assistance  

text[[147, 615, 788, 633]]
20. Oracle 19c is not available for any Linux or Unix operating system?  

text[[176, 641, 262, 684]]
a) True 
b) False

--- Page 32 ---

table[[184, 99, 805, 656]]
<table><td colspan="2">Quiz answers - chapter 21c2b3a4c5b6a7b8d9a10d11b12b13a14c15a16a17b18d19b20b</table>
