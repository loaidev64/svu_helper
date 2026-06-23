--- Page 1 ---

title[[120, 308, 878, 351]]
# Oracle Database Administration  

text[[484, 372, 515, 402]]
I  

text[[132, 530, 865, 560]]
Chapter 1 :Cloud Computing Fundamentals

--- Page 2 ---

sub_title[[732, 149, 884, 170]]
محتويات الفصل: 

text[[117, 210, 880, 226]]
Objectives ........................................................................................................................................ 2 

text[[118, 234, 881, 250]]
1. What Is Cloud Computing? .................................................................................................. 3 

text[[116, 258, 882, 274]]
2. Benefits of Cloud Computing ............................................................................................... 4 

text[[117, 282, 880, 298]]
3. Challenges of Cloud Computing ...................................................................................... 5 

text[[118, 305, 881, 321]]
4. Cloud Computing Service Models .................................................................................... 6 

text[[116, 329, 882, 344]]
5. Cloud Deployment Models ............................................................................................... 8 

text[[117, 352, 880, 367]]
6. Metering and Chargeback .................................................................................................. 12 

text[[118, 375, 881, 391]]
7. Cloud Security Model ........................................................................................................... 13 

text[[116, 398, 882, 414]]
8. Quiz ........................................................................................................................................ 15

--- Page 3 ---

sub_title[[117, 108, 253, 127]]
Objectives: 

text[[150, 141, 450, 158]]
1. The cloud computing concepts 

text[[149, 168, 377, 185]]
2. Database as a service 

text[[148, 194, 430, 211]]
3. Definition of cloud computing 

text[[147, 220, 460, 237]]
4. Challenges of Cloud Computing

--- Page 4 ---

sub_title[[120, 108, 471, 128]]
## 1.What Is Cloud Computing?  

text[[115, 141, 884, 312]]
Cloud computing is more of a pay- as- you- go model, compared to a do- it- yourself (DIY) model. You just pay for computing resources for the duration of your use. You are not concerned with how these computing resources are hosted or managed. In database terms, you will get your database up and running very quickly. You don't need to worry about procurement of server, configuration, and installation of various software, or with, maintaining the datacenter, infrastructure, hardware, or operating system.  

text[[115, 344, 881, 440]]
Definition of Cloud Computing (given by the National Institute of Standards and Technology): It's essentially a web- based service for computing resources, including server, network, storage, and applications. This service is ubiquitous and provided as on- demand basis.

--- Page 5 ---

sub_title[[117, 107, 506, 128]]
## 2. Benefits of Cloud Computing:  

text[[115, 140, 884, 286]]
Companies have traditionally believed in owning the assets and managing them on their own, but this model meant large capital expenditure (CAPEX) and operating expenditure (OPEX) costs. Another challenge with this traditional approach is related to meeting the higher computing requirements due to a single business event. Buying extra hardware and resources for handling spikes means waste of resources during the non- peak times.  

table[[145, 337, 924, 785]]
table_caption[[369, 319, 624, 336]]
Cloud Computing Benefits   

<table>CategoryBenefitsProvisioningFaster provisioning makes cloud computing an ideal platform for test and development environmentsScalabilityScale up and scale out on-demandResource releaseFaster resource release/scale downCAPEXNo investment required for setting up the infrastructureOPEXLower OPEX due to pay-as-you-go modelAvailabilityHighly availableSkill requirementsLower skill required due to built-in automationAccessibilityAccessible using web-based portal, hence it is ubiquitous</table>

--- Page 6 ---

sub_title[[119, 108, 538, 129]]
## 3. Challenges of Cloud Computing:  

text[[118, 142, 848, 160]]
There are many challenges related to cloud computing, some of the key ones are:  

text[[147, 167, 882, 725]]
Cost of service: While cloud computing is good for ad hoc usage, it becomes more costly if you try to adopt it as the only solution for all your hosting requirements Laws of the land: Local laws in various countries don't allow you to keep data on servers that aren't in direct control of the data owner. In a few cases, keeping data outside of a given country is also not allowed Cloud interoperability: Moving things between different cloud service providers is a very difficult task Geographical presence: Cloud vendors do not have a presence in all geographies, which means cloud computing becomes infeasible for some customers Application certification: Not all applications are certified to run in a cloud; this is one of the key challenges in cloud computing adoption Lack of an integrated solution provider: Currently no single vendor provides all the cloud services that any given organization needs. For example, converged infrastructure as a service is provided by Oracle, whereas physical hardware as IaaS is provided by IBM SoftLayer Security: Security used to be the biggest challenge for cloud computing, but this is less the case nowadays. Cloud service providers get all security certifications and have a proven track record. For example, AWS hosts the American Security agency's cloud computing infrastructure. Many organizations still perceive cloud security as a major challenge

--- Page 7 ---

sub_title[[117, 108, 555, 129]]
## 4. Cloud Computing Service Models:  

text[[116, 143, 551, 160]]
There are three commonly used service models:  

text[[147, 168, 487, 239]]
Infrastructure as a Service (IaaS) Platform as a Service (PaaS) Software as a Service (SaaS)  

image[[278, 256, 666, 401]]  

sub_title[[116, 499, 435, 517]]
## Infrastructure as a Service (laaS)  

text[[114, 524, 882, 693]]
Infrastructure as a Service (IaaS)IaaS providers supply physical/virtual machines, storage, firewall, load balances, VLANs, etc. These are provided from a vast pool of resources. In IaaS, the consumer is responsible for patching and maintaining the operating system and the application software. In Oracle database context, IaaS means that the cloud service provider gives you the server, network, storage, OS, and other software that is required to run Oracle. Sometimes, Oracle software is preinstalled or the server comes with Oracle binaries. You are allowed to bring your own software image.  

sub_title[[117, 702, 393, 719]]
## Platform as a Service (PaaS)  

text[[114, 727, 882, 874]]
Platform as a Service (PaaS)PaaS providers give the dev environment like Dev toolkit (for example, Microsoft Azure and Google App engine). In PaaS, the consumer is not responsible for managing the underlying infrastructure and doesn't administer the underlying cloud components such as the operating system, database, etc. In Oracle database context, PaaS means Oracle database as a service. Here, you don’t need to worry about installing Oracle or managing the database server.

--- Page 8 ---

sub_title[[117, 106, 396, 124]]
## Software as a Service (SaaS)  

text[[114, 131, 884, 250]]
Software as a Service (SaaS)In the SaaS model, the application is placed in the cloud by the SaaS provider. The consumer is not responsible for managing the infrastructure and platform. In Oracle context, SaaS means getting the entire database service from the cloud provider; you just pay for usage. The schema as a service offering from Oracle Cloud is one example of SaaS.

--- Page 9 ---

sub_title[[117, 108, 470, 128]]
## 5. Cloud Deployment Models:  

text[[115, 141, 883, 236]]
Cloud computing can be deployed in many ways and it all depends on the placement of computing resources at the consumer's location (on- premise), at cloud service provider's location, or at both locations. The current cloud deployment models are as follows:  

text[[146, 268, 343, 362]]
Public cloud Private cloud Hybrid cloud Community cloud  

sub_title[[117, 397, 244, 414]]
## Public Cloud  

text[[115, 423, 883, 493]]
This is most common deployment model. In this model, computing resources are present in the cloud service provider's datacenter and are shared with various consumers in a multi- tenant architecture (see the Figure below).  

image[[150, 531, 838, 697]]  

text[[115, 724, 881, 770]]
The major advantage of this deployment model is that you don't need to invest in Hardware and effort in setting up the cloud.  

text[[117, 775, 883, 844]]
The disadvantage is that you don't have full control of your computing resources. You can't use this model when there are local laws that prevent you from keeping your data outside your premises.

--- Page 10 ---

text[[117, 106, 883, 150]]
The public cloud model is good option for startups and any organization that wants to avoid CAPEX costs related to DB servers.  

text[[116, 183, 881, 227]]
Oracle database can be run on many public cloud providers; however the prominent players are as follows:  

text[[146, 235, 455, 304]]
- Oracle Cloud  
- Microsoft Azure  
- Amazon Web Services (AWS)  

text[[116, 311, 881, 356]]
In the public cloud model, database related services are provided in all three service models (IaaS, PaaS, and SaaS).  

text[[117, 384, 601, 402]]
Oracle provides the following services in Oracle cloud:  

text[[146, 410, 883, 606]]
- Oracle Database Cloud Service, Virtual Image: IaaS offering to run Oracle database  
- Oracle Database Cloud Service: IaaS/PaaS offering to run Oracle database  
- Oracle Database Exadata Cloud Service: IaaS offering for running Oracle on Exadata machines  
- Schema as a Service: SaaS offering to run Oracle database Microsoft Azure provides IaaS service where you can run Oracle database on virtual machines hosted in their cloud.  

text[[116, 639, 632, 657]]
AWS provides the following services for Oracle database:  

text[[146, 665, 851, 709]]
- EC2 Instance: IaaS offering  
- Relational Database Services (RDS): SaaS offering to run Oracle database  

text[[117, 742, 861, 786]]
Cloud service providers continuously add enhancements, hence it is recommended that you check the cloud service provider's portal to get the latest offerings.  

sub_title[[118, 794, 252, 810]]
## Private Cloud  

text[[116, 819, 883, 888]]
In this deployment model, computing resources are placed on- premise. There is one more option here in which computing resources are placed at the cloud provider's premises, but all of these are dedicated for consumers (see the Figure below).

--- Page 11 ---

text[[114, 106, 882, 151]]
The major advantage of this model is that you have full control of your resources and you can meet any local laws requiring data be kept in your datacenter.  

text[[115, 158, 758, 176]]
The disadvantage is related to the effort needed for private cloud setup.  

image[[156, 209, 839, 403]]  

text[[114, 436, 883, 603]]
Database private cloud setup is done mostly in house, where companies use commodity server or converged infrastructures like Oracle Exadata, VCE Vblock, and IBM Pure app to host DB servers in a consolidated fashion. Oracle OEM 12c/13c cloud control is used to mimic a cloud- like setup where a self- service portal is created for quick provisioning and a chargeback module is used for metering and billing. In this model, planning, implementation, and on- going maintenance is handled by the company itself.  

text[[115, 611, 881, 681]]
Private cloud is good option for organizations that want to get ROI from their CAPEX investments done and where hosting in a public cloud is not an option due to compliance requirements.  

sub_title[[116, 716, 251, 732]]
## Hybrid Cloud  

text[[115, 740, 883, 858]]
This deployment model provides the best of the public and private cloud options. In this model, consumers use both a public cloud and private cloud to cater to different requirements (see the Figure below). For example, some applications can't move to a public cloud since they are running on end- of- life software, so they remain in a private cloud.

--- Page 12 ---

image[[166, 106, 824, 424]]  

text[[114, 456, 881, 500]]
In the hybrid cloud model, some of the databases run on- premise and some are hosted in a public cloud.  

text[[115, 506, 882, 573]]
The public cloud does not offer support for all database versions. You can't run Oracle 10g on Oracle cloud, so you have to keep such databases in your own private cloud/datacenter.  

text[[114, 580, 881, 626]]
Similarly, you might want to keep your extremely complex and mission- critical databases in your datacenter rather than host them in a public cloud.  

text[[115, 632, 880, 677]]
A hybrid cloud is good for situations where you can selectively move some of your workload into a public cloud while retaining others on- premises.  

sub_title[[117, 708, 292, 725]]
## Community Cloud  

text[[115, 733, 881, 854]]
In the community cloud model, cloud infrastructure is provisioned for the community. Here community refers to organizations that have shared objectives. This cloud infrastructure might be managed by one or more organizations that are part of community or by some third- party provider. This cloud deployment model is not very popular, but it does fall into the official NIST definition, hence it is mentioned here.

--- Page 13 ---

sub_title[[118, 108, 471, 129]]
## 6. Metering and Chargeback:  

text[[117, 142, 880, 187]]
Metering refers to the measurement of resource use, whereas Chargeback is related to charging based on that metering.  

text[[115, 193, 881, 387]]
These two ideas are essential characteristics of cloud computing. They are always present in the public cloud deployment model, but are optional in the private cloud deployment model. The metering and chargeback concepts can best be understood by considering the analogy of electricity use in your home. You have a meter that monitors all your energy consumption and then you are charged for the number of units consumed in a given period. While electricity consumption has only one metric, cloud computing has many metrics, including the number of virtual machines, the type of virtual machines, storage, I/O, etc.  

text[[117, 395, 880, 441]]
The metering and chargeback model in cloud computing is similar to the pay- as- yougo/pre- paid model used in the mobile industry.  

text[[118, 448, 725, 467]]
Oracle database pricing (chargeback) is divided into two categories:  

text[[146, 474, 880, 520]]
Metered: A pay- as- you- go model where no upfront payment is required and invoices are generated on a monthly basis for actual use on an hourly basis.  

text[[145, 526, 834, 545]]
Non- metered: A monthly pricing. Per hour pricing is not applicable here.  

text[[117, 551, 621, 568]]
Within each of these categories, there are three options:  

text[[148, 576, 444, 593]]
1. Oracle Database as a Service  

text[[147, 602, 527, 619]]
2. Oracle Database Exadata cloud service  

text[[149, 628, 450, 644]]
3. Oracle Database Virtual Image  

text[[117, 652, 880, 721]]
In Oracle Database as a Service, Oracle software is installed and Oracle database is created using the option you provide. The database management tools are available for backup, recovery, and patching.  

text[[116, 728, 881, 849]]
In Oracle Database Virtual Image, you get Oracle software pre- installed on Oracle cloud virtual machine. Database instances are not created automatically, but you can do that using DBCA or manually. Here, you don't get any additional cloud tools. In the Exadata cloud service, you get Exadata quarter, half, and full rack in a hosted environment.

--- Page 14 ---

sub_title[[120, 108, 424, 128]]
## 7. Cloud Security Model :  

text[[115, 141, 883, 260]]
Security is number one priority for any organization moving to the cloud. With on- premise databases, you are only concerned about security around the database, but with cloud DBs, you need to think beyond the DB. Since your DB is being accessed over the Internet, you have to take care of the security of all aspects of it, such as security during transit of data and security at rest.  

text[[117, 268, 881, 314]]
The cloud security model is a shared security model where you and the cloud provider share the responsibility of various components (See Model in the below):  

image[[120, 351, 911, 508]]  

text[[115, 534, 883, 654]]
So, securing the datacenters and infrastructure is the cloud provider's responsibility, whereas security of the database, storage, network, and accounts is the customer's responsibility. In other words, security "of" the cloud is the cloud provider's responsibility, whereas security "in" the cloud is your responsibility. Amazon and Oracle take care of following, which is what the cloud is made of:  

text[[147, 662, 883, 810]]
- Physical security of datacenter premises- Access control mechanism- Firewall and network security monitoring- Hypervisor security- OS-level patching and upgrade for managed services offering (such as Amazon RDS and Oracle Cloud) where you don't get OS-level access  

text[[115, 841, 881, 886]]
As a DBA, your security responsibilities vary according to the DB hosting model. If you are using an IaaS kind of service, such as Oracle database running on Amazon

--- Page 15 ---

text[[117, 106, 879, 150]]
EC2 instance, then you are responsible for securing your EC2 instance, your EBS/S3 storage, your network like VPC, and your database.  

text[[116, 157, 881, 253]]
If you are running a database in a managed service kind of offering, such as Amazon RDS or Oracle Schema as a Service then your security related responsibilities are limited to accounts and credential management. Security Task List in a database cloud service at Different Layers are:  

table[[120, 297, 873, 743]]

<table>LayerTasksVMSecuring your VM by defining network security policiesOSSecuring your OS by patching and OS-level hardeningNetworkSecuring your network by implementation of security groups, Network Access Control Lists (NACL)DatabaseSecuring data that is stored inside the database by implementing Transparent Data Encryption (TDE)Securing your backups (RMAN/data pump) by encryptionSecuring your database using least privilege mechanismSecuring your access to the database by database access controlSecuring data transfer by implementing SQL*Net encryption</table>  

text[[117, 769, 583, 787]]
Oracle Cloud has two options for database security:  

text[[147, 795, 494, 837]]
- Transparent Data Encryption (TDE)- SQL\*Net Encryption

--- Page 16 ---

sub_title[[118, 108, 225, 127]]
## 8. Quiz :  

text[[147, 141, 770, 160]]
1. What is the cloud computing model as? (Choose the best answer).  

text[[175, 167, 635, 263]]
a) Pay-as-you-go model  
b) Pay your invoice after one month  
c) Open usage for resource for limited amount  
d) Only subscribe for free with unlimited resources  

text[[146, 293, 881, 364]]
2. What is the Cloud Deployment Model related to" Computing resources are placed on-premise or are placed at the cloud provider's premises, but all of these are dedicated for consumers"? (Choose the best answer).  

text[[175, 370, 374, 468]]
a) Public cloud  
b) Private cloud  
c) Hybrid cloud  
d) Community cloud  

text[[146, 498, 880, 542]]
3. Are Metering and Chargeback always present in the public cloud deployment model, but are optional in the private cloud deployment model?  

text[[175, 550, 476, 620]]
a) FALSE  
b) ALL THE OTHER ANSWERS  
c) TRUE  

text[[147, 650, 452, 668]]
4. Cloud computing is more of a?  

text[[176, 676, 411, 746]]
a) pay-as-you-go model  
b) structured model  
c) storage model

--- Page 17 ---

text[[147, 105, 760, 124]]
5. One Resource of the following is not related to Cloud computing?  

text[[176, 132, 312, 227]]
a) Servers  
b) Applications  
c) Network  
d) Humans  

text[[147, 259, 565, 277]]
6. Are OPEX and CAPEX in cloud computing?  

text[[176, 285, 549, 355]]
a) Smaller than those in traditional mode  
b) Bigger than those in traditional mode  
c) Equal to those in traditional mode  

text[[147, 386, 880, 431]]
7. Why OPEX are lower by using a Cloud Computing resources by Lower skill required due to built-in automation?  

text[[176, 439, 713, 508]]
a) Because it doesn't needs any skills  
b) Because it needs Top skills due to built-in automation  
c) Because it needs Lower skills due to built-in automation  

text[[147, 540, 761, 559]]
8. Moving things between different cloud service providers is called?  

text[[176, 567, 432, 660]]
a) pay-as-you  
b) Interoperability  
c) Service cost  
d) Geographical distribution  

text[[147, 693, 777, 711]]
9. What is the statement that is not a Challenge of Cloud Computing?  

text[[176, 719, 412, 813]]
a) Availability  
b) Laws of the land  
c) Cost of Service  
d) Application certification

--- Page 18 ---

text[[147, 106, 771, 125]]
10. Is Infrastructure as a Service (IaaS) is a service model of Cloud?  

text[[176, 133, 274, 177]]
a) TRUE 
b) FALSE  

text[[148, 208, 879, 253]]
11. The consumer doesn't administer the underlying cloud components such as the operating system, database, etc., in?  

text[[176, 260, 262, 328]]
a) IaaS 
b) SaaS 
c) PaaS 

text[[148, 360, 879, 405]]
12. The consumer gets the entire database service from the cloud provider and just pays for usage, in?  

text[[176, 412, 262, 481]]
a) IaaS 
b) SaaS 
c) PaaS 

text[[148, 513, 876, 532]]
13. Choose two statements from the following that are Cloud Deployment Models?  

text[[176, 540, 332, 635]]
a) Public Cloud 
b) SaaS 
c) Private Cloud 
d) PaaS 

text[[148, 667, 879, 737]]
14. What is the cloud deployment model related to: Computing resources are present in the cloud service provider's datacenter and are shared with various consumers in a multi-tenant architecture:  

text[[176, 745, 367, 840]]
a) Public cloud 
b) Private cloud 
c) Hybrid cloud 
d) Community cloud

--- Page 19 ---

text[[147, 106, 690, 125]]
15. What is the cloud service that Oracle doesn't provide it?  

text[[176, 133, 401, 227]]
a) Virtual image  
b) AWS  
c) Schema as a Service  
d) Exadata cloud service  

text[[147, 259, 880, 304]]
16. What is the cloud deployment model related to: Computing resources are placed on-premise?  

text[[176, 311, 374, 405]]
a) Public cloud  
b) Private cloud  
c) Hybrid cloud  
d) Community cloud  

text[[147, 438, 880, 483]]
17. The disadvantage of Private cloud is related to the effort needed for private cloud setup?  

text[[176, 491, 260, 534]]
a) True  
b) False  

text[[148, 566, 879, 611]]
18. The disadvantage of Public cloud is related to the effort needed for private cloud setup?  

text[[177, 619, 261, 662]]
a) True  
b) False  

text[[147, 694, 880, 738]]
19. In which service, you get Exadata quarter, half, and full rack in a hosted environment?  

text[[177, 747, 412, 815]]
a) Database as a service  
b) Virtual image  
c) Exadata cloud service

--- Page 20 ---

text[[147, 105, 880, 150]]
20. In database cloud service, the task: Securing data transfer by implementing SQL\*Net encryption, is belonging to?  

text[[181, 158, 343, 175]]
a) Network Layer  

text[[182, 184, 296, 201]]
b) OS Layer  

text[[183, 210, 298, 226]]
c) VM Layer  

text[[181, 236, 347, 252]]
d) Database layer  

table[[182, 277, 807, 835]]

<table><td colspan="2">Quiz answers – chapter 11a2b3c4a5d6a7c8b9a10a11c12b13a, c14a15b16b17a18b19c20d</table>
