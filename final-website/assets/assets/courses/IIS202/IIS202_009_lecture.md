--- Page 1 ---

الصفحة 

3 

3 

3 

4 

5 

8 

9 

11 

12 

13 

14 

16 

17 

18 

20 

21 

العنوان 

1. مقدمة 

2. استرجاع البيانات من الجداول المصدر 

1.2 الاختيار Selection 

2.2 الاسقاط Projection 

3.2 الضم Join 

4.2 الجداء Product 

5.2 الاجتماع Union 

6.2 التقاطع Intersection 

7.2 الفرق Difference 

8.2 متممات 

3. ترتيب البيانات المسترجعة Order by clause 

4. تجميع البيانات المسترجعة واختيار المجموعات 

Group by & Having clause 

5. إلغاء التكرار في البيانات المسترجعة Distinct Keyword 

6. تطبيق 

7. المراجع 

8. تدريبات

--- Page 2 ---

الكلمات المفتاحية: 

جدول، سجل، عمود، تابع، قيمة، بيانات، حقل، جدول، رقمية، سالسل محارف، تاريخ، صيغة، قاعدة بيانات. 

ملخص: 

هذه الوحدة هي عرض لتعليمات لغة الإستعلام المهيكلة والأشكال المحتملة لكل تعليمية، مع شرح المفهوم النظري لحالات استخدام تعليمات SQL. 

أهداف تعليمية: 

يهدف هذا الفصل التعريف بالمفاهيم التالية: 

- استرجاع البيانات من الجداول المصدر: 

1. الاختيار Selection 

2. الاقساط Projection 

3. الضم Join 

4. الجداء Product 

5. الاجتماع Union 

6. التقاطع Intersection 

7. الفرق Difference 

8. متممات 

- ترتيب البيانات المسترجعة Order by clause 

- تجميع البيانات المسترجعة واختيار المجموعات Group by & Having clause 

- الغاء التكرار في البيانات المسترجعة Distinct Keyword 

- تطبيق

--- Page 3 ---

## 1. مقدمة 

ستخدم تعليمية Select لاسترجاع بيانات من جدول أو أكثر، وتستخدم أيضاً لمعالجة البيانات المسترجعة: 

SELECT select_list [ INTO new_table ] 
FROM table_source 
[ WHERE search_condition ] 
[ GROUP BY group_by_expression ] 
[ HAVING search_condition ] 
[ ORDER BY order_expression [ ASC | DESC ] ] 

في هذا الفصل سنحل جميع عناصر تعليمية Select المعروضة في الشكل السابق، مع شرح المفهوم النظري لكل من أجزاء التعليمية. 

## 2. استرجاع البيانات من الجداول المصدر 

### الاختيار Selection 

يعني الاختيار استرجاع مجموعة جزئية من تسجيلات المصدر، يتم تحديد السجلات المسترجعة بشرط أو مجموعة شروط، ويمكن جمع عدة شروط بالمعاملات المنطقية and, or, not. 

### Employee 

<table><tr><td>Id</td><td>Name</td><td>Section</td></tr><tr><td>1</td><td>A</td><td>HR</td></tr><tr><td>2</td><td>B</td><td>Finance</td></tr><tr><td>3</td><td>C</td><td>HR</td></tr><tr><td>4</td><td>D</td><td>Sales</td></tr></table>

### Select * 

#### From Employee 

Where id <=3 and name <> 'B' ; 

---- 

<table><tr><td>Id</td><td>Name</td><td>Section</td></tr><tr><td>1</td><td>A</td><td>HR</td></tr><tr><td>2</td><td>C</td><td>HR</td></tr></table>

--- Page 4 ---

الإسقاط Projection 

يعني الاستقاط استرجاع مجموعة جزئية من أعمدة المصدر، ويمكن ترتيب الأعمدة المسترجعة بغير ترتيبها في المصدر ويمكن أيضاً اعطاؤها تسميات جديدة. 

Employee 

<table><tr><td>Id</td><td>Name</td><td>Section</td></tr><tr><td>1</td><td>A</td><td>HR</td></tr><tr><td>2</td><td>B</td><td>Finance</td></tr><tr><td>3</td><td>C</td><td>HR</td></tr><tr><td>4</td><td>D</td><td>Sales</td></tr></table>

Select section as S, Name as E 

From Employee 

Order by section; 

---- 

<table><tr><td>S</td><td>E</td></tr><tr><td>Finance</td><td>B</td></tr><tr><td>HR</td><td>A</td></tr><tr><td>HR</td><td>C</td></tr><tr><td>Sales</td><td>D</td></tr></table>

--- Page 5 ---

لضم Join 

عند اختيار البيانات من أكثر من مصدر (جدولين مثلاً)، وفي حال عدم ضم الجدولين (ربطها) بإحدى طرق الضم الأربع المشروحة في هذه الفقرة، فإننا سنحصل على الجداء الديكاري لمحتوى الجدولين. 

طرق الضم هي: 

<table><tr><td>نظم الضم</td><td>الطرف المشارك اليميني</td><td>الطرف المشارك اليساري</td></tr><tr><td>Inner Join</td><td>فقط السجلات التي لها مقابل في الطرف الآخر</td><td>فقط السجلات التي لها مقابل في الطرف الآخر</td></tr><tr><td>Left Join</td><td>فقط السجلات التي لها مقابل في الطرف الآخر</td><td>جميع السجلات</td></tr><tr><td>Right Join</td><td>جميع السجلات</td><td>فقط السجلات التي لها مقابل في الطرف الآخر</td></tr><tr><td>Outer Join</td><td>جميع السجلات</td><td>جميع السجلات</td></tr></table>

--- Page 6 ---

:مثال 

## Employee 

<table><tr><td>E_Id</td><td>E_Name</td><td>E_Section</td></tr><tr><td>1</td><td>A</td><td>3</td></tr><tr><td>2</td><td>B</td><td>4</td></tr><tr><td>3</td><td>C</td><td>3</td></tr><tr><td>4</td><td>D</td><td></td></tr></table>

## Section 

<table><tr><td>S_Id</td><td>S_Name</td></tr><tr><td>1</td><td>HR</td></tr><tr><td>2</td><td>Finance</td></tr><tr><td>3</td><td>Production</td></tr><tr><td>4</td><td>Sales</td></tr></table>

Select S_Name,E_Name from 

Employee inner join Section 

On Employee.E_Section=Section.S_Id; 

 

<table><tr><td>S_Name</td><td>E_Name</td></tr><tr><td>Production</td><td>A</td></tr><tr><td>Sales</td><td>B</td></tr><tr><td>Production</td><td>C</td></tr></table>

Select S_Name,E_Name from 

Employee Left outer join Section 

On Employee.E_Section=Section.S_Id;

--- Page 7 ---

<table><tr><td>S_Name</td><td>E_Name</td></tr><tr><td>Production</td><td>A</td></tr><tr><td>Sales</td><td>B</td></tr><tr><td>Production</td><td>C</td></tr><tr><td></td><td>D</td></tr></table>

Select S_Name,E_Name from

Employee Right outer join Section

On Employee.E_Section=Section.S_Id;

---

<table><tr><td>S_Name</td><td>E_Name</td></tr><tr><td>Production</td><td>A</td></tr><tr><td>Sales</td><td>B</td></tr><tr><td>Production</td><td>C</td></tr><tr><td>HR</td><td></td></tr><tr><td>Finance</td><td></td></tr></table>

---

Select S_Name,E_Name from

Employee Full Outer join Section

On Employee.E_Section=Section.S_Id;

---

<table><tr><td>S_Name</td><td>E_Name</td></tr><tr><td>Production</td><td>A</td></tr><tr><td>Sales</td><td>B</td></tr><tr><td>Production</td><td>C</td></tr><tr><td></td><td>D</td></tr><tr><td>HR</td><td></td></tr><tr><td>Finance</td><td></td></tr></table>

--- Page 8 ---

## Product الجداء 

في حال اختيار السجلات من جدولين دون تطبيق احدى طرق الضم عليهما، فإننا سنحصل على الجداء الديكارتي (كل سجل من الطرف الاول مع جميع سجلات الطرف الثاني). 

بتطبيق ذلك على الجدولين Employee و Section سنحصل على ما يلي: 

### Employee 

<table><tr><td>E_Id</td><td>E_Name</td><td>E_Section</td></tr><tr><td>1</td><td>A</td><td>3</td></tr><tr><td>2</td><td>B</td><td>4</td></tr><tr><td>3</td><td>C</td><td>3</td></tr><tr><td>4</td><td>D</td><td></td></tr></table>

### Section 

<table><tr><td>S_Id</td><td>S_Name</td></tr><tr><td>1</td><td>HR</td></tr><tr><td>2</td><td>Finance</td></tr><tr><td>3</td><td>Production</td></tr><tr><td>4</td><td>Sales</td></tr></table>

Select S_Name, E_Name from Employee, Section; 

---

--- Page 9 ---

<table><tr><td>S_Name</td><td>E_Name</td></tr><tr><td>HR</td><td>A</td></tr><tr><td>HR</td><td>B</td></tr><tr><td>HR</td><td>C</td></tr><tr><td>HR</td><td>D</td></tr><tr><td>Finance</td><td>A</td></tr><tr><td>Finance</td><td>B</td></tr><tr><td>Finance</td><td>C</td></tr><tr><td>Finance</td><td>D</td></tr><tr><td>Production</td><td>A</td></tr><tr><td>Production</td><td>B</td></tr><tr><td>Production</td><td>C</td></tr><tr><td>Production</td><td>D</td></tr><tr><td>Sales</td><td>A</td></tr><tr><td>Sales</td><td>B</td></tr><tr><td>Sales</td><td>C</td></tr><tr><td>Sales</td><td>D</td></tr></table>

## الاجماع Union 

تجمع هذه العملية كافة الأسطر المسترجعة من تعليمتي Select، دون تكرار الأسطر الموجودة في نيتجة كلا التعليمتين، ولتطبيق هذه العملية يجب أن تتطابق النتيجتين اللتين نجمعها في ترتيب وأنماط الأعمدة. 

مثال: 

### Staff 

<table><tr><td>Id</td><td>Name</td><td>Location</td></tr><tr><td>1</td><td>A</td><td>Sales section</td></tr><tr><td>2</td><td>B</td><td>HR section</td></tr><tr><td>3</td><td>C</td><td>Sales section</td></tr></table>

--- Page 10 ---

# Manager  

<table><tr><td>Id</td><td>Department</td><td>Name</td></tr><tr><td>1</td><td>HR section</td><td>B</td></tr><tr><td>3</td><td>QA</td><td>D</td></tr></table>  

Select location as dept from Staff Union  

Select Department as dept from Manager;  

<table><tr><td>dept</td></tr><tr><td>Sales section</td></tr><tr><td>HR section</td></tr><tr><td>Sales section</td></tr><tr><td>QA</td></tr></table>  

Select \* from Staff Union  

Select \* from Manager;  

<table><tr><td>?</td><td>?</td><td>?</td></tr><tr><td>1</td><td>A</td><td>Sales section</td></tr><tr><td>2</td><td>B</td><td>HR section</td></tr><tr><td>3</td><td>C</td><td>Sales section</td></tr><tr><td>1</td><td>HR section</td><td>B</td></tr><tr><td>3</td><td>QA</td><td>D</td></tr></table>  

Select id, name, location from Staff Union  

Select id, name, department from Manager;

--- Page 11 ---

<table><tr><td>?</td><td>?</td><td>?</td></tr><tr><td>1</td><td>A</td><td>Sales section</td></tr><tr><td>2</td><td>B</td><td>HR section</td></tr><tr><td>3</td><td>C</td><td>Sales section</td></tr><tr><td>3</td><td>D</td><td>QA</td></tr></table>

## Intersection 

تعطي هذه العملية تقاطع الأسطر المسترجعة من تعليمتي (Al-Sulur المكررة في نتيجة التعليمتين)، دون تكرار، ولتطبيق هذه العملية يجب أن تتطابق النتيجتين اللتين نقاطهما في ترتيب وأنماط الأعمدة. 

مثال: 

### Staff 

<table><tr><td>Id</td><td>Name</td><td>Location</td></tr><tr><td>1</td><td>A</td><td>Sales section</td></tr><tr><td>2</td><td>B</td><td>HR section</td></tr><tr><td>3</td><td>C</td><td>Sales section</td></tr></table>

### Manager 

<table><tr><td>Id</td><td>Department</td><td>Name</td></tr><tr><td>1</td><td>HR section</td><td>B</td></tr><tr><td>3</td><td>QA</td><td>D</td></tr></table>

Select location as dept from Staff 

Intersect 

Select Department as dept from Manager; 

 

<table><tr><td>dept</td></tr><tr><td>HR section</td></tr></table>

--- Page 12 ---

Select * from Staff 

Intersect 

Select * from Manager; 

Nothing 

====== 

Select name, location from Staff 

Intersect 

Select name, department from Manager; 

 

<table><tr><td>?</td><td>?</td></tr><tr><td>B</td><td>HR section</td></tr></table>

## Difference الفرق 

تعطي هذه العملية فرق الأسطر المسترجعة من تعليمتي (الأسطر المسترجعة من التعليمة الأولى باستثناء الموجودة في نتيجة التعليمية الثانية)، ولتطبيق هذه العملية يجب أن تتطابق النتيجتين اللتين نفطعهما في ترتيب وأنماط الأعمدة. 

مثال: 

Staff 

<table><tr><td>Id</td><td>Nam</td><td>Location</td></tr><tr><td>1</td><td>A</td><td>Sales section</td></tr><tr><td>2</td><td>B</td><td>HR section</td></tr><tr><td>3</td><td>C</td><td>Sales section</td></tr></table>

Manager 

<table><tr><td>Id</td><td>Department</td><td>Name</td></tr><tr><td>1</td><td>HR section</td><td>B</td></tr><tr><td>3</td><td>QA</td><td>D</td></tr></table>

Select location from Staff 

Except 

Select Department from Manager; 

======

--- Page 13 ---

Database Architecture And Design_CH9 

Location 

Sales section 

متممات 

:Like تعبير 

عند اختيار مجموعة جزئية من السجلات لاسترجاعها من المصدر، يمكن وضع شرط أو عدة شروط مرتبطة بالعمليات المنطقية (and, or, not) وتختلف بنية الشرط حسب نمط المعطيات للحقول التي يتم تطبيق الشروط عليها. 

في حال كان الحقل المراد تطبيق شرط عليه من نمط نصي، فإن أهم تعبير للمقارنة هو Like، وفيما يلي أمثلة على استخدامه. 

Employee 

<table><tr><td>Id</td><td>Name</td><td>Location</td></tr><tr><td>1</td><td>A</td><td>Sales section</td></tr><tr><td>2</td><td>B</td><td>HR section</td></tr><tr><td>3</td><td>C</td><td>Sales section</td></tr></table>

Select * from Employee where Name like 'A%'; 

أيدا | الاسم بحرف 

Select * from Employee where Name like '%A'; 

ينتهي | الاسم بحرف 

Select * from Employee where Name like '%A%'; 

يحيوي | الاسم حرف 

Select * from Employee where Name like 'A_'; 

الاسم مؤلف من حرفين | أولهما 

Select * from Employee where Name like '_A%'; 

الحرف الثاني من الاسم هو 

يمكن استبدالها بأي سلسلة محارف 

تستبدل بمحرف وحيد

--- Page 14 ---

## :Into تعبير 

يمكن تخزين نتيجة تطبيق تعليمية Select من التسجيلات في جدول جديد في قاعدة المعطيات، لتحفظ بشكل دائم. 

### Employee 

<table><tr><td>Id</td><td>Name</td><td>Location</td></tr><tr><td>1</td><td>A</td><td>Sales section</td></tr><tr><td>2</td><td>B</td><td>HR section</td></tr><tr><td>3</td><td>C</td><td>Sales section</td></tr></table>

Select id, name into HREmp from Employee
Where location='HR section'; 

======== 

انشاء جدول جديد باسم HREmp يتضمن بيانات موظفي قسم شؤون الموظفين. 

### HREmp 

<table><tr><td>Id</td><td>Location</td></tr><tr><td>1</td><td>Sales section</td></tr><tr><td>2</td><td>HR section</td></tr><tr><td>3</td><td>Sales section</td></tr></table>

## :Order by clause ترتيب البيانات المسترجعة 3. 

عند اختيار مجموعة جزئية من السجلات لاسترجاعها من المصدر فلا ضمانة على ترتيب السجلات المسترجعة (الترتيب ليس بالضرورة حسب ترتيب الادخال)، ولترتيب النتيجة المسترجعة لا بد من استخدام Order by ويمكن الترتيب تصاعدياً أو تنازلياً (asc | desc) ، علماً أن الترتيب للحقول الرقمية حسب الأصغر والأكبر بينما الترتيب للحقول النصية يتم حسب الترتيب الأبجدي، ويتم ترتيب حقول التاريخ حسب الأقدم والأحدث.

--- Page 15 ---

## Employee 

<table><tr><td>Id</td><td>Name</td><td>Location</td></tr><tr><td>1</td><td>Ahmad</td><td>HR Section</td></tr><tr><td>2</td><td>Bassem</td><td>Sales Section</td></tr><tr><td>3</td><td>Ahmad</td><td>Sales Section</td></tr><tr><td>4</td><td>Mazen</td><td>HR Section</td></tr></table>

Select * from Employee id desc; 

======== 

النتيجة مرتبة حسب تسلسل الرقم المعرف تنازلياً. 

## Employee 

<table><tr><td>Id</td><td>Name</td><td>Location</td></tr><tr><td>4</td><td>Mazen</td><td>HR Section</td></tr><tr><td>3</td><td>Ahmad</td><td>Sales Section</td></tr><tr><td>2</td><td>Bassem</td><td>Sales Section</td></tr><tr><td>1</td><td>Ahmad</td><td>HR Section</td></tr></table>

======== 

Select * from Employee order by name asc, id desc; 

======== 

## Employee 

<table><tr><td>Id</td><td>Name</td><td>Location</td></tr><tr><td>3</td><td>Ahmad</td><td>Sales Section</td></tr><tr><td>1</td><td>Ahmad</td><td>HR Section</td></tr><tr><td>2</td><td>Bassem</td><td>Sales Section</td></tr><tr><td>4</td><td>Mazen</td><td>HR Section</td></tr></table>

النتيجة مرتبة بحسب أبجدية الاسم، وفي حال تشابه اسمين يتم ترتيبها حسب الرقم المعرف تنازلياً.

--- Page 16 ---

4. تجميع البيانات المسترجعة واختيار المجموعات Group by & Having clause

يمكن تجميع البيانات المسترجعة من عملية Select حسب واحد أو أكثر من الأعمدة المسترجعة باستخدام Group by, ويمكن اختيار مجموعات من المجموعات الناتجة بوضع شرط على المجموعة باستخدام Having. 

يجب التمييز هنا بين Where التي تضع شرطاً على التسجيلات المسترجعة, و Having التي تضع شرطاً على المجموعات المسترجعة.

مثال: 

Emp1oyee

| Id | Name | Age | Salary |
|----|-------|-----|--------|
| 401 | Anu  | 22  | 9000   |
| 402 | Shane| 29  | 8000   |
| 403 | Rohan| 34  | 6000   |
| 404 | Scott| 44  | 9000   |
| 405 | Tiger| 35  | 8000   |

Select name, age from Employee group by salary;

========

نطاق: الحقول المنتقاة يجب أن تكون إما جزء من الحقول التي يجري التجميع حسبها, أو نتيجة تطبيق تابع يعطي قيمة وحيدة لكل مجموعة.

========

Select salary, count(name) from Employee group by salary;

========

| Salary | Count(salary) |
|---------|---------------|
| 9000    | 2             |
| 8000    | 2             |
| 6000    | 1             |

========

-16-

--- Page 17 ---

Select salary, count(name) 

from Employee 

group by salary 

having count(name) >1 ; 

===== 

<table><tr><td>Salary</td><td>Count(salary)</td></tr><tr><td>9000</td><td>2</td></tr><tr><td>8000</td><td>2</td></tr></table>

## 5. إلغاء التكرار في البيانات المسترجعة (Distinct Keyword) 

مثال: 

### Employee 

<table><tr><td>Id</td><td>Name</td><td>Location</td></tr><tr><td>1</td><td>Ahmad</td><td>HR Section</td></tr><tr><td>2</td><td>Bassem</td><td>Sales Section</td></tr><tr><td>3</td><td>Ahmad</td><td>Sales Section</td></tr><tr><td>4</td><td>Mazen</td><td>HR Section</td></tr></table>

Select distinct name from Employee; 

في حال وجود اسم مكرر يظهر مرة واحدة في النتيجة المسترجعة. 

===== 

<table><tr><td>Name</td></tr><tr><td>Ahmad</td></tr><tr><td>Bassem</td></tr><tr><td>Mazen</td></tr></table>

========

--- Page 18 ---

Employee 

<table><tr><td>Id</td><td>Name</td><td>Location</td></tr><tr><td>1</td><td>Ahmad</td><td>HR Section</td></tr><tr><td>2</td><td>Bassem</td><td>Sales Section</td></tr><tr><td>3</td><td>Ahmad</td><td>HR Section</td></tr><tr><td>4</td><td>Mazen</td><td>HR Section</td></tr></table>

Select distinct (name, location) from Employee; 

في حال وجود اسم مكرر بنفس مكان العمل يظهر مرة واحدة في النتيجة المسترجمة. 

====== 

<table><tr><td>Name</td><td>Location</td></tr><tr><td>Ahmad</td><td>HR Section</td></tr><tr><td>Bassem</td><td>Sales Section</td></tr><tr><td>Mazen</td><td>HR Section</td></tr></table>

6. تطبيق 

تتألف قاعدة المعطيات في تطبيقنا من ثلاثة جداول كما يلي: 

- Person 

<table><tr><td>Id</td><td>FName</td><td>LName</td><td>Gender</td><td>Nationality</td><td>Age</td></tr><tr><td>1</td><td>John</td><td>Smith</td><td>1</td><td>2</td><td>32</td></tr><tr><td>2</td><td>Adam</td><td>Sandler</td><td>1</td><td>1</td><td>45</td></tr><tr><td>3</td><td>Mary</td><td>Clair</td><td>0</td><td>1</td><td>40</td></tr><tr><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td></tr></table>

--- Page 19 ---

- Nationality 

<table><tr><td>Id</td><td>Name</td></tr><tr><td>1</td><td>American</td></tr><tr><td>2</td><td>French</td></tr><tr><td>...</td><td>...</td></tr></table>

- ContactMedia 

<table><tr><td>Id</td><td>Media</td></tr><tr><td>1</td><td>Mobile</td></tr><tr><td>2</td><td>E-Mail</td></tr><tr><td>3</td><td>Phone</td></tr><tr><td>...</td><td>...</td></tr></table>

- PersonContact 

<table><tr><td>Id</td><td>Person</td><td>ContactMedia</td><td>ContactValue</td></tr><tr><td>1</td><td>1</td><td>1</td><td>00963944111222</td></tr><tr><td>2</td><td>1</td><td>2</td><td>xxx@gmail.com</td></tr><tr><td>...</td><td>...</td><td>...</td><td>...</td></tr></table>

======== 

في مثانلا تصدر الجنسية Nationality مفتاحها إلى الجدول (ارتباط واحد لعدة)، وترتبط طريقة الاتصال ContactMedia مع جدول Person من خلال جدول وسيط هو PersonContact (يمكن أن يكون لنفس الشخص أكثر من طريقة للاتصال به). 

المطلوب: 

- قائمة بأسماء الذكور مرتبة أبجدياً؟ 

- قائمة بأسماء الأشخاص الذين لهم بيانات اتصال مدخلة؟ 

- قائمة بكل زوج من الأشخاص فارق العمر بينهما أقل من 5 سنوات، وهما من جنسين مختلفين؟ 

- قائمة بأرقام موبايل الأشخاص من جنسية فرنسية؟ 

- قائمة بأسماء الأشخاص الذين ليست لهم بيانات اتصال مدخلة؟

--- Page 20 ---

## :المراجع 7 

http://www.studytonight.com/dbms/select-query

--- Page 21 ---

:نتيجة تطبيق جملة التعليمات التالية 

Select Sum (price) From Invoice, Material, Invoice_Item Invoice.Id=Invoice_item.Invoice And Invoice_Item.material=Material.Id And Invoice.id=2; 

:هي 

. اجمالي سعر جميع فواتير .1 

. اجمالي الفاتورة رقم .2 

. اجمالي فواتير الزبون .1 

. مجموع أسعار المواد المتضمنة في الفاتورة رقم .2 

(4) :الإجابة 

. Sum(Price * QTY) بالعبارة Sum(price) يجب استبدال 2 رقم للحصول على اجمالي الفاتورة 

:نتيجة التعليمة التالية 

Select Sum (QTY * Price) From Invoice, Material, Invoice_Item Invoice.Id=Invoice_item.Invoice And Invoice_Item.material=Material.Id And Client.Name='C 1'; 

:هي 

. اجمالي فواتير الزبون .1 C 

. اجمالي الفواتير بصرف النظر عن الزبون .2 

. خطأ .3 

. مجموع أسعار المواد المتضمنة في فواتير الزبون .4 

(4) :الإجابة 

From الجدول المصدر لاسم الزبون غير وارد في قائمة

--- Page 22 ---

- نتيجة التعليمية التالية: 

Select    Sum (QTY * Price)
From    Invoice, Material, Invoice_Item
Where    Invoice.Id=Invoice_item.Invoice
    And Invoice_Item.material=Material.Id
Group by    Invoice_Item.Invoice
Having    count(Invoice_item.id) >1; 

هي: 

1. قائمة باجمالي الفواتير. 

2. قائمة باجمالي الفواتير التي تحوي أكثر من قلم. 

3. مجموع قيم الفواتير التي تحوي أكثر من قلم. 

4. اجمالي الفواتير مرتبة حسب رقم الفاتورة. 

الإجابة: (2) 

- نتيجة التعليمية التالية: 

Select    distinct Invoice.Date
From    Invoice, Client
Where    Invoice.Client=Client.Id
    And Client.Name = 'C 2'; 

هي: 

1. تاريخ آخر فاتورة للزبون C 2. 

2. قائمة بتاريخ الأيام التي اشترى فيها الزبون C 2 بدون تكرار. 

3. قائمة بتاريخ فواتير الزبون C 2. 

4. اجمالي فواتير الزبون C 2. 

الإجابة: (2)
