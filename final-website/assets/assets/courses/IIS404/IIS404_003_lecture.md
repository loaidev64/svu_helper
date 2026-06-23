--- Page 1 ---

# Bachelor of IT Program BAIT  

# MS SQL Server Administration IIS404  

Chapter three  

High Availability & Disaster Recovery  

Eng. Ayham Mohammad

--- Page 2 ---

## Contents  

1. Intro. 1  
2. High Availability (HA) vs. Disaster Recovery (DR) 2  
3. SQL Server HA & DR Solutions 2  
3.1. Log Shipping 3  
3.2. Replication 4  
3.2.1. Snapshot Replication 4  
3.2.2. Transactional Replication 5  
3.2.3. Merge Replication 5  
3.3. Database Mirroring 5  
3.4. Always On Failover Cluster Instances 7  
3.5. Always On availability groups AG 8  
3.5.1. AG Terms & Definitions 8  
3.5.2. AG Failover Types 9  
3.5.3. Configuring AlwaysON Demo 10

--- Page 3 ---

## 1. Intro  

Armed with the knowledge that everything can fail; you should build in redundancy where possible. The sad reality is that these decisions are governed by budget constraints. The amount of money available is inversely proportional to the amount of acceptable data loss and length of downtime. For business- critical systems, however, uptime is paramount, and a highly available solution will be more cost effective than being down, considering the cost- per- minute to the organization.  

Availability can be measured relative to "100% operational". A widely- held but difficult- to- achieve standard of availability for a system or product is known as "five 9s" (99.999 percent) availability.  

It is nearly impossible to guarantee zero downtime with zero data loss. There is always a trade- off. The business decides on that trade- off, based on resources (equipment, people, money), and the technical solution is in turn developed around that trade- off. The business drives this strategy using two values called the Recovery Point Objective and Recovery Time Objective, which are defined in a Service- Level Agreement (SLA).  

## Recovery Point Objective  

A good way to think of Recovery Point Objective (RPO) is "How much data are you prepared to lose?" When a failure occurs, how much data will be lost between the last transaction log backup and the failure? This value is usually measured in seconds or minutes.  

## Recovery Time Objective  

The Recovery Time Objective (RTO) is defined as how much time is available to bring the environment up to a known and usable state after a failure. There might be different values for HA and disaster recovery scenarios. This value is usually measured in hours.

--- Page 4 ---

## 2. High Availability (HA) vs. Disaster Recovery (DR) 

يجب الأخذ بعين الإعتبار معياري الـ RTO، (الزمن السموح إستغراقه لعودة الخدمة للعمل) (RPO) (كمية البيانات السموح ضياعها) 

- (عند العمل على الـ DR) 

- كل ما خفضنا الـ Down Time سيتطلب ذلك تكلفة مادية أعلى 

- فكرة الـ HA فكرة وقائية تعتمد على إبقاء السيرفر Online قدر الإمكان (Available) 

بينما فكرة الـ DR فكرة علاجية 

HA is not disaster recovery (DR). They are often grouped under the same heading (HA/DR), mainly because there are shared technology solutions for both concepts, but HA is about keeping the service running, whereas DR is what happens when the infrastructure fails entirely. DR is like insurance: you don't think you need it until it's too late. HA costs more money, the shorter the RPO. 

- HA goal is to mitigate the downtime of the system. 

- DR deals with situations when a system needs to be recovered after a disaster, which was not prevented by the high availability strategy in use.

--- Page 5 ---

## 3. SQL Server HA & DR Solutions  

- Log shipping (DR almost)- Replication (DR & HA partially)- Database mirroring (will be removed in future versions, DR)- Always On Failover Cluster Instances- Always On availability groups

--- Page 6 ---

### 3.1. Log Shipping 

تعتمد على فكرة أن ال Server الأول (ال Primary) نريد أن نعمل منه نسخ 

متاحة للاستخدام في حالة وقوعه و توقفه عن العمل ، حيث نعمل 

لن لBackup Log file عبر نسخها إلى Shared Folder ممكن لسيرفر الثاني أو 

الثالث القيام ب Restore Log منه 

حيث عند توقف ال Primary Server عن العمل نقوم بالإنتقال الثنائي أو الثالث 

بشكل يدوي 

 

- يقوم ال Backup لـ SQL Agent بجدولة أعمال العمليات (Jobs) بين ال Server: 

(1) نقل ال Backup من ال Server الأول لمجلد مشترك 

(2) نقل ال Backup من المجلد المشترك لمجلد المشترك ال Server الثاني 

(3) من المجلد المشترك لسيرفر الثاني لـ Server Restore 

و نضع بعدها ال Secondary Server / إحدى الحالتين (Standby) يعني لا يعمل و لكن جاهز للعمل في حال وقوع السيرفر الأساسي — أو Backup ممكن استخدامه لـ Read-Only 

- تكون طريقة ال Log Shipping متاحة على كل نسخ ال Server و متاحة على اللينكس 

- يجب أن تذكر أن نوع ال Simple Recovery لن يعمل معنا في هذه الحالة، لأنه لا يقوم ب Restore Log 

- يطلق على عملية الإنتقال لسيرفر الثاني أو الثالث في حال وقوع الأول ب Failover و تكون يدوية 

- مثال عن ال Log Shipping 

Use master 

Go 

Drop database if exists shipDB 

Go 

Create database shipDB on 

( name='ShipDB_Data', Filename='EsvuBait\.ShipDB_data.mdf' ) 

Log on (name='ShipDB_Log', Filename='EsvuBait\.ShipDB_log.ldf' ) 

Go 

4 | Page

--- Page 7 ---

Use ShipDB
Go 

Create table shiptable (id int primary key ) 

:Shared Folder على السيرفر الأول الى الـ Backup نقوم ب 

Backup Database ShipDB to Disk = 'E:\svu\bait\Demo\...\ShipDBFB.bak ' 

تم على السيرفر الثاني: نقوم ب Restore من نوع Restore و نحدد أن تكون عملية الـ Shared Folder من الـ Database 

: With Norecovery 

Restore Database ShipDB from Disk = 'E:\svu\bait\Demo\...\ShipDBFB.bak ' with norecovery 

: تم نقوم بنقل ملفات الـ Database إلى مكان خاص بالسيرفر الثاني 

Move "ShipDB_Data' to 'G:\new_DB\...\ShipDB_mirror_data.mdf', 

Move "ShipDB_Data' to 'G:\new_DB\...\ShipDB_mirror_log.ldf', 

Norecovery 

و نستطيع القيام بالعمليات السابقة من Backup و Restore من والـ Shared Folder باستخدام الـ GUI كما قام الدكتور في المحاضرة أيضا 

و يجب ملاحظة أنه عند الوصول لخطوة الـ Restore من طريق الـ GUI يتم سؤالنا عن الوضع المراد وضعها به بعد عملية Restore حيث يكون لدينا وضعين متاحين: No Recovery mode (1: يعنى إبقائها Standard by mode (2 Offline ) Restore لـ 

وضعها بحالة Read Only 

: نقوم بإدخال بعض المعلومات الـ DB في السيرفر الأول 

Insert into shiptable values (1000) 

تم ننتظر 15 دقيقة ليقوم السيرفر الأول بعملية Backup ماتمته 

الـ Job في SQL Server Agent هو المسؤول عن أتمته العمليات و جدولتها، مثل جدولة عملية الـ Backup 

حيث يكون الوقت الافتتاضي للـ Backup كل 15 دقيقة، و لاجراء Backup فوري نقوم بالدخول الى Jobs من منسذة الـ SQL

--- Page 8 ---

فريى Backup و اختيار LSBackup ShipDB و من ثم الضغط باليمين على ال Server Agent 

Use ShipDB
Select * from shiptable 

Like Always On availability groups and database mirroring, log shipping operates at the database level. SQL Server Transaction Log Shipping is an extremely flexible technology to provide a relatively inexpensive and easily managed HA and DR solution. 

The principle is as follows: a primary database is in either the Full or Bulk Logged recovery model, with transaction log backups being taken regularly every few minutes. These transaction log backup files are transferred to a shared network location, where one or more secondary servers restore the transaction log backups to a standby database. 

A log shipping configuration does not automatically fail over from the primary server to the secondary 

 

server. If the primary database becomes unavailable, any of the secondary databases can be brought online manually. You can use a secondary database for reporting purposes. In addition, you can configure alerts for your log shipping configuration. 

If you use the built-in Log Shipping Wizard in SQL Server Management Studio, on the Restore tab, click Database State When Restoring Backups, and then choose the No Recovery Mode or Standby Mode option (https://docs.microsoft.com/sql/database-engine/logshipping/configure-log-shipping-sql-server). 

If you are building your own log shipping solution, remember to use the RESTORE feature with NORECOVERY, or RESTORE with STANDBY.

--- Page 9 ---

If a failover occurs, the tail of the log on the primary server is backed up the same way (if available—this guarantees zero data loss of committed transactions), transferred to the shared location, and restored after the latest regular transaction logs. The database is then put into RECOVERY mode (which is where crash recovery takes place, rolling back incomplete transactions and rolling forward complete transactions).

--- Page 10 ---

As soon as the application is pointed to the new server, the environment is back up again with zero data loss (tail of the log was copied across) or minimal data loss (only the latest shipped transaction log was restored). 

Log Shipping is a feature that works on all editions of SQL Server, on Windows and Linux. However, because Express edition does not include the SQL Server Agent, Express can be only a witness, and you would need to manage the process through a separate scheduling mechanism. You can even create your own solution for any edition of SQL Server, using Azure Blob Storage and AzCopy.exe, for instance. 

### 3.2. Replication 

**Publisher** وحددة موجودة عند ال Master Database تعتمد على مبدأ وجود 

**ل** عن طريق ال **Subscribers (ل** و نقلها إلى الافرع الأخرى **Customers** يتم بها إنشاء ال **Distributor** 

Replication is a set of technologies for copying and distributing data and database objects from one database to another and then synchronizing between databases to maintain consistency. 

Use replication to distribute data to different locations and to remote or mobile users over local and wide area networks, dial-up connections, wireless connections, and the Internet. 

 

له ثلاث أنواع: 

:Snapshot Replication (1) 

يتم نقل كل ال **Distributor** إلى ال **Subscriber** (تم عملية 

(Overwrite 

Transactional Replication (2) 

Merge Replication (3) 

 

### 3.2.1. Snapshot Replication 

خصائصها: 

تكون المزامنة بإتجاه واحد من ال **Publisher** و ال **Distributor** بإتجاه ال **Subscribers** 

**Subscribers** 

تكون كل فترة معينة (2) 

**Subscribers** عند ال **Up-to-date** ل تكون المعلومات (3) 

8 | P a g e

--- Page 11 ---

Replication  اىل  استخدا م  األول  الخيار  اىل  Snapshot Replication  يكون  -  اىل  معلوماتهم  مع  جداول  بعرسال  يقومو  لكى  معينة  حاالت  فى  Publishers  كى  Subscribers  اىل  تعيين  ممكن  -  الحالة  هذه  فى  Subscriber  يعمل  اذلي 

Provides the initial data set for transactional and merge replication; It can also be used when complete refreshes of data are appropriate. 

Using snapshot replication by itself is most appropriate when one or more of the following is true: 

• Data changes infrequently. 

• It is acceptable to have copies of data that are out of date with respect to the Publisher for a period of time. 

• Replicating small volumes of data. 

• A large volume of changes occurs over a short period of time.

--- Page 12 ---

### 3.2.2. Transactional Replication 

Applied where high latency is not allowed, such as an OLTP system for a bank, because you always need real-time updates of cash or stocks. 

Typically used in server-to-server scenarios that require high throughput, including: 

- improving scalability and availability; 

- data warehousing and reporting; 

- integrating data from multiple sites; 

- integrating heterogeneous data; 

### 3.2.3. Merge Replication 

- تكون بإتجاهين 

- يقبل عدم وجود PK لكل جدول، حيث سيتم إنشاء GUID لكل جدول و سيتم الإعتماد عليه 

- تتميز بأن ال Publisher و Subscriber سيتبقى تعمل ك Subscriber و Publisher طول الوقت مع استخدام Replication بالإتجاهين 

مثال عن ال Merge Replication: 

Use master 

Go 

Drop database if exists IIS404R 

Go 

Create database IIS404R on 

( name='IIS404R_Data', Filename='Esvu\bait\.IIS404R_data.mdf' ) 

Log on (name='IIS404R_Log', Filename='Esvu\bait\.IIS404R_log.ldf' ) 

Go 

Use IIS404R 

Go 

Create table ReplicationTable (id int primary key) 

Create table noReplicationTable (id int)

--- Page 13 ---

بعد انشاء جدولين في الـ DB نبدأ بعملية الـ 

حيث نقوم بإنشاء New Publisher, Distributor, New Publisher 

عن طريق مجلد الـ Replication, نقوم باختيار انشاء New Publisher و من ضمن خطواته يتم إنشاء الـ Distributor 

و من ضمن الخطوات يتم تحديد موقع حفظ الـ Snapshot Replication الأولية 

و من ثم تحديد نوع الـ Publication : (سنتكار نوع الـ Transactional ) 

 

و من ثم نحدد الـ Objects المراد عمل Replication لهم ( لن نستطيع تحديد الجدول noReplicationTable بسبب عدم 

احتوائه على أي PK

--- Page 14 ---

و عند الإنتهاء سنظهر لدينا في
السيبرف الأول كالتالي: 

 

حيث نقوم في الخطوات بتحديد ال Publisher المراد الإرتباط معه ( تحديد ال Publisher الذي أنشأه منذ قليل على السيرف الأول ) 

ثم نقوم بتحديد ال DB التي سيتم النسخ عليها لدى ال Subscriber ( تحديد واحدة موجودة أو إنشاء جديدة ) 

للتأكد بعد الإنتهاء، نقوم بإدخال قيمة 1000 للجدول Replication Table لدى ال Publisher 

ثم نستعلم عن معلومات بيانات الجدول نفسه لدى ال Subscriber 

Merge replication, like transactional replication, typically starts with a snapshot of the publication database objects and data. Subsequent data changes and schema modifications made at the Publisher and Subscribers are tracked with triggers. 

The Subscriber synchronizes with the Publisher when connected to the network and exchanges all rows that have changed between the Publisher and Subscriber since the last time synchronization occurred.

--- Page 15 ---

### 3.3. Database Mirroring 

① Note 

This feature will be removed in a future version of Microsoft SQL Server. Avoid using this feature in new development work, and plan to modify applications that currently use this feature. Use Always On availability groups instead. 

- High-performance mode: Asynchronously and uses only the principal server and mirror server. (With possible data loss) not supported in 2017. 

- High-safety mode: Synchronously and, optionally, uses a witness. 

هي صورة عن ال DB (خاصة صورة عن ال Publisher). و لا تكون Readable حيث عند وقوع ال Principle Server سيتم عمل ال Mirror Server. 

و لها خيار إضافة سيرفر من نوع Witness لكي تصبح عملية ال Fail Over أوتومايكية 

- لتفعيل ال Mirror Server معيّنة. نضغط باليمين عليها و نختار Mirror في النسخ القديمة: لكن في النسخ الحديثة، يجب القيام بحركة معيّنة عن طريق Script لتفعيلها. (نقوم بإضافة Partner لكل طرف بشكل Script) 

Alter Database db_name 

Set partner = 'TCP://SQL:5022' 

5 | P a g e

--- Page 16 ---

## WCF & AG  

## Clustering  

Clustering is the connecting of computers (nodes) in a set of two or more nodes, that work together and present themselves to the network as one computer. In most cluster configurations, only one node can be active in a cluster. To ensure that this happens, a quorum instructs the cluster as to  

  

which node should be active. It also steps in if there is a communication failure between the nodes.  

Each node has a vote in a quorum. However, if there is an even number of nodes, to ensure a simple majority an additional witness must be included in a quorum to allow for a majority vote to take place.  

## Windows Server Failover Cluster  

Windows Server Failover Cluster  

CRM- Cluster 或 Linux 或 Windows Server 或 Failover Cluster 或 Resource Manager  

As Microsoft describes it:  

"Failover clusters provide high availability and scalability to many server workloads. These include server applications such as Microsoft Exchange Server, Hyper- V, Microsoft SQL Server, and file servers. The server applications can run on physical servers or virtual machines. [Windows Server Failover Clustering] can scale to 64 physical nodes and to 8,000 virtual machines."  

(https://technet.microsoft.com/library/hh831579(v=ws.11).aspx).  

The terminology here matters. Windows Server Failover Clustering is the name of the technology that underpins a Failover Cluster Instance (FCI), where two or more Windows Server Failover Clustering nodes (computers) are connected together in a Windows Server Failover Clustering resource group and masquerade as a single machine behind a network endpoint called a Virtual Network Name (VNN). A SQL Server service that is installed on an FCI is cluster- aware.

--- Page 17 ---

6 | P a g e

--- Page 18 ---

## How long does the FCI failover take? 

During a planned failover, any dirty pages in the buffer pool must be written to the drive; thus, the downtime could be longer than expected on a server with a large buffer pool. 

On Linux, the principle is very similar. A cluster resource manager such as Pacemaker manages the cluster, and when a failover occurs, the same process is followed from SQL Server's perspective, in which the first node is brought down and the second node is brought up to take its place as the owner. The cluster has a virtual IP address, just as on Windows. You must add the virtual network name manually to the DNS server. 

### 3.5. Always On availability groups AG 

 

- تكون هذه التقنية على مستوى ال Server و ال Database 

- يكون لدينا Primary Replica عليها ال DB التي تكون قابلة للقراءة و الكتابة, بالإضافة لحد 8 إضافية ( ممكن أن يكون Read-Only و ممكن أن يكون حتى غير قابلين للقراءة, كأن تستخدمهم لاستخدامات معينة ) 

- حيث حين وضع ال Secondary Replica كد Read-Only يتم توزيع الحمل بين ال Replicas عند طلب قراءة من ال DB ( Load Balancing ) 

و يكون ال اؤيضا اوتوماتيكي 

- لها نوعان: 

( غير متزامن) يستخدم مع المسافات البعيدة و يعتبر من حلول ال DR ( Asynchronous ) 

( متزامن) يستخدم مع المسافات القريبة و يعتبر من حلول ال HA ( Synchronous ) 

A high-availability and disaster-recovery solution that provides an enterprise-level alternative to database mirroring. It maximizes the availability of a set of user databases for an enterprise.

--- Page 19 ---

Supports a failover environment for a discrete set of user databases, known as availability databases that fail over together. Supports a set of read- write primary databases and one to eight sets of corresponding secondary databases. Optionally, secondary databases can be made available for read- only access and/or some backup operations. An availability group fails over at the level of an availability replica. Installing SQL Server is by using install standalone instance per replica.  

#### 3.5.1. AG Terms & Definitions  

- Availability group: A container for a set of databases, availability databases, that fail over together.  
- Availability database: A database that belongs to an availability group  
- Primary database: The read-write copy of an availability database.

--- Page 20 ---

- Secondary database: A read-only copy of an availability database.  

- Availability replica: An instantiation of an availability group that is hosted by a specific instance of SQL Server and maintains a local copy of each availability database that belongs to the availability group.  

- Two types of availability replicas exist: a single primary replica and one to eight secondary replicas.  

- Primary replica: The availability replica that makes the primary databases available for read-write connections from clients and, also, sends transaction log records for each primary database to every secondary replica.  

- Secondary replica: An availability replica that maintains a secondary copy of each availability database, and serves as a potential failover targets for the availability group. Optionally, a secondary replica can support read-only access to secondary databases can support creating backups on secondary databases.  

- Availability group listener: A server name to which clients can connect in order to access a database in a primary or secondary replica of an Always On availability group. Availability group listeners direct incoming connections to the primary replica or to a read-only secondary replica.  

- AG Supports alternative availability modes, as follows:  

- Asynchronous-commit mode: a disaster-recovery solution that works well when the availability replicas are distributed over considerable distances.- Synchronous-commit mode: emphasizes high availability and data protection over performance, at the cost of increased transaction latency.  

#### 3.5.2. AG Failover Types  

Planned manual failover (without data loss): Occurs after a database administrator issues a failover command and causes a synchronized secondary replica to transition to the primary role (with guaranteed data protection) and the primary replica to transition to the secondary role. A manual failover requires that both the primary replica and the target secondary replica are running under synchronous- commit mode, and the secondary replica must already be synchronized.  

Automatic failover (without data loss): Occurs in response to a failure that causes a synchronized secondary replica to transition to the primary role (with guaranteed data protection). When the former primary replica becomes available, it transitions to the secondary role. Automatic failover requires that both the primary replica and the target secondary replica are running under

--- Page 21 ---

synchronous- commit mode with the failover mode set to "Automatic". In addition, the secondary replica must already be synchronized, have WSFC quorum, and meet the conditions specified by the flexible failover policy of the availability group. 

### 3.5.3. Configuring AlwaysON Demo 

**:Failover Cluster** ال **مثال عن تطبيق** 

1. We need 3 Servers running Windows Server. 

2. One is a DC, the others are SQL Nodes (SQLNode01, SQLNode02). 

3. Install and Configure Windows failover cluster on the nodes.

--- Page 22 ---

4. If Firewall is active then add port #1433 & #5022 to the firewall.  

5. Install SQL Server on both nodes.  

6. Create a test Database on SQLNode01 then take a full backup and restore it on SQLNode02  

7. From SQL Server Configuration manager in both nodes, Set the properties of service and enable AlwaysON.  

<table><tr><td>SQL Server Configuration Manager (Local)</td><td>Name</td><td>State</td><td>Start Mode</td><td>Log On As</td><td>Process</td></tr><tr><td>SQL Server Services:</td><td>SQL Server Integr... Running</td><td>Automatic</td><td>NT Service\MsDtsServer110</td><td>1212</td><td></td></tr><tr><td>SQL Server Network Configuration (32bit)</td><td>SQL Server (MSS... Running</td><td>Automatic</td><td>TESTDOMAIN\sqlservice</td><td>1284</td><td></td></tr><tr><td>SQL Native Client 11.0 Configuration (32bit)</td><td>SQL Server Browser Stopped</td><td>Other (Boot, Syst...</td><td>NT AUTHORITY\LOCALSERVICE</td><td>0</td><td></td></tr><tr><td>SQL Server Network Configuration</td><td>SQL Server Agent... Running</td><td>Automatic</td><td>TESTDOMAIN\sqlservice</td><td>1876</td><td></td></tr><tr><td>SQL Native Client 11.0 Configuration</td><td></td><td></td><td></td><td></td><td></td></tr></table>

--- Page 23 ---

Create AlwaysON availability Group on SQLNode01

--- Page 24 ---

## References  

LeBlanc. P, Assaf. W, Jackson. B, Curnutt M; "SQL Server 2017 Administration Inside Out", Microsoft Press (2018).  

https://docs.microsoft.com/en- us/sql/sql- server/
