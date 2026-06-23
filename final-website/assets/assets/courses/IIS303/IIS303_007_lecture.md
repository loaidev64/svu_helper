--- Page 1 ---

ربط الجداول 

Joining Tables 

فكرة المحاضرة: 

سنناقش في هذا الدرس مبادئ وتقنيات إنشاء استعلامات متعددة الجداول، بما في ذلك ربط استعلامين
فرعيين ضمن عبارة From. إذ يمكن لاستعلام SQL التعامل مع عدد كبير من الجداول، لكن يجب على كل
جدول أن يتشارك بحقل مع جدول واحد على الأقل ليتم تشكيل ما يسمى سلسلة العلاقات أو
chain. يوجد العديد من أشكال الربط بين الجداول، وتختلف الصيغة باختلاف نظام إدارة قواعد البيانات. 

مواضيع المحاضرة: 

كيف يقوم SQL بربط الجداول؟
الربط البسيط أو الجداء الديكارتي Cartesian Product
الربط بالتساوي Equi Join
الربط باللامساوة Non-Equi Join
الربط الداخلي Inner Join
الربط الخارجي Outer Join
الربط الذاتي Self Join
ربط استعلامين فرعيين Join two sub-queries 

مقدمة: 

وجدنا فيما سبق أن الاستعلام عن أكثر من جدول باستخدام الاستعلامات الفرعية قد وفر قدرات جيدة على
معالجة البيانات. ولكن هذه القدرات قد لا تمكننا دائماً من الحصول على كل النتائج التي نحتاجها. كما أن
الصيغة قد تصبح صعبة الفهم بعض الشيء وقد تؤدي إلى انخفاض مستوى الأداء أحياناً. 

توفر SQL إمكانية الاستعلام عن جداول متعددة في وقت واحد باستخدام صيغة أبسط ندعوها الربط. 

لا تستطيع الصيغة الجديدة استبدال كل التقنيات التي تؤمنها الاستعلامات الفرعية، ولكنها تمثل الحل الأمثل
في بعض الحالات، وخاصة في الاستعلامات التي تربط بين سجلات من جداول مختلفة. 

نبذاً فيما يلي بعرض حالات الربط البسيطة لنصل بعد ذلك إلى الحالات الأكثر تعقيداً: 

• الربط البسيط أو الجداء الديكارتي Cartesian product 

• الربط بالتساوي Equi Join 

• الربط بعدم المساواة Non-Equi Join 

• الربط الخارجي Outer Join 

كيف يقوم SQL بربط الجداول؟ 

ليكن لدينا الجدولين التاليين:

--- Page 2 ---

<table><tr><td colspan="2">Department</td></tr><tr><td>DeptID</td><td>DeptName</td></tr><tr><td>Actg</td><td>Accounting</td></tr><tr><td>Admn</td><td>Administration</td></tr><tr><td>Fin</td><td>Finance</td></tr><tr><td>Mktg</td><td>Marketing</td></tr></table>

<table><tr><td colspan="4">Employee</td></tr><tr><td>EmpID</td><td>FirstName</td><td>LastName</td><td>Gender</td><td>DeptID</td></tr><tr><td>1</td><td>عمر</td><td>السهاي</td><td>Male</td><td>Actg</td></tr><tr><td>2</td><td>طارق</td><td>عود</td><td>Male</td><td>Mktg</td></tr><tr><td>3</td><td>سامية</td><td>سمان</td><td>Female</td><td>Mktg</td></tr><tr><td>4</td><td>حنان</td><td>آغا</td><td>Female</td><td>NULL</td></tr></table>

<table><tr><td colspan="4">Children</td></tr><tr><td>ChildID</td><td>ChildName</td><td>Gender</td><td>Birthdate</td><td>EmpID</td></tr><tr><td>1</td><td>سحر</td><td>Female</td><td>11/02/1990</td><td>1</td></tr><tr><td>2</td><td>طوني</td><td>Male</td><td>19/02/1990</td><td>2</td></tr><tr><td>3</td><td>رهام</td><td>Female</td><td>30/08/1992</td><td>1</td></tr><tr><td>4</td><td>لميس</td><td>Female</td><td>19/09/1980</td><td>3</td></tr><tr><td>5</td><td>وسيم</td><td>Male</td><td>04/03/1999</td><td>4</td></tr><tr><td>6</td><td>حسن</td><td>Male</td><td>02/07/2000</td><td>1</td></tr><tr><td>7</td><td>محمد</td><td>Male</td><td>29/05/1991</td><td>3</td></tr><tr><td>8</td><td>عبير</td><td>Female</td><td>09/01/2001</td><td>2</td></tr></table>

## تذكير ببعض التعريفات: 

- **المفتاح الرئيسي: Primary key** 

حقل أو أكثر تعرف فيه قيمة أو قيم فريدة لكل سجل في الجدول. في الجدول السابقة يمثل الحقل Department. ويمثل الحقل Employee. ويمثل الحقل DeptID. مفتاحاً رئيسياً للجدول Department. ويمثل الحقل ChildID. 

- **المفتاح الخارجي: Foreign key** 

حقل أو أكثر من حقول الجدول يشير إلى حقول أو حقول المفتاح الرئيسي في جدول آخر. في الجدول السابقة يمثل الحقل DeptID. الموجود في الجدول Employee. مفتاحاً خارجياً للجدول Department. 

## الرابط البسيط أو الجداء الديكارتي Cartesian Product 

تتم عملية الربط بمقابلة كل سجل من الجدول الأول مع جميع سجلات الجدول الثاني. وهذا ما يدعى بالجاء الديكارتي أو Cartesian product. وفي هذه الحالة يكون عدد السجلات الناتجة عن الاستعلام هو عدد سجلات الجدول الأول × عدد سجلات الجدول الثاني. 

مثال: نتيجة الربط البسيط بين الجدولين: Employee و Department. هي:

--- Page 3 ---

Cartesian Product 

<table><tr><td>EmpID</td><td>FirstName</td><td>LastName</td><td>Gender</td><td>DeptID</td><td>DeptID</td><td>DeptName</td></tr><tr><td>1</td><td>عمر</td><td>السهاي</td><td>male</td><td>actg</td><td>actg</td><td>accounting</td></tr><tr><td>2</td><td>طارق</td><td>العواد</td><td>male</td><td>mktg</td><td>actg</td><td>accounting</td></tr><tr><td>3</td><td>سامية</td><td>سمن</td><td>female</td><td>mktg</td><td>actg</td><td>accounting</td></tr><tr><td>4</td><td>حنان</td><td>أغا</td><td>female</td><td>NULL</td><td>actg</td><td>accounting</td></tr><tr><td>1</td><td>عمر</td><td>السهاي</td><td>male</td><td>actg</td><td>adm</td><td>administration</td></tr><tr><td>2</td><td>طارق</td><td>العواد</td><td>male</td><td>mktg</td><td>adm</td><td>administration</td></tr><tr><td>3</td><td>سامية</td><td>سمن</td><td>female</td><td>mktg</td><td>adm</td><td>administration</td></tr><tr><td>4</td><td>حنان</td><td>أغا</td><td>female</td><td>NULL</td><td>adm</td><td>administration</td></tr><tr><td>1</td><td>عمر</td><td>السهاي</td><td>male</td><td>actg</td><td>fin</td><td>finance</td></tr><tr><td>2</td><td>طارق</td><td>العواد</td><td>male</td><td>mktg</td><td>fin</td><td>finance</td></tr><tr><td>3</td><td>سامية</td><td>سمن</td><td>female</td><td>mktg</td><td>fin</td><td>finance</td></tr><tr><td>4</td><td>حنان</td><td>أغا</td><td>female</td><td>NULL</td><td>fin</td><td>finance</td></tr><tr><td>1</td><td>عمر</td><td>السهاي</td><td>male</td><td>actg</td><td>Mktg</td><td>marketing</td></tr><tr><td>2</td><td>طارق</td><td>العواد</td><td>male</td><td>mktg</td><td>Mktg</td><td>marketing</td></tr><tr><td>3</td><td>سامية</td><td>سمن</td><td>female</td><td>mktg</td><td>Mktg</td><td>marketing</td></tr><tr><td>4</td><td>حنان</td><td>أغا</td><td>female</td><td>NULL</td><td>Mktg</td><td>marketing</td></tr></table>

يمكن التعبير عن صيغة الربط بالصيغة التالية: 

SELECT Table1.Column1, Table2.Column2
FROM Table1, Table2; 

يسمى استعلام الربط البسيط أيضاً بالربط المتصالب أو Cross join. ويمكن التعبير عن نفس صيغة الربط السابقة، بالصيغة: 

SELECT Table1.Column1, Table2.Column2
FROM Table1 CROSS JOIN Table2; 

Equi Join الربط بالتصاوي 

يُعَرَّف الربط بالتصاوي على أنه الربط البسيط بين سجلات جدول أول، وسجلات جدول ثان اعتماداً على مساواة بين قيمة حقل في سجل من الجدول الأول (عادة المفتاح الخارجي) وقيمة حقل في سجل من الجدول الثاني (عادة المفتاح الرئيسي). 

يُعَرَّف عن الربط بالتصاوي بالصيغة:

--- Page 4 ---

SELECT Table1.Column1, Table1.Column2, Table2.Column3 

FROM Table1, Table2 

WHERE Table1.Column1 = Table2.Column2; 

عموماً، لا تستخدم عملية الربط بالضرورة نفس الحقوق التي يجب أن يعيدها الاستعلام. 

مثال: لنفرض أننا نبحث عن أسماء الموظفين الذين يعملون في قسم المحاسبة. عندها سيكون الاستعلام على الشكل التالي: 

SELECT DeptName, FirstName, LastName
FROM Employee, Department
WHERE Employee.DeptID = Department.DeptID
    AND DeptName = 'Accounting' 

وستكون النتيجة هي: 

DeptName 

FirstName 

LastName 

Accounting 

عمر 

السهل 

Equi Join 

SELECT Table1.Column1, Table1.Column2, Table2.Column3 

FROM Table1, Table2 

WHERE Table1.Column1 = Table2.Column2; 

SELECT Table1.Column1, Table1.Column2, Table2.Column3 

FROM Table1 Join Table2 

ON Table1.Column1 = Table2.Column2; 

1. أسماء الموظفين الذين لديهم ولد اسمه وسيم. 

SELECT FirstName, LastName 

FROM Employee, Children 

WHERE Employee.Empid = Children.Empid 

AND ChildName = 'وسيم' 

2. أسماء الأبناء الذكور للموظفين العاملين في قسم التسويق. 

SELECT ChildName 

FROM Department, Employee, Children 

WHERE Department.DeptID = Employee.DeptID 

AND Employee.Empid = Children.Empid 

AND Children.Gender = 'Male' 

AND DeptName = 'Marketing'

--- Page 5 ---

3. أسماء الموظفين وأعداد أولاد الموظفين (في جميع الأقسام) (جميع الموظفين). 

SELECT FirstName, LastName,
    Count(ChildID) As ChidrenCount
FROM Employee, Children
WHERE Employee.EmpID = Chidren.EmpID
GROUP BY FirstName, LastName 

## انتبه: 

عند إضافة العلاقة «Primary key – Foreign key »، يتم استعمال اسم الجدول ملحقاً بنقطة «.» لمنع الالتهاب عند تشابه أسماء الحقول الموجودة في عدة جداول. 

كما يجب استخدام اسم الجدول ملحقاً بنقطة ضمن التعبير «Select أو Where» أيضا عند إمكانية حدوث التباس بالحقول. انظر المثال 2 في الجدول السابق. 

## ALBUL Non-Equi Join الربط باللامساواة 

يعتمد الربط بالمساواة على استخدام المساواة في شرط التعبير WHERE ولكن هذا لا يعني أننا لا نستطيع استخدام عمليات المقارنة الأخرى (أكبر، أصغر، وغيرها) كما في الصيغة التالية: 

SELECT Table1.Column1, Table2.Column2
FROM Table1, Table2
WHERE Table1.Column1 < Table2.Column2; 

## مثال: 

تحديد الاستعلام الذي يعطي أسماء الأقسام وأسماء الموظفين الذين لا يعملون فيها. عندها سيكون الاستعلام على الشكل التالي: 

SELECT DeptName, FirstName, LastName
FROM Employee, Department
WHERE Employee.DeptID <> Department.DeptID 

## وستكون النتيجة هي: 

<table><tr><td>accounting</td><td>طارق</td><td>العواد</td></tr><tr><td>accounting</td><td>سامية</td><td>سمان</td></tr><tr><td>administration</td><td>عمر</td><td>السهاي</td></tr><tr><td>administration</td><td>طارق</td><td>العواد</td></tr><tr><td>administration</td><td>سامية</td><td>سمان</td></tr><tr><td>finance</td><td>عمر</td><td>السهاي</td></tr><tr><td>finance</td><td>طارق</td><td>العواد</td></tr><tr><td>finance</td><td>سامية</td><td>سمان</td></tr><tr><td>marketing</td><td>عمر</td><td>السهاي</td></tr></table>

--- Page 6 ---

الربط الداخلي Inner Join 

يعطي الربط الداخلي نفس النتيجة التي يعطيها الربط بالتساوي، الفرق فقط بالصيغة. إذ لا تزودنا جميع أنواع أنظمة إدارة قواعد المعطيات بالربط الداخلي. فنسخ Oracle ما قبل 9 لا تدعم الربط الداخلي. بالنسبة للصيغة، يوجد اختلافان: 

- يفصل بين أسماء الجداول الكلمات Inner Join بدلاً من الفواصل "،". 

- يتغير موضع تحديد العلاقة بين الجداول من Where إلى On، تاركين بذلك التعبير Where للشروط التقليدية. 

الأمثلة الواردة في الجدول التالي هي نفسها الواردة في فقرة الربط بالتساوي، وبالتالي يمكنك المقارنة. 

<table><tr><td colspan="2">Inner Join</td></tr><tr><td>SELECT *<br/>FROM Table1 INNER JOIN Table2 ON Table1.Field = Table2.Field</td><td>Syntax<br/>الصيغة</td></tr><tr><td>1. أسماء الموظفين الذين لديهم ولد اسمه وسيم.<br/>SELECT FirstName, LastName<br/>FROM Employee Inner Join Children<br/>ON Employee.EmpID = Children.EmpID<br/>WHERE ChildName = 'وسيم'</td><td>مثال</td></tr><tr><td>2. أسماء الأبناء الذكور للموظفين العاملين في قسم التسويق.<br/>SELECT ChildName<br/>FROM Department<br/>Inner Join Employee<br/>ON Department.DeptID = Employee.DeptID<br/>Inner Join Children<br/>ON Employee.EmpID = Children.EmpID<br/>WHERE Children.Gender = 'Male'<br/>AND DeptName = 'Marketing'</td><td></td></tr><tr><td>2. ب. أسماء الأبناء الذكور للموظفين العاملين في قسم التسويق.<br/>SELECT ChildName<br/>FROM (Department<br/>Inner Join Employee<br/>ON Department.DeptID = Employee.DeptID)<br/>Inner Join Children<br/>ON Employee.EmpID = Children.EmpID<br/>WHERE Children.Gender = 'Male'<br/>AND DeptName = 'Marketing'</td><td></td></tr></table>

--- Page 7 ---

3. أسماء وأعداد أولاد الموظفين في جميع الأقسام. 

SELECT FirstName, LastName,
    Count(ChildID) As ChidrenCount
FROM Employee
    Inner Join Children
    ON Employee.EmpID = Children.EmpID
GROUP BY FirstName, LastName 

مثال 

ملاحظة: 

رأينا فيما سبق كيفية تغيير اسم حقل أو عمود ضمن التعبير Select في أي استعلام، وذلك عبر ما يسمى Alias. يمكننا أيضًا تغيير أسماء الجداول ضمن SQL. بهدف تفسير طول الاستعلام أو تسهيل قراءته. لاستعمال Alias ضمن التعبير From، أتبع الاسم الحقيقي للجدول بفراغ ثم الاسم الجديد الذي ترغب بالتعامل معه. ويمكنك إضافة As بين الاسم الحقيقي للجدول والاسم الجديد له. وعند تغيير تسمية جدول، لا يمكن استخدام الاسم الحقيقي في بقية الاستعلام. يبين الجدول التالي عدة أمثلة على استخدام إعادة تسمية الجداول. 

<table><tr><td colspan="2">Table Aliases</td></tr><tr><td>SELECT *<br/>FROM Table1 Alias1 Inner Join Table2 Alias2<br/>On Alias1.Field = Alias2.Field</td><td>Syntax<br/>الصيغة</td></tr><tr><td>SELECT *<br/>FROM Table1 Alias1, Table2 Alias2<br/>Where Alias1.Field = Alias2.Field</td><td>..1</td></tr><tr><td>SELECT FirstName, LastName<br/>FROM Employee E, Children C<br/>WHERE E.EmpID = C.EmpID AND ChildName = 'وسيم'</td><td>أمثلة</td></tr><tr><td>SELECT ChildName<br/>FROM Department D<br/>Inner Join Employee E ON D.DeptID = E.DeptID<br/>Inner Join Children C ON E.EmpID = C.EmpID<br/>WHERE Children.Gender = 'Male'<br/>AND DeptName = 'Marketing'</td><td></td></tr></table>

--- Page 8 ---

## Outer Join الربط الخارجي 

في حالة INNER JOIN ، كانت السجلات التي أرجعها الاستعلام، هي السجلات التي تحقق شرط الربط الذي يظهر بعد تعبير ON ، حيث تم إسقاط السجلات غير المتطابقة من جدول النتائج. أما في حالة الربط الخارجي Outer Join فلا يتم إسقاط السجلات غير المتطابقة. 

للربط الخارجي ثلاثة أنواع: LEFT, RIGHT, FULL. 

## 1. Left Outer Join 

لأخذ جميع السجلات من الجدول الأول Table1 وفقط السجلات من الجدول الثاني Table2 التي تتطابق فيها قيمة الحقل Column1 من الجدول Column2 مع قيمة الحقل Column1 من الجدول الثاني Table2. 

SELECT * FROM Table1 LEFT OUTER JOIN Table2 ON Table1.Column1 = Table2.Column2; 

## 2. Right Outer Join 

لأخذ جميع السجلات من الجدول الثاني Table2 وفقط السجلات من الجدول الأول Table1 التي تتطابق فيها قيمة الحقل Column1 من الجدول Column2 مع قيمة الحقل Column1 من الجدول Column2. 

SELECT * FROM Table1 RIGHT OUTER JOIN Table2 ON Table1.Column1 = Table2.Column2; 

## 3. full Outer Join 

لأخذ جميع السجلات من الجدول الثاني Table2 وجميع السجلات من الجدول الأول Table1 بحيث تتوضع السجلات التي تتطابق فيها قيمة الحقل Column1 مع قيمة الحقل Column2 من الجدول Column2 مع قيمة الحقل Column1 من الجدول Column2. 

SELECT * FROM Table1 FULL OUTER JOIN Table2 ON Table1.Column1 = Table2.Column2; 

## ملاحظة: 

ينتج عن عمليات الربط الخارجي، في الحالة العامة، سجلات تحتوي في حقول معينة القيمة NULL بسبب اختلاف عدد السجلات التي نريد ربطها، وهذا ما سنوضحه بالتفصيل الحقاً مع مثال مناسب لكل نوع من أنواع الربط الخارجي.

--- Page 9 ---

ال تعتمد جميع أنظمة إدارة قواعد البيانات DBMS نفس الصيغة في التعبير عن أشكال Outer Join المختلفة 

الصيغة المستخدمة في sql server هي الصيغة المطابقة تقريباً لصيغة Inner Join (وهي ما استخدمناه فيما سبق من هذه الفقرة). أي يتم وضع الكلمات (Left Outer Join أو اختصاراً) أو الكلمات (Right Outer Join أو اختصاراً) أو الكلمات (Full Join أو اختصاراً) أو الكلمات (Right Join أو اختصاراً) والتي اسم الجدول الثاني تعليمية ON لتحديد الحقول الرابطة بين الجداول. 

<table><tr><td colspan="2">Outer Join (first syntax form)</td></tr><tr><td>SELECT Table1.Column1, Table1.Column2, Table2.Column3<br/>FROM Table1 LEFT | RIGHT | FULL JOIN Table2<br/>On Table1.Field = Table2.Field</td><td>Syntax<br/>الصيغة</td></tr><tr><td>. اعرض أسماء جميع الأقسام مع ما يقابلها من موظفين يعملون في هذه الأقسام.</td><td>مثال</td></tr><tr><td>SELECT DeptName, FirstName, LastName<br/>FROM Department LEFT JOIN Employee<br/>ON Department.DeptID = Employee.DeptID<br/>Where employee.name = null</td><td></td></tr></table>

ستكون النتيجة هي: 

<table><tr><td>accounting</td><td>طارق</td><td>العواد</td></tr><tr><td>administration</td><td>عمر</td><td>السهلي</td></tr><tr><td>administration</td><td>null</td><td>null</td></tr><tr><td>finance</td><td>null</td><td>null</td></tr><tr><td>marketing</td><td>طارق</td><td>عواد</td></tr><tr><td>marketing</td><td>عمر</td><td>السهلي</td></tr></table>

تمرين: 

أعد كتابة الاستعلام التالي مستخدماً Outer Join بدلاً من IN. 

Select Artistname 

From Artists 

Where ArtistID NOT IN (Select ArtistID From Movies); 

الحل:

--- Page 10 ---

الربط الذاتي Self Join 

الربط الذاتي هو ربط جدول مع نفسه. ويمكن ذلك عبر Inner Join أو Outer Join. لنأخذ بنية معدلة عن الجدول Employee الذي عرفناه في بداية الجلسة، وذلك بإضافة ManagerID إليه كما هو موضح في الجدول التالي. 

<table><tr><td colspan="4">Employee</td></tr><tr><td>EmpID</td><td>FirstName</td><td>LastName</td><td>DeptID</td><td>ManagerID</td></tr><tr><td>1</td><td>عمر</td><td>السهل</td><td>actg</td><td>4</td></tr><tr><td>2</td><td>طارق</td><td>العواد</td><td>mktg</td><td>4</td></tr><tr><td>3</td><td>سامية</td><td>سمان</td><td>mktg</td><td>2</td></tr><tr><td>4</td><td>حنان</td><td>أغا</td><td>NULL</td><td>NULL</td></tr></table>

يعبر الحقل الجديد ManagerID عن الرقم EmpID لمدير الموظف. وإذا كانت قيمته NULL فهذا يعني أن الموظف الحالي هو المدير العام أو ليس له مدير. 

 

تمرين: 

اكتب الاستعلام الذي يعطي أسماء جميع الموظفين مع اسم المدير (إن كان موجوداً). 

ملاحظة: نستخدم الاسم المستعار M ونستخدم معه حقل المفتاح الرئيسي، لأن العلاقة من طرف جدول المدير هي واحد وبالتالي هو الجدول الرئيسي، بينما هي من طرف الموظفين متعدد .. وبالتالي معه نستخدم المفتاح الثانوي ManagerID .... 

الحل:

--- Page 11 ---

Select E.FirstName, E.LastName, M.FirstName, M.LastName From Employee E LEFT JOIN Employee M ON E.ManagerID = M.EmpID; 

لا حفظ الاستخدام الإجبارى لإعادة التسمية (Aliasing) ضمن عبارة From في التمرين السابق. 

<table><tr><td>Self Join</td><td></td></tr><tr><td>SELECT Alias1.Field1, Alias2.Field2<br/>FROM Table Alias1 Inner | Left | Right | Full Join Table Alias2<br/>On Alias1.Field1 = Alias2.Field2</td><td>الصيغة<br/>Syntax</td></tr><tr><td>SELECT Alias1.Field1, Alias2.Field2<br/>FROM Table Alias1, Table Alias2<br/>Where Alias1.Field1 = Alias2.Field2</td><td></td></tr><tr><td>أ. أ. اكتب الاستعلام الذي يعطي أسماء جميع الموظفين مع اسم المدير (إن كان موجوداً).</td><td></td></tr><tr><td>Select E.FirstName, E.LastName, M.FirstName, M.LastName From Employee E LEFT JOIN Employee M ON E.ManagerID = M.EmpID;</td><td></td></tr><tr><td>ب. ب. اكتب الاستعلام الذي يعطي أسماء الموظفين مع اسم المدير (يعطي فقط اسم الموظف مع اسم المدير المرتبط به)</td><td></td></tr><tr><td>Select E.FirstName, E.LastName, M.FirstName, M.LastName From Employee E, Employee M WHERE E.ManagerID = M.EmpID;</td><td></td></tr></table>

## ربط استعلامين فرعيين Join two sub-queries 

في الكثير من الأحيان نضطر لاستحصال معلومات موجودة في جداول ضخمة جدا. وتؤدي عملية ربط هذه الجداول مع بعضها للحصول على كميات هائلة من السجلات المتقابلة، والتي يتم اختصارها وفق شروط معينة. أما إذا تم اختصار هذه الجداول وفق الشروط المعطاة قبل البدء بعملية الربط، سيؤدي ذلك إلى تسريع الاستعلام المطلوب، وبالتالي إلى تسريع النظام ككل. وهذا يأتي دور الاستعلامات الفرعية الموجودة ضمن عبارة FROM في اختصار عدد السجلات التي ستربط مع سجلات أخرى. 

لا يوجد مبرر في مثلنا البسيط لاستخدام الاستعلام الفرعي سوى التمرين والتدريب على المفهوم. 

ملاحظات:

--- Page 12 ---

- تعمل الاستعلامات الفرعية بشكل جيد في SQL Server 

Subqueries in FROM Clause 

SQL Server 

SELECT Field | Field, Field, Field | * 

FROM Table1 Inner | Left | Right Join 

(SELECT Field, Field FROM Table Where condition) Alias 

On Table1.Field = Alias.Field 

SELECT Field | Field, Field, Field | * 

FROM Table1, 

(SELECT Field, Field, Field FROM Table 

Where condition) Alias 

Where Table1.Field = Alias.Field 

1. ترغب المؤسسة بتقديم معونات مالية لموظفيها. لذلك ترغب بمعرفة أسماء العاملين وأعداد أولادهم الذين تزيد أعمارهم عن 5 سنوات، وذلك في كل قسم من أقسامها. 

اكتب الاستعلام الذي يؤمن للمؤسسة هذه المعلومات. 

(الاستعلام الفرعي: يعطي رقم القسم مع اسم الموظف وكنيته مع عدد أولاده الذين يزيد عددهم عن خمس سنوات وذلك لكل الأقسام). 

تقوم بربط البنية الجدول الناتج من الاستعلام الفرعي مع جدول الأقسام من أجل الحصول على اسم كل قسم... لأن الاستعلام الفرعي لا يحتوي إلا على رقم القسم... 

Select d.DeptName, sub.FirstName, sub.LastName, sub.ChildrenCount 

FROM Department D INNER JOIN 

(SELECT DeptID, FirstName, LastName, COUNT (ChildID) AS ChildrenCount 

FROM Employee INNER JOIN 

Children ON Employee.EmpID = Children.EmpID 

WHERE 

DATEDiff(yy, Children.Birthdate, GETDATE()) > 5 

GROUP BY DeptID, FirstName, LastName 

) AS sub 

ON D.DeptID = sub.DeptID 

النتيجة هي: 

<table><tr><td>accounting</td><td>عمر</td><td>السهاي</td><td>3</td></tr><tr><td>marketing</td><td>سامية</td><td>سمان</td><td>2</td></tr><tr><td>marketing</td><td>طارق</td><td>العواد</td><td>2</td></tr></table>
