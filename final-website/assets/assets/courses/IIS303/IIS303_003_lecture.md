--- Page 1 ---

المحاضرة الثالثة 

لغة التعامل مع البيانات DML 

تذكر: شرح قواعد البيانات النموذجية المستخدمة 

سنشرح مخطط كيانات – علاقات ERD لمثالين شهيرين عن قواعد البيانات ضمن
MS SQL Server وMS، Northwind: Pubs 

شرح قاعدة البيانات Pubs 

وهي قاعدة بيانات لشركة تقوم ببيع الكتب. يتبع لهذه الشركة مجموعة من المتاجر Stores التي يجري كلا منها حسومات Discounts على المبيعات. يقوم كل متجر بعمليات بيع Sales للكتب Titles المتوفرة لديه. لكل كتاب مجموعة من المؤلفين TitleAuthor. كل مؤلف Author يشارك في تأليف مجموعة من الكتب. لكل كتاب دار نشر Publishers معين. في كل دار نشر مجموعة من الوظائف Jobs التي يعمل في كل منها عدة موظفين Employees. لكل ناشر شعار وتوصيف لعنوان الناشر التي تخزن في الجدول Pub_info. 

المخطط العام

--- Page 2 ---

<center>Part I - Titles - Authors </center>

--- Page 3 ---

Part II 

Titles - Stores, Titles - Publishers, Publishers - Jobs 

قاعدة البيانات Northwind 

وهي قاعدة بيانات لشركة افتراضية تدعى Northwind Traders Company. تقوم هذه الشركة بتزويد بإنتهاء Customers بالطلبات Orders التي قام موظفو الشركة Employees بتوقيعها مع الزبائن. لكل طلبية مجموعة من البنود Order Items التي يوافق كل منها منتجاً Product.

--- Page 4 ---

تؤمن الشركة كل منتج عن طريق موردين Suppliers. تقوم الشركة بتوصيل الطلبية إلى الزبائن 

عن طريق موزعين Shippers. 

المخطط العام

--- Page 5 ---

(Part II) Customers - orders

--- Page 6 ---

(Part III) Products - orders 

## Data Manipulation Language لغة معالجة البيانات 

DML هي جزء من لغة SQL تتضمن التعليمات الخاصة باستعادة البيانات و اضافتها و تعديلها وحذفها وتدعى كل تعليمة استعلاماً Query مثل: 

SELECT وهي مخصصة لقراءة البيانات و استخلاصها من قاعدة البيانات. INSERT وهي مخصصة لإضافة سجلات جديدة إلى قاعدة البيانات.

--- Page 7 ---

: DELETE
: وهي مخصصة لحذف سجل أو مجموعة سجلات من قاعدة البيانات.
: UPDATE
: وهي مخصصة لتعديل سجل أو مجموعة من السجلات في قاعدة البيانات. 

استخدام تعليمية Select في استعادة البيانات من قاعدة البيانات.
تُعتبر تعليمية SELECT من أشهر تعليمات اللغة وأكثرها استخداماً. تُستخدم هذه التعليمية لاستعادة و انتقاء مجموعة من البيانات من قاعدة البيانات و ذلك بإعادة جدول يحتوي مجموعة البيانات المطلوبة. 

Select Coll, Col2, Col3 ... From Tab 

مثال: من قاعدة البيانات Pubs، اكتب تعليمية اختيار الاسماء لجميع السجلات من جدول المؤلفين. 

Select au_Fname From Authors 

• تُستخدم إشارة * كبديل لأسماء الحقول (عادة لا ننصح باستخدامها في الحالات التطبيقية لأنها تُحمّل برنامج إدارة قاعدة البيانات عبء تحديد الحقول وتحديد عددها و أسماءها). 

مثال: من قاعدة البيانات Pubs، اكتب تعليمية اختيار جميع السجلات من جدول المؤلفين. 

Select * From Authors 

Select Authors.* From Authors أو 

• يُستخدم تعبير DISTINCT لاستعادة جميع السجلات مع إلغاء التكرار في السجلات المعادة ويستخدم التعبير ALL لاستعادة جميع السجلات مع تأكيد

--- Page 8 ---

التكرار في السجلات المعادة علماً أن عدم استخدام أي تعبير سيؤدي لاستعادة جميع السجلات مع التكرار في السجلات المعادة افتراضياً. 

- مثال 1: من قاعدة البيانات (Northwind)، ما هي البلدان التي يوجد فيها زبان؟ 

Select country From customers 

نلاحظ تكرار البلدان دون استخدام أي تعبير اضافي – الوضع الافتراضي 

مثال 2: من قاعدة البيانات (Northwind)، ما هي البلدان (بدون تكرار) التي يوجد فيها زبان؟ 

Select Distinct country From customers 

نلاحظ عدم تكرار البلدان 

مثال 3: من قاعدة البيانات (Northwind)، ما هي البلدان (مع تأكيد التكرار) التي يوجد فيها زبان؟ 

Select all country From customers 

نلاحظ تكرار البلدان 

- يُستخدم التعبير BY ORDER BY لترتيب السجلات المُعادة ترتيباً تصاعدياً أو تنازلياً حسب التعبير المرافق المستخدم: ASC للترتيب التصاعدي أو DESC للترتيب التنازلي وفي حال عدم تحديد نوع الترتيب يكون الترتيب الافتراضي تصاعدياً. 

مثال: من قاعدة البيانات (Pubs)، اكتتب تعليمية اختيار جميع السجلات من جدول المؤلفين. السجلات يجب أن تكون مرتبة حسب كنية المؤلف تصاعديا، وحسب اسم المؤلف تنازليا

--- Page 9 ---

Select * From Authors Order by au_lname asc, au_Fname desc 

Select * From Authors Order by au_lname , au_Fname desc أو 

• في حال الرغبة باستخدام أسماء بديلة Alias لحقول جدول القيم المعادة نستخدم 

التعبير AS 

مثال: من قاعدة البيانات Pubs، اكتب تعليمية اختيار اسم المؤلف، كنية المؤلف، 

رقم الهاتف، المدينة، الولاية من جدول المؤلفين مع الترتيب حسب الاسم والكنية تصاعدياً. 

Select au_Fname, au_lname, phone as telephone, City, State 

From Authors Order by au_Fname , au_lname 

• نستخدم الكلمة المفتاحية WHERE مع تعليمية SELECT لاستعادة مجموعة 

من السجلات التي تحقق شرط أو مجموعة من الشروط التي نعبر عنها بعبارة شرطية. تُعيد العبارة الشرطية قيمة منطقية (صح أو خطأ). 

يمكن للعبارة الشرطية أن تتضمن عمليات مقارنة مثل (=>, <, >, <, >, =) ويتم ضم السجل الذي يحققها إلى جدول النتائج. 

مثال 1: من قاعدة البيانات Pubs، اكتب تعليمية اختيار جميع أسماء المؤلفين وأسماءهم الذين يسكنون في ولاية CA، مرتبين حسب الاسم والكنية. 

Select au_Fname, au_lname From Authors Where state = 'CA' 

Order by au_Fname asc, au_lname asc

--- Page 10 ---

مثال 2: من قاعدة البيانات Northwind، من هم الزبائن من خارج 'Argentina' 

Select Contactname, contacttitle, country From customers 

Where county <> 'Argentina' 

- تُستخدم الكلمة المفتاحية LIKE ضمن العبارة الشرطية، كشرط لوجود مثيل.
غالباً ما تُستخدم هذه الكلمة مع إشارة (%)، التي تضاف إلى القيمة التي نبحث
عن مثيلاتها، كبديل عن أي رقم من الأرقام أو الأحرف 

Wildcard: 

تستخدم مع LIKE كبديل عن محرف أو عدة محارف عند الاستعلام من قاعدة البيانات: 

<table><tr><td>Wildcard</td><td>Description</td></tr><tr><td>%</td><td>A substitute for zero or more characters</td></tr><tr><td>_</td><td>A substitute for exactly one character</td></tr><tr><td>[charlist]</td><td>Any single character in charlist</td></tr><tr><td>[^charlist]</td><td>Any single character not in charlist</td></tr></table>

--- Page 11 ---

مثال 1: من قاعدة البيانات Northwind، من هم الزبائن الذين يسكنون في بلدان يبدأ اسمها بحرف U. 

Select Contactname, contacttitle, country From customers 

Where country like 'u%' Order by country asc 

مثال 2: من قاعدة البيانات Pubs، من هم مجموعة المؤلفين الذين يبدأ اسمهم بأحد الأحرف التالية (j, a, b). 

Select * From Authors Where au_Fname Like '[jab]%' 

مثال 3: من قاعدة البيانات Pubs، من هم مجموعة المؤلفين الذين لا يبدأ اسمهم بأحد الأحرف التالية (j, a, b). 

Select * From Authors Where au_Fname Like '[^jab]%' 

مثال 4: من قاعدة البيانات Pubs، من هم مجموعة المؤلفين الذين يكون اسمهم يحوي مقاطع الأحرف A ثم rah ثم m بالترتيب. 

Select * From Authors Where au_Fname Like 'A_rah_m' 

• تُستخدم الكلمة المفتاحية BETWEEN ضمن العبارة الشرطية، كشرط لوجود قيمة محصورة بين قيمتين محددتين 

مثال: من قاعدة البيانات Northwind، ما هي المنتجات التي يتوفر منها في المخزن من 100 إلى 200 وحدة؟ 

Select Productname, unitsinstock From products 

Where unitsinstock between 100 and 200

--- Page 12 ---

- تقبل الكلمة المفتاحية WHERE أكثر من شرط يفصل بينها عمليات منطقية مثل AND أو OR ويمكن أن يسبق الشرط العملية NOT لنفيه. 

Operators: 

<table><tr><td>Operator</td><td>Description</td></tr><tr><td>= (Equals)</td><td>Equal to</td></tr><tr><td>&gt; (Greater Than)</td><td>Greater than</td></tr><tr><td>&lt; (Less Than)</td><td>Less than</td></tr><tr><td>&gt;=(Greater Than or Equal To)</td><td>Greater than or equal to</td></tr><tr><td>&lt;= (Less Than or Equal To)</td><td>Less than or equal to</td></tr><tr><td>&lt;&gt; (Not Equal To)</td><td>Not equal to</td></tr><tr><td>!= (Not Equal To)</td><td>Not equal to (not ISO standard)</td></tr><tr><td>!&lt; (Not Less Than)</td><td>Not less than (not ISO standard)</td></tr><tr><td>!&gt; (Not Greater Than)</td><td>Not greater than (not ISO standard)</td></tr><tr><td>Union</td><td>Combines the result of two or more queries and returns a single result set</td></tr></table>

--- Page 13 ---

<table><tr><td></td><td>excluding the duplicate values.<br>Some rules to remember while working with UNION operator:<br>1. The number of columns must be same.<br>2. The data type of the columns must be same or implicitly convertible by database.</td></tr><tr><td>UNIONALL</td><td>Union but includes the duplicate values.</td></tr><tr><td>Intersect</td><td>Takes the result of two queries and returns common rows which appear in both the result sets excluding the duplicate values.</td></tr><tr><td>EXCEPT</td><td>Returns distinct rows from the first query which do not appear into the second result set.</td></tr><tr><td>ALL</td><td>TRUE if all of a set of comparisons are TRUE.</td></tr><tr><td>AND</td><td>TRUE if both Boolean expressions are TRUE.</td></tr></table>

--- Page 14 ---

<table><tr><td>ANY</td><td>TRUE if any one of a set of comparisons are TRUE.</td></tr><tr><td>BETWEEN</td><td>TRUE if the operand is within a range.</td></tr><tr><td>EXISTS</td><td>TRUE if a subquery contains any rows.</td></tr><tr><td>IN</td><td>TRUE if the operand is equal to one of a list of expressions.</td></tr><tr><td>LIKE</td><td>TRUE if the operand matches a pattern.</td></tr><tr><td>Is Null</td><td>TRUE if the value is Null</td></tr><tr><td>OR</td><td>TRUE if either Boolean expression is TRUE.</td></tr><tr><td>SOME</td><td>TRUE if some of a set of comparisons are TRUE.</td></tr><tr><td>+ (Add)</td><td>Addition</td></tr><tr><td>- (Subtract)</td><td>Subtraction</td></tr><tr><td>* (Multiply)</td><td>Multiplication</td></tr><tr><td>/ (Divide)</td><td>Division</td></tr></table>

--- Page 15 ---

<table><tr><td>% (Modulo)</td><td>Returns the integer remainder of a division. For example, 12 % 5 = 2 because the remainder of 12 divided by 5 is 2.</td></tr><tr><td>& (Bitwise AND)</td><td>Bitwise AND (two operands of any integer data type category).</td></tr><tr><td>| (Bitwise OR)</td><td>Bitwise OR (two operands of any integer data type category).</td></tr><tr><td>^ (Bitwise Exclusive OR)</td><td>Bitwise exclusive OR (two operands of any integer data type category).</td></tr></table>

مثال 1: من قاعدة البيانات 'Northwind'، من هم الزبائن من 'Argentina' أو 'USA' 

Select Contactname, contacttitle, country From customers 

Where county = 'Argentina' or county = 'USA' 

مثال 2: من قاعدة البيانات 'Northwind'، أوجد اسم المنتج وسعره من جدول المنتجات
للمنتجات التي سعرها ضمن المجموعة (19,20,18) 

Select productName, unitPrice From products Where unitPrice IN (18, 19, 20)

--- Page 16 ---

Select productName, unitPrice From products
Where unitPrice = 18 OR unitPrice = 19 OR unitPrice = 20 

مثال 3: من قاعدة البيانات (Northwind)، أوجد اسم المنتج وسعره من جدول المنتجات للمنتجات التي سعرهها ليس ضمن المجموعة (19,20,18) 

Select productName, unitPrice From products Where unitPrice
Not IN (18, 19, 20) 

مثال 3: من قاعدة البيانات (Northwind)، أوجد اسم المورد من جدول الموردين حيث لا يوجد رقم فاكس. 

Select companyName
From suppliers Where fax IS NULL
مثال 4: من قاعدة البيانات (Northwind)، أوجد المدينة والبلد التي فيها موظفين أو زبائن. 

- مع حذف التكرار 

Select city, country from employees 

Union 

Select city, country from customers 

- بدون حذف التكرار 

select city, country from employees

--- Page 17 ---

Unionall 

Select city, country from customers 

مثال 5: من قاعدة البيانات Northwind، أوجد المدينة والبلد التي فيها موظفين و
زبان معاً. 

select city, country from employees 

Intersect 

Select city, country from customers 

مثال 6: من قاعدة البيانات Northwind، أوجد المدينة التي فيها موظفين ولايوجد فيها
زبان. 

select city from employees 

except 

Select city from customers 

تعليمية الإضافة 

استخدام تعليمية Insert لإدراج سجل أو أكثر ضمن جدول من قاعدة البيانات

--- Page 18 ---

Insert into Tab (col1, col2, col3...) values (val1, val2, val3...) 

أو 

Insert into Tab values (val1, val2, val3...) 

- عند اضافة سجل أو أكثر إلى جدول يجب عدم اضافة قيم للحقول التي تتولد بشكل تلقائي. 

مثال: 

insert into department values ( 5, 'sa', '2/20/2013') 

لاحظ الخطأ التاج 

insert into department values ('sa', '2/20/2013') 

insert into department values ('sa', '5-28-2017') ; 

insert into department values ('sa', '2-20-2013 13:00:10') 

- عندما نضيف سجل أو أكثر إلى جدول يمكننا وضع اسماء الحقول بالترتيب الذي 

نريد ثم نضيف القيم بالترتيب ذاته. 

مثال: من قاعدة البيانات Northwind، اضف سجلا لجدول الموزعين 

يحوي المعلومات التالية: 

<table><tr><td>Phone</td><td>Companyname</td></tr><tr><td>(011)333-1234</td><td>Kadvous</td></tr></table>

--- Page 19 ---

Insert into shippers (phone, Companyname) Values 

('011)333-1234', 'Kadmous') 

- عندما نضيف سجل أو أكثر إلى جدول يمكننا تجاهل وضع اسماء الحقول ونضيف القيم بالترتيب الذي وردت فيه الحقول عند انشاء الجدول. 

مثال: من قاعدة البيانات Northwind، اضف سجل لجدول الموزعين Shippers
يحوي المعلومات التالية: 

<table><tr><td>Phone</td><td>Companyname</td></tr><tr><td>(011)222-1994</td><td>DHL</td></tr></table>

Insert into shippers values ('DHL', '011)222-1994') 

- يمكن اضافة سجل أو أكثر لجدول مع تحديد قيم لبعض الحقول وليس كلها (طبعا يجب تحديد قيم لكل الحقول التي لا تسمح بقيم null). 

مثال: من قاعدة البيانات Northwind، اضف سجل لجدول الموزعين Shippers
يحوي المعلومات التالية: 

<table><tr><td>Companyname</td></tr><tr><td>Ahlya</td></tr></table>

Insert into shippers (Companyname) values ('Ahlya') 

وتكون النتيجة اضافة سجل باسم شركة الموزع 'Ahlya' مع رقم هاتف فارغ null.

--- Page 20 ---

• يمكن اضافة عدة سجلات إلى جدول. 

طريقة أولى (قبل 2008: sql server) : تكرار تعليمية Insert عدة مرات. 

مثال 1: 

Insert into shippers values ('DHL1', '(011)255-1774') 

Insert into shippers values ('DHL2', '(011)442-1900') 

Insert into shippers values ('DHL3', '(011)352-1764') 

طريقة ثانية (sql server 2008) وما بعد): تعليمية Insert واحدة. 

مثال 2: 

Insert into shippers 

Values ('DHL4', '(011)987-8764'), ('DHL5', '(012)344-1722'), 

('DHL6', '(033)444-2564') 

مثال 3: 

Insert into shippers 

Select 'Xp1', '(055)793-9764' 

Union all 

Select 'Xp2', '(078)907-8004' 

• يمكن اضافة سجلات يتم استرجاعها من جدول إلى جدول آخر. 

مثال 1:

--- Page 21 ---

Insert into shippers 

Select * From 

( 

Select 'Xp3', '(056)733-9664' 

Union all 

Select 'Xp4', '(022)867-8222' 

) 

:2ثالثا 

Select Companyname, Phone Into Shippers 

From Customers Where Country = 'UK' 

:3ثالثا 

Insert Into Shippers 

Select Companyname, Phone From Customers 

Where Country = 'USA' 

استخدام تعليمية Update لتعديل سجل أو أكثر في جدول من قاعدة البيانات: 

ويمكن استخدام الكلمة المفتاحية WHERE مع تعليمية UPDATE. تأخذ تعليمية
الصيغة: UPDATE 

UPDATE Tab SET col1= NewVal1, col2 = NewVal2... 

يمكن استخدام الكلمة المفتاحية WHERE مع تعليمية UPDATE لتحديد شروط
التعديل: 

UPDATE Tab SET col1= NewVal1, col2 = NewVal2...

--- Page 22 ---

WHERE condition 

مثال 1: من قاعدة البيانات Northwind، عدل البيانات التي أضفتها سابقا للجدول
Shippers لتغيير اسم الموزع من 'DHL4' إلى 'Delivery Speed' : 

UPDATE Shippers SET companyname = 'Delivery Speed' 

WHERE companyname = 'DHL4' 

مثال 2: من قاعدة البيانات Northwind، عدل البيانات التي أضفتها سابقا للجدول
Shippers لتغيير رقم الهاتف لكل الشركات ليصبح '(000)333-2222' : 

UPDATE Shippers SET Phone = '(000)333-2222' 

استخدام تعليمية Delete لحذف سجل أو أكثر من جدول في قاعدة البيانات: 

DELETE FROM Tab 

أو 

DELETE FROM Tab WHERE col1= Val1 

• يمكن حذف جميع السجلات دفعة واحدة دون حذف بنية الجدول 

• يمكن حذف عدة سجلات تحقق شرط فلترة معين. 

مثال 1: من قاعدة البيانات Northwind، احذف البيانات التي أضفتها سابقا للجدول
Shippers والتي يكون اسم الموزع فيها يبدأ بـ 'DHL%' : 

Delete shippers where companyname like 'DHL%' 

• يمكن حذف سجل واحد يحقق شرطا معينا.

--- Page 23 ---

مثال 2: من قاعدة البيانات Northwind، احذف السجل من الجدول Shippers و اسم الموزع فيه 'Kadmous' والسجل الذي يكون فيه معرف الشركة < 8 والسجل الذي يكون فيه رقم الهاتف '(055)793-9764' 

Delete shippers Where Shipperd > 8 

Delete shippers Where companyname = 'Kadmous' 

Delete shippers Where phone = '(055)793-9764' 

- نلاحظ أن حذف سجلات يمكن أن يشكل فجوة gab في الجدول. 

- يمكن استخدام عدة شروط في فقرة Where ويتم الحذف عندما تكون الشروط 

- محققة باستخدام and, or, not 

- انتهت المحاضرة.
