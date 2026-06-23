--- Page 1 ---

# Bachelor of IT Program BAIT  

# MS SQL Server Administration IIS404  

Chapter nine  

MS Business Intelligence  

Eng. Ayham Mohammad

--- Page 2 ---

## Contents  

1. Intro to Business Intelligence 1  

2. Server Analysis Services SSAS 4  

2.1. Tabular models 4  

2.2. Multidimensional models 5  

2.2.1. Benefits of Multidimensional Solutions 5  

2.2.2. Multidimensional Model Databases (SSAS) 5  

2.3. Data Warehouse Schemas 9  

2.4. What is Data mining? 10  

2.4.1. Data Mining Algorithms 10  

2.4.2. Choosing an Algorithm by Type 11  

2.4.3. Choosing an Algorithm by Task 13  

4. SQL Server Reporting Service SSRS 14  

4.1. SSRS Architecture 15  

4.1.1. Report Viewer 16  

4.1.2. Report Builder 16  

4.1.3. Report Designer 16  

4.1.4. Report Server 16  

4.1.5. Report Manager 16  

4.1.6. Report Services Configuration Manager 16  

4.2. Design 17

--- Page 3 ---

## 1. Intro to Business Intelligence 

- ال Business Intelligence هي أدوات يتم تزويدنا بها لتحليل البيانات إلستخراج معلومات و بموجبها نحصل على معرفة يتم الإستفادة من المعلومات و المعرفة لإتخاذ القرارات الإستراتيجية 

Data is raw, unorganized facts that need to be processed, numbers, texts, images or symbols that represent events or measures. Information is processed data. 

Business Intelligence (BI) refers to technologies, applications and practices for the collection, integration, analysis, and presentation of business information. The purpose of Business Intelligence is to support better business decision making. 

If a picture is worth a thousand words, the following illustration by pictures might be sufficient and worth a lot of papers 

- يتم تحويل ال Data الخام عبر تحليلها إلى Information معلومات 

- هناك مستوى أعلى من المعرفة Knowledge التي نحصل عليها من خلال المعلومات و Information و هو الحكمة Wisdom

--- Page 4 ---

- يطلق على عملية نقل ال Data بأشكالها و تنسيقاتها المختلفة إلى Data بعملية ETL - Extraction Transformation Loading حيث يتم بها استخراج ال Data من بنيتها السابقة و تحويلها لنمط مشترك مع كل ال Data المستخرجة الأخرى Data Warehouse و من ثم تحميلها إلى ال 

 

- دورة حياة ال Business Intelligence 

 

حيث أن ال Cube هو عبارة عن عملية Denormalization لل Data

--- Page 5 ---

- في SQL Server لدينا 3 أدوات تساعدنا في العمل على الـ Business Intelligence و هي: 

- SQL Server Integration Service: المسؤولة عن عمليات الـ ETL 

- SQL Server Analysis Service: المسؤولة عن التحليل 

- SQL Server Reporting Service: التي تقوم بعرض نتائج التحليل (أيست إجبارية حيث لدينا أدوات أخرى تقوم بهذه الوظيفة)

--- Page 6 ---

## 2. Server Analysis Services SSAS 

- لها شكلين: 

( األقدم و اإلفتراضى و الذي يحوي خدمات أكثر و الذي يستهلك موارد أكثر ) Multidimensional Model (1 Tabular Model (2 

Analytical data engine used in decision support and business analytics. It provides enterprise-grade semantic data models for business reports and client applications such as Power BI, Excel, Reporting Services reports, and other data visualization tools. A typical workflow includes creating a tabular or multidimensional data model project in Visual Studio, deploying the model as a database to a server instance, setting up recurring data processing, and assigning permissions to allow data access by end-users. When it's ready to go, your semantic data model can be accessed by client applications supporting Analysis Services as a data source. 

( Azure, On-premises ) بنوعيه SQL Server في كل من SSAS تواجد خدمات ال 

❖ Azure Analysis Services - Supports tabular models at the 1200 and higher compatibility levels. DirectQuery, partitions, row-level security, bi-directional relationships, and translations are all supported. 

❖ SQL Server Analysis Services - Supports tabular models at all compatibility levels, multidimensional models, data mining, and Power Pivot for SharePoint. 

### 2.1. Tabular models 

تأخر إصداره بشكل رسمي عن ال Multidimensional Model بسبب استهالكه الكبير للذاكرة حيث يقوم وضع ال Data في الذاكرة، ثم يضغطها 10 مرات ليعطى أداء أفضل بـ 10 مرات 

يعتمد ال Tabular Model في عمله على ال Columned-store-index الذي يعمل على الذاكرة يتحسب باستخدام ال Tabular Model عند وجود ذاكرة كبيرة و سريعة فقط 

يستخدم / حدى تقنينين: 

Memory في ال Data يقدم بوضع كل ال In-Memory (1
Direct-Query: تستخدم عند عدم وجود ذاكرة كافية، حيث يستخدم بها طريقة ال Multithreading للقراءة بسرعة كبيرة بدون نسخ البيانات إلى الذاكرة 

x Velocity و حاليا تم تعديل الإسم إلى In-Memory سابقا كان يطلق على طريقة ال Tabular Model والتي توفر وصول سريع للعناصر و البيانات في ال 

Row Level ( في ال Formula Language من توقع (Dax تستطيع استخدم لغة إسمها Tabular Model في ال Security و توفر Measuring ( عمليات حسابية على ال Data 

SQL Server في ال SSDTSQL Server Data Tools باستخدام ال Tabular Model يتم إنشاء ال 

Tabular models in Analysis Services are databases that run in-memory or in DirectQuery mode, 

connecting to data directly from back-end relational data sources. By using state-of-the-art compression

--- Page 7 ---

algorithms and multi- threaded query processor, the Analysis Services Vertipaq analytics engine delivers fast access to tabular model objects and data by reporting client applications like Power BI and Excel.  

While in- memory models are the default, DirectQuery is an alternative query mode for models that are either too large to fit in memory, or when data volatility precludes a reasonable processing strategy.  

DirectQuery achieves parity with in- memory models through support for a wide array of data sources, ability to handle calculated tables and columns in a DirectQuery model, row level security via DAX expressions that reach the back- end database, and query optimizations that result in faster throughput.  

DAX is a formula language. You can use DAX to define custom calculations for Calculated Columns and for Measures (also known as calculated fields).  

Tabular models are created in SQL Server Data Tools (SSDT) using the Tabular model project template. The project template provides a design surface for creating semantic model objects like tables, partitions, relationships, hierarchies, measures, and KPIs.

--- Page 8 ---

An Analysis Services database is a collection of data sources, data source views, cubes, dimensions, and roles. Optionally, an Analysis Services database can include structures for data mining, and custom assemblies that provide a way for you to add user- defined functions to the database.  

Cubes are the fundamental query objects in Analysis Services. When you connect to an Analysis Services database via a client application, you connect to a cube within that database. A database might contain multiple cubes if you are reusing dimensions, assemblies, roles, or mining structures across multiple contexts. You can create and modify an Analysis Services database programmatically or by using one of these interactive methods:  

- Deploy an Analysis Services project from SQL Server Data Tools (SSDT) to a designated instance of Analysis Services. This process creates an Analysis Services database, if a database with that name does not already exist within that instance, and

--- Page 9 ---

instantiates the designed objects within the newly created database. When working with an Analysis Services database in SQL Server Data Tools, changes made to objects in the Analysis Services project take effect only when the project is deployed to an Analysis Services instance.  

Create an empty Analysis Services database within an instance of Analysis Services, by using either SQL Server Management Studio or SQL Server Data Tools (SSDT), and then connect directly to that database using SQL Server Data Tools (SSDT) and create objects within it (rather than within a project). When working with an Analysis Services database in this manner, changes made to objects take effect in the database to which you are connecting when the changed object is saved.  

SQL Server Data Tools (SSDT) uses integration with source control software to support multiple developers working with different objects within an Analysis Services project at the same time. A developer can also interact with an Analysis Services database directly, rather than through an Analysis Services project, but the risk of this is that the objects in an Analysis Services database can become out of sync with the Analysis Services project that was used for its deployment. After deployment, you administer an Analysis Services database by using SQL Server Management Studio. Certain changes can also be made to an Analysis Services database by using SQL Server Management Studio, such as to partitions and roles, which can also cause the objects in an Analysis Services database to become out of sync with the Analysis Services project that was used for its deployment.

--- Page 10 ---

جميع الجداول هامة للحفظ 

من أهم الفروقات بين ال Tabular, Multidimensional models 

<table><tr><td>Feature</td><td>Multidimensional Modeling</td><td>Tabular Modeling</td></tr><tr><td>Data Sources</td><td>Relational Databases</td><td>Relational databases, Analysis Services cubes, Reporting Services reports, Azure DataMarket datasets, data feed, Excel files and text files</td></tr><tr><td>Development Tool</td><td>SQL Server Data Tools (SSDT)</td><td>SQL Server Data Tools (SSDT)</td></tr><tr><td>Management Tool</td><td>SQL Server Management Studio (SSMS)</td><td>SQL Server Management Studio (SSMS)</td></tr><tr><td>API</td><td>AMO, AMOMD.NET and PowerShell</td><td>AMO, AMOMD.NET and PowerShell</td></tr><tr><td>Reporting &amp; Analysis Tool</td><td>Report Builder, Report Designer, Excel PivotTable and PerformancePoint dashboard</td><td>Report Builder, Report Designer Excel PivotTable, PerformancePoint dashboard and Power View</td></tr><tr><td>Query &amp; Expression Language</td><td>MDX Scripting - Calculations (cube designer) MDX - Queries &amp; Calculations DMX - Data Mining Queries</td><td>DAX - Calculations &amp; Queries MDX - Queries</td></tr><tr><td>Write Back Support</td><td>Yes</td><td>No</td></tr><tr><td>Security</td><td>Role-based permissions in SSAS &amp; cell-level security</td><td>Role-based permissions in SSAS and row-level security</td></tr><tr><td>Data Compression</td><td>3+ times</td><td>10+ times</td></tr></table>

--- Page 11 ---

## Scalability  

Multidimensional  

Tabular  

- Pre-Aggregated Data From Disk- Can Store Very Large Amounts of Data- Uses Aggregations to Increase Query Performance- Data Compression 3x- MOLAP - Balanced configuration - Disk I/O & RAM- ROLAP - Maximize Disk I/O, Minimize network latency  

- In-Memory Technology (x-Velocity)- Can Store Large Amounts of Data- No Aggregations. Column-Based Storage.- Data Compression 10x- In Memory - Emphasize RAM & CPUs with fast clock speeds.- Direct Query - Relational DB Performance, Low Network Latency, Faster CPUs  

## Summary  

Consider Tabular... If You Have a Short Development Timeline If You are Working with a Plethora of Memory If Your Data Model is Simple If You Have Many Disparate Data Sources If Users Need to Query Large Amounts of Detail Data  

Consider Multidimensional... If You are Using SQL Server 2008 R2 or Earlier If You Have a Multi-Terabyte Data Source If You Have a Complex Data Model If You Need Multidimensional only features (Actions, Data Mining, Writeback, etc.)

--- Page 12 ---

## 2.3. Data Warehouse Schemas 

- في الـ Star Schema: جدول الحقيقة يتصل مع Dimensions بشكل اتصال نجمة يحوي كل منها على Table واحد 

## Star Schema 

- A star schema has a single table for each dimension 

- Each table supports all attributes for that dimension 

- Typically a de-normalized solution 

 

- في الـ Snowflake Schema: يستطيع كل Dimensions متصل مع جدول الحقيقة، أن يتصل مع جداول أخرى و ينحفض مستوى الأداء فيها كلما كثر عدد الأفرع المتصلة مع الـ Dimensions حيث للاستعلام عن كل فرع متصل مع أحد الـ Dimensions يجب استخدام الـ Join مع جميع الأفرع التي قبله للوصول إلى جدول الحقيقة 

- نستطيع القيام بـ Normalization لجمع الأفرع المتصلة عن طريق Dimension واحد لدمجها إلى DB واحدة 

## Snowflake Schema 

- More normalized solution
- Typically contains multiple tables per dimension
- Each table contains dimension key, value, and the foreign key value for the parent

--- Page 13 ---

- ملاحظة مهمة: 

- Star schema requires de-normalization during the load process
  - Can impact the ETL times 

- Snowflake schema can increase dimension complexity
  - Can impact Analysis Services solutions, negatively affecting cube performance 

- مثال عن بيانات جدول الحقيقة و ال Dimensions المتصلة به:

--- Page 14 ---

### 2.4. What is Data mining?  

## 2.4. What is Data mining?  

## (Hidden patterns)  

The practice of examining large databases in order to generate new knowledge. It's the process of analyzing hidden patterns.  

It results with knowledge (summary of information witch is a summary of data).  

Data mining is:  

Exploring Data. Finding out Patterns. Performing Predictions.  

## Data Mining Process in SQL  

  

### 2.4.1. Data Mining Algorithms  

An algorithm in data mining (or machine learning) is a set of heuristics and calculations that creates a model from data. To create a model, the algorithm first analyzes the data you provide, looking for specific types of patterns or trends. The algorithm uses the results of this analysis over many iterations to 13 | Page

--- Page 15 ---

find the optimal parameters for creating the mining model. These parameters are then applied across the entire data set to extract actionable patterns and detailed statistics.  

The mining model that an algorithm creates from your data can take various forms, including:

--- Page 16 ---

- A set of clusters that describe how the cases in a dataset are related.- A decision tree that predicts an outcome, and describes how different criteria affect that outcome.- A mathematical model that forecasts sales.- A set of rules that describe how products are grouped together in a transaction, and the probabilities that products are purchased together.  

#### 2.4.2. Choosing an Algorithm by Type  

- Classification algorithms predict one or more discrete variables, based on the other attributes in the dataset.- Regression algorithms predict one or more continuous numeric variables, such as profit or loss, based on other attributes in the dataset.- Segmentation algorithms divide data into groups, or clusters, of items that have similar properties.- Association algorithms find correlations between different attributes in a dataset. The most common application of this kind of algorithm is for creating association rules, which can be used in a market basket analysis.- Sequence analysis algorithms summarize frequent sequences or episodes in data, such as a series of clicks in a web site, or a series of log events preceding machine maintenance.

--- Page 17 ---

#### 2.4.3. Choosing an Algorithm by Task  

To help you select an algorithm for use with a specific task, the following table provides suggestions for the types of tasks for which each algorithm is traditionally used.  

<table><tr><td>Examples of tasks</td><td>Microsoft algorithms to use</td></tr><tr><td>Predicting a discrete attribute:</td><td>Microsoft Decision Trees Algorithm</td></tr><tr><td>Flag the customers in a prospective buyers list as good or poor prospects.</td><td>Microsoft Naive Bayes Algorithm</td></tr><tr><td>Calculate the probability that a server will fail within the next 6 months.</td><td>Microsoft Clustering Algorithm</td></tr><tr><td>Categorize patient outcomes and explore related factors.</td><td>Microsoft Neural Network Algorithm</td></tr><tr><td>Predicting a continuous attribute:</td><td>Microsoft Decision Trees Algorithm</td></tr><tr><td>Forecast next year&#x27;s sales.</td><td>Microsoft Time Series Algorithm</td></tr><tr><td>Predict site visitors given past historical and seasonal trends.</td><td>Microsoft Linear Regression Algorithm</td></tr><tr><td>Generate a risk score given demographics.</td><td></td></tr><tr><td>Predicting a sequence:</td><td>Microsoft Sequence Clustering Algorithm</td></tr><tr><td>Perform clickstream analysis of a company&#x27;s Web site.</td><td></td></tr><tr><td>Analyze the factors leading to server failure.</td><td></td></tr><tr><td>Capture and analyze sequences of activities during outpatient visits, to formulate best practices around common activities.</td><td></td></tr><tr><td>Finding groups of common items in transactions:</td><td>Microsoft Association Algorithm</td></tr><tr><td>Use market basket analysis to determine product placement.</td><td>Microsoft Decision Trees Algorithm</td></tr><tr><td>Suggest additional products to a customer for purchase.</td><td></td></tr><tr><td>Analyze survey data from visitors to an event, to find which activities or booths were correlated, to plan future activities.</td><td></td></tr></table>

--- Page 18 ---

### 4.1. SSRS Architecture

--- Page 19 ---

#### 4.1.1. Report Viewer  

The primary mechanism for viewing reports over the Web  

#### 4.1.2. Report Builder  

Report 4  

The tool that provides users with a front end for ad hoc reporting against a SQL Server or Analysis Services database. Unlike most ad hoc reporting tools, users of Report Builder do not need to know Structured Query Language (SQL) or anything about joins or grouping to create reports.  

#### 4.1.3. Report Designer  

Report 4  

The tool that takes on the job of building advanced reports. Although Report Builder does a good job as an ad hoc reporting tool, Report Designer was made to tackle really advanced reports.  

#### 4.1.4. Report Server  

Stateless Server 4  

A report server is a stateless server that uses the SQL Server Database Engine to store metadata and object definitions. A native mode Reporting Services installation uses two databases to separate persistent data storage from temporary storage requirements, you can access it by navigating to the url:  

http://SERVERNAME/reportServer  

#### 4.1.5. Report Manager  

Web- based Server 4  

A Web- based report access and management tool that you use to administer a single report server instance from a remote location over an HTTP connection. You can also use Report Manager for its report viewer and navigation features, you can access it by navigating to the url: http://SERVERNAME/reports.  

#### 4.1.6. Report Services Configuration Manager  

The Report Services Configuration Manager simplifies customization of the behavior of features and capabilities offered by SQL Server Reporting Services. You can use it to perform the following tasks and more:  

Create or select existing Report Server databases Define the URLs used to access the Report Server and Report Manager

--- Page 20 ---

- Configure the Report Server Service Account- Modify the connection string used by the Report Server- Set up email distribution capability

--- Page 21 ---

### 4.2. Design  

The designer is SQL Server data tools SSDT which is the development environment for all Microsoft Business intelligence members (SSIS, SSRS, and SSAS).

--- Page 22 ---

## References  

LeBlanc. P, Assaf. W, Jackson. B, Curnutt M; "SQL Server 2017 Administration Inside Out", Microsoft Press (2018).  

https://docs.microsoft.com/en- us/analysis- services/tabular- models/tabular- models-  

ssas?view=asallproducts- allversions  

https://docs.microsoft.com/en- us/analysis- services/multidimensional- models/multidimensional- models- ssas?view=asallproducts- allversions  

https://docs.microsoft.com/en- us/analysis- services/data- mining/data- mining- ssas?view=asallproducts- allversions  

https://docs.microsoft.com/en- us/sql/reporting- services/create- deploy- and- manage- mobile- and- paginated- reports?view=sql- server- ver15  

https://docs.microsoft.com/en- us/sql/integration- services/sql- server- integration- services?view=sql- server- ver15
