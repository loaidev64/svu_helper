--- Page 1 ---

title[[120, 307, 878, 403]]
# Oracle Database AdministrationI  

text[[150, 454, 847, 484]]
Chapter 4: Oracle Network Configuration

--- Page 2 ---

sub_title[[733, 149, 887, 170]]
## :  

text[[114, 209, 884, 620]]
Objectives .2 1. Oracle Net Services: Overview .3 2. Oracle Net Listener: Overview .4 3. Oracle Net Services user interface tools .5 4. Establishing Oracle Network Connections .7 5. Naming Methods .8 5.1. Easy connect naming .8 5.2. Local naming .9 5.3. Directory naming .13 5.4. External naming .13 5.5. Defining Oracle Net Services Components .14 6. Using the Listener Control Utility .15 7. Testing Oracle Net Connectivity .16 8. Comparing Dedicated Server and Shared Server Configurations .17 8.1. User Sessions: Dedicated Server Process .17 8.2. User Sessions: Shared Server Process .18 8.3. Shared Server Configuration Considerations .19 9. Quiz .20

--- Page 3 ---

sub_title[[117, 108, 253, 127]]
## Objectives:  

text[[148, 140, 845, 260]]
1. Oracle Net services mission  
2. Start and stop listener  
3. Create additional listener and reconfigure it  
4. Create a listener by using the Oracle Net Configuration Assistant (NetCA)  
5. Clients connection methods with database

--- Page 4 ---

sub_title[[119, 108, 520, 128]]
## 1. Oracle Net Services: Overview:  

image[[238, 173, 760, 428]]  

text[[114, 455, 884, 674]]
Oracle Net Services enables network connections from a client or middle- tier application to the Oracle server. After a network session is established, Oracle Net acts as the data courier for both the client application and the database server. It is responsible for establishing and maintaining the connection between the client application and database server, as well as exchanging messages between them. Oracle Net (or something that simulates Oracle Net, such as Java Database Connectivity) is located on each computer that needs to talk to the database server. On the client computer, Oracle Net is a background component for application connections to the database.  

text[[116, 682, 881, 750]]
On the database server, Oracle Net includes an active process called Oracle Net Listener, which is responsible for coordinating connections between the database and external applications.

--- Page 5 ---

sub_title[[117, 110, 515, 130]]
## 2. Oracle Net Listener: Overview:  

image[[177, 171, 804, 443]]  

text[[116, 474, 882, 547]]
Oracle Net Listener (or simply the listener) is the gateway to the Oracle instance for all nonlocal user connections. A single listener can service multiple database instances and thousands of client connections.  

text[[117, 551, 880, 596]]
You can use Enterprise Manager Cloud Control or Oracle Net Manager to configure the listener and specify log file locations.  

text[[116, 601, 882, 673]]
Advanced administrators can also configure Oracle Net Services by manually editing the configuration files, if necessary, with a standard operating system (OS) text editor such as vi  

text[[117, 681, 215, 695]]
or qedit.

--- Page 6 ---

sub_title[[117, 107, 629, 127]]
## 3. Oracle Net Services user interface tools:  

text[[116, 140, 880, 185]]
Oracle Net Services provides user interface tools and command- line utilities that enable you to easily configure, manage, and monitor the network.  

text[[117, 192, 879, 237]]
You can use Oracle Net Manager to configure the listener and specify log file locations, Then the Oracle net configuration assistant NetCA will start as the following:  

image[[346, 260, 652, 685]]

--- Page 7 ---

image[[181, 100, 816, 730]]

--- Page 8 ---

sub_title[[117, 108, 652, 128]]
## 4. Establishing Oracle Network Connections:  

text[[115, 141, 880, 159]]
To make a client or middle- tier connection, Oracle Net requires the client to know the:  

text[[147, 168, 608, 263]]
Host where the listener is running. Port that the listener is monitoring Protocol that the listener is using Name of the service that the listener is handling

--- Page 9 ---

sub_title[[120, 109, 358, 128]]
## 5.Naming Methods:  

text[[116, 142, 773, 159]]
Oracle Net supports several methods of resolving connection information:  

text[[150, 168, 808, 263]]
Easy connect naming: Uses a TCP/IP connect string Local naming: Uses a local configuration file Directory naming: Uses a centralized LDAP- compliant directory server External naming: Uses a supported non- Oracle naming service  

sub_title[[119, 295, 395, 313]]
## 5.1.Easy connect naming:  

text[[150, 325, 721, 501]]
Is enabled by default Requires no client- side configuration Supports only TCP/IP (no SSL) Offers no support for advanced connection options such as: Connect- time failover Source routing Load balancing  

sub_title[[117, 532, 204, 548]]
## Example:  

text[[116, 568, 679, 586]]
SQL>CONNECT hr/hr@db.us.oracle.com:1521/dba11g  

text[[115, 604, 880, 673]]
With Easy Connect, you supply all information that is required for the Oracle Net connection as part of the connect string. Easy Connect connection strings take the following form:  

text[[116, 691, 817, 708]]
<username>/password@hostname>:<listener port>/service name>  

text[[115, 725, 880, 818]]
The listener port and service name are optional. If the listener port is not provided, Oracle Net assumes that the default port of 1521 is being used. If the service name is not provided, Oracle Net assumes that the database service name and host name provided in the connect string are identical.

--- Page 10 ---

text[[117, 106, 881, 175]]
Assuming that the listener uses TCP to listen on port 1521 and the SERVICE_NAME=sdb and DB_DOMAIN=us.oracle.com instance parameters, the connect string shown in the slide can be shortened:  

text[[118, 194, 546, 211]]
SQL> connect hr/hr@db.us.oracle.com  

text[[117, 231, 881, 274]]
Note: Toad for Oracle is support connecting with easy connect method in a very interactive window.  

sub_title[[119, 308, 313, 325]]
### 5.2. Local naming:  

text[[118, 338, 545, 355]]
1. Requires a client-side names-resolution file  

text[[117, 363, 454, 380]]
2. Supports all Oracle Net protocols  

text[[116, 389, 577, 407]]
3. Supports advanced connection options such as:  

text[[177, 415, 411, 486]]
- Connect-time failover- Source routing- Load balancing  

text[[117, 504, 397, 521]]
SQL> CONNECT hr/hr@orcl  

text[[116, 541, 881, 611]]
With local naming, the user supplies an alias for the Oracle Net service. Oracle Net checks the alias against a local list of known services and, if it finds a match, converts the alias into host, protocol, port, and service name.  

text[[117, 617, 881, 660]]
One advantage of local naming is that the database users need to remember only a short alias rather than the long connect string required by Easy Connect.  

text[[118, 667, 819, 685]]
The local list of known services is stored in the following text configuration file:  

text[[117, 705, 604, 721]]
<oracle_home>/network/admin/tnsnames.ora  

text[[116, 741, 881, 785]]
This is the default location of the tnsnames.ora file, but the file can be located elsewhere using the TNS_ADMIN environment variable.  

text[[117, 792, 880, 836]]
Local naming is appropriate for organizations in which Oracle Net service configurations do not change often.

--- Page 11 ---

text[[120, 108, 684, 124]]
The following example display the content of the tnsnames.ora:  

image[[122, 128, 919, 447]]  

text[[119, 474, 879, 516]]
We can use netca "Net configuration Assistant" to change the content of tnsnames.ora automatically, as the in the attached video  

image[[150, 545, 846, 870]]

--- Page 12 ---

image[[195, 103, 800, 675]]

--- Page 13 ---

image[[138, 103, 860, 789]]

--- Page 14 ---

sub_title[[118, 107, 355, 126]]
### 5.3. Directory naming:  

text[[141, 137, 797, 156]]
- Requires LDAP with Oracle Net names resolution information loaded:  

text[[186, 165, 524, 258]]
- Oracle Internet Directory- Microsoft Active Directory Services- Supports all Oracle Net protocols- Supports advanced connection options  

sub_title[[118, 291, 208, 307]]
## Example:  

text[[117, 327, 398, 344]]
SQL> CONNECT hr/hr@orcl  

text[[115, 364, 881, 460]]
With directory naming, the user supplies an alias for the Oracle Net service. Oracle Net checks the alias against an external list of known services and, if it finds a match, converts the alias into host, protocol, port, and service name. Like local naming, database users need to remember only a short alias.  

text[[115, 467, 881, 586]]
One advantage of directory naming is that the service name is available for users to connect with as soon as a new service name is added to the LDAP directory. With local naming, the database administrator (DBA) must first distribute updated tnsnames.ora files containing the changed service name information before users can connect to new or modified services.  

text[[115, 594, 880, 639]]
Directory naming is appropriate for organizations in which Oracle Net service configurations change frequently.  

sub_title[[118, 673, 343, 691]]
### 5.4. External naming:  

text[[146, 702, 582, 720]]
- Uses a supported non-Oracle naming service  

text[[147, 730, 266, 746]]
Includes:  

text[[186, 755, 663, 773]]
Network Information Service (NIS) External Naming  

text[[185, 780, 855, 798]]
Distributed Computing Environment (DCE) Cell Directory Services (CDS)  

text[[115, 805, 880, 849]]
The external naming method stores Net Service names in a supported non- Oracle naming service.  

text[[117, 854, 656, 873]]
Conceptually, external naming is similar to directory naming.

--- Page 15 ---

sub_title[[117, 106, 606, 125]]
5.5. Defining Oracle Net Services Components: 

table[[97, 160, 898, 638]]
<table>ComponentDescriptionFileListenersA process that resides on the server whose responsibility is to listen for incoming client connection requests and manage the traffic to the server.listener.oraNaming methodsA resolution method used by a client application to resolve a connect identifier to a connect descriptor when attempting to connect to a database service.Naming (net service name)A simple name (connect identifier) for a service that resolves to a connect descriptor to identify the network location and identification of a service.tnsnames.ora (local configuration)ProfilesA collection of parameters that specifies preferences for enabling and configuring Oracle Net features on the client or server.sqlnet.ora</table>

--- Page 16 ---

sub_title[[117, 108, 550, 128]]
## 6. Using the Listener Control Utility:  

text[[116, 142, 881, 186]]
The Listener Control Utility enables you to control the listener. With lsnrctl, you can:  

text[[146, 195, 721, 340]]
- Start the listener- Stop the listener- Check the status of the listener- Reinitialize the listener from the configuration file parameters- Dynamically configure many listeners- Change the listener password  

text[[118, 347, 510, 363]]
The basic command syntax for this utility is:  

text[[300, 368, 686, 384]]
LSNRCTL> command [listener_name]  

text[[117, 394, 393, 444]]
LSNRCTL> <command name> LSNRCTL> start LSNRCTL> status  

text[[118, 462, 876, 499]]
Commands are: start, stop, status, services, version, reload, save_config, trace, spawn, quit, exit, set\*, show\*  

text[[117, 513, 881, 581]]
Remember that if your listener is named something other than LISTENER, you must either include the listener name with the command or use the SET CURRENT_LISTENER command.  

text[[118, 601, 880, 644]]
Suppose that your listener is named custom_lis. Here are two examples of stopping a listener named custom_lis by using prompt syntax:  

text[[117, 654, 803, 715]]
LSNRCTL> stop custom_lis Connecting to (DESCRIPTION \(\equiv\) (ADDRESS \(=\) (PROTOCOL \(=\) TCP) (HOST \(=\) host01) (PORT \(=\) 5521)) The command completed successfully  

text[[118, 735, 800, 844]]
This produces the same results as the following: LSNRCTL> set cur custom_lis Current Listener is custom_lis LSNRCTL> stop Connecting to (DESCRIPTION \(\equiv\) (ADDRESS \(=\) (PROTOCOL \(=\) TCP) (HOST \(=\) host01) (PORT \(=\) 5521)) The command completed successfully  

text[[117, 860, 792, 877]]
Note: In the preceding syntax, current_listener has been abbreviated to cur.

--- Page 17 ---

sub_title[[119, 108, 536, 128]]
## 7. Testing Oracle Net Connectivity:  

text[[117, 142, 631, 159]]
The tnsping utility that tests Oracle Net service aliases:  

text[[147, 168, 785, 185]]
- Ensures connectivity between the client and the Oracle Net Listener  

text[[148, 194, 660, 211]]
- Does not verify that the requested service is available  

text[[149, 220, 566, 236]]
- Supports Easy Connect Names Resolution:  

text[[208, 255, 646, 271]]
tnsping host01.example.com:1521/orcl  

text[[148, 291, 508, 308]]
- Supports local and directory naming:  

text[[209, 328, 356, 343]]
tnsping orcl

--- Page 18 ---

sub_title[[115, 108, 715, 159]]
## 8. Comparing Dedicated Server and Shared Server Configurations:  

text[[145, 172, 772, 191]]
Dedicated server configuration: One server process for each client  

text[[146, 199, 881, 244]]
Shared server configuration: A small pool of server processes can serve a large number of clients  

text[[115, 250, 880, 321]]
In a dedicated server configuration, a server process handles requests for a single client process. A shared server configuration enables multiple client processes to share a small number of server processes.  

sub_title[[116, 351, 603, 371]]
## 8.1. User Sessions: Dedicated Server Process:  

image[[193, 403, 789, 695]]  

text[[115, 726, 881, 794]]
With dedicated server processes, there is a one- to- one ratio of server processes to user processes. Each server process uses system resources, including CPU cycles and memory.  

text[[116, 802, 880, 847]]
In a heavily loaded system, the memory and CPU resources that are used by dedicated server processes can be prohibitive and can negatively affect the system's scalability.

--- Page 19 ---

text[[115, 105, 881, 150]]
If your system is being negatively affected by the resource demands of the dedicated server architecture, you have the following options:  

text[[146, 157, 880, 229]]
- Increasing system resources by adding more memory and additional CPU capability- Using the Oracle Shared Server Process architecture  

sub_title[[115, 260, 572, 280]]
### 8.2. User Sessions: Shared Server Process:  

image[[186, 313, 808, 593]]  

text[[113, 630, 881, 749]]
Each service that participates in the shared server process architecture has at least one dispatcher process (and usually more). When a connection request arrives, the listener does not spawn a dedicated server process. Instead, the listener maintains a list of dispatchers that are available for each service name, along with the connection load (number of concurrent connections) for each dispatcher.  

text[[115, 756, 880, 826]]
Connection requests are routed to the lightest loaded dispatcher that is servicing a given service name. Users remain connected to the same dispatcher for the duration of a session.  

text[[116, 834, 879, 877]]
Unlike dedicated server processes, a single dispatcher can manage hundreds of user sessions.

--- Page 20 ---

text[[114, 105, 883, 329]]
Dispatchers do not actually handle the work of user requests. Instead, they pass user requests to a common queue located in the shared pool portion of the SGA.Shared server processes take over most of the work of dedicated server processes, pulling requests from the queue and processing them until they are complete.Because a user session may have requests processed by multiple shared server processes, most of the memory structures that are usually stored in the PGA must be in a shared memory location (by default, pool). However, configured SGA_TARGET is set for automatic memory management, these memory structures are stored in the large pool portion of the SGA.  

sub_title[[117, 360, 628, 379]]
### 8.3. Shared Server Configuration Considerations:  

text[[115, 391, 804, 409]]
Certain types of database work must not be performed using shared servers:  

text[[147, 417, 560, 514]]
- Database administration- Backup and recovery operations- Batch processing and bulk load operations- Data warehouse operations  

image[[220, 555, 370, 650]]  

image[[616, 564, 727, 641]]

--- Page 21 ---

sub_title[[118, 108, 215, 127]]
## 9. Quiz:  

text[[119, 142, 596, 159]]
1. You connect to the database using the command:.  

text[[148, 168, 530, 187]]
sqlplus scott/tiger@abc.com:1522/orcl  

text[[149, 195, 536, 212]]
To which database are you connecting?  

text[[150, 220, 259, 237]]
a) abc.com  

text[[151, 245, 225, 262]]
b) tiger  

text[[152, 271, 217, 287]]
c) orcl  

text[[150, 296, 224, 312]]
d) scott  

text[[117, 345, 881, 390]]
2. What is the name of the piece of shared memory that client connections are bound to during communications via Shared Server?  

text[[150, 397, 371, 415]]
a) Program Global Area  

text[[151, 423, 364, 440]]
b) System Global Area  

text[[152, 449, 301, 465]]
c) Virtual Circuit  

text[[150, 474, 388, 491]]
d) Database Buffer Cache  

text[[118, 523, 881, 568]]
3. Your database is open and the listener LISTENER is running. The new DBA of the system stops the listener by using the command:  

text[[151, 575, 342, 592]]
LSNRCTL>STOP  

text[[150, 600, 880, 644]]
What happens to the sessions that are presently connected to the database instance?  

text[[149, 651, 553, 670]]
a) Sessions are able to perform only queries  

text[[151, 677, 707, 695]]
b) Sessions are not affected and continue to function normally  

text[[150, 703, 780, 720]]
c) Sessions are terminated and the active transactions are rolled back  

text[[149, 728, 857, 746]]
d) Sessions are not allowed to perform any operations till the listener is started

--- Page 22 ---

text[[114, 104, 881, 123]]
4. Which configuration files are used to configure the listener? (Choose two answers)  

text[[150, 132, 291, 149]]
a) listener.ora  

text[[152, 158, 296, 175]]
b) listener.conf  

text[[153, 184, 303, 200]]
c) tnsnames.ora  

text[[150, 210, 270, 226]]
d) sqlnet.ora  

text[[117, 258, 881, 304]]
5. When using the shared server process architecture, the UGA portion of the PGA is relocated into the SGA?  

text[[150, 312, 230, 329]]
a) True  

text[[152, 338, 235, 354]]
b) False  

text[[117, 385, 881, 430]]
6. Which is the Name Resolution Method that doesn't support advanced connection options?  

text[[150, 439, 327, 456]]
a) External naming  

text[[152, 465, 375, 483]]
b) Easy Connect naming  

text[[153, 491, 300, 508]]
c) Local naming  

text[[150, 517, 334, 534]]
d) Directory naming  

text[[117, 565, 713, 584]]
7. What are the two correct statements about the Shared Server?  

text[[149, 592, 881, 637]]
a) When a connection request arrives, the listener spawns a dedicated server process  

text[[150, 644, 880, 689]]
b) Each service that participates in the shared server architecture has at least one dispatcher process  

text[[149, 696, 881, 741]]
c) When a connection request arrives, the listener does not spawn a dedicated server process  

text[[150, 748, 880, 791]]
d) Connection requests are routed to the highest loaded dispatcher that is servicing a given service name

--- Page 23 ---

text[[117, 106, 750, 124]]
8. Which of the following is not correct related to Oracle Net Listener?  

text[[146, 131, 808, 228]]
a) Is the gateway to the Oracle instance for all local user connections  
b) Is the gateway to the Oracle instance for all nonlocal user connections  
c) A single listener can service multiple database  
d) A single listener can service thousands of client connections  

text[[117, 260, 628, 278]]
9. Which are the two true statements about Oracle Net?  

text[[147, 285, 683, 380]]
a) Is located on each client computer  
b) Is checked at the time of commit  
c) Oracle Net is not responsible for maintaining the session  
d) Is located on the database server  

text[[119, 412, 829, 432]]
10. Which is the incorrect option regarding listener configuration requirements?  

text[[147, 439, 723, 534]]
a) Network protocol  
b) Name or IP address of the server that the listener will run on  
c) Operating System of the server that the listener will run on  
d) Port that you want the listener to monitor  

text[[120, 565, 347, 583]]
11. What is Oracle Net?  

text[[147, 591, 816, 687]]
a) It is background component for application connections to the database  
b) It is an original protocol used through internet  
c) It doesn't include an active process called the Oracle Net Listener  
d) It is a Parameter file  

text[[120, 719, 689, 737]]
12. The Listener Control Utility doesn't enables you to control?  

text[[147, 745, 735, 839]]
a) Starting the listener  
b) Stopping the listener  
c) Checking the status of the SYS user  
d) Reinitializing the listener from the configuration file parameters

--- Page 24 ---

text[[117, 106, 539, 124]]
13. With dedicated server processes, there is:  

text[[145, 131, 685, 227]]
a) one-to-four ratio of server processes to user processes  
b) one-to-one ratio of server processes to user processes  
c) one-to-two ratio of server processes to user processes  
d) one-to-three ratio of server processes to user processes  

text[[117, 259, 757, 278]]
14. Database administration must be performed using shared servers?  

text[[147, 285, 232, 329]]
a) True  
b) False  

text[[118, 360, 780, 379]]
15. Database administration must be performed using dedicated servers?  

text[[146, 387, 231, 431]]
a) True  
b) False  

text[[117, 464, 880, 508]]
16. In the shared server process architecture, When a connection request arrives, the listener:  

text[[147, 516, 496, 634]]
a) spawns a dedicated server process  
b) Doesn't have any action  
c) the listener maintains a list of dispatchers that are available for each service name  
d) all the other options  

text[[117, 667, 880, 710]]
17. What is the Oracle Net names resolution method that requires LDAP with information loaded:  

text[[147, 718, 375, 814]]
a) Easy connect naming  
b) Local naming  
c) Directory naming  
d) External naming

--- Page 25 ---

text[[118, 105, 880, 150]]
18. After a network session is established, Oracle Net acts as the data courier for both the client application and the database server?  

text[[148, 158, 234, 175]]
a) True  

text[[149, 185, 230, 201]]
b) False  

text[[118, 233, 881, 278]]
19. To make a client or middle-tier connection, Oracle Net doesn't require the client to know the:  

text[[148, 285, 480, 378]]
a) Host where the listener is running  
b) Port that the listener is monitoring  
c) Protocol that the listener is using  
d) Listener name  

text[[118, 411, 836, 430]]
20. Which is the naming resolution methat that has the a connection string like:  

text[[148, 438, 690, 458]]
- SQL>CONNECT hr/hr@db.us.oracle.com:1521/dba11g?  

text[[149, 466, 374, 559]]
a) Easy connect naming  
b) Local naming  
c) Directory naming  
d) External naming

--- Page 26 ---

table[[184, 100, 805, 656]]
<table><td colspan="2">Quiz answers - chapter 41c2b3b4a, d5a6b7b, c8a9a, d10c11a12c13b14b15a16c17c18a19d20a</table>
