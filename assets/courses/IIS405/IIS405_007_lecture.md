--- Page 1 ---

title[[120, 307, 878, 351]]
# Oracle Database Administration  

text[[483, 373, 515, 402]]
I  

text[[194, 455, 800, 484]]
Chapter 7: Users and Basic Security

--- Page 2 ---

sub_title[[732, 147, 887, 170]]
## :  

text[[114, 208, 883, 736]]
Objectives .2 Introduction .3 1. Database User Accounts .4 2. Managing Default Users.. 6 2.1. Predefined Administrative Accounts .6 2.2. Administrative Privileges.. 8 2.3. Locking Accounts and Expiring Passwords ..8 2.4. Checking Default Passwords... 9 3. Creating Users .10 3.1. Authentication Methods .14 3.2. Grant Privileges.. 16 3.3. Revoking Privileges .18 3.4. Using Roles to Manage Privileges.. 20 3.5. Managing Profiles ..25 3.6. Implementing Password Security Features... 28 3.7. Supplied Password Verification Functions ...30 4. Modifying Passwords.. 31 5. Schema Only Account .32 6. Modifying/Dropping Users.. 34 6.1. Modifying users.. 34 6.2. Dropping Users.. 35 7. Quiz... 36 References ..42

--- Page 3 ---

sub_title[[118, 108, 253, 127]]
## Objectives:  

text[[148, 141, 583, 159]]
1. Create and manage database user accounts:  

text[[178, 168, 592, 210]]
Authenticate users Assign default storage areas (tablespaces)  

text[[147, 218, 428, 236]]
2. Grant and revoke privileges  

text[[148, 244, 406, 261]]
3. Create and manage roles  

text[[146, 269, 435, 287]]
4. Create and manage profiles:  

text[[178, 295, 630, 312]]
Implement standard password security features  

text[[179, 320, 502, 337]]
Control resource usage by users

--- Page 4 ---

sub_title[[117, 108, 270, 126]]
## Introduction:  

text[[116, 141, 881, 185]]
The following terms relate to administering database users and assist you in understanding the objectives:.  

text[[146, 193, 883, 466]]
A database user account is a way to organize the ownership of and access to database objects A password is an authentication by the Oracle database. A privilege is a right to execute a particular type of SQL statement or to access another user's object A role is a named group of related privileges that are granted to users or to other roles Profiles impose a named set of resource limits on database usage and instance resources, and manage account status and password management rules. A quota is a space allowance in a given tablespace. This is one of the ways by which you can control resource usage by users..

--- Page 5 ---

sub_title[[120, 108, 460, 128]]
## 1. Database User Accounts:  

text[[117, 143, 428, 159]]
Each database user account has:  

text[[148, 169, 407, 339]]
A unique username An authentication method A default namespace A temporary namespace A user profile An initial consumer group An account status  

sub_title[[117, 346, 220, 362]]
## A schema:  

text[[147, 371, 790, 390]]
Is a collection of database objects that are owned by a database user  

text[[148, 399, 542, 415]]
Has the same name as the user account  

text[[117, 424, 417, 440]]
Each database user account has:  

text[[147, 450, 880, 495]]
A unique username: Usernames cannot exceed 30 bytes, cannot contain special characters, and must start with a letter.  

text[[148, 502, 881, 593]]
An authentication method: The most common authentication method is a password. Oracle Database supports password, global, and external authentication methods (such as biometric, certificate, and token authentication).  

text[[147, 600, 880, 721]]
A default namespace: This is a place where a user creates objects if the user does not specify some other namespace. Note that having a default namespace does not imply that the user has the privilege of creating objects in that namespace, nor does the user have a quota of space in that namespace in which to create objects. Both of these are granted separately.  

text[[147, 729, 880, 798]]
A temporary namespace: This is a place where temporary objects, such as sorts and temporary tables, are created on behalf of the user by the instance. No quota is applied to temporary namespaces.  

text[[146, 806, 881, 850]]
A user profile: This is a set of resource and password restrictions assigned to the user. An initial consumer group: This is used by the Resource Manager.

--- Page 6 ---

text[[150, 105, 880, 152]]
- An account status: Users can access only "open" accounts. The account_status may be:  

text[[177, 158, 881, 611]]
- OPEN: The account is available for use.- LOCKED: This indicates that the DBA deliberately locked the account. No user can connect to a locked account.- EXPIRED: This indicates that the lifetime has expired. Passwords can have a limited lifetime. No user can connect to an EXPIRED account until the password is reset.- EXPIRED & LOCKED: Not only has the account been locked, but its password has also expired.- EXPIRED (GRACE): This indicates that the grace period is in effect. A password need not expire immediately when its lifetime ends; it may be configured with a grace period during which users connecting to the account have the opportunity to change the password.- LOCKED (TIMED): This indicates that the account is locked because of failed login attempts. An account can be configured to lock automatically for a period after an incorrect password is presented a certain number of times.- EXPIRED & LOCKED (TIMED)- EXPIRED (GRACE) & LOCKED- EXPIRED (GRACE) & LOCKED (TIMED)A schema:  

text[[118, 616, 217, 632]]
A schema:  

text[[147, 641, 803, 687]]
- Is a collection of database objects that are owned by a database user.- Has the same name as the user account  

text[[117, 692, 881, 789]]
Schema objects are the logical structures that directly refer to the database's data. Schema objects include such structures as tables, views, sequences, stored procedures, synonyms, indexes, clusters, and database links. In general, schema objects include everything that your application creates in the database.

--- Page 7 ---

sub_title[[119, 108, 454, 129]]
## 2. Managing Default Users:  

text[[117, 141, 882, 239]]
When you create a database, Oracle creates several default database users. These default users would either set a default password or take input from database creation. With Oracle 19c, all of the default accounts are locked on installation except for SYS and SYSTEM. You can view the default user accounts, as follows:  

text[[117, 255, 688, 275]]
SQL> select username from dba_users order by 1;  

text[[116, 291, 881, 338]]
Note: If you are working in a pluggable database environment, you can view all users while connected as a privileged account to the root container by querying CDB_USERS.  

sub_title[[117, 368, 542, 388]]
### 2.1. Predefined Administrative Accounts:  

text[[146, 400, 232, 416]]
SYS:  

text[[147, 424, 855, 593]]
- Owns the data dictionary and the Automatic Workload Repository (AWR)- Used for startup and shutdown of the database instance-SYSTEM: Owns additional administrative tables and views-SYSBACKUP: Facilitates Oracle Recovery Manager (RMAN) backup and recovery operations-SYSDG: Facilitates Oracle Data Guard operations-SYSKM: Facilitates Transparent Data Encryption wallet  

text[[117, 602, 220, 619]]
Operations  

text[[116, 626, 881, 750]]
The SYS and SYSTEM accounts have the database administrator (DBA) role granted to them by default. In addition, the SYS account has all privileges with ADMIN OPTION and owns the data dictionary. To connect to the SYS account, you must use the AS SYSDBA clause for a database instance and AS SYSASM for an Automatic Storage Management (ASM) instance.  

text[[116, 755, 881, 826]]
Any user that is granted the SYSDBA privilege can connect to the SYS account by using the AS SYSDBA clause. Only "privileged" users who are granted the SYSDBA, SYSOPER, or SYSASM  

text[[116, 832, 844, 877]]
privileges are allowed to start up and shut down instances. The SYSTEM account does not have the SYSDBA privilege. SYSTEM is also granted the

--- Page 8 ---

text[[117, 108, 880, 150]]
AQ ADMINISTRATOR ROLE and MGMT USER roles. The SYS and SYSTEM accounts are required accounts in the database. They cannot be dropped.  

text[[116, 158, 881, 227]]
Best practice: Applying the principle of least privilege, these accounts are not used for routine operations. Users who need DBA privileges have separate accounts with the required privileges granted to them.  

text[[117, 234, 883, 329]]
The SYSBACKUP, SYSDG, and SYSKM users are created to facilitate separation of duties for database administrators. Each of these provides a designated use for an administrative privilege by the same name. You should create a user and grant the appropriate administrative privilege to that user.  

text[[117, 361, 881, 406]]
Note: Any user that is granted the SYSDBA privilege can connect to the SYS account by using the AS SYSDBA clause.  

text[[116, 413, 883, 457]]
Note: The SYS and SYSTEM accounts are required accounts in the database. They cannot be dropped.

--- Page 9 ---

sub_title[[117, 106, 438, 125]]
### 2.2. Administrative Privileges:  

table[[114, 153, 819, 492]]

<table>PrivilegeDescriptionSYSDEAStandard database operations, such as starting and shutting down the database instance, creating the server parameter file (SPFILE), and changing the ARCHIVELOG mode. Allows the grantee to view user dataSYSOPERStandard database operations, such as starting and shutting down the database instance, creating the server parameter file (SPFILE), and changing the ARCHIVELOG modeSYSBACKUPOracle Recovery Manager (RMAN) backup and recovery operations by using RMAN or SQL*PlusSYSDGData Guard operations by using the Data Guard Broker or the DGMRL command-line interfaceSYSKMManage Transparent Data Encryption wallet operations</table>  

sub_title[[117, 497, 174, 512]]
## Note:  

text[[115, 520, 882, 666]]
Security for SYSDEA, SYSOPER roles is often controlled through access to the OS account owner of the Oracle software. Additionally, security for these roles can be administered via a password file, which allows remote client/server access. Starting with 12c the SYS account could also be locked in some databases. Locking the account prevented unauthorized access from the server and another OS account but SYSDEA will need to be granted to an authorized user first.  

sub_title[[117, 699, 608, 718]]
### 2.3. Locking Accounts and Expiring Passwords:  

text[[115, 729, 881, 872]]
To begin securing your database, you should minimally change the password for every default account and then lock any accounts that you are not using. Locking an account means that a user won't be able to access it unless a DBA explicitly unlocks it. Also Consider having policies that change the password for each account. Expiring the password means that when a user first attempts to access an account, that user

--- Page 10 ---

text[[117, 106, 880, 150]]
will be forced to change the password, but it does not require the current password, so it is better to change passwords and lock the accounts.  

text[[116, 158, 881, 202]]
After creating a database, it would be better to lock every default account and change their passwords; and to unlock default users only as they are needed.  

text[[117, 210, 578, 227]]
The following script generates the SQL statements:  

text[[116, 245, 796, 335]]
SQL> alter user <username> identified by <new password>; SQL> select 'alter user' || username || account lock'; from dba_users;  

text[[117, 366, 880, 400]]
A locked user can only be accessed by altering the user to an unlocked state; for example:  

text[[116, 416, 565, 432]]
SQL> alter user outlin account unlock;  

text[[117, 468, 881, 537]]
A user with an expired password is prompted for a new password when first connecting to the database as that user. When connecting to a user, Oracle checks to see if the current password is expired and, if so, prompts the user, as follows:  

text[[116, 555, 542, 604]]
ORA- 28001: the password has expired Changing password for ... New password:  

text[[117, 624, 758, 642]]
After entering the new password, the user is prompted to enter it again:  

text[[116, 663, 363, 708]]
Retype new password: Password changed Connected.  

sub_title[[118, 741, 470, 759]]
## 2.4.Checking Default Passwords:  

text[[117, 772, 881, 840]]
You should also check your database to determine whether any accounts are using default passwords. you can check the DBA_USERS_WITH_DEFPWD view whether any Oracle- created user accounts are still set to the default password:  

text[[117, 859, 613, 875]]
SQL> select \* from dba_users_with_defpwd;

--- Page 11 ---

sub_title[[119, 108, 343, 128]]
## 3. Creating Users:  

text[[117, 142, 782, 159]]
When you are creating a user, you need to consider the following factors:  

text[[147, 168, 602, 262]]
- Username and authentication method- Basic privileges- Default permanent tablespace and space quotas- Default temporary tablespace  

text[[117, 294, 880, 363]]
Note: Pluggable database environments have common users and local users. Common users span all pluggable databases within a container database. Local users exist within one pluggable database.  

text[[119, 396, 788, 414]]
The following figures are show the required steps to create a user account:  

text[[117, 422, 880, 466]]
The following figure shows the how to choose the create user operation from Toad for Oracle application:  

image[[119, 493, 878, 778]]  

text[[116, 807, 877, 850]]
The following figure shows the entering the essential data for the new user; as user name, authentication method, and profile

--- Page 12 ---

image[[244, 100, 746, 429]]  

text[[114, 457, 847, 475]]
The following figure shows the assignment of default tablespace for the new user:  

image[[198, 500, 796, 888]]

--- Page 13 ---

text[[117, 105, 785, 123]]
The following figure shows the granting roles for the new user with options:  

image[[235, 152, 763, 497]]  

text[[116, 501, 783, 519]]
The following figure shows the granting system privileges for the new user:  

image[[238, 547, 761, 884]]

--- Page 14 ---

text[[117, 105, 842, 123]]
The following figure shows the quotas' assignment on each existing tablespaces:  

image[[226, 152, 769, 510]]  

text[[116, 536, 879, 581]]
The following figure is the last step and it shows the create user statement related to previous steps:  

image[[181, 609, 816, 884]]

--- Page 15 ---

sub_title[[119, 108, 424, 126]]
### 3.1. Authentication Methods:  

text[[116, 138, 880, 208]]
A user account must have an authentication method: some means whereby the database can determine if the user attempting to create a session connecting to the account is allowed to do so. Authentication types are:  

text[[147, 215, 639, 334]]
Operating system authentication (for administrators) Password file authentication (for administrators) Password authentication (for users) External authentication (for users) Global authentication (for users)  

text[[116, 366, 880, 437]]
The first two techniques are used only for administrators who log in as SYSDBA or as SYSOPER; the last requires an LDAP directory server. The LDAP directory server is the Oracle Internet Directory, shipped as a part of the Oracle Application Server.  

image[[148, 464, 473, 595]]  

sub_title[[150, 635, 442, 653]]
## Operating System Authentication:  

text[[147, 670, 880, 865]]
Operating System Authentication:- Type of Administrators Authentication who log in as SYSDBA or as SYSOPER- Users log on without specifying additional password or user name- Best when only local access or secured line access are allowed- Can be a security risk if used with non- secure internet or network lines- Requires knowledge of operating system security- Two special operating system groups control database administrator connections when using OS authentication- These groups are generically referred to as OSDBA and OSOPER

--- Page 16 ---

text[[117, 106, 284, 123]]
How to implement  

text[[147, 131, 553, 150]]
1. Create operating system user for DBA use  

text[[146, 157, 880, 204]]
2. Create OSDBA group (UNIX only because Windows automatically creates the group with name ORA_DBA)  

text[[147, 209, 879, 254]]
3. Assign operating system user to ORA_DBA group in Windows or OSDBA group in Unix:  

text[[176, 272, 618, 288]]
SET REMOTE_LOGIN_PASSWORDFILE = NONE  

text[[177, 297, 495, 312]]
CONNECT / @oradb as sysdba  

sub_title[[117, 350, 404, 368]]
## Password File Authentication:  

text[[146, 376, 880, 547]]
- Type of Administrators Authentication who log in as SYSDBA or as SYSOPER- Following database creation, the only user with these privileges is SYS- Users must know their Oracle username and password to log onto the database- Best for non-secured line access, such as Internet, is allowed- Users required to remember multiple usernames and passwords- Possible security risk due to storage of passwords in an encrypted operating system file  

text[[117, 555, 288, 571]]
How to implement:  

text[[146, 579, 880, 625]]
1. Set REMOTE_LOGIN_PASSWORDFILE = EXCLUSIVE (or SHARED if database is part of distributed system)  

text[[147, 631, 879, 696]]
2. Add more SYSDBA or SYSOPER users by Creating new Oracle user, for example student: CREATE USER student IDENTIFIED BY mypass;  

text[[146, 700, 677, 735]]
3. Assigning SYSDBA or SYSOPER privileges to this user: GRANT sysdba TO student;  

text[[117, 740, 879, 784]]
Password file is automatically updated when new users are assigned these privileges and when any of these users change their passwords:

--- Page 17 ---

text[[117, 105, 881, 150]]
Note: OS authentication takes precedence over password file authentication for privileged users  

sub_title[[118, 158, 363, 175]]
## Password Authentication:  

text[[147, 183, 880, 328]]
1. Authentication by the Oracle database  
2. Encrypted and stored in the data dictionary using the Advanced Encryption Standard (AES) algorithm during network connections before sending them across the network.  
3. When setting up a password, you can expire the password immediately, which forces the user to change the password after first logging in  

sub_title[[118, 360, 352, 377]]
## External Authentication:  

text[[147, 385, 645, 456]]
1. Authentication is delegated to an external service  
2. Users can connect without user name and password  
3. Operating System  

title[[196, 486, 533, 508]]
# OS_AUTHENT_PREFIX = OPS\$  

text[[197, 512, 800, 601]]
Windows account: John  Windows domain: SVU  Create user "OPS\SVU\JOHN" identified externally; Connect /  

sub_title[[118, 634, 332, 650]]
## Global Authentication:  

text[[147, 658, 837, 703]]
1. Requires the Oracle Advanced Security option  
2. Enables users to be identified through the use of Oracle Internet Directory  

sub_title[[118, 738, 340, 756]]
## 3.2. Grant Privileges:  

text[[117, 767, 881, 862]]
By default, no one can do anything in an Oracle database. A user cannot even connect without being granted a privilege. And once this has been done, he still can't do anything useful (or dangerous) without being given more privileges. Privileges are assigned to user accounts with a GRANT command and withdrawn with a REVOKE. By

--- Page 18 ---

text[[117, 106, 881, 149]]
default, only the DBAs (SYS and SYSTEM) have the right to grant any but the most limited privileges.  

text[[118, 158, 464, 175]]
There are two types of user privileges:  

sub_title[[117, 183, 294, 200]]
## System Privileges:  

text[[116, 208, 881, 304]]
There are about two hundred system privileges. Most apply to actions that affect the data dictionary, such as creating tables or users. Others affect the database or the instance, such as creating tablespaces, adjusting instance parameter values, or establishing a session.  

text[[147, 311, 880, 412]]
Some of the more commonly used privileges are: CREATE SESSION, CREATE TABLE, CREATE ANY TABLE, SELECT ANY TABLE- ANY clause means that the privilege crosses schema lines:- Grant select any table to scott with admin option;- The SYs user and users with the DBA role are granted all of the ANY privileges  

sub_title[[118, 420, 291, 437]]
## Object Privileges:  

text[[116, 445, 881, 562]]
Object privileges give the ability to perform SELECT, INSERT, UPDATE, and DELETE commands against tables and related objects, and to execute PL/SQL objects. These privileges do not exist for objects in the users' own schemas; if a user has the system privilege CREATE TABLE, he/she can perform SELECT and DML operations against the tables he/she creates with no further need for permissions.  

text[[118, 597, 601, 616]]
The object privileges apply to different types of object:  

table[[117, 624, 805, 811]]

<table>PrivilegeGranted onSELECTTables, views, sequences, synonymsINSERTTables, views, synonymsUPDATETables, views, synonymsDELETETables, views, synonymsALTERTables, sequencesEXECUTEProcedures, functions, packages, synonyms</table>  

text[[118, 815, 800, 852]]
GRANT OPTION, lets a user pass his/her object privilege on to a third party: Grant select on employees to scott with grant option;

--- Page 19 ---

sub_title[[119, 108, 380, 126]]
### 3.3. Revoking Privileges:  

sub_title[[117, 138, 586, 156]]
## Revoking System Privileges with ADMIN OPTION  

text[[115, 163, 884, 305]]
System privileges that have been granted directly with a GRANT command can be revoked by using the REVOKE SQL statement. Users with ADMIN OPTION for a system privilege can revoke the privilege from any other database user. The revoker does not have to be the same user who originally granted the privilege. There are no cascading effects when a system privilege is revoked, regardless of whether it is given the ADMIN OPTION.The  

text[[117, 307, 561, 324]]
The SQL syntax for revoking system privileges is:  

text[[115, 344, 689, 361]]
REVOKE <system_privilege> FROM <grantee clause>  

text[[116, 380, 589, 398]]
The enclosed figure illustrates the following situation.  

image[[160, 431, 832, 747]]

--- Page 20 ---

text[[117, 108, 208, 123]]
Scenario:  

text[[147, 132, 880, 179]]
1. The DBA grants the CREATE TABLE system privilege to Joe with ADMIN OPTION.  

text[[148, 185, 363, 202]]
2. Joe creates a table.  

text[[146, 210, 699, 227]]
3. Joe grants the CREATE TABLE system privilege to Emily.  

text[[147, 236, 376, 252]]
4. Emily creates a table.  

text[[145, 260, 763, 278]]
5. The DBA revokes the CREATE TABLE system privilege from Joe.  

sub_title[[117, 285, 186, 300]]
## Result:  

text[[116, 310, 879, 356]]
Joe's table still exists, but Joe cannot create new tables. Emily's table still exists, and she still has the CREATE TABLE system privilege.  

sub_title[[117, 386, 576, 405]]
## Revoking Object Privileges with GRANT OPTION  

text[[115, 411, 881, 533]]
Cascading effects can be observed when revoking a system privilege that is related to a data manipulation language (DML) operation. For example, if the SELECT ANY TABLE privilege is granted to a user, and if that user has created procedures that use the table, all procedures that are contained in the user's schema must be recompiled before they can be used again.  

text[[115, 540, 881, 635]]
Revoking object privileges also cascades when given with GRANT OPTION. As a user, you can revoke only those privileges that you have granted. For example, Bob cannot revoke the object privilege that Joe granted to Emily. Only the grantee or a user with the privilege called GRANT ANY OBJECT PRIVILEGE can revoke object privileges.  

image[[264, 660, 734, 893]]

--- Page 21 ---

text[[117, 108, 208, 123]]
Scenario:  

text[[147, 132, 880, 177]]
1. Joe is granted the SELECT object privilege on EMPLOYEES with GRANT OPTION.  

text[[146, 184, 692, 202]]
2. Joe grants the SELECT privilege on EMPLOYEES to Emily.  

text[[147, 210, 880, 253]]
3. The SELECT privilege is revoked from Joe. This revoke is cascaded to Emily as well.  

sub_title[[118, 286, 518, 305]]
### 3.4. Using Roles to Manage Privileges:  

text[[116, 316, 881, 435]]
A role is a named group of related privileges that are granted to users or to other roles. You can use roles to administer database privileges. You can add privileges to a role and grant the role to a user. The user can then enable the role and exercise the privileges granted by the role. A role contains all privileges that are granted to that role and all privileges of other roles that are granted to it.  

text[[117, 444, 880, 488]]
There are several roles defined automatically for Oracle databases when you run database creation scripts.  

text[[118, 495, 881, 538]]
Please check this example to learn how to manage roles and this video to see how to create roles in Toad for Oracle application  

text[[117, 546, 763, 564]]
Roles provide the following benefits with respect to managing privileges:  

sub_title[[119, 572, 399, 589]]
## Easier privilege management:  

text[[116, 597, 881, 666]]
Use roles to simplify privilege management. Rather than granting the same set of privileges to several users, you can grant the privileges to a role and then grant that role to each user.  

text[[146, 674, 880, 717]]
- Privileges are granted to and revoked from roles as though the role were a user.  

text[[147, 726, 879, 769]]
- Roles are granted to and revoked from users or other roles as though they were system privileges.  

text[[146, 777, 672, 795]]
- A role can consist of both system and object privileges.  

text[[147, 803, 825, 821]]
- A role can be enabled or disabled for each user who is granted the role.  

text[[146, 829, 583, 846]]
- A role can require a password to be enabled.  

text[[147, 854, 764, 871]]
- Roles are not owned by anyone, and they are not in any schema.

--- Page 22 ---

sub_title[[117, 106, 425, 123]]
## Dynamic privilege management:  

text[[115, 131, 881, 175]]
If the privileges associated with a role are modified, all users who are granted the role acquire the modified privileges automatically and immediately.  

sub_title[[117, 183, 444, 200]]
## Selective availability of privileges:  

text[[115, 208, 881, 253]]
Roles can be enabled and disabled to turn privileges on and off temporarily. This allows the privileges of the user to be controlled in a given situation.  

sub_title[[117, 260, 282, 277]]
## Predefined Roles  

table[[92, 304, 904, 528]]

<table>RolePrivileges IncludedCONNECTCREATE SESSIONDBAMost system privileges; several other roles. Do not<br>grant to non-administrators.RESOURCECREATE CLUSTER, CREATE INDEXTYPE, CREATE OPERATOR, CREATE PROCEDURE, CREATE SEQUENCE, CREATE TABLE, CREATE TRIGGER, CREATE TYPESCHEDULER_ADMINCREATE ANY JOB, CREATE EXTERNAL JOB, CREATE JOB, EXECUTE ANY CLASS, EXECUTE ANY PROGRAM, MANAGE SCHEDULERSELECT_CATALOG_ROLESELECT privileges on data dictionary objects</table>  

sub_title[[117, 556, 208, 572]]
## Example:  

text[[115, 581, 881, 675]]
In the following example, the SELECT and UPDATE privileges on the employees table and the CREATE JOB system privilege are granted to the HR_CLERK role. DELETE and INSERT privileges on the employees table and the HR_CLERK role are granted to the HR_MGR role.  

text[[115, 682, 881, 725]]
The manager is granted the HR_MGR role and can now select, delete, insert, and update the employees table.

--- Page 23 ---

image[[131, 100, 845, 411]]  

text[[117, 437, 635, 455]]
The following figures are shown the steps to create a role:  

text[[116, 463, 871, 506]]
The following figure shows the how to choose the create new role operation from Toad for Oracle application  

image[[128, 533, 852, 805]]  

text[[117, 829, 591, 846]]
The following figure shows the create new Role Info:

--- Page 24 ---

image[[181, 100, 805, 443]]  

text[[114, 470, 679, 488]]
The following figure shows how to grant roles to the new Role:  

image[[217, 514, 770, 871]]

--- Page 25 ---

text[[116, 104, 786, 122]]
The following figure shows how to grant System Privileges to the new Role:  

image[[222, 152, 766, 508]]  

text[[114, 538, 780, 556]]
The following figure shows how to grant Object Privileges to the new Role:  

image[[172, 580, 824, 845]]

--- Page 26 ---

text[[116, 105, 783, 123]]
The following figure shows how to grant Object Privileges to the new Role:  

image[[176, 152, 821, 417]]  

text[[115, 448, 878, 465]]
The following figure shows the SQL statement generated with the previous information:  

image[[177, 467, 822, 715]]  

sub_title[[119, 744, 363, 762]]
### 3.5. Managing Profiles:  

text[[116, 774, 526, 791]]
Users are assigned only one profile at a time.  

text[[117, 800, 198, 815]]
Profiles:  

text[[147, 825, 612, 867]]
- Control resource consumption  
- Manage account status and password expiration

--- Page 27 ---

text[[115, 105, 881, 233]]
Profiles impose a named set of resource limits on database usage and instance resources. Profiles also manage the account status and place limitations on users' passwords (length, expiration time, and so on). Every user is assigned a profile and may belong to only one profile at any given time. If users have already logged in when you change their profile, the change does not take effect until their next login.  

text[[117, 233, 880, 279]]
The DEFAULT profile serves as the basis for all other profiles (applied by default to all users, including SYS and SYSTEM)  

text[[115, 295, 738, 362]]
select profile, resource_name, resource_type, limit from dba_profiles order by profile, resource_type;  

text[[117, 395, 881, 466]]
Unlike password settings, kernel resource profile restrictions don't take effect until you set the RESOURCE_LIMIT initialization parameter to TRUE for your database; for example:  

text[[115, 485, 760, 552]]
SQL> alter system set resource_limit=true scope=both; SQL> select name, value from v$parameter where name='resource_limit';  

text[[117, 586, 660, 605]]
The following figures are shown the steps to create a profile:  

text[[115, 611, 880, 656]]
The following figure shows the how to choose the create new profile operation from Toad for Oracle application - first page information: Resource Parameters:

--- Page 28 ---

image[[120, 98, 875, 387]]  

text[[117, 413, 877, 458]]
The following figure shows the how to choose the create new profile operation from Toad for Oracle application - second page information: Password Parameters:  

image[[150, 483, 844, 746]]

--- Page 29 ---

sub_title[[117, 106, 607, 125]]
### 3.6. Implementing Password Security Features:  

text[[115, 137, 880, 181]]
Oracle password management is implemented with user profiles. Profiles can provide many standard security features:  

image[[170, 213, 816, 500]]  

sub_title[[117, 554, 283, 570]]
## Account locking:  

text[[115, 578, 881, 621]]
Enables automatic locking of accounts for a set duration when users fail to log in to the system in the specified number of attempts  

text[[146, 628, 880, 670]]
- FAILED_LOGIN_ATTEMPTS: Specifies the number of failed login attempts before the lockout of the account  

text[[147, 679, 881, 722]]
- PASSWORD_LOCK_TIME: Specifies the number of days for which the account is locked after the specified number of failed login attempts  

text[[115, 730, 880, 773]]
Note: Do not use profiles that cause the SYS, SYSMAN, and DBSNMP passwords to expire and the accounts to be locked.

--- Page 30 ---

sub_title[[119, 106, 432, 123]]
## Password aging and expiration:  

text[[117, 131, 880, 175]]
Enables user passwords to have a lifetime, after which the passwords expire and must be changed  

text[[146, 184, 881, 278]]
- PASSWORD_LIFE_TIME: Determines the lifetime of the password in days, after which the password expires  
- PASSWORD_GRACE_TIME: Specifies a grace period in days for changing the password after the first successful login after the password has expired  

sub_title[[119, 286, 290, 302]]
## Password history:  

text[[117, 310, 881, 381]]
Checks the new password to ensure that the password is not reused for a specified amount of time or a specified number of password changes. These checks can be implemented by using one of the following:  

text[[146, 388, 880, 483]]
- PASSWORD_REUSE_TIME: Specifies that a user cannot reuse a password for a given number of days  
- PASSWORD_REUSE_MAX: Specifies the number of password changes that are required before the current password can be reused  

sub_title[[119, 491, 442, 507]]
## Password complexity verification:  

text[[117, 515, 881, 586]]
Makes a complexity check on the password to verify that it meets certain rules. The check must ensure that the password is complex enough to provide protection against intruders who may try to break into the system by guessing the password.  

text[[117, 592, 874, 632]]
It is useful to check to see whether the password for a user has ever been changed: select  

text[[116, 638, 835, 825]]
name user_name, to_char(ctime,'dd- mon- yy hh24:mi:ss') password_creationtime ,to_char(ptime,'dd- mon- yy hh24:mi:ss') password_presenttime ,length(password) from user$ where password is not null and password not in ('GLOBAL','EXTERNAL') and ctime=ptime;

--- Page 31 ---

sub_title[[117, 107, 603, 126]]
### 3.7. Supplied Password Verification Functions:  

text[[146, 138, 724, 183]]
- The following functions are created by the \(\)ORACLE_HOME/rdbms/admin/utilpwdmg.sql script:\$ORA12C_VERIFY_FUNCTION\$  

text[[176, 191, 530, 208]]
- ORA12C_VERIFY_FUNCTION  

text[[177, 218, 560, 234]]
- ORA12C_STRONG_VERIFY_FUNCTION  

text[[146, 245, 610, 262]]
- The functions require the following of passwords:  

text[[176, 270, 832, 389]]
- Have a minimum number of characters- Not be the username, username with a number, or username reversed- Not be the database name or the database name with a number- Have at least one alphabetic and one numeric character- Differ from the previous password by at least three letters  

text[[116, 421, 880, 466]]
Note: The functions must be owned by the SYS user. Password complexity checking is not enforced for the SYS user.  

text[[117, 474, 881, 540]]
The following figure shows the how to choose the create new profile operation from Toad for Oracle application - SQL statement to create the new profile with the selected parameters:  

image[[140, 543, 860, 817]]

--- Page 32 ---

sub_title[[120, 108, 413, 129]]
## 4.Modifying Passwords:  

text[[117, 142, 881, 188]]
Use the ALTER USER command to modify an existing user's password. This example changes the HR user's password to PEOPLE:  

text[[118, 205, 603, 221]]
SQL> alter user HR identified by PEOPLE;  

text[[115, 240, 885, 438]]
You can change the password of another account only if you have the ALTER USER privilege granted to your user. This privilege is granted to the DBA role. After you change a password for a user, any subsequent connection to the database by that user requires the password indicated by the ALTER USER statement. When you modify a password, it is case sensitive. The behavior with the case is set with a parameter SEC CASE SENSITIVE_LOGON and by default is TRUE. You can change the password for a user with the SQL\*Plus PASSWORD command. After issuing the command, you are prompted for a new password:  

text[[117, 466, 411, 579]]
SQL> passw HR Changing password for HR New password: Retype new password: Password changed  

text[[116, 614, 881, 658]]
This method has the advantage of changing a password for a user without displaying the new password on the screen.

--- Page 33 ---

sub_title[[120, 108, 424, 129]]
## 5. Schema Only Account:  

text[[115, 141, 883, 313]]
Previously without a schema only account, a DBA would have to log in as a different user to perform some create table scripts and issue grants. Now, there are new Schema Only Accounts that can be created without passwords. This is for application schemas and holds all of the objects, so changes to these objects can be done if granted the privilege to access these accounts. These accounts have no privilege to log in directly to the database. So even without a password, there is no possibility to log in, and an error will occur.  

text[[117, 331, 883, 474]]
SQL> create user appl NO AUTHENTICATION; In the dba_users table, this user will have an AUTHENTICATION_TYPE=NONE, and the password column will also be NULL. Schema only accounts can have privileges granted to create table and other objects; however, it cannot have any of the administrative privileges assigned to it. Even granting CONNECT SESSION to the schema only account will not allow you to log in to this schema account directly.  

text[[117, 492, 530, 508]]
SQL> grant create session to appl;  

text[[120, 516, 313, 531]]
Grant succeeded.  

text[[119, 540, 324, 556]]
SQL> connect appl  

text[[118, 565, 301, 580]]
Enter password:  

text[[117, 590, 195, 604]]
ERROR:  

text[[116, 613, 661, 629]]
ORA- 01005: null password given; logon denied  

text[[118, 637, 684, 653]]
Warning: You are no longer connected to ORACLE.  

text[[119, 660, 324, 676]]
SQL> connect appl  

text[[117, 685, 301, 700]]
Enter password:  

text[[118, 710, 195, 724]]
ERROR:  

text[[116, 733, 726, 750]]
ORA- 01017: invalid username/password; logon denied  

text[[117, 777, 881, 847]]
In order to perform the DDL statements in other accounts including the schema only accounts, a proxy connection can be made. Using a proxy connection was possible, and with the schema only account, it continues to be possible in order to perform any

--- Page 34 ---

text[[117, 106, 883, 151]]
necessary code as the schema. Here is an example using jb_dba as our account as we log in to the database, and the schema only account is app1.  

image[[114, 168, 881, 434]]  

text[[117, 455, 883, 549]]
This schema without a password can simply be used to application schemas and allow privileges to be granted to the objects or become this schema to run code. This is something to consider for application schemas; and, as we will see in grants and permissions can still be handled by roles for these objects.

--- Page 35 ---

sub_title[[117, 108, 470, 130]]
## 6. Modifying/Dropping Users:  

title[[118, 143, 339, 161]]
#### 6.1. Modifying users:  

text[[115, 173, 829, 192]]
Sometimes you need to modify existing users for the following types of reasons:  

text[[145, 199, 748, 345]]
- Change a user's password  
- Lock or unlock a user  
- Change the default permanent or temporary tablespace, or both  
- Change a profile or role  
- Change system or object privileges  
- Modify quotas on tablespaces  

text[[117, 376, 563, 394]]
Use the ALTER USER statement to modify users.  

text[[118, 402, 645, 420]]
Listed next are several SQL statements that modify a user:  

text[[116, 428, 815, 447]]
This example changes a user's password, using the IDENTIFIED BY clause:  

text[[117, 466, 675, 484]]
SQL> alter user HR identified by PEOPLE_New12;  

text[[116, 502, 879, 546]]
If you don't set a default permanent tablespace and temporary tablespace when you initially create the user, you can modify them after creation, as shown here:  

text[[117, 564, 878, 598]]
SQL> alter user HR default tablespace users temporary tablespace temp;  

text[[118, 616, 437, 634]]
This example locks a user account:  

text[[116, 653, 507, 671]]
SQL> alter user HR account lock;  

text[[117, 689, 727, 707]]
And, this example alters the user's quota on the USERS tablespace:  

text[[118, 728, 590, 744]]
SQL> alter user HR quota 500m on users;

--- Page 36 ---

sub_title[[119, 108, 335, 126]]
### 6.2. Dropping Users:  

text[[114, 137, 883, 382]]
Before you drop a user, it is recommended that you first lock the user. Locking the user prevents others from connecting to a locked database account. This allows you to better determine whether someone is using the account before it is dropped. Locking users is a very handy technique for securing your database and discovering which users are active. Be aware that by locking a user, you are not locking access to a user's objects. For instance, if a USER_A has select, insert, update, and delete privileges on tables owned by USER_B, if you lock the USER_B account, USER_A can still issue DML statements against the objects owned by USER_B. After you are sure that a user and its objects are not needed, use the DROP USER statement to remove a database account.  

text[[117, 391, 455, 408]]
Here is an example of locking a user:  

text[[116, 429, 504, 446]]
SQL> alter user HR account lock;  

text[[115, 467, 880, 510]]
Any user or application attempting to connect to this user now receives the following error:  

text[[117, 529, 511, 546]]
ORA- 28000:the account is locked  

text[[116, 566, 729, 584]]
To view the users and lock dates in your database, issue this query:  

text[[118, 604, 688, 621]]
SQL> select username, lock_date from dba_users;  

text[[117, 640, 504, 656]]
To unlock an account, issue this command:  

text[[116, 678, 530, 693]]
SQL> alter user HR account unlock;  

text[[118, 715, 411, 730]]
This example drops the user HR:  

text[[117, 737, 334, 752]]
SQL> drop user HR;  

text[[116, 772, 880, 816]]
The prior command won't work if the user owns any database objects. Use the CASCADE clause to remove a user and have its objects dropped:  

text[[117, 835, 434, 850]]
SQL> drop user HR cascade;

--- Page 37 ---

sub_title[[119, 108, 215, 127]]
## 7. Quiz:  

text[[117, 141, 880, 187]]
1. If you create a user without specifying a temporary tablespace, what temporary tablespace will be assigned? (Choose the best answer).  

text[[147, 193, 577, 313]]
a) You must specify a temporary tablespace  
b) SYSTEM  
c) TEMP  
d) The database default temporary tablespace  
e) He/she will not have a temporary tablespace  

text[[117, 345, 880, 390]]
2. Which of these statements about system privileges are correct? (Choose all correct answers).  

text[[147, 397, 740, 417]]
a) Only the SYS and SYSTEM users can grant system privileges.  

text[[148, 423, 880, 468]]
b) If a system privilege is revoked from a user, it will also be revoked from all users to whom he granted it.  

text[[147, 474, 879, 518]]
c) If a system privilege is revoked from a user, it will not be revoked from all users to whom she granted it.  

text[[148, 525, 524, 543]]
d) CREATE TABLE is a system privilege.  

text[[147, 550, 570, 569]]
e) CREATE ANY TABLE is a system privilege.  

text[[117, 600, 879, 620]]
3. Which of these statements is incorrect regarding roles? (Choose the best answer).  

text[[147, 626, 832, 645]]
a) You can grant object privileges and system privileges and roles to a role.  

text[[148, 652, 595, 670]]
b) A role cannot have the same name as a table.  

text[[147, 678, 590, 695]]
c) A role cannot have the same name as a user.  

text[[146, 703, 635, 721]]
d) Roles can be enabled or disabled within a session.

--- Page 38 ---

text[[117, 106, 880, 150]]
4. Which of these can be controlled by a password profile? (Choose all correct answers).  

text[[147, 157, 630, 253]]
a) Two or more users choosing the same password  
b) Preventing the reuse of a password by the same user  
c) Forcing a user to change password  
d) Enabling or disabling password file authentication  

text[[117, 284, 820, 303]]
5. All passwords created in Oracle Database are not case-sensitive by default.  

text[[147, 311, 232, 353]]
a) True  
b) False  

text[[118, 386, 556, 404]]
6. A database role: (Choose all correct answers).  

text[[148, 412, 567, 509]]
a) Can be enabled or disabled  
b) Can consist of system and object privileges  
c) Is owned by its creator  
d) Cannot be protected by a password  

text[[118, 540, 880, 583]]
7. With RESOURCE_LIMIT set at its default value of FALSE, profile password limitations are ignored.  

text[[148, 592, 232, 634]]
a) True  
b) False  

text[[118, 668, 395, 685]]
8. A database user account is:  

text[[147, 693, 880, 840]]
a) A named set of resource limits on database usage  
b) An authentication by the Oracle database.  
c) A right to execute a particular type of SQL statement or to access another user's object.  
d) A named group of related privileges that are granted to users or to other roles.  
e) A way to organize the ownership of and access to database objects.

--- Page 39 ---

text[[117, 106, 544, 124]]
9. Users can access only accounts with status?  

text[[147, 132, 364, 230]]
a) Locked and Expired  
b) Locked  
c) Open  
d) Expired  

text[[117, 259, 574, 277]]
10. Who is the user that owns the data dictionary?  

text[[147, 285, 298, 404]]
a) SYS  
b) SYSTEM  
c) SYSBACKUP  
d) SYSDG  
e) SYSKM  

text[[119, 440, 301, 457]]
11. Common users:  

text[[147, 466, 695, 559]]
a) Are same as local users  
b) Have SYSDBA privilege  
c) Exist in one pluggable database  
d) Span all pluggable databases within a container database  

text[[119, 590, 733, 609]]
12. What is the wrong statement regarding the Authentication types?  

text[[147, 616, 640, 740]]
a) Operating system authentication (for administrators)  
b) Remote Desktop connection authentication  
c) Password authentication (for users)  
d) External authentication (for users)  
e) Global authentication (for users)  

text[[119, 770, 880, 814]]
13. OS authentication takes precedence over password file authentication for privileged users?  

text[[147, 822, 230, 863]]
a) True  
b) False

--- Page 40 ---

text[[117, 106, 623, 124]]
14. Password authentication is encrypted and stored in?  

text[[147, 132, 407, 227]]
a) The Data Dictionary  
b) The Shared Global Area  
c) The Program Global Area  
d) The Shared Pool Area  

text[[117, 259, 722, 278]]
15. What is the true statement for revocation of a system privilege?  

text[[147, 285, 480, 379]]
a) Won't be allowed  
b) Will be allowed only for SYS user  
c) Will be cascaded  
d) Won't be cascaded  

text[[117, 411, 624, 430]]
16. What are the statements of types of user privileges?  

text[[147, 438, 360, 532]]
a) System privileges  
b) SQL DDL privileges  
c) Object privileges  
d) SQL DCL privileges  

text[[117, 564, 705, 583]]
17. What is the wrong statement regarding the benefits of Roles?  

text[[147, 591, 480, 686]]
a) Easier privilege management  
b) Static privilege management  
c) Dynamic privilege management  
d) Selective availability of privileges  

text[[117, 719, 725, 737]]
18. Schema Only Accounts that can be created without passwords?  

text[[147, 745, 232, 788]]
a) True  
b) False

--- Page 41 ---

text[[118, 105, 760, 123]]
19. Choose the correct statement that describe the following command:  

sub_title[[147, 131, 595, 148]]
## SQL> create user app1 NO AUTHENTICATION;  

text[[146, 157, 534, 253]]
a) Adding privileges to the user app1  
b) Creation a User Account with password  
c) Creation a Schema Only Account  
d) Creation a Privileged User  

text[[117, 284, 881, 328]]
20. You can't modify a default permanent tablespace, and temporary tablespace after creation a user?  

text[[146, 334, 228, 351]]
a) True  

text[[147, 359, 230, 376]]
b) False

--- Page 42 ---

table[[114, 99, 735, 656]]
<table>Quiz answers - chapter 71d2c, d, e3b4b, c5b6a, b7b8e9c10a11d12b13a14a15d16a, c17b18a19c20b</table>

--- Page 43 ---

sub_title[[120, 108, 260, 126]]
## References:  

sub_title[[119, 142, 183, 158]]
## Books  

text[[147, 166, 881, 338]]
1. Oracle Database Administrator's Guide, 18c (Oracle University), March 2019, Primary Author: Rajesh Bhatiya, Randy Urbano  
2. database-new-features-guide (Oracle University), 18c E88909-01 February 2018, Primary Authors: Tanaya Bhattacharjee, Sunil Surabhi, Mark Baue  
3. The Cloud DBA-Oracle: Managing Oracle Database in the Cloud - First Edition, Abhinivesh Jain and Niraj Mahajan. Apress - ISBN-13 (pbk): 978-1-4842-2634-6 ISBN-13 (electronic): 978-1-4842-2635-3  

sub_title[[119, 369, 217, 386]]
## Web Sites  

text[[147, 394, 817, 516]]
1. https://docs.oracle.com/database  
2. https://docs.oracle.com/en/database/oracle/oracle-database/19/whats-new.html  
3. http://www.oracle.com/technetwork/database/enterprise-edition/downloads/index.html
