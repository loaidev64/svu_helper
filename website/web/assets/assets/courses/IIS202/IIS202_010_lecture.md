--- Page 1 ---

الصفحة 

4 

4 

4 

4 

5 

5 

6 

6 

7 

7 

9 

11 

13 

15 

15 

18 

19 

العنوان 

1. مقدمة 

2. شروط التكامل المرجعي (Integrity constraints) 

1.2. المفتاح الأساسي Primary key 

2.2. المفتاح المستورد Foreign key 

3.2. الوحدانية Unique 

4.2. اجباري Not Null 

3. القيم الافتراضية Default 

4. شروط التحقق Check 

5. التوابع في SQL 

1.5. التوابع التجميعية 

2.5. التوابع الدرجية 

6. الأسماء البديلة Aliases 

7. تعليمية Select (nested select statement) 

8. تعليمات Select (Correlated select statement) 

9. تطبيق 

10. المراجع 

11. تدريبات

--- Page 2 ---

الكلمات المفتاحية: 

جدول، سجل، عمود، تابع، قيمة، بيانات، حقل، جدول، رقمية، سلاسل محارف، تاريخ، صيغة، قاعدة بيانات. 

ملخص: 

هذه الوحدة هي توسع في لغة الإستعلام المهيكلة وتعرض مفاهيم متقدمة في SQL وتدريبات تطور مهارة الطالب في استخدام SQL. 

أهداف تعليمية: 

يهدف هذا الفصل التعريف بالمفاهيم التالية: 

• شروط التكامل المرجعي في SQL: 

1. المفاتيح الأساسية Primary Keys 

2. المفاتيح المستوردة Foreign Keys 

3. الوحدانية Unique 

4. الالزامية Not null 

• القيم الافتراضية Default 

• شروط التحقق Check 

• التوابع في SQL 

5. التوابع التجميعية 

6. التوابع الدرجية 

• الأسماء البديلة Aliases 

• تعليمية Select المتداخلة (Nested Select statement) 

• تعليمات Select المترابطة Correlated Select statement 

• تطبيق

--- Page 3 ---

## :المخطط 

مقدمة 

شروط التكامل المرجعي (Integrity constraints) 

القيم الافتراضية Default 

شروط التحقق Check 

التوابع في SQL 

الأسماء البديلة Aliases 

تعليمية Select المتداخلة (nested select statement) 

تعليمات Select المترابطة (Correlated select statement) 

تطبيق 

-3-

--- Page 4 ---

## 1. مقدمة 

في هذا الفصل سنعرض حالات متقدمة لاستخدام تعليمية Select موضوع الفصل السابق، وتتمات أساسية في لغة الاستعلام المهيكلة. 

## 2. شروط التكامل المرجعي (Integrity constraints): 

شروط التكامل المرجعي هي مجموعة من القواعد، تطبق على نمط وقيم البيانات التي يمكن إدخالها إلى أعمدة الجداول، والغاية منها ضمان صحة وتكامل البيانات في مجموعة جداول قاعدة البيانات. 

شروط التكامل المرجعي هي: مفتاح أساسي (Primary Key)، مفتاح مستورد (Foreign Key)، وحيد (Unique)، اجباري (Not Null). 

### المفتاح الأساسي Primary key 

المفتاح الأساسي هو حقل يعرف بشكل وحيد كل تسجيلية من الجدول، وقد شرحنا سابقاً كيفية اختياره من المفاتيح الأعظمية والمفاتيح المرشحة (راجع الفصل: النموذج العلائقي لقواعد البيانات)، أما كيفية تعريفه فهي على الشكل التالي: 

Create table Student (s_id int PRIMARY KEY, Name varchar(60), Age int); 

الحقل s_id هو المفتاح الأساسي للجدول Student، لا يمكن ادخال قيم مكررة أو Null في هذا الحقل. ومعرفة s_id تحدد حتمياً قيم بقية حقول الجدول. 

### المفتاح المستورد Foreign key 

المفتاح المستورد هو وسيلة ربط جدولين، بحيث تكون قيم الحقل المستورد في الجدول الآن هي حتمياً موجودة في حقل المفتاح الأساسي في الجدول الأب، إن لم تكن Null. 

يمكن فهم المفتاح المستورد من خلال المثال التالي: 

Department 

<table><tr><td>Id</td><td>Name</td></tr><tr><td>1</td><td>HR</td></tr><tr><td>2</td><td>Sales</td></tr></table>

--- Page 5 ---

Create table Emp (id number primary key, name
varchar(30), dept foreign key references Department(id));

Emp 

<table><tr><td>Id</td><td>Name</td><td>dept</td></tr><tr><td>1</td><td>A</td><td>1</td></tr><tr><td>2</td><td>B</td><td>2</td></tr><tr><td>3</td><td>C</td><td>2</td></tr><tr><td>4</td><td>D</td><td>1</td></tr></table>

القيم المتاحة للحل Dept في الجدول Emp هي 1 (Sales) و Null, وأي محاولة لإدخال قيمة أخرى ستشمل مع رسالة خطأ (تم خرق قيد تكامل مرجعي). 

Insert into Emp values (5, 'E', 3); 

خطأ – فشل في تطبيق التعليمية بسبب خرق قيد تكامل مرجعي. 

## الوحدانية Unique 

تعني الوحدانية، عدم امكانية إدخال نفس القيمة للحقل أكثر من مرة:
Create table Student (s_id int Primary Key, Name varchar(60) Unique, Age int); 

لا يمكن ادخال قيم مكررة للحقل Name، و يمكن ادخال Null في هذا الحقل. 

## اجباري Not Null 

في حال كان الحقل اجباري، لا يمكن ادخال قيمة Null فيه بشكل صريح أو بشكل ضمني: 

Create table Student (s_id int Primary Key, Name varchar(60) not null, Age int); 

Insert into Student values (6, Null, 2); 

خطأ: لا يمكن ادخال Null للحقل بشكل صريح. 

Insert into Student (id, age) values (6, 2); 

خطأ: لا يمكن ادخال Null للحقل بشكل ضمني.

--- Page 6 ---

## 3. القيم الافتراضية Default 

يمكن تعريف قيمة افتراضية لأحد الحقول عند انشاء الجدول، وفي هذه الحالة يمكن ادخال قيمة صريحة في هذا الحقل وإلا فإن القيمة الافتراضية بدلاً من Null ستدخل في الحقل عند إضافة تسجيله . 

Create table Student (s_id int Primary Key, Name varchar(60), Age int default 30 ); 

<table><tr><td>S_id</td><td>Name</td><td>age</td></tr></table>

======== 

Insert into student(id, name) values(1,'x'); 

Insert into student values(2,'y',45); 

<table><tr><td>S_id</td><td>Name</td><td>age</td></tr><tr><td>1</td><td>x</td><td>30</td></tr><tr><td>2</td><td>y</td><td>45</td></tr><tr><td></td><td></td><td></td></tr></table>

في التسجيلية الأولى تم ادخال القيمة الافتراضية (30) في حقل العمر، بدلاً من Null. 

## 4. شروط التحقق Check : 

يفيد شرط التحقق في وضع قيد على القيم المدخلة لأحد الحقول، كأن يكون ضمن مجال معين، أو أكبر من قيمة محددة. 

Create table Student (s_id int Primary Key, Name varchar(60), Age int check (age>18) ); 

<table><tr><td>S_id</td><td>Name</td><td>age</td></tr></table>

Insert into student values(1,'x',12); 

خطأ – فشل في تطبيق التعليمية بسبب خرق قيد تكامل مرجعي.

--- Page 7 ---

## 5. التوابع في SQL 

التابع هو عبارة عن تعبير رياضي يأخذ مجموعة من قيم الدخل التي ندعوها مُعاملات، ويعيد قيمة خرج وحيدة ندعوها قيمة التابع. تتعلق قيمة التابع (أي الخرج) بمُعاملاته (أي بالدخل)، كحال التابع الذي يقوم بحساب مجموع قيم عديدة. 

تصنف توابع SQL إلى: 

- التوابع التجميعية وهي التوابع التي تأخذ كُمعاملات مجموعة من القيم وتعيد قيمة وحيدة، مثل التابع الذي يحسب مجموع أعداد حقيقية. 

- التوابع الدرجية وهي التوابع التي تأخذ مُعاملاً وحيداً وتُعيد قيمة وحيدة، مثل تابع القيمة المُطلقة لعدد حقيقي. 

## التوابع التجميعية 

أهم التوابع التجميعية والأكثر استخداماً هي: 

<table><tr><td>استخدامه</td><td>التابع</td></tr><tr><td>يقوم بحساب معدل القيم لحقل معين</td><td>AVG</td></tr><tr><td>يقوم بحساب عدد البيانات الخاصة بحقل معين</td><td>COUNT</td></tr><tr><td>يقوم بإعادة القيمة الصغرى من قيم حقل معين</td><td>MIN</td></tr><tr><td>يقوم بإعادة القيمة العظمى من قيم حقل معين</td><td>MAX</td></tr><tr><td>يقوم بحساب مجموع قيم حقل معين</td><td>SUM</td></tr></table>

فيما يلي أمثلة على استخدام التوابع التجميعية: 

### Employee 

<table><tr><td>Id</td><td>Name</td><td>Location</td><td>Age</td><td>Salary</td></tr><tr><td>1</td><td>X</td><td>1</td><td>32</td><td>15000</td></tr><tr><td>2</td><td>Y</td><td>1</td><td>44</td><td>12000</td></tr></table>

### Dept 

<table><tr><td>Id</td><td>Name</td></tr><tr><td>1</td><td>HR</td></tr><tr><td>2</td><td>Sales</td></tr></table>

--- Page 8 ---

Select avg (age) from Employee, Dept where Employee.location=Dept.id and Dept.name='Sales'; 

النتيجة معدل أعمار موظفي المبيعات. 

Select Dept.name, Sum (Employee.salary) from Employee, Dept where Employee.location=Dept.id group by Dept.name having Count (Employee.id)>10; 

النتيجة مجاميع رواتب الأقسام التي فيها أكثر من عشرة موظفين. 

## ملاحظات: 

- التابع Avg يمكن أن يأخذ أحد دخلين بالإضافة إلى الحقل المراد حساب الوسطى له، الدخلين هما All و، ويفيد الثاني منهما باستبعاد القيم المكررة عند حساب الوسطى، أما الأول فهو الخيار الافتراضي ولا يتم فيه استبعاد القيم المكررة. 

- التابع Count يأخذ إحدى ثلاثة قيم للدخل هي (All, Distict) ، بالإضافة لاسم الحقل، وتعني: 

- * أي عدد التسجيالت بما فيها التسجيالت التي تحوي Null كقيمة للحقل الذي نحسب مجموع ادخالته. 

- *: تستبعد هنا القيم Null من العدد. 

- *: نستبعد هنا القيم Null والقيم المكررة للحقل.

--- Page 9 ---

التوابع الدرجية 

التوابع الدرجية هي أربعة أنواع: 

<table><tr><td>التوابع الرقمية</td><td>وهي التوابع الخاصة بالعمليات على الأرقام، مثل تابع التقرير إلى أقرب فاصلة عشرة</td></tr><tr><td>توابع سلاسل المحارف</td><td>وهي التوابع الخاصة بالعمليات على سلاسل المحارف، مثل تابع تحديد طول سلسلة محرية</td></tr><tr><td>توابع التاريخ والوقت</td><td>وهي التوابع الخاصة بالعمليات على التاريخ والوقت، مثل تابع حساب الزمن الفاصل بين تاريخين</td></tr><tr><td>توابع التحويل</td><td>هي التوابع الخاصة بعملية تحويل مُعامل الدخل، من نمط بيانات إلى آخر.</td></tr></table>

التوابع الرقمية: وهي التوابع الدرجية الخاصة بالعمليات على القيم الرقمية ومن أهمها التوابع التالية: 

<table><tr><td>Floor</td><td>وهو التابع الذي يُقَرِّب مُعامل الدخل إلى أقرب عدد صحيح أصغر من مُعامل الدخل</td></tr><tr><td>Ceiling</td><td>وهو التابع الذي يُقَرِّب مُعامل الدخل إلى أقرب عدد صحيح أكبر من مُعامل الدخل</td></tr><tr><td>Round</td><td>وهو التابع الذي يُقَرِّب مُعامل الدخل ذو الفاصلة العشرية إلى أقرب عدد صحيح أو عدد حقيقي بدقة محددة</td></tr><tr><td>Abs</td><td>وهو التابع الذي يعيد القيمة المطلقة لمُعامل الدخل</td></tr><tr><td>Sin, Cos, Tan, Atan</td><td>وهي التوابع التي تحسب قيم ظل، تظل، جب، تجب الزاوية التي نأخذها كمُعامل دخل.</td></tr><tr><td>SQRT</td><td>هو التابع الذي يُعيد قيمة الجذر التربيعي لمُعامل الدخل</td></tr><tr><td>RAND</td><td>وهو التابع الذي يُعيد رقم عشوائي بين 0 و 1 و يستخدم مُعامل الدخل كأساس لتوليد الرقم العشوائي</td></tr></table>

توابع سلاسل المحارف: هي التوابع الدرجية الخاصة بالعمليات على السلاسل المحرية، ومن أهمها 

التوابع التالية:

--- Page 10 ---

- توابع التحويل: هي التوابع الخاصة بالتحويل من نمط بيانات إلى نمط آخر ومن أهمها التوابع التالية: 

<table><tr><td>استخدامه</td><td>التابع</td></tr><tr><td>يُحول قيمة الدخل العددية إلى سلسلة محرّفية.</td><td>Str()</td></tr><tr><td>يُحول سلسلة المحارف المارة كمعامل دخل إلى عدد.</td><td>To_Number()</td></tr><tr><td>يُحول قيمة الدخل إلى قيمة من أي نمط آخر من البيانات</td><td>Cast()</td></tr><tr><td>يُحول قيمة الدخل إلى قيمة من أي نمط آخر من البيانات</td><td>Convert()</td></tr></table>

أمثلة: 

Employee 

<table><tr><td>Id</td><td>Name</td><td>Location</td><td>Age</td><td>Salary</td></tr><tr><td>1</td><td>X</td><td>HR</td><td>32</td><td>15000</td></tr><tr><td>2</td><td>Y</td><td>Sales</td><td>44</td><td>12000</td></tr></table>

Select Left (Name,1) 

from Employee; 

النتيجة الحرف الأول من اسم كل موظف. 

Select Concat (name, location) 

from Employee; 

النتيجة قائمة بأسماء الموظفين مدمجة مع أسماء الأقسام التي يعملون فيها. 

6. الأسماء البديلة Aliases 

قد تتضمن الجداول حقول متشابهة في الاسم، فمثلاً يمكن أن نجد حقل باسم Id في جدول Employee وفي جدول Dept (مثالنا السابق)، ولتمميز حقلي بنفس الاسم من جدولين مختلفين في نفس عبارة Select نستخدم الأسماء البديلة على الشكل التالي.

--- Page 11 ---

## Employee 

<table><tr><td>Id</td><td>Name</td><td>Location</td></tr><tr><td>1</td><td>X</td><td>1</td></tr><tr><td>2</td><td>Y</td><td>1</td></tr></table>

## Dept 

<table><tr><td>Id</td><td>Name</td></tr><tr><td>1</td><td>HR</td></tr><tr><td>2</td><td>Sales</td></tr></table>

Select Employee.id as e_id,Employee.name as e_name,
Dept.name as department
from Employee, Dept
where Employee.location=Dept.id; 

======== 

<table><tr><td>E_id</td><td>E_Name</td><td>Department</td></tr><tr><td>1</td><td>X</td><td>HR</td></tr><tr><td>2</td><td>Y</td><td>HR</td></tr></table>

يمكن أيضاً استخدام نفس الجدول في تعليمية Select أكثر من مرة (nested, correlated, self-join), وفي هذه الحالة يجب تمييز ورودات الجدول عن بعضها باستخدام الأسماء البديلة، كما في المثال التالي: 

## Person 

<table><tr><td>Id</td><td>Name</td><td>Gender</td><td>Age</td></tr><tr><td>1</td><td>X</td><td>1</td><td>32</td></tr><tr><td>2</td><td>Y</td><td>1</td><td>24</td></tr><tr><td>3</td><td>A</td><td>0</td><td>30</td></tr><tr><td>4</td><td>B</td><td>0</td><td>28</td></tr></table>

--- Page 12 ---

Select A.name as m1, B.name as m2 

from Person A, Person B 

where A.gender + B.Gender=1 and abs(A.age-B.age)<5; 

======== 

النتيجة: هي الأزواج المحتملة من ذكور وائات بفارق عمر لا يزيد عن 5 سنوات 

<table><tr><td>M1</td><td>M2</td></tr><tr><td>X</td><td>A</td></tr><tr><td>X</td><td>B</td></tr><tr><td>Y</td><td>B</td></tr><tr><td>A</td><td>X</td></tr><tr><td>B</td><td>X</td></tr><tr><td>B</td><td>y</td></tr></table>

نلاحظ أن الأزواج مكررة (ما الشرط الذي يجب أن نضيفه لإلغاء التكرار؟) 

المثال السابق ¹ يدعى بالارتباط الذاتي (self-join), الحالات الأخرى التي نضطر فيها لاستخدام أسماء بديلة للجداول هي حالات تداخل (select statement) و حالة (select statement) المرتبطة (select statement) و سنناقش الحالتين في الفقرات التالية. 

## 7. تعليمية Select المتداخلة (nested select statement) 

يمكن استخدام نتيجة تعليمية Select كمصدر للبيانات تبنى عليه تعليمية Select أخرى, تساعد هذه التقنية في تسهيل فهم وقراءة تعليمات Select إلا أنها ليست الخيار الأفضل في حال كان تنفيذ المطلوب بعبارة Select واحدة مع الضم والاختيار, وذلك لدواعي سرعة التنفيذ. 

فيما يلي سنحل كيفية حل مسألة باستخدام تعليمات Select متداخل, وسنرى أننا يمكن أن نحقق نفس النتيجة بتعليمية Select واحدة:

--- Page 13 ---

Company 

<table><tr><td>Id</td><td>Name</td><td>City</td></tr><tr><td>401</td><td>x</td><td>Damascus</td></tr></table>

Product 

<table><tr><td>Id</td><td>Name</td><td>Producer</td></tr><tr><td>1</td><td>x</td><td>401</td></tr></table>

Order 

<table><tr><td>Id</td><td>Product</td><td>Client</td></tr><tr><td>10</td><td>1</td><td>John</td></tr><tr><td>20</td><td>1</td><td>Joe</td></tr></table>

المطلوب هو المدن التي فيها شركات تنتج مواد تم طلبها من قبل John. 

المواد التي طلبها John هي: 

Select Product.id 

from Product, Order 

where Product.id=Order.product and Order.Client='John'; 

باستبدال أرقام المواد بأرقام مصنعها، يبقى أن نختار اسم كل شركات رقمها ضمن قائمة أرقام المصنعين التي ننتجت معنا. 

Select City from Company where Company.Id in ( 

Select Product.Producer
from Product, Order
where Product.id=Order.product
Order.Client='John'
); 

========

--- Page 14 ---

نفس النتيجة يمكن تحقيقها بتعليمه Select واحدة هي: 

Select Company.City
from Product, Order, Company
where Product.id=Order.product
and Product.Producer=Company.id
and Order.Client='John'; 

## 8. تعليمات Select (Correlated select statement) المرتبطة 

Product 

<table><tr><td>Name</td><td>Price</td><td>Category</td><td>Producer</td><td>Year</td></tr><tr><td></td><td></td><td></td><td></td><td></td></tr></table>

المطلوب قائمة بالمنتجات الأغلى من أية منتجات أنتجها نفس المصنع قبل عام 2014 

SELECT DISTINCT name, producer
FROM Product AS x
WHERE price > ALL (SELECT
FROM Product AS y
WHERE x.producer = y.producer AND 

y.year < 2014); 

 

## 9. تطبيق: 

في المثال التالي سنعرض بعض الاستخدامات الخاصة لتعليمية Select: 

Person 

<table><tr><td>Id</td><td>FName</td><td>LName</td><td>Gender</td><td>Nationality</td><td>Age</td></tr><tr><td>1</td><td>John</td><td>Smith</td><td>1</td><td>2</td><td>32</td></tr><tr><td>2</td><td>Adam</td><td>Sandler</td><td>1</td><td>1</td><td>45</td></tr><tr><td>3</td><td>Mary</td><td>Clair</td><td>0</td><td>1</td><td>40</td></tr><tr><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td></tr></table>

--- Page 15 ---

======

Nationality 

<table><tr><td>Id</td><td>Name</td></tr><tr><td>1</td><td>American</td></tr><tr><td>2</td><td>French</td></tr><tr><td>...</td><td>...</td></tr></table>

======

ContactMedia 

<table><tr><td>Id</td><td>Media</td></tr><tr><td>1</td><td>Mobile</td></tr><tr><td>2</td><td>E-Mail</td></tr><tr><td>3</td><td>Phone</td></tr><tr><td>...</td><td>...</td></tr></table>

======

PersonContact 

<table><tr><td>Id</td><td>Person</td><td>ContactMedia</td><td>ContactValue</td></tr><tr><td>1</td><td>1</td><td>1</td><td>00963944111222</td></tr><tr><td>2</td><td>1</td><td>2</td><td>xxx@gmail.com</td></tr><tr><td>...</td><td>...</td><td>...</td><td>...</td></tr></table>

في مثاننا الجنسية Nationality تصدر مفتاحها إلى الجدول (ارتباط واحد لعدة)، وطريقة الاتصال ContactMedia ترتبط مع جدول Person من خلال جدول وسيط هو PersonContact (يمكن أن يكون لنفس الشخص أكثر من طريقة للاتصال به).

--- Page 16 ---

## المطلوب: 

- قائمة بفرق العمل المحتملة، علماً أن كل فريق يتألف من شخصين من جنسية واحدة و فارق العمر بينهما لا يتجاوز 5 سنوات ؟ 

- قائمة بالجنسيات التي يحملها على الأقل شخصين مسجلين في قاعدة البيانات ؟ 

- وسيلة الاتصال الأكثر استخداماً (المدخل بياناتها للأشخاص المسجلين) ؟ 

- وسطي أعمار الأشخاص المسجلين في كل جنسية ؟ 

- قائمة بفرق العمل المحتملة، علماً أن كل فريق يتألف من شخصين من جنسية واحدة و فارق العمر بينهما لا يتجاوز 5 سنوات ؟
- قائمة بالجنسيات التي يحملها على الأقل شخصين مسجلين في قاعدة البيانات ؟
- وسيلة الاتصال الأكثر استخداماً (المدخل بياناتها للأشخاص المسجلين) ؟
- وسطي أعمار الأشخاص المسجلين في كل جنسية ؟

--- Page 17 ---

10. المراجع: 

- http://www.studytonight.com/dbms/select-query

--- Page 18 ---

Invoice 

<table><tr><td>Id</td><td>Serial</td><td>Date</td><td>Client</td></tr><tr><td>1</td><td>1</td><td>1-1-2015</td><td>20</td></tr><tr><td>2</td><td>2</td><td>2-1-2015</td><td>30</td></tr><tr><td>3</td><td>3</td><td>1-1-2015</td><td>10</td></tr><tr><td>4</td><td>4</td><td>4-2-2015</td><td>20</td></tr><tr><td>5</td><td>5</td><td>4-2-2015</td><td>10</td></tr></table>

Client 

<table><tr><td>Id</td><td>Name</td></tr><tr><td>10</td><td>C 1</td></tr><tr><td>20</td><td>C 2</td></tr><tr><td>30</td><td>C 3</td></tr></table>

Material 

<table><tr><td>Id</td><td>Name</td><td>Price</td></tr><tr><td>1</td><td>Printer</td><td>15000</td></tr><tr><td>2</td><td>Monitor</td><td>30000</td></tr><tr><td>3</td><td>Case</td><td>2500</td></tr><tr><td>4</td><td>MB</td><td>22000</td></tr></table>

Invoice_Item 

<table><tr><td>Id</td><td>Invoice</td><td>Material</td><td>QTY</td></tr><tr><td>1</td><td>1</td><td>1</td><td>1</td></tr><tr><td>2</td><td>1</td><td>2</td><td>1</td></tr><tr><td>3</td><td>1</td><td>4</td><td>1</td></tr><tr><td>4</td><td>2</td><td>2</td><td>2</td></tr><tr><td>5</td><td>2</td><td>3</td><td>2</td></tr></table>

--- Page 19 ---

- نتيجة تطبيق جملة التعليمات التالية: 

Select Id,Name 

From Material 

Where Id not in 

( Select material from invoice, invoice_item where invoice.id=invoice_item. invoice and invoice.date <>'1-1-2015'); 

هي: 

1. المواد التي تم شراؤها في 1-1-2015. 

2. المواد التي لم يتم شراء كميات منها. 

3. المواد التي لم يتم شراء أي كمية منها بتاريخ 1-1-2015. 

4. المواد المتضمنة في الفاتورة رقم 1 و الفاتورة رقم 3. 

الإجابة: (3) 

- نتيجة التعليمية التالية: 

Select Id,Name 

From Material 

Where Price > ( 

Select Max(price) from material, invoice_item 

where invoice_item.material=material.id 

); 

هي: 

1. المادة الأعلى سعراً. 

2. المواد التي سعرها أعلى من سعر أية مادة ظهرت في إحدى الفواتير. 

3. المادة المباعة و الأعلى سعراً. 

4. المواد التي لم يتم البيع منها. 

الإجابة: (2)

--- Page 20 ---

نتيجة التعليمية التالية: 

SELECT
FROM
WHERE 

Name, Sum(price*qty) AS TotalSales
Material, Invoice, Invoice_item 

Material.id=Invoice_item.material
And invoice_item.invoice=invoice.id
And date > '1/1/2015' 

GROUP BY 

name 

هي: 

1. اجمالي الفواتير بعد تاريخ 1-1-2015. 

2. إجمالي المبيعات حسب المادة بعد تاريخ 1-1-2015. 

3. مجموع أسعار المواد المباعة بتاريخ 1-1-2015. 

4. مبيعات المواد مجمعة حسب التاريخ. 

الإجابة: (2)
