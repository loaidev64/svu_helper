--- Page 1 ---

# المحاضرة الخامسة 

## التوابع في SQL 

### الهدف من الجلسة: 

سوف نتعرف في هذه الجلسة على: 

- (Functions in SQL) SQL التوابع في 

- (Aggregate functions) التوابع التجميعية 

- (Scalar functions) التوابع السلمية (الدرجية) 

 

### التوابع: 

التابع هو عبارة عن تعبير رياضي يأخذ مجموعة من قيم الدخل التي ندعوها مُعاملات، ويعيد قيمة خرج وحيدة ندعوها قيمة التابع. تتعلق قيمة التابع (أي الخرج) بمُعاملاته (أي بالدخل)، كحال التابع الذي يقوم بحساب مجموع قيم عددية. 

### أنواع التوابع في SQL: التوابع هي أغراض ضمن قاعدة المعطيات وتقسم في SQL إلى: 

- توابع النظام System Defined Functions وستناولها في هذا الدرس. 

- التوابع المعرفة من قبل المستخدم User Defined Functions ستناولها في درس لاحق. 

➤ تُقسم توابع النظام في SQL System Defined Functions حسب معيار SQL-99 إلى نوعين: 

التوابع التجميعية: وهي التوابع التي تأخذ كُمعاملات مجموعة من القيم وتعيد قيمة وحيدة، مثل التابع الذي يحسب مجموع أعداد حقيقية. مثال: 

التوابع الدرجية: وهي التوابع التي تأخذ مُعاملاً وحيداً وتُعيد قيمة وحيدة، مثل تابع القيمة المُطلقة لعدد حقيقي. مثال: 

##kowe Align Function

--- Page 2 ---

## تعريف التابع التجميعي 

هو تابع يولد قيم مختصرة Summary. يقوم التابع التجميعي بمعالجة جميع القيم المختارة في عمود ما لتوليد ناتج وحيد. 

تطبق التوابع التجميعية على الأسطر المختارة في عملية الانتقاء. 

## المخطط العام للتوابع التجميعية 

AGG-FUNC ([ ALL | DISTINCT ] Expression ) 

ALL: تطبيق التابع التجميعي على جميع القيم بما فيها القيم المكررة وهو الخيار التلقائي (الافتراضي) في حال لم يتم تحديد أي خيار. 

DISTINCT: تطبيق التابع التجميعي على القيم المختلفة فقط (تجاهل التكرار). 

Expression: هو قيمة ثابتة، أو اسم عمود، أو تعبير حسابي أو محرفي ما. 

## استخدام التوابع التجميعية في تعليمية الانتقاء SELECT 

### تابع العدد COUNT 

يحسب التابع COUNT عدد البيانات الموجودة في الجدول من أجل حقل معين أي يقوم بحساب عدد الأسطر الموجودة. 

SELECT COUNT ([* | ALL | DISTINCT] column_name) 

FROM table_name; 

يستخدم الخيار ALL عندما نريد الحصول على عدد البيانات الموجودة في الجدول، بالنسبة لحقل معين، مع استبعاد القيم التي تساوي NULL. يُعتبر هذا الخيار هو الخيار التلقائي في حال عدم تحديد أي من الخيارين أو ALL DISTINCT. 

يستخدم الخيار DISTINCT عندما نريد الحصول على عدد البيانات الموجودة في الجدول، بالنسبة لحقل معين، مع استبعاد القيم التي تساوي NULL واستبعاد القيم المكررة. 

يستخدم الخيار * عندما نريد الحصول على عدد البيانات الموجودة في الجدول، بالنسبة لحقل معين، بما فيها البيانات ذات القيمة NULL. ولكن بدون كتابة اسم الحقل.

--- Page 3 ---

select count(*) , count(distinct customer) , count(orderprice) , count(orderDate) , count(distinct orderprice) , count(ALL customer) 

From Orders 

<table><tr><td>O_Id</td><td>OrderDate</td><td>OrderPrice</td><td>Customer</td></tr><tr><td>1</td><td>null</td><td>1000</td><td>Hasan</td></tr><tr><td>2</td><td>2008/10/23</td><td>1600</td><td>Wael</td></tr><tr><td>3</td><td>2008/09/02</td><td>700</td><td>Hasan</td></tr><tr><td>4</td><td>2008/09/03</td><td>NULL</td><td>Hasan</td></tr><tr><td>5</td><td>2008/08/30</td><td>2000</td><td>Sami</td></tr><tr><td>6</td><td>null</td><td>1000</td><td>Wael</td></tr></table>

من قاعدة معطيات Northwind احسب عدد المناطق التي يوجد فيها زبائن بدون تكرارات. مثال: 

SELECT COUNT (DISTINCT Region) AS 'Region Count' FROM Customers 

select count(*) , COUNT(All region) , COUNT(distinct Region) from Customers 

احسب عدد المناطق التي يوجد فيها زبائن مع الحفاظ على التكرار. 

SELECT COUNT (ALL Region) AS 'Region Count' FROM Customers أو 

SELECT COUNT (Region) AS 'Region Count' FROM Customers 

احسب عدد المناطق التي يوجد فيها زبائن بغض النظر عن وجود قيم NULL. 

SELECT COUNT (*) AS 'Region Count' FROM Customers

--- Page 4 ---

## تابع المجموع SUM 

يقوم بحساب مجموع القيم في تعبير حسابي يتضمن عمودا واحدا أو أكثر. 

مثال: احسب مجموع المبيعات من جميع الكتب 

## SELECT SUM(ALL YTD_SALES) 'YTD SALES' FROM TITLES 

<table><tr><td>title_id</td><td>title</td><td>type</td><td>pub_id</td><td>price</td><td>advance</td><td>royalty</td><td>yd_sales</td></tr><tr><td>BU1032</td><td>The Busy Executive's ...</td><td>business</td><td>1389</td><td>19.99</td><td>5000.00</td><td>10</td><td>4095</td></tr><tr><td>BU1111</td><td>Cooking with Computer...</td><td>business</td><td>1389</td><td>11.95</td><td>5000.00</td><td>10</td><td>3876</td></tr><tr><td>BU2075</td><td>You Can Combat Comp...</td><td>business</td><td>0736</td><td>2.99</td><td>10125.00</td><td>24</td><td>18722</td></tr><tr><td>BU7832</td><td>Straight Talk About Co...</td><td>business</td><td>1389</td><td>19.99</td><td>5000.00</td><td>10</td><td>4095</td></tr><tr><td>MC2222</td><td>Silicon Valley Gastrono...</td><td>mod_cook</td><td>0877</td><td>19.99</td><td>0.00</td><td>12</td><td>2032</td></tr><tr><td>MC3021</td><td>The Gourmet Microwave</td><td>mod_cook</td><td>0877</td><td>2.99</td><td>15000.00</td><td>24</td><td>22246</td></tr><tr><td>MC3026</td><td>The Psychology of Com...</td><td>UNDECIDED</td><td>0877</td><td>NULL</td><td>NULL</td><td>NULL</td><td>NULL</td></tr><tr><td>PC1035</td><td>But Is It User Friendly?</td><td>popular_cmp</td><td>1389</td><td>22.95</td><td>7000.00</td><td>16</td><td>8780</td></tr><tr><td>PC8888</td><td>Secrets of Silicon Valley</td><td>popular_cmp</td><td>1389</td><td>20.00</td><td>8000.00</td><td>10</td><td>4095</td></tr><tr><td>PC3999</td><td>Net Etiquette</td><td>popular_cmp</td><td>1389</td><td>21.59</td><td>7000.00</td><td>10</td><td>3795</td></tr><tr><td>PS1372</td><td>Computer Phobic AND ...</td><td>psychology</td><td>0877</td><td>21.59</td><td>7000.00</td><td>10</td><td>375</td></tr><tr><td>PS2091</td><td>Is Anger the Enemy?</td><td>psychology</td><td>0736</td><td>10.95</td><td>2275.00</td><td>12</td><td>2045</td></tr><tr><td>PS2106</td><td>Life Without Fear</td><td>psychology</td><td>0736</td><td>7.00</td><td>6000.00</td><td>10</td><td>1111</td></tr><tr><td>PS3333</td><td>Prolonged Data Depriv...</td><td>psychology</td><td>0736</td><td>19.99</td><td>2000.00</td><td>10</td><td>4072</td></tr><tr><td>PS7777</td><td>Emotional Security: A N...</td><td>psychology</td><td>0736</td><td>7.99</td><td>4000.00</td><td>10</td><td>3336</td></tr><tr><td>TC3218</td><td>Onions, Leeks, and Gar...</td><td>trad_cook</td><td>0877</td><td>20.95</td><td>7000.00</td><td>10</td><td>375</td></tr><tr><td>TC4203</td><td>Fifty Years in Buckingham...</td><td>trad_cook</td><td>0877</td><td>11.95</td><td>4000.00</td><td>14</td><td>15096</td></tr><tr><td>TC7777</td><td>Sushi, Anyone?</td><td>trad_cook</td><td>0877</td><td>14.99</td><td>8000.00</td><td>10</td><td>4095</td></tr></table>

SELECT SUM(Distinct YTD_SALES) as [YTD SALES] 

FROM TITLES 

## تابع الوسطى AVG 

يقوم بحساب القيمة الوسطية لتعبير حسابي يتضمن عمودا واحدا أو أكثر 

مثال: احسب وسطى أسعار الكتب فيما لو تم زيادة سعر كل كتاب بمقدار 10$ 

SELECT AVG(PRICE + 10) AS 'AVG PRICE' FROM TITLES

--- Page 5 ---

<table><tr><td>title_id</td><td>title</td><td>type</td><td>pub_id</td><td>price</td></tr><tr><td>BU1032</td><td>The Busy Executi...</td><td>business</td><td>1389</td><td>19.99</td></tr><tr><td>BU1111</td><td>Cooking with Co...</td><td>business</td><td>1389</td><td>11.95</td></tr><tr><td>BU2075</td><td>You Can Combat ...</td><td>business</td><td>0736</td><td>2.99</td></tr><tr><td>BU7832</td><td>Straight Talk Abo...</td><td>business</td><td>1389</td><td>19.99</td></tr><tr><td>MC2222</td><td>Silicon Valley Gas...</td><td>mod_cook</td><td>0877</td><td>19.99</td></tr><tr><td>MC3021</td><td>The Gourmet Mic...</td><td>mod_cook</td><td>0877</td><td>2.99</td></tr><tr><td>MC3026</td><td>The Psychology ...</td><td>UNDECIDED</td><td>0877</td><td>NULL</td></tr><tr><td>PC1035</td><td>But Is It User Fire...</td><td>popular_comp</td><td>1389</td><td>22.95</td></tr><tr><td>PC8888</td><td>Secrets of Silicon...</td><td>popular_comp</td><td>1389</td><td>20.00</td></tr><tr><td>PC9999</td><td>Net Etiquette</td><td>popular_comp</td><td>1389</td><td>NULL</td></tr><tr><td>PS1372</td><td>Computer Phobic ...</td><td>psychology</td><td>0877</td><td>21.59</td></tr><tr><td>PS2091</td><td>Is Anger the Ene...</td><td>psychology</td><td>0736</td><td>10.95</td></tr><tr><td>PS2106</td><td>Life Without Fear</td><td>psychology</td><td>0736</td><td>7.00</td></tr><tr><td>PS3333</td><td>Prolonged Data ...</td><td>psychology</td><td>0736</td><td>19.99</td></tr><tr><td>PS7777</td><td>Emotional Securit...</td><td>psychology</td><td>0736</td><td>7.99</td></tr><tr><td>TC3218</td><td>Onions, Leeks, a...</td><td>trad_cook</td><td>0877</td><td>20.95</td></tr><tr><td>TC4203</td><td>Fifty Years in Buc...</td><td>trad_cook</td><td>0877</td><td>11.95</td></tr><tr><td>TC7777</td><td>Sushi, Anyone?</td><td>trad_cook</td><td>0877</td><td>14.99</td></tr></table>

× 10 

AVG PRICE
AVG 24.7662 

لا تدخل القيم المعدومة NULL في حساب تابع الوسطي: 

SELECT SUM(PRICE)/COUNT(*) AS 'Avg with Null' 

, SUM(PRICE)/COUNT(PRICE) AS 'Avg without Null' 

, AVG(PRICE) AS 'Avg func' 

FROM TITLES 

<table><tr><td>Avg with Null</td><td>Avg without Null</td><td>Avg func</td></tr><tr><td>22.0144</td><td>24.7662</td><td>24.7662</td></tr></table>

نلاحظ أنه يمكن استخدام أكثر من تابع تجميعي في نفس التعليمة الواحدة. 

تابع القيمة العظمى MAX: يعيد أعلى قيمة ضمن تعبير. 

مثال: أوجد أعلى قيمة مبيعات لكتاب 

SELECT MAX(YTD_SALES) 'BEST SALES' FROM TITLES 

تابع القيمة الدنيا MIN: يعيد أدنى قيمة ضمن تعبير. 

مثال: أوجد أدنى قيمة مبيعات لكتاب 

SELECT MIN (YTD_SALES) 'LOWEST SALES' FROM TITLES 

LOWEST SALES
111

--- Page 6 ---

- تجدر الإشارة إلى عدم وجود أي تأثير للخيارين ALL و DISTINCT على التوابع MIN و MAX
رغم أنه بالإمكان استخدامهما. فالقيمة العظمى أو القيمة الصغرى لقيم حقل، تبقى نفسها، حتى ولو كان هناك تكرار في قيم الحقل وحتى ولو كان هناك قيم غير محددة (أي تساوي NULL). 

## التعبير N TOP 

يمكن استخدام التعبير (TOP N) مع التوابع التجميعية ولكن استخدامه لا يقتصر عليها فقط. ويُعيد هذا التعبير أول N سجل من نتيجة الاستعلام. 

يأخذ هذا التعبير الصيغة: 

### SELECT TOP N field_1, field_2 FROM table_name; 

مثال: أوجد أول 6 كتب من جدول الكتب. أو مثال آخر الثلاث كتب الأكثر مبيعا 

### SELECT top 6 * FROM TITLES 

<table><tr><td>title_id</td><td>title</td><td>type</td><td>pub_id</td><td>price</td><td>advance</td><td>royalty</td><td>ytd_sales</td><td>notes</td><td>pubdate</td></tr><tr><td>1</td><td>BU1032</td><td>The Busy Executive's...</td><td>business</td><td>1389</td><td>19.99</td><td>5000.00</td><td>10</td><td>4095</td><td>An overview of ...</td><td>1991-06-12 00:00:00.000</td></tr><tr><td>2</td><td>BU1111</td><td>Cooking with Comput...</td><td>business</td><td>1389</td><td>11.95</td><td>5000.00</td><td>10</td><td>3876</td><td>Helpful hints on ...</td><td>1991-06-09 00:00:00.000</td></tr><tr><td>3</td><td>BU2075</td><td>You Can Combat Co...</td><td>business</td><td>0736</td><td>2.99</td><td>10125.00</td><td>24</td><td>18722</td><td>The latest medic...</td><td>1991-06-30 00:00:00.000</td></tr><tr><td>4</td><td>BU7832</td><td>Straight Talk About C...</td><td>business</td><td>1389</td><td>19.99</td><td>5000.00</td><td>10</td><td>4095</td><td>Annotated analy...</td><td>1991-06-22 00:00:00.000</td></tr><tr><td>5</td><td>MC2222</td><td>Silicon Valley Gastron...</td><td>mod_cook</td><td>0877</td><td>19.99</td><td>0.00</td><td>12</td><td>2032</td><td>Favorite recipes ...</td><td>1991-06-09 00:00:00.000</td></tr><tr><td>6</td><td>MC3021</td><td>The Gourmet Microw...</td><td>mod_cook</td><td>0877</td><td>2.99</td><td>15000.00</td><td>24</td><td>22246</td><td>Traditional Frenc...</td><td>1991-06-18 00:00:00.000</td></tr></table>

## تجميع الأسطر وتعليمه GROUP BY

--- Page 7 ---

عندما نتكلم عن التوابع التجميعية فالبد لنا أن نتساءل: هل نستطيع أن نطبق التوابع التجميعية على مجموعات جزئية من السجلات بدلاً من تطبيقها على كامل السجلات؟ 

فإذا كان لدينا جدول منتجات، وأردنا حساب مجموع أسعار المنتجات التي نحصل عليها من المورد الأول، وحساب مجموع أسعار المنتجات التي نحصل عليها من المورد الثاني، وحساب مجموع أسعار المنتجات التي نحصل عليها من المورد الثالث، 

فإننا سنحتاج لكتابة ثلاث تعليمات منفصلة تعتمد على التابع التجميعي SUM، 

SELECT SUM(UnitPrice) FROM products WHERE supplierID = 1; 

SELECT SUM(UnitPrice) FROM products WHERE supplierID = 2; 

SELECT SUM(UnitPrice) FROM products WHERE supplierID = 3; 

لكن هل يمكننا أن نصل إلى نفس النتيجة بتعليمة واحدة فقط؟ 

لتجميع البيانات في SQL نستخدم تعليمة GROUP BY 

SELECT columnA,..., aggFunc (aggFuncSpec) 

FROM tableName 

WHERE WHEREspec 

GROUP BY [ ALL ] columnA ,... 

وبالتالي يصبح المثال السابق على الشكل التالي: 

SELECT supplierID, SUM(UnitPrice) 

FROM products 

Where supplierID in (1, 2, 3) 

GROUP BY supplierID

--- Page 8 ---

النتيجة من أجل الموردين 1 و 2 و 3 هي: 

 

مثال آخر: 

ليكن لدينا جدول الطلبيات التالي: 

Select sum(orderprice) from orders where customere = Hasan 

Select sum(orderprice) from orders where customere = Wael 

Select sum(orderprice) from orders where customere = Sami 

<table><tr><td>O_Id</td><td>OrderDate</td><td>OrderPrice</td><td>Customer</td></tr><tr><td>1</td><td>2008/10/23</td><td>1000</td><td>Hasan</td></tr><tr><td>2</td><td>2008/10/23</td><td>1600</td><td>Wael</td></tr><tr><td>3</td><td>2008/09/02</td><td>200</td><td>Hasan</td></tr><tr><td>4</td><td>2008/09/02</td><td>300</td><td>Hasan</td></tr><tr><td>5</td><td>2008/08/30</td><td>2000</td><td>Sami</td></tr><tr><td>6</td><td>2008/10/23</td><td>100</td><td>Wael</td></tr></table>

Group By Customer---→ 

<table><tr><td>O_Id</td><td>OrderDate</td><td>OrderPrice</td><td>Customer</td></tr><tr><td>1</td><td>2008/10/23</td><td>1000</td><td>Hasan</td></tr><tr><td>3</td><td>2008/09/02</td><td>200</td><td>Hasan</td></tr></table>

--- Page 9 ---

<table><tr><td>4</td><td>2008/09/02</td><td>300</td><td>Hasan</td></tr><tr><td>5</td><td>2008/08/30</td><td>2000</td><td>Sami</td></tr><tr><td>6</td><td>2008/10/23</td><td>100</td><td>Wael</td></tr><tr><td>2</td><td>2008/10/23</td><td>1600</td><td>Wael</td></tr></table>

SELECT Customer , orderDate , SUM(orderPrice) 

FROM Orders 

GROUP BY Customer , orderDate 

<table><tr><td>Customer</td><td>SUM(orderPrice)</td></tr><tr><td>Hasan</td><td>1500</td></tr><tr><td>Sami</td><td>2000</td></tr><tr><td>Wael</td><td>1700</td></tr></table>

- عند وجود تابع تجميعي في تعليمية الاختيار SELECT فإن كل عمود موجود في تعليمية الاختيار إلى 

جانب التابع التجميعي يجب وضعه في فقرة الـ GROUP BY. 

- لا يمكن أن يحوي تعبير التجميع GROUP BY على توابع تجميعية. 

- تفيد كلمة ALL في إعادة جميع المجموعات الناتجة بما في ذلك المجموعات الفارغة. 

- غالبا ما تستخدم فقرة HAVING مع فقرة GROUP BY لتحديد شرط معين على المجموعات 

- المختارة وهي تشبه فقرة WHERE بالنسبة لتعليمية SELECT. 

- الأسطر العائدة من التعليمة لا تكون في ترتيب محدد لذلك يفضل دوما استخدام الترتيب 

- ORDER BY لتحديد الترتيب المرغوب.

--- Page 10 ---

مثال: 

أوجد قائمة بالسنوات وعدد الموظفين الذين تم توظيفهم في كل منها ضمن قاعدة معطيات Northwind. 

SELECT DATEPART(yy, HIREDATE) AS 'YEAR', 

COUNT(*) AS 'HIRED COUNT' 

FROM EMPLOYEES 

GROUP BY DATEPART(YY, HIREDATE) 

<table><tr><td>EmployeeID</td><td>LastName</td><td>FirstName</td><td>Title</td><td>TitleOfCourtesy</td><td>BirthDate</td><td>HireDate</td></tr><tr><td>3</td><td>Levering</td><td>Janet</td><td>Sales Represent...</td><td>Ms.</td><td>1963-08-30</td><td>1992-04-01 0...</td></tr><tr><td>1</td><td>Davolo</td><td>Nancy</td><td>Sales Represent...</td><td>Ms.</td><td>1948-12-08</td><td>1992-05-01 0...</td></tr><tr><td>2</td><td>Fuller</td><td>Andrew</td><td>Vice President, S...</td><td>Dr.</td><td>1952-02-19</td><td>1992-08-14 0...</td></tr><tr><td>4</td><td>Peacock</td><td>Margaret</td><td>Sales Represent...</td><td>Ms.</td><td>1937-09-19</td><td>1993-05-03 0...</td></tr><tr><td>5</td><td>Buchanan</td><td>Steven</td><td>Sales Manager</td><td>Mr.</td><td>1955-03-04</td><td>1993-10-17 0...</td></tr><tr><td>6</td><td>Suyama</td><td>Michael</td><td>Sales Represent...</td><td>Mr.</td><td>1963-07-02</td><td>1993-10-17 0...</td></tr><tr><td>7</td><td>King</td><td>Robert</td><td>Sales Represent...</td><td>Mr.</td><td>1960-05-29</td><td>1994-01-02 0...</td></tr><tr><td>8</td><td>Callahan</td><td>Laura</td><td>Inside Sales Coor...</td><td>Ms.</td><td>1958-01-09</td><td>1994-03-05 0...</td></tr><tr><td>9</td><td>Dodsworth</td><td>Anne</td><td>Sales Represent...</td><td>Ms.</td><td>1966-01-27</td><td>1994-11-15 0...</td></tr><tr><td></td><td></td><td></td><td></td><td></td><td></td><td>Result: YEAR HIRED COUNT 1992 3 1993 3 1994 3</td></tr></table>

مثال: 

احسب عدد الموظفين في كل مدينة مرتبين حسب عدد الموظفين (من القاعدة NORTHWIN) 

SELECT CITY, 'EMPLOYEES' = COUNT(*) 

FROM EMPLOYEES 

GROUP BY CITY 

ORDER BY 'EMPLOYEES' 

<table><tr><td>CITY</td><td>EMPLOYEES</td></tr><tr><td>Kirkland</td><td>1</td></tr><tr><td>Redmond</td><td>1</td></tr><tr><td>Tacoma</td><td>1</td></tr><tr><td>Seattle</td><td>2</td></tr><tr><td>London</td><td>4</td></tr></table>

--- Page 11 ---

مثال: اوجد قائمة بأنواع الكتب مع السعر الوسطى لكل نوع ومجموع المبيعات الجارية له وذلك بالنسبة لكل
ناشر في قاعدة معطيات. PUBS 

SELECT TYPE, PUB_ID, 'AVG' = AVG(PRICE), 'YTD' = SUM(YTD_SALES) 

FROM TITLES 

GROUP BY TYPE, PUB_ID 

ORDER BY TYPE, PUB_ID 

<table><tr><td>TYPE</td><td>PUB_ID</td><td>ytd_sales</td><td>price</td></tr><tr><td>business</td><td>0736</td><td>18722</td><td>2.99</td></tr><tr><td>business</td><td>1389</td><td>4095</td><td>19.99</td></tr><tr><td>business</td><td>1389</td><td>4095</td><td>19.99</td></tr><tr><td>business</td><td>1389</td><td>3876</td><td>11.95</td></tr><tr><td>mod_cook</td><td>0877</td><td>2032</td><td>19.99</td></tr><tr><td>mod_cook</td><td>0877</td><td>22246</td><td>2.99</td></tr><tr><td>popular_comp</td><td>1389</td><td>8780</td><td>22.95</td></tr><tr><td>popular_comp</td><td>1389</td><td>4095</td><td>20.00</td></tr><tr><td>popular_comp</td><td>1389</td><td>NULL</td><td>NULL</td></tr><tr><td>psychology</td><td>0736</td><td>2045</td><td>10.95</td></tr><tr><td>psychology</td><td>0736</td><td>111</td><td>7.00</td></tr><tr><td>psychology</td><td>0736</td><td>402</td><td>19.99</td></tr><tr><td>psychology</td><td>0736</td><td>3336</td><td>7.99</td></tr><tr><td>psychology</td><td>0877</td><td>375</td><td>21.59</td></tr><tr><td>trad_cook</td><td>0877</td><td>375</td><td>20.95</td></tr><tr><td>trad_cook</td><td>0877</td><td>15096</td><td>11.95</td></tr><tr><td>trad_cook</td><td>0877</td><td>4095</td><td>14.99</td></tr><tr><td>UNDECIDED</td><td>0877</td><td>NULL</td><td>NULL</td></tr></table>

✓ عند كتابة تعليمية اختيار، يمكنك استخدام وإضافة الفقرة WHERE. في هذه الحالة جميع الأسطر التي لا تحقق الشرط تهمل قبل أن تجرى عملية التجميع. 

مثال: من قاعدة البيانات pubs، أوجد السعر الوسطى لكل نوع من أنواع الكتب وذلك فقط للكتب التي يزيد
سعرها عن 10$ (شرط قبل عملية التجميع_ لذلك نستخدم) 

SELECT TYPE, 'AVG' = AVG(PRICE) 

FROM TITLES 

WHERE PRICE >10

--- Page 12 ---

GROUP BY TYPE 

 

WHERE 

Group By 

➤ بعكس الفقرة WHERE التي تضع شروطا على البيانات قبل تجميعها، فإن الفقرة HAVING تضع شروطا على البيانات بعد تجميعها. لكن يجب أن يكون الحقل المستخدم في having موجودا ضمن قائمة الـ group by أو أن نستخدم معه تابع تجميعي. 

مثال: 

أوجد قائمة بالناشرين الذين تجاوزت مجموع مبيعاتهم الجارية مبلغ $25,000 ($ شروط بعد التجمع) 

SELECT PUB_ID, TOTAL = SUM(YTD_SALES) 

FROM TITLES 

GROUP BY PUB_ID 

HAVING SUM(YTD_SALES)>25000 

ORDER BY PUB_ID

--- Page 13 ---

مثال: أوجد قائمة بالناشرين مع قيمة المبيعات الجارية لكل ناشر الذين ينشرون أكثر من خمسة كتب 

SELECT PUB_ID, 'TOTAL' = SUM(YTD_SALES) 

FROM TITLES 

GROUP BY PUB_ID 

HAVING COUNT(*) > 5 

ORDER BY PUB_ID

--- Page 14 ---

- كما في الفقرة WHERE، يمكن وضع أكثر من شرط في الفقرة HAVING. في حال وجود أكثر من شرط، نستخدم العمليات المنطقية AND, OR, NOT. 

مثال: من أجل كل ناشر، أوجد مجموع الدفعات المقدمة والسعر الوسطي لكتب هذا الناشر، شريطة أن يكون رقم لناشر أكبر من 0800' و مجموع الدفعات المقدمة أكبر من 10.000$ ووسطي سعر الكتاب أكبر من $16. 

SELECT PUB_ID, TOTAL = SUM(ADVANCE), 'AVG'=AVG(PRICE) 

FROM TITLES 

WHERE PUB_ID >'0800' 

GROUP BY PUB_ID 

HAVING SUM(ADVANCE) > 10000 AND AVG(PRICE) >$16 

ORDER BY PUB_ID 

 

- يكون استخدام كلمة ALL مفيدا إذا احتوى الاستعلام على شرط اختيار WHERE، وفي هذه الحالة فإن نتيجة الاستعلام بوجود الشروط ستتضمن جميع المجموعات بما في ذلك المجموعات التي لا تحوي على بيانات. (مع ملاحظة أنه لا يطبق عليهم التابع التجميعي) 

مثال:

--- Page 15 ---

نريد قائمة بأنواع الكتب والسعر الوسطي لكتب كل نوع وذلك فقط للكتب التي ضريبتها 10$ 

SELECT TYPE, 'AVG'= AVG(PRICE) 

FROM TITLES 

WHERE ROYALTY=$10 

GROUP BY TYPE 

ORDER BY TYPE 

تظهر التعليمة السابقة أنواع الكتب التي تتضمن كتبا ضريبتها 10$ ولا تظهر الأنواع التي لا تتضمن أي كتاب ضريبه 10$ 

<table><tr><td>TYPE</td><td>AVG</td></tr><tr><td>business</td><td>17.31</td></tr><tr><td>popular_comp</td><td>20.00</td></tr><tr><td>psychology</td><td>14.1425</td></tr><tr><td>trad_cook</td><td>17.97</td></tr></table>

مثال: 

نريد قائمة بأنواع الكتب والسعر الوسطي لكتب كل نوع وذلك للكتب التي ضريبتها 10$ مع إظهار جميع الأنواع بما فيها تلك التي لا تحوي أي كتاب ضريبه 10$ 

SELECT TYPE, 'AVG'= AVG(PRICE) 

FROM TITLES 

WHERE ROYALTY=$10 

GROUP BY ALL TYPE 

ORDER BY TYPE 

<table><tr><td>TYPE</td><td>AVG</td></tr><tr><td>business</td><td>17.31</td></tr><tr><td>mod_cook</td><td>NULL</td></tr><tr><td>popular_comp</td><td>20.00</td></tr><tr><td>psychology</td><td>14.1425</td></tr><tr><td>trad_cook</td><td>17.97</td></tr><tr><td>UNDECIDED</td><td>NULL</td></tr></table>

--- Page 16 ---

<table><tr><td rowspan="2"></td><td colspan="2">التوابع الرياضية</td></tr><tr><td colspan="2">Mathematical Functions</td></tr><tr><td>CEILING</td><td>RADIANS</td><td></td></tr><tr><td>EXP</td><td>PI</td><td></td></tr><tr><td>FLOOR</td><td>SIGN</td><td></td></tr><tr><td>LOG</td><td>SIN</td><td></td></tr><tr><td>LOG10</td><td>COS</td><td></td></tr><tr><td>POWER</td><td>TAN</td><td></td></tr><tr><td>RAND</td><td>ACOS</td><td></td></tr><tr><td>ROUND</td><td>ASIN</td><td></td></tr><tr><td>SQUARE</td><td>ATAN</td><td></td></tr><tr><td>SORT</td><td>COT</td><td></td></tr><tr><td>DEGREES</td><td>ATN2</td><td></td></tr></table>

## التوابع الرياضية Mathematical Functions 

وهي توابع تقوم بإجراء حسابات على متحولات وتعيد قيمة عددية. 

### CEILING 

يعيد العدد الصحيح الأكبر مباشرة أو تساوي قيمة تعبير دخل حسابي. نمط القيمة العائدة من التابع مطابق لنمط التعبير الحسابي. 

<table><tr><td>Function</td><td>Result</td></tr><tr><td>SELECT CEILING(2)</td><td>2</td></tr><tr><td>SELECT CEILING(1.5)</td><td>2</td></tr><tr><td>SELECT CEILING(-1.5)</td><td>-1</td></tr><tr><td>SELECT CEILING(-3)</td><td>-3</td></tr></table>

### FLOOR 

يعيد العدد الصحيح الأصغر أو يساوي قيمة التعبير الداخل. 

<table><tr><td>Function</td><td>Result</td></tr></table>

--- Page 17 ---

<table><tr><td>SELECT FLOOR(2)</td><td>2</td></tr><tr><td>SELECT FLOOR (1.5)</td><td>1</td></tr><tr><td>SELECT FLOOR (-1.5)</td><td>-2</td></tr><tr><td>SELECT FLOOR (-3)</td><td>-3</td></tr></table>

 

EXP
يعيد قيمة التابع النيبري e (التابع الأسى) الموافقة لعدد حقيقي. 

DECLARE @var float 

SET @var = 4 

SELECT 'The EXP is: '+' CONVERT (varchar, EXP(@var)) 

LOG 

يعيد قيمة التابع اللغاريتمي النيبري للتعبير الموافق 

DECLARE @var float 

SET @var = 5.175643 

SELECT 'The LOG is: '+' CONVERT (varchar, LOG(@var)) 

POWER 

يعيد ناتج رفع المتحول الأول إلى القوة التي يمثلها المتحول الثاني. 

DECLARE @VALUE INT, @COUNTER INT

--- Page 18 ---

SET @VALUE = 2 

SET @COUNTER = 0 

WHILE @COUNTER < 5 

BEGIN 

SELECT POWER(@VALUE, @COUNTER) 

SET @COUNTER = @COUNTER + 1 

END 

<table><tr><td>Counter</td><td>Counter&lt;5</td><td>Power(@value,@counter)</td></tr><tr><td>0</td><td>True</td><td>Power(2,0)=1</td></tr><tr><td>1</td><td>True</td><td>Power(2,1)=2</td></tr><tr><td>2</td><td>True</td><td>Power(2,2)=4</td></tr><tr><td>3</td><td>True</td><td>Power(2,3)=8</td></tr><tr><td>4</td><td>True</td><td>Power(2,4)=16</td></tr><tr><td>5</td><td>False</td><td>STOP</td></tr></table>

RAND 

يعيد عدد حقيقي عشوائي بين 0 و 1 

DECLARE @COUNTER SMALLINT 

SET @COUNTER = 1 

WHILE @COUNTER < 5 

BEGIN 

SELECT RAND(@COUNTER) RANDOM_NUMBER 

-- SELECT RAND(@COUNTER*100000)*1000 as RANDOM_NUMBER 

SET @COUNTER = @COUNTER + 1 

END

--- Page 19 ---

<table><tr><td>Counter</td><td>Counter&lt;5</td><td>RAND(@COUNTER)</td></tr><tr><td>1</td><td>True</td><td>RAND(1)</td></tr><tr><td>2</td><td>True</td><td>RAND(2)</td></tr><tr><td>3</td><td>True</td><td>RAND(3)</td></tr><tr><td>4</td><td>True</td><td>RAND(4)</td></tr><tr><td>5</td><td>False</td><td>STOP</td></tr></table>

ROUND 

يقوم بتقرير قيمة تعبير حسابي إلى الدقة المطلوبة. 

ROUND (numeric_expression, length [, function ]) 

المتحول length يمثل دقة التقريب المطلوبة. إذا كان قيمة موجبة فيتم تقريب العدد على يمين الفاصلة (الجزء العشري)، أما إذا كان قيمة سالبة فيتم تقريب العدد على يسار الفاصلة (الجزء الحقيقي). يجب أن يكون نمط هذا المتحول صحيحا أي tinity, smallint, int. 

المتحول الثالث function يمثل العملية المراد القيام بها ويجب أن يكون صحيحا. القيمة الافتراضية له هي 0 وتعني القيام بعملية تقريب. أي قيمة مختلفة عن الصفر تعني القيام بعملية قص. 

<table><tr><td>ROUND</td><td>Length</td><td>Function</td><td>Result</td></tr><tr><td>SELECT ROUND(1268.4556, 2)</td><td>+2</td><td>No</td><td>1268.4600</td></tr><tr><td>SELECT ROUND(1268.4556, 2,0)</td><td>+2</td><td>0</td><td>1268.4600</td></tr><tr><td>SELECT ROUND(1268.4556, 2,1)</td><td>+2</td><td>1</td><td>1268.4500</td></tr><tr><td>SELECT ROUND(1268.4556, -2)</td><td>-2</td><td>No</td><td>1300.0000</td></tr><tr><td>SELECT ROUND(1268.4556, -2,1)</td><td>-2</td><td>1</td><td>1200.0000</td></tr></table>

SQUARE 

يعيد القيمة التربيعية لتعبير حسابي ما.

--- Page 20 ---

لحساب حجم اسطوانة 

DECLARE @H FLOAT, @R FLOAT 

SET @H = 5 

SET @R = 1 

SELECT PI() * SQUARE(@R) * @H AS 'CYL VOL' 

15.707963267949 

SORT 

يعيد قيمة الجذر التربيعي لتعبير حسابي ما. 

DECLARE @MYVALUE FLOAT 

SET @MYVALUE = 1.00 

WHILE @MYVALUE < 10.00 

BEGIN 

SELECT SORT(@MYVALUE) 

SELECT @MYVALUE = @MYVALUE + 1 

END

--- Page 21 ---

<table><tr><td>@MYVALUE</td><td>WHILE @MYVALUE &lt; 10.00</td><td>SORT(@MYVALUE)</td></tr><tr><td>1</td><td>True</td><td>√1=1</td></tr><tr><td>2</td><td>True</td><td>√2= 1.4142135623731</td></tr><tr><td>3</td><td>True</td><td>√3=1.73205080756888</td></tr><tr><td>4</td><td>True</td><td>√4=2</td></tr><tr><td>5</td><td>True</td><td>√5=2.23606797749979</td></tr><tr><td>6</td><td>True</td><td>√6=2.44948974278318</td></tr><tr><td>7</td><td>True</td><td>√7=2.64575131106459</td></tr><tr><td>8</td><td>True</td><td>√8=2.82842712474619</td></tr><tr><td>9</td><td>True</td><td>√9=3</td></tr><tr><td>10</td><td>False</td><td>Stop</td></tr></table>

## String Functions ملاحظات سلسل 

وهي توابع تطبق على سلسل المحارف وتعيد إما سلسل محارف أو قيم رقمية. 

### التابع SUBSTRING 

يعيد التابع SUBSTR جزء من سلسلة محارف، ابتداءً من موقع محدد في تلك السلسلة، وبطول عدد محدد من المحارف. فإذا أردنا في جدول الكتب من قاعدة المعطيات pubs كتابة الاستعلام الذي يعيد سلسلة محارف بطول 5 محارف اعتباراً من قيم الحقل Title (عنوان الكتاب) مبتدئاً من المحرف رقم 1، نكتب الصيغة التالية: 

<table><tr><td>Shortcut Title</td></tr><tr><td>But 1</td></tr><tr><td>Compu</td></tr><tr><td>Cookie</td></tr><tr><td>Emoti</td></tr><tr><td>Fifty</td></tr><tr><td>Is An</td></tr><tr><td>Life</td></tr><tr><td>Net E</td></tr><tr><td>Onion</td></tr><tr><td>Prolo</td></tr><tr><td>Secre</td></tr><tr><td>Silic</td></tr><tr><td>Strai</td></tr><tr><td>Sushi</td></tr><tr><td>The B</td></tr><tr><td>The G</td></tr><tr><td>The P</td></tr><tr><td>You C</td></tr></table>

SELECT SUBSTRING(title, 1, 5) as 'Shortcut Title' FROM Titles

--- Page 22 ---

: LEN : يعيد عدد المحارف في سلسلة محارف ما بدون الفراغات في نهاية السلسلة. 

: DATALENGTH : يعيد عدد المحارف في سلسلة محارف ما كاملا مع الفراغات 

DECLARE @STR1 VARCHAR(50) 

DECLARE @STR2 CHAR(50) 

SET @STR1 = ' Hello, my lovely students ' 

SET @STR2 = ' Hello, my lovely students ' 

SELECT @STR1 AS STR1, LEN(@STR1) AS 'LEN STR1', 

DATALENGTH(@STR1) AS 'DATALENGTH STR1', 

@STR2 AS STR2, LEN(@STR2) AS 'LEN STR2', 

DATALENGTH(@STR2) AS 'DATALENGTH STR2' 

<table><tr><td>STR1</td><td>LEN STR1</td><td>DATALENGTH STR1</td><td>STR2</td><td>LEN STR2</td><td>DATALENGTH STR2</td></tr><tr><td>Hello, my lovely students</td><td>31</td><td>42</td><td>Hello, my lovely students</td><td>31</td><td>50</td></tr></table>

العبارة مؤلفة من 6 فراغات ثم 25 محرف ثم 11 فراغ في نهاية السلسلة 

ASCII 

يعيد القيمة الصحيحة الموافقة للمحرف الأول من تعبير 

SELECT ASCII('HELLO, SQL!') AS 'HELLO, SQL!', ASCII('H') AS 'H', ASCII('h') AS 'h' 

<table><tr><td>HELLO, SQL!</td><td>H</td><td>h</td></tr><tr><td>72</td><td>72</td><td>104</td></tr></table>

CHAR 

وهو التابع المعاكس للتابع ASCII أي يعيد المحرف المقابل لقيمة معينة. وهنا يمكن أيضا إعادة المحارف
الغير مطبوعة. 

<table><tr><td colspan="2">Control character</td><td>Value</td></tr><tr><td>Tab</td><td>CHAR(9)</td><td></td></tr></table>

--- Page 23 ---

<table><tr><td>Line feed</td><td>CHAR(10)</td></tr><tr><td>Carriage return</td><td>CHAR(13)</td></tr></table>

SELECT CHAR(72) AS 'Char', ASCII (CHAR(72)) AS 'ASCII Number' 

CHARINDEX 

يعيد موقع بداية سلسلة محارف جزئية ضمن سلسلة أخرى (الفهارس تبدأ بـ 1). 

CHARINDEX (expression1, expression2 [, start_location ]) 

Expression1 هو التعبير الذي نبحث عنه. 

Expression2 هو التعبير الذي نبحث ضمنه. 

start location
و هي التي تطبق إذا أدخلنا قيمة صفرية أو
سالة. 

إذا كان أي من التعبيرين الداخلي يحمل القيمة NULL فإن القيمة العائدة هي NULL. 

SELECT CHARINDEX('Who', NOTES) as 'Default Sart Location', 

CHARINDEX('Who', NOTES, -5) as 'Negative Sart Location', 

CHARINDEX('Who', NOTES, 77) as 'search for the second location', 

CHARINDEX('Who', NOTES) as 'search for wrong word', 

CHARINDEX(NULL, NOTES) as 'search for Null' 

FROM TITLES WHERE TITLE_ID='PS1372' 

<table><tr><td>Default Sart Location</td><td>Negative Sart Location</td><td>search for the second location</td><td>search for wrong word</td><td>search for Null</td></tr><tr><td>76</td><td>76</td><td>114</td><td>0</td><td>NULL</td></tr></table>

--- Page 24 ---

LEFT (character_expression, integer_expression) 

يعيد الجزء اليساري من التعبير character_expression بالطول integer_expression. إذا كان الطول المطلوب سالبا فإن التابع يولد خطأ أما إذا كان صفرا فالقيمة العائدة هي سلسلة فارغة. 

في قاعدة المعطيات Pubs من جدول الكتب أوجد اسم الكتاب الكامل وأول 6 أحرف من اسم الكتاب على اليسار. 

SELECT TITLE, LEFT(TITLE, 6) AS 'LEFT' 

FROM TITLES 

ORDER BY TITLE_ID 

<table><tr><td>TITLE</td><td>LEFT</td></tr><tr><td>The Busy Executive's Database Guide</td><td>The Busy Executive's Database Guide</td></tr><tr><td>Cooking with Computers: Surreptitious Balance Sheets</td><td>Cooking with Computers: Surreptitious Balance Sheets</td></tr><tr><td>You Can Combat Computer Stress!</td><td>You Can Combat Computer Stress!</td></tr><tr><td>Straight Talk About Computers</td><td>Straight Talk About Computers</td></tr><tr><td>Silicon Valley Gastronomic Treats</td><td>Silicon Valley Gastronomic Treats</td></tr><tr><td>The Gourmet Microwave</td><td>The Gourmet Microwave</td></tr><tr><td>The Psychology of Computer Cooking</td><td>The Psychology of Computer Cooking</td></tr><tr><td>But Is It User Friendly?</td><td>But Is It User Friendly?</td></tr><tr><td>Secrets of Silicon Valley</td><td>Secrets of Silicon Valley</td></tr><tr><td>Net Etiquette</td><td>Net Etiquette</td></tr><tr><td>Computer Phobic AND Non-Phobic Individuals: Beha...</td><td>Computer Phobic AND Non-Phobic Individuals: Beha...</td></tr><tr><td>Is Anger the Enemy?</td><td>Is Anger the Enemy?</td></tr><tr><td>Life Without Fear</td><td>Life Without Fear</td></tr><tr><td>Prolonged Data Deprivation: Four Case Studies</td><td>Prolonged Data Deprivation: Four Case Studies</td></tr><tr><td>Emotional Security: A New Algorithm</td><td>Emotional Security: A New Algorithm</td></tr><tr><td>Onions, Leeks, and Garlic: Cooking Secrets of the M...</td><td>Onions, Leeks, and Garlic: Cooking Secrets of the M...</td></tr><tr><td>Fifty Years in Buckingham Palace Kitchens</td><td>Fifty Years in Buckingham Palace Kitchens</td></tr><tr><td>Sushi, Anyone?</td><td>Sushi, Anyone?</td></tr></table>

LOWER 

يعيد سلسلة محارف بعد تحويل الحروف الكبيرة إلى صغيرة. 

DECLARE @STR VARCHAR(20) 

SET @STR = 'HELLO, SQL!' 

SELECT @STR AS 'STR', LOWER(@STR) AS 'str' 

<table><tr><td>STR</td><td>str</td></tr><tr><td>HELLO, SQL!</td><td>hello, sql!</td></tr></table>

LTRIM 

يقوم بحذف الفراغات فقط (لا يحذف TABS) من بداية سلسلة محارف على اليسار.

--- Page 25 ---

DECLARE @STR VARCHAR(20) 

DECLARE @LSTR VARCHAR(20) 

SET @STR = ' HELLO, SQL!' 

SELECT @LSTR = LTRIM(@STR) 

SELECT @STR AS 'STR', LEN(@STR) AS 'STR LEN' 

, @LSTR AS 'LSTR', LEN(@LSTR) AS 'LSTR LEN' 

<table><tr><td>STR</td><td>STR LEN</td><td>LSTR</td><td>LSTR LEN</td></tr><tr><td>HELLO, SQL!</td><td>15</td><td>HELLO, SQL!</td><td>11</td></tr></table>

## Date and Time Functions وازمن التاريخ 

### GETDATE 

الذي يُعيد التاريخ الحالي متضمناً السنة، والشهر، واليوم، والساعة، والدقيقة، والثانية وجزء الثانية. 

SELECT GETDATE() 

يعطي التاريخ مع الزمن بدقة 3 أجزاء من الثانية 

### DATEADD 

إضافة فاصل زمني إلى تاريخ محدد. 

SELECT DATEADD(day,6, '2006-07-31'); 

SELECT DATEADD(year,6, '2006-07-31'); 

SELECT DATEADD(year,2147483647, '2006-07-31'); 

خارج حدود الزمن المقبول 

SELECT DATEADD(year,2147483647, '2006-07-31'); 

لا يتم التنفيذ 

تتحسب الفرق بين تاريخين DATEDIFF 

Example:

--- Page 26 ---

SELECT DATEDIFF(millisecond, GETDATE(), SYSDATETIME()); 

الدقة في GETDATE بالمبلي ثانية أما في SYSDATETIME فهي بالنانو ثانية 

(دعوى الجزء من التاريخ المحدد بالمعامل الأول وبالاسماء إن أمكن (اسم الشهر مثال) DATENAME 

DATENAME ( datepart , date ) 

مثال: 

SELECT DATENAME(year, '12:10:30.123') defYear 

,DATENAME(month, '12:10:30.123') defMonth 

,DATENAME(day, '12:10:30.123') defDay 

,DATENAME(day, '11-5-2011 12:10:30.123') dayofdate 

,DATENAME(dayofyear, '12:10:30.123') defDayofyear 

,DATENAME(weekday, '12:10:30.123') defWd; 

<table><tr><td>defYear</td><td>defMonth</td><td>defDay</td><td>dayofdate</td><td>defDayofyear</td><td>defWd</td></tr><tr><td>1900</td><td>January</td><td>1</td><td>5</td><td>1</td><td>Monday</td></tr></table>

SELECT DATENAME(month, '2007-06-01') monthofDate 

,DATENAME(minute, '2007-06-01') defMinute 

,DATENAME(second, '2007-06-01') defsec; 

<table><tr><td>monthofDate</td><td>defMinute</td><td>defsec</td></tr><tr><td>June</td><td>0</td><td>0</td></tr></table>

SELECT DATENAME(year, '3/24/2012 12:10:30.123') 

,DATENAME(month, '3/24/2012 12:10:30.123') 

,DATENAME(day, '3/24/2012 12:10:30.123') 

,DATENAME(dayofyear, '3/24/2012 12:10:30.123') 

,DATENAME(weekday, '3/24/2012 12:10:30.123') 

,DATENAME(HOUR, '3/24/2012 12:10:30.123') 

,DATENAME(MINUTE, '3/24/2012 12:10:30.123')
