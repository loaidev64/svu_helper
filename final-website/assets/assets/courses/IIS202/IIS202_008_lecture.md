--- Page 1 ---

الصفحة 

3 

3 

4 

4 

5 

6 

8 

8 

9 

10 

11 

11 

11 

12 

13 

14 

16 

العنوان 

1. مقدمة 

2. تعليمات SQL 

3. تعليمات DDL 

1.3 توليد جدول Create Table 

2.3 حذف جدول Drop Table 

3.5 تعديل بنية جدول Alter Table 

4. تعليمات DML 

1.4 إدخال بيانات لجدول Insert 

2.4 تعديل بيانات جدول Update 

3.4 حذف بيانات من جدول Delete 

5. تعليمات DCL 

1.5 منح صلاحية Grant 

2.5 حجب صلاحية Revoke 

6. تعليمات TCL 

7. تعليمات DQL 

8. تحليل نموذج عن تعليمات SQL 

9. المراجع

--- Page 2 ---

الكلمات المفتاحية: 

جدول، سجل، عمود، تابع، قيمة، بيانات، حقل، جدول، رقمية، سالسل محارف، تاريخ، صيغة، قاعدة بيانات. 

ملخص: 

هذه الوحدة هي ملخص وتذكرة بتعليمات لغة الاستعلام المهيكلة والشكل الأبسط لكل من هذه التعليمات. 

أهداف تعليمية: 

يهدف هذا الفصل التعريف بالمفاهيم التالية: 

- لمحة سريعة عن لغة الاستعلام المهيكلة 

- الشكل الأبسط لتعليمات SQL 

1. تعريف البنى في قاعدة المعطيات (DDL). 

2. معالجة البيانات (DML). 

3. تعليمات التحكم بالوصول للبيانات (DCL). 

4. تعليمات إدارة المناقلات (TCL). 

5. تعليمات اختيار البيانات (DQL). 

- تحليل نموذج عن تعليمات SQL

--- Page 3 ---

## 1. مقدمة 

يرمز اختصار SQL إلى "لغة الاستعلام المهيكلة" Structured Query Language. 

تُستخدم لغة SQL للولوج إلى قواعد المعطيات والتعامل معها. ويقوم "المعهد الوطني الأمريكي للمقاييس" American National Standards Institute بإدارة مقاييس ومعايير هذه اللغة، ويشار إلى الهيئة المختصة بمواصفات هذه اللغة بهيئة ANSI SQL. 

تُعتبر لغة SQL لغةً بسيطةً نسبياً، ولكنها فعالة للغاية، فالكثير من التعليمات البسيطة في هذه اللغة تخفي ورائها خصائص فعّالة يمكن استخدامها للقيام بالعديد من العمليات المعقدة المعروفة في قواعد المعطيات. 

## 2. تعليمات SQL 

يمكن تصنيف تعليمات SQL إلى خمس مجموعات حسب الغاية منها، وهي: 

لإلشعاع جدول أو أي غرض آخر في قاعدة المعطيات (Data definition language) 

<table><tr><td>Create</td><td>إلنشاء جدول أو أي غرض آخر في قاعدة المعطيات</td></tr><tr><td>Alter</td><td>لتعديل بنية غرض في قاعدة المعطيات</td></tr><tr><td>Drop</td><td>لحذف غرض من قاعدة المعطيات</td></tr></table>

لإدخال بيانات في جدول (Data manipulation language) 

<table><tr><td>Insert</td><td>إلدخال بيانات في جدول</td></tr><tr><td>Update</td><td>تعديل البيانات في جدول</td></tr><tr><td>Delete</td><td>حذف بيانات من جدول</td></tr></table>

للتتحكم بالوصول إلى بيانات جدول (Data Control language) 

<table><tr><td>Grant</td><td>منح صلاحية إدخال أو تعديل أو حذف لمستخدم</td></tr><tr><td>Revoke</td><td>حجب صلاحية عن مستخدم</td></tr></table>

لإدخال البيانات من جدول (Data Query language) 

<table><tr><td>Select</td><td>انتقاء وعرض بيانات من جدول أو أكثر</td></tr></table>

--- Page 4 ---

## TCL (Transaction Control language) لإدارة المناقلات 

<table><tr><td>Commit</td><td>لتثبيت التعديلات بشكل نهائي</td></tr><tr><td>Rollback</td><td>للتراجع عن التعديلات</td></tr></table>

## 3. تعليمات DDL 

### Create Table جدول توليد 

تُستخدم تعليمة Create Table لتوليد جدول جديد ضمن قاعدة المعطيات. والشكل الأبسط لهذه التعليمة هو: 

Create table ( tablename (column1 data type, column2 data type, column3 data type); 

ويكون لها الشكل المُعقد التالي في حال تم وضع شروط تكامل مرجعي على حقول الجدول (Primary Key, ) :(Foreign key, unique, not null 

Create table table_name (column1 data type column2 data type column3 data type 

[constraint], [constraint], [constraint]); 

Create table table_name (column1 data type column2 data type column3 data type 

[constraint], [constraint], [constraint]); 

يبدأ اسم الجدول واسم أي حقق فيه، بحرف حصراً، ويمكن أن تتبعه أرقام أو حروف أو إشارات "_" 

(underscores), شرط ألا يزيد طول سلسلة المحارف الممثلة للإسم عن 30 محرف 

يجب تجنب استخدام أي كلمة مفتاحية مثل SELECT أو CREATE كاسم لجدول أو لحقل 

يحدد البند data type أنماط المعطيات والتي تكون: (varchar(size), char(size)) 

number(size,d), date.number(size)

--- Page 5 ---

<table><tr><td>char(size)</td><td>بابيت 255 لا يزيد على size</td></tr><tr><td>varchar(size)</td><td>size</td></tr><tr><td>number(size)</td><td>size</td></tr><tr><td>date</td><td>تاريخ</td></tr><tr><td>number(size,d)</td><td>d وحدد في size</td></tr><tr><td></td><td>نعم عددي حقيقي بعدد أرقام قبل الفاصلة م حدد في size</td></tr><tr><td></td><td>بعد الفاصلة</td></tr></table>

Create table Employee 

( Emp_Id Number Primary key, 

Name varchar(30), 

BOD Date); 

<table><tr><td>Id</td><td>Name</td><td>DOB</td></tr><tr><td>1</td><td>John Smith</td><td>1/1/107</td></tr><tr><td>2</td><td>Samer</td><td>2/4/1994</td></tr></table>

## حذف جدول Drop Table 

تُستخدم تعليمية Drop Table لحذف جدول من قاعدة المعطيات. والشكل الأبسط لهذه التعليمة هو: 

Drop table table_name; 

مثال: 

Drop table Employee;

--- Page 6 ---

## Alter Table جدول بنية تعديل 

تُستخدم تعليمية Alter Table لتعديل بنية جدول من قاعدة المعطيات. علماً أن التعديل يتضمن إضافة حقل، تعديل نمط حقل، حذف حقل وإعادة تسمية أحد الحقول، والشكل الأبسط لهذه التعليمية هو: 

Alter table table-name add (column1-name datatype, column2-name datatype, column3-name datatype); 

Alter table table-name modify (column-name datatype); 

Alter table table-name drop (column-name); 

Alter table table-name rename old-column-name to column-name;

--- Page 7 ---

## Employee 

<table><tr><td>Id</td><td>Name</td><td>DOB</td></tr><tr><td>1</td><td>John Smith</td><td>1/1/1071</td></tr><tr><td>2</td><td>Samer</td><td>2/4/1994</td></tr></table>

------ 

## Alter table Employee drop (DOB); 

------ 

<table><tr><td>Id</td><td>Name</td><td></td></tr><tr><td>1</td><td>John Smith</td><td></td></tr><tr><td>2</td><td>Samer</td><td></td></tr></table>

------ 

## Alter table Employee add (Hire_date date); 

------ 

<table><tr><td>Id</td><td>Name</td><td>Hire_date</td></tr><tr><td>1</td><td>John Smith</td><td></td></tr><tr><td>2</td><td>Samer</td><td></td></tr></table>

------ 

## Alter table Employee Modify (Hire_date varchar(50)); Insert into Employee values(5,'Jamal','January 2015'); 

------ 

<table><tr><td>Id</td><td>Name</td><td>Hire_date</td></tr><tr><td>1</td><td>John Smith</td><td></td></tr><tr><td>2</td><td>Samer</td><td></td></tr><tr><td>5</td><td>Jamal</td><td>January 2015</td></tr></table>

------ 

## Alter table Employee rename Hire_date to Hire_month; 

------ 

<table><tr><td>Id</td><td>Name</td><td>Hire_month</td></tr><tr><td>1</td><td>John Smith</td><td></td></tr><tr><td>2</td><td>Samer</td><td></td></tr><tr><td>5</td><td>Jamal</td><td>January 2015</td></tr></table>

لتعديل نمط حقل في جدول يجب أن تكون القيم المتضمنة في هذا الحقل قابلة للتحويل إلى النمط الجديد، وإلا فإن رسالة خطأ ستنتج عن تطبيق التعليمية. 

في حالة تعديل حقل، يمكن أن يكون التعديل هو تغيير نمط الحقل، أو إضافة قيمة افتراضية أو شرط تكامل مرجعي.

--- Page 8 ---

## 4. تعليمات DML 

### إدخال بيانات لجدول Insert 

تُستخدم تعليمة Insert لإدخال بيانات إلى جدول جديد ضمن قاعدة المعطيات. والشكل الأبسط لهذه التعليمة هو: 

Insert into table-name values (data1,data2,...);
Insert into table-name (column1, column2,...) values (data1,data2,...); 

مثال: 

### Employee 

<table><tr><td>Id</td><td>Name</td><td>Hire_month</td></tr><tr><td>1</td><td>John Smith</td><td></td></tr><tr><td>2</td><td>Samer</td><td></td></tr><tr><td>5</td><td>Jamal</td><td>January 2015</td></tr></table>

--- 

Insert into Employee values (8, 'John Do', '2013'); 

<table><tr><td>Id</td><td>Name</td><td>Hire_month</td></tr><tr><td>1</td><td>John Smith</td><td></td></tr><tr><td>2</td><td>Samer</td><td></td></tr><tr><td>5</td><td>Jamal</td><td>January 2015</td></tr><tr><td>8</td><td>John Do</td><td>2013</td></tr></table>

--- 

Insert into Employee (Id,Name) values (9, 'xxx'); 

<table><tr><td>Id</td><td>Name</td><td>Hire_month</td></tr><tr><td>1</td><td>John Smith</td><td></td></tr><tr><td>2</td><td>Samer</td><td></td></tr><tr><td>5</td><td>Jamal</td><td>January 2015</td></tr><tr><td>8</td><td>John Do</td><td>2013</td></tr><tr><td>9</td><td>xxx</td><td></td></tr></table>

--- Page 9 ---

- الحقول التي لا يتم إدخال قيم لها، تأخذ قيمة Null إذا لم يتعارض ذلك مع شرط تكامل مرجعي. 

- يمكن إدخال Null بشكل صريح لأحد الحقول، على الشكل التالي: 

Insert into Employee values (15, 'yyy', Null); 

## تعديل بيانات جدول Update 

تُستخدم تعليمية Update لتعديل بيانات تسجيلية أو أكثر في جدول ضمن قاعدة المعطيات. والشكل الأبسط لهذه التعليمية هو: 

Update table-name set column-name = value where condition; 

مثال: 

### Employee 

<table><tr><td>Id</td><td>Name</td><td>Hire_month</td></tr><tr><td>1</td><td>John Smith</td><td></td></tr><tr><td>2</td><td>Samer</td><td></td></tr><tr><td>5</td><td>Jamal</td><td>January 2015</td></tr><tr><td>8</td><td>John Do</td><td>2013</td></tr></table>

--- 

Update Employee set Hire_month='June 2013' where id=8; 

--- 

<table><tr><td>Id</td><td>Name</td><td>Hire_month</td></tr><tr><td>1</td><td>John Smith</td><td></td></tr><tr><td>2</td><td>Samer</td><td></td></tr><tr><td>5</td><td>Jamal</td><td>January 2015</td></tr><tr><td>8</td><td>John Do</td><td>June 2013</td></tr></table>

--- Page 10 ---

Update Employee set Name='Smith'; 

---

| Id | Name | Hire_month |
|----|-------|-------------|
| 1  | Smith |             |
| 2  | Smith |             |
| 5  | Smith | January 2015 |
| 8  | Smith | 2013        |

سنتعرف على الشروط الممكنة وكيفية استخدامها، في تعليمية Update عند الحديث لاحقاً عن تعليمية الاختيار
Select 

## حذف بيانات من جدول Delete 

تُستخدم تعليمية Delete لحذف تسجيلية أو أكثر من جدول ضمن قاعدة المعطيات. والشكل الأبسط لهذه التعليمية هو: 

Delete from table-name where condition; 

مثال: 

### Employee 

<table><tr><td>Id</td><td>Name</td><td>Hire_month</td></tr><tr><td>1</td><td>John Smith</td><td></td></tr><tr><td>2</td><td>Samer</td><td></td></tr><tr><td>5</td><td>Jamal</td><td>January 2015</td></tr><tr><td>8</td><td>John Do</td><td>2013</td></tr></table>

### Delete from Employee where id>=5; 

<table><tr><td>Id</td><td>Name</td><td>Hire_month</td></tr><tr><td>1</td><td>John Smith</td><td></td></tr><tr><td>2</td><td>Samer</td><td></td></tr></table>

--- Page 11 ---

عدم استخدام الشرط يؤدي إلى حذف جميع سجلات الجدول، فمثلاً التعليمية "Delete from Employee" ستؤدي إلى حذف جميع سجلات الجدول. Employee 

## 5. تعليمات DCL 

لتنفيذ أي عملية على قاعدة بيانات أو أي غرض منها، (إنشاء جدول، إدخال بيئات للجدول، إنشاء اتصال مع قاعدة البيانات ...) يحتاج المستخدم إلى صلاحية مناسبة، يمكن لمدير النظام أو مالك الصلاحية منحها لمستخدم باستخدام Grant، ويمكن حجب الصلاحية باستخدام Revoke. 

### منح صلاحية Grant 

الشكل الأبسط لهذه التعليمية هو: 

Grant privilege on object-name to user-name;
Grant role to user-name; 

مثال: 

Grant select on Employee to Scott;
Grant sysdba to Scott; 

حجب صلاحية Revoke 

الشكل الأبسط لهذه التعليمية هو: 

Revoke privilege on object-name from user-name;
Revoke role from user-name; 

مثال: 

Revoke select on Employee from Scott;
Revoke sysdba from Scott;

--- Page 12 ---

## 6. تعليمات TCL 

تعليمات إدارة المناقلات هي تعليمتين, Commit لتثبيت التعديلات التي تمت منذ آخر استدعاء لها, و Rollback للتراجع إلى آخر تعليمة Commit. عند أنها جلسة (بشكل نظامي) لمستخدم متصل مع قاعدة البيانات يتم استدعاء Commit بشكل ضمني, وعند انها الجلسة بشكل غير نظامي يتم استدعاء Rollback. 

مثال: 

### Employee 

<table><tr><td>Id</td><td>Name</td><td>Hire_month</td></tr><tr><td>1</td><td>John Smith</td><td></td></tr><tr><td>2</td><td>Samer</td><td></td></tr><tr><td>5</td><td>Jamal</td><td>January 2015</td></tr><tr><td>8</td><td>John Do</td><td>2013</td></tr></table>

 

Delete from Employee where id=5; 

Commit; 

Delete from Employee where id=8; 

Commit; 

Insert into Employee values (11, 'xxx', '2015'); 

Delete from employee; 

Rollback; 

 

<table><tr><td>Id</td><td>Name</td><td>Hire_month</td></tr><tr><td>1</td><td>John Smith</td><td></td></tr><tr><td>2</td><td>Samer</td><td></td></tr></table>

--- Page 13 ---

## 7. تعليمات DQL 

تعليمات اختيار البيانات هي تعليمه واحدة Select لها أشكال وخيارات متعددة، تستخدم تعليمه لاسترجاع بيانات من جدول أو أكثر، وتستخدم أيضاً لمعالجة البيانات المسترجعة. 

سنعرض هنا أبسط أشكالها مع نماذج عن استخدامها، وسنفصل في جميع الخيارات الممكنة لها في الفصل التالي. 

الشكل الأبسط لهذه التعليمة هو: 

Select column1_name, Column2_name,...
From table-name; 

مثال: 

## Employee 

<table><tr><td>Id</td><td>Name</td><td>Hire_month</td></tr><tr><td>1</td><td>John Smith</td><td></td></tr><tr><td>2</td><td>Samer</td><td></td></tr><tr><td>5</td><td>Jamal</td><td>January 2015</td></tr><tr><td>8</td><td>John Do</td><td>2013</td></tr></table>

 

Select Name, Id from Employee; 

 

<table><tr><td>Name</td><td>Id</td></tr><tr><td>John Smith</td><td>1</td></tr><tr><td>Samer</td><td>2</td></tr><tr><td>Jamal</td><td>5</td></tr><tr><td>John Do</td><td>8</td></tr></table>

 

Select * from Employee;

--- Page 14 ---

<table><tr><td>Id</td><td>Name</td><td>Hire_month</td></tr><tr><td>1</td><td>John Smith</td><td></td></tr><tr><td>2</td><td>Samer</td><td></td></tr><tr><td>5</td><td>Jamal</td><td>January 2015</td></tr><tr><td>8</td><td>John Do</td><td>2013</td></tr></table>

---

- ترتيب استرجاع البيانات من الجدول ليس بالضرورة هو نفس ترتيب إدخالها. 

## 8. تحليل نموذج عن تعليمات SQL 

في المثال التالي سنقوم بتحليل نموذج عن تعليمية Select لتكون مقدمة لدرسنا القادم: 

SELECT select_list [ INTO new_table ] 

FROM table_source 

[ WHERE search_condition ] 

[ GROUP BY group_by_expression ] 

[ HAVING search_condition ] 

[ ORDER BY order_expression [ ASC | DESC ] ] 

 

Employee 

<table><tr><td>Id</td><td>Name</td><td>Hire_month</td></tr><tr><td>1</td><td>John Smith</td><td></td></tr><tr><td>2</td><td>Samer</td><td></td></tr><tr><td>5</td><td>Jamal</td><td>January 2015</td></tr><tr><td>8</td><td>John Do</td><td>2013</td></tr></table>

 

Select Name, Id 

From Employee 

Where id&lt;5 

Order by Name desc;

--- Page 15 ---

تعليمية Select السابقة توضح أن: 

- الحقول المطلوب عرضها هي الاسم Name والرقم Id وبالترتيب 

- مصدر البيانات هو الجدول Employee 

- البيانات المطلوبة هي التي تحقق الشرط (الرقم أصغر تماماً من 5) 

- ترتيب عرض النتيجة هي حسب الترتيب الأبجدي للاسم تنازلياً 

- لا يمكن الاستغناء عن الجزء الأول والثاني من تعليمية Select ، بينما الجزء الثالث والرابع يمكن 

- حذفها إذا لم يكن هناك شرط على التسجيلات المسترجعة من الجدول، ولا شرط على ترتيب النتيجة 

المسترجعة 

- في الجزء الرابع تعني ترتيب تنازلي، والقيمة الافتراضية هي Asc أي تصاعدي 

يمكن إضافة أكثر من شرط في الجزء الثالث من التعليمة، وربط الشروط يتم بالعمليات المنطقية And, Or, 

Not 

--- 

<table><tr><td>Name</td><td>Id</td></tr><tr><td>2</td><td>Samer</td></tr><tr><td>1</td><td>John Smith</td></tr></table>

تعليمية Select هي موضوع الفصل التالي

--- Page 16 ---

## 9. المراجع: 

- http://www.studytonight.com/dbms/select-query
