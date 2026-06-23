--- Page 1 ---

المحاضرة التاسعة
لغة التحكم بالتدفق والمؤشرات
Control of Flow Language and Cursors 

مقدمة: في الكثير من الأحيان نجد أنه من الضروري ألا يتم تنفيذ استعلام ما إلا عند تحقق شرط معين، وقد يكون أحد السيناريوهات المحتملة أيضاً الرغبة في عدم تنفيذ استعلام ما لم يعد استعلام سابق نتيجة متوقعة، أو أن نحتاج إلى تنفيذ استعلامات مختلفة بحسب قيمة معامل محدد مثلاً. 

تتيح لغة Transact SQL بعض الكلمات المفتاحية التي تسمح بالتحكم بتدفق التنفيذ لعبارات T-SQL. من دون تعليمات التحكم بالتدفق فإن تعليمات T-SQL ستفذ بالترتيب حسب ورودها أما بوجود تعليمات التحكم بالتدفق فإن التعليمات سترتبط مع بعضها البعض بالطريقة ذاتها كما في لغات البرمجة حيث نجد التعبيرات الشرطية IF.. ELSE و CASE.. WHEN. 

الكلمات المفتاحية 

<table><tr><td>الكلمة المفتاحية</td><td>الشرح</td></tr><tr><td>BEGIN ... END</td><td>A Statement Block تعريف كتلة من التعابير</td></tr><tr><td>IF ... ELSE</td><td>التعريف التنفيذ الشرطي (أي تنفيذ كتلة تعليمات عند تحقق شرط منطقي ما) والتنفيذ الاختياري لكتلة أخرى عند عدم تحقق الشرط</td></tr><tr><td>CASE</td><td>تعيد تعبيراً واحداً من مجموعة من التعابير بناء على شرط مقارنة</td></tr><tr><td>WHILE</td><td>تنفيذ مجموعة من التعليمات طالما أن شرطاً محدداً ما زال محققاً</td></tr></table>

--- Page 2 ---

<table><tr><td>الخروج من حلقة التكرار While الداخلية</td><td>BREAK</td></tr><tr><td>إعادة تنفيذ حلقة التكرار While</td><td>CONTINUE</td></tr><tr><td>الخروج غير المشروط</td><td>RETURN</td></tr><tr><td>متابعة التنفيذ عند التعليمية التالية للعلامة التي اسمها label</td><td>GOTO label</td></tr><tr><td>انتظار مؤقت للتنفيذ</td><td>WAITFOR</td></tr></table>

1. التعليمية الشرطية IF...ELSE 

وتستخدم لتنفيذ كتلة تعليمات بناء على تحقق شرط منطقي ما. 

IF Boolean_expression 

{ sql_statement | statement_block } 

[ ELSE 

{ sql_statement | statement_block } ] 

ينفذ الجزء ELSE في حال كان الشرط المنطقي Boolean_expression غير محقق (أي يعطي قيمة منطقية FALSE). وهذا الجزء اختياري وليس بالضرورة موجود. 

مثال: 

في قاعدة المعطيات Pubs نريد تحديد كون وسطي أسعار الكتب أكبر أو أصغر من 15$ مع طباعة العبارة المناسبة 

USE pubs 

IF (SELECT AVG(price) FROM titles ) < $15 

PRINT 'Average title price is less than $15.' 

ELSE 

IF (SELECT AVG(price) FROM titles ) > $15

--- Page 3 ---

PRINT 'Average title price is more than $15.' 

ELSE 

PRINT 'Average title price is equal to $15.' 

مثال: في قاعدة المعطيات Pubs نريد طباعة بيانات عن الكتب بحسب مجالات السعر: أصغر من 8، بين 8 و 15، وأكبر من 15% مع رسالة توضيحية تبين مجال السعر. 

Use Pubs 

Go 

Declare @msg VarChar(100) 

If (Select Count(*) From Titles Where Price <8) >0 

Begin 

Set @msg = 'There are several books with prices less than $ 8. These Books are: 

Print @msg 

Select title From titles where price <8 

End 

If (Select Count(*) From Titles Where Price Between 8 and 15) >0 

Begin 

Set @msg = 'There are several books with bearable prices. These Books are: 

Print @msg 

Select title From titles Where price Between 8 and 15 

End 

If (Select Count(*) From Titles Where Price > 15) >0 

Begin 

Set @msg = 'Many books are very expensive. These Books are: 

Print @msg 

Select title From titles Where price > 15 

End 

Else 

Begin 

Set @msg = 'this msg appears if the condition above is not True' 

Print @msg 

End

--- Page 4 ---

في حال أبدلنا السعر في آخر تعليمه IF لتكون: 

If (Select Count(*) From Titles Where Price > 25) > 0 

نجد أن الشرط سيكون تقييمه False وبالتالي سيذهب مباشرة إلى ELSE ويطبع الرسالة. 

2. التعليمية CASE 

تعيد إحدى القيم الممكنة من مجموعة قيم وذلك بناء على شرط ما. 

لهذه التعليمية نمطين: 

- النمط البسيط Simple CASE: وفيه تتم مقارنة تعبير ما مع مجموعة من التعابير 

المحتملة لتحديد النتيجة. 

- نمط الاكتشاف Searched CASE: وفيه يتم اختبار مجموعة من الشروط المنطقية 

لتحديد النتيجة. 

يمكن تضمين جزء ELSE في كلا النمطين. 

النمط البسيط: 

CASE input_expression 

WHEN when_expression THEN result_expression 

[ ...n ] 

[ 

ELSE else_result_expression 

] 

END 

نمط الاكتشاف: 

CASE 

WHEN Boolean_expression THEN result_expression

--- Page 5 ---

[ ...n ] 

[ 

ELSE else_result_expression 

] 

END 

: input_expression 

وهو التعبير المراد مقارنته مع مجموعة القيم الموجودة في النمط البسيط (تعبير المقارنة) 

: WHEN when_expression 

وهو تعبير بسيط لمقارنة قيمته مع قيمة تعبير المقارنة. نمط هذا التعبير ونمط تعبير المقارنة يجب أن يتطابقا أو أن يكون هناك تحويل ممكن مضمّن بينهما. 

: THEN result_expression 

وهو ناتج التعليمية في حال طابق تعبير المقارنة التعبير البسيط المحدد في فقرة WHEN الموافقة. 

: n : للدلالة على أن الجزء WHEN...THEN يمكن أن تتكرر أكثر من مرة. 

: ELSE else_result_expression 

وهو نتيجة التعليمية في حال كانت قيمة المقارنة مختلفة عن جميع التعبير البسيطة المحددة في الفقرات WHEN السابقة له. إذا لم يتم تحديد هذا الجزء وكانت قيمة المقارنة مغايرة لجميع الأنماط البسيطة المحددة فإن ناتج التعليمية هو NULL. 

مثال: يظهر المثال التالي كيفية استخدام تعليمية case من أجل تعديل القيمة الراجعة من حقل. تظهر التعليمية نوع، عنوان، سعر الكتب. 

USE pubs 

GO 

SELECT title, Category = 

CASE type

--- Page 6 ---

WHEN 'popular_comp' THEN 'Popular Computing' WHEN 'mod_cook' THEN 'Modern Cooking' WHEN 'business' THEN 'Business' WHEN 'psychology' THEN 'Psychology' WHEN 'trad_cook' THEN 'Traditional Cooking' ELSE 'Not yet categorized' END, CAST(title AS varchar(25)) AS 'Shortened Title', price AS Price FROM titles 

مثال: 

يمكننا نمط الاستكشاف لتعليمه case من استبدال قيم حقل في النتيجة النهائية. "very Reasonable" "Coffee Table Title" "Expensive" "not yet priced" (20 من 20) ، "Book" 

USE pubs 

GO 

SELECT title, 'Price Category' = 

CASE 

WHEN price IS NULL THEN 'Not yet priced' 

WHEN price < 10 THEN 'Very Reasonable Title' 

WHEN price >= 10 and price < 20 THEN 'Coffee Table Title' 

ELSE 'Expensive book!' 

END, 

CAST(title AS varchar(20)) AS 'Shortened Title' 

FROM titles 

ORDER BY price 

المثال السابق بعد اجراء تعديل بسيط: 

SELECT title, 

CASE 

WHEN price IS NULL THEN 'Not yet priced'

--- Page 7 ---

when type = 'mod_cook' THEN 'Modern Book' WHEN price < 10 THEN 'Very Reasonable Title' WHEN price >= 10 and price < 20 THEN 'Coffee Table Title' WHEN price = (select price from titles where title_id = 'BU1032') THEN 'data base book' 

ELSE 'Expensive book!' END NewColomn, price, type 

FROM titles
ORDER BY price 

3. حلقة التكرار WHILE 

وتستخدم لتنفيذ تعليمة SQL أو كتلة تعليمات طالما أن شرطاً منطقياً مازال محققاً. 

في Server يستخدم التعبير WHILE مع END و BEGIN. 

WHILE Boolean_expression 

{ sql_statement | statement_block } 

[ BREAK ] 

{ sql_statement | statement_block } 

[ CONTINUE ] 

{ statements } 

: Boolean_expression وهو تعبير منطقي (أي يعيد إما صح أو خطأ). يمكن للتعبير 

المنطقي أن يحوي تعليمة Select وفي هذه الحالة يجب وضع تعليمة الانتقاء بين أقواس. 

{ sql_statement | statement_block } أو كتلة 

. END و BEGIN كتلة تعليمات هي مجموعة من التعليمات الموضوعة بين SQL تعليمات 

: BREAK وتؤدي إلى الخروج من تعليمة WHILE الداخلية (في حالة وجود أكثر من حلقة WHILE منسوخة ضمن بعضها البعض). الكلمة المفتاحية END تحدد نهاية الحلقة. 

: CONTINUE وتؤدي إلى العودة إلى بداية الحلقة مجددا، وإهمال كافة التعليمات اللاحقة لها.

--- Page 8 ---

مثال نريد أن نضاعف أسعار جميع الكتب طالما أن وسطي السعر أقل من 60$ وأعلى سعر لا يتجاوز 160$. 

USE pubs
GO
WHILE (SELECT AVG(price) FROM titles) < $60
BEGIN
    UPDATE titles
    SET price = price * 2
    SELECT MAX(price) FROM titles
    IF (SELECT MAX(price) FROM titles) > $160
    BREAK
    ELSE
    CONTINUE
END 

<table><tr><td>AVG(price)</td><td>AVG(price)<60</td><td>MAX(price)</td><td>MAX(price)>160</td><td>price</td></tr><tr><td>14.7662</td><td>True</td><td>22.95</td><td>False</td><td>Price*2</td></tr><tr><td>29.5325</td><td>True</td><td>45.90</td><td>False</td><td>Price*2</td></tr><tr><td>59.065</td><td>True</td><td>91.80</td><td>False</td><td>Price*2</td></tr><tr><td>118.13</td><td>False</td><td>-</td><td>-</td><td>-</td></tr></table>

Stop while 

في حال غيرنا الشروط ليكون وسطي السعر أقل من 120$ وأعلى سعر لا يتجاوز 90$. 

WHILE (SELECT AVG(price) FROM titles) < $120
BEGIN
    UPDATE titles
    SET price = price * 2
    SELECT MAX(price) FROM titles
    IF (SELECT MAX(price) FROM titles) > $90
    BREAK
    ELSE

--- Page 9 ---

CONTINUE
END 

<table><tr><td>AVG(price)</td><td>AVG(price)<120</td><td>MAX(price)</td><td>MAX(price)>90</td><td>price</td></tr><tr><td>14.7662</td><td>True</td><td>22.95</td><td>False</td><td>Price*2</td></tr><tr><td>29.5325</td><td>True</td><td>45.90</td><td>False</td><td>Price*2</td></tr><tr><td>59.065</td><td>True</td><td>91.80</td><td>True</td><td>—</td></tr></table>

Continue
Continue
Break 

Go Out
While 

4. التعليمية WAITFOR 

وتستخدم لإيقاف تنفيذ التعليمية التالية له مدة محددة من الزمن أو بدء التنفيذ في زمن محدد.
WAITFOR { DELAY 'time' | TIME 'time' } 

DELAY : تنفيذ التعليمية التالية بعد مرور الزمن المحدد بالقيمة (time) هذا المتحول يجب أن يكون من النمط (DateTime). 

TIME : تنفيذ التعليمية التالية بحلول التوقيت المحدد بالقيمة (time) وهو متحول يجب أن يكون من النمط (DateTime). 

مثال تقوم التعليمية التالية بإيقاف التنفيذ لمدة ثانيتين ثم تقوم بعرض قائمة بأرقام الموظفين في قاعدة البيانات Northwind. 

WAITFOR DELAY '00:00:02' 

SELECT EmployeeID FROM Northwind.dbo.Employees 

مثال عند الساعة العاشرة والنصف و 59 ثانية ليالاً أنشئ تقريرا بأرقام وأسماء الموظفين من قاعدة البيانات Northwind. 

USE northwind 

go 

BEGIN 

WAITFOR TIME '22:30:59'

--- Page 10 ---

SELECT 

employeeId, 

firstName + '' + lastname as 'full name' 

FROM 

employees 

ORDER BY employeeid 

END 

5. Goto: تعليمية الفقر 

مثال:

--- Page 11 ---

DECLARE @Counter INT;  

SET @Counter \(= 1\)  

WHILE @Counter \(< 10\)  

BEGIN  

SELECT @Counter  

SET @Counter \(= \text{@Counter} + 1\)  

IF @Counter \(= 4\) GOTO Branch_One - - Jumps to the first branch.  

IF @Counter \(= 5\) GOTO Branch_Two - - This will never execute.  

END  

Branch_One:  

SELECT Jumping To Branch One.'  

GOTO Branch_Three; - - This will prevent Branch_Two from executing.  

Branch_Two:  

SELECT Jumping To Branch Two.'  

Branch_Three:  

SELECT Jumping To Branch Three.'  

<table><tr><td>@Counter</td><td>@Counter&amp;lt;10</td></tr><tr><td>1</td><td>True</td></tr><tr><td>2</td><td>True</td></tr><tr><td>3</td><td>True</td></tr><tr><td>4</td><td>True</td></tr></table>  

SELECT Jumping To Branch One.'  

GOTO Branch Three.  

SELECT Jumping To Branch Three.'

--- Page 12 ---

المؤشرات
CURSORS 

الهدف من المؤشرات: 

تسمح المؤشرات بالمرور على نتائج تعليمية Select سطراً، ومن أجل كل سطر من الأسطر يمكن إجراء معالجة محددة. 

تعريف المؤشرات: 

الصيغة النظامية لتعريف مؤشر وفق معيار SQL هي على الشكل التالي:
DECLARE cursor_name [ INSENSITIVE ] [ SCROLL ] CURSOR 

FOR select_statement 

[ FOR { READ ONLY | UPDATE [ OF column_name [ ...n ] ] } ] 

الصيغة الممددة لتعريف مؤشر هي على الشكل التالي: 

DECLARE cursor_name CURSOR 

[ LOCAL | GLOBAL ] 

[ FORWARD_ONLY | SCROLL ] 

[ STATIC | KEYSET | DYNAMIC | FAST_FORWARD ] 

[ READ_ONLY | SCROLL_LOCKS | OPTIMISTIC ] 

[ TYPE_WARNING ] 

FOR select_statement 

[ FOR UPDATE [ OF column_name [ ...n ] ] ] 

سوف نستخدم الصيغة الممددة لتعريف مؤشر لذلك سوف نقوم بشرح البنية الثانية: 

cursor_name 

اسم المؤشر

--- Page 13 ---

<table><tr><td>LOCAL</td><td>المؤشر داخلي لإجرائية أو كتلة statement block، عند انتهاء تنفيذ الإجرائية أو كتلة التعليمات ينتهي تعريف المؤشر. لكن إذا أسند المؤشر الداخلي (المعرف ضمن إجرائية) إلى متحول معرف output يبقى تعريف المؤشر ويمكن استخدامه خارج الإجرائية.</td></tr><tr><td>GLOBAL</td><td>المؤشر عام ويمكن استخدامه في جميع الإجرائيات بعد تعريفه.</td></tr><tr><td>FORWARD_ONLY</td><td>يمكن المرور على نتائج عملية Select باتجاه واحد Next (من السجل الأول إلى السجل الأخير).</td></tr><tr><td>SCROLL</td><td>يعني أن التجوال على البيانات المعرف عليها المؤشر يمكن أن يكون من الأول إلى الأخير ومن الأخير إلى الأول: (الاحتمالات الممكنة):<br/>إحضار السجل التالي: Fetch next:<br/>إحضار السجل السابق: Fetch prior:<br/>إحضار السجل الأول: Fetch first:<br/>إحضار السجل الأخير: Fetch last:</td></tr><tr><td>STATIC</td><td>يقوم DBMS بإنشاء نسخة عن البيانات المراد التجوال عليها في قاعدة البيانات المؤقتة TEMPDB (نتيجة لذلك لا تؤثر عمليات الحذف والإضافة ضمن الجداول على بيانات المؤشر). يمكن التجوال على بيانات المؤشر في هذه الحالة كالتجوال في حالة الخيار SCROLL.</td></tr><tr><td>KEYSET</td><td>يقوم مخدم قواعد البيانات بإنشاء جدول في قاعدة البيانات TEMPDB يحوي فقط مفاتيح السجلات التي سوف تستخدم كبيانات للمؤشر. إذا تم تغيير البيانات التي لا تشكل مفتاحاً للسجلات التي سوف يتم عليها المؤشر، سوف يظهر هذا التغيير عند استحضار</td></tr></table>

--- Page 14 ---

الأسطر. 

إذا تم حذف (أو تعديل ) سجلات مفاتيحها الأولية مخزنة في 

الجدول في قاعدة البيانات TEMPDB، فإن ذلك سوف يضع 

قيمة لمتحول عام : 

-2 @ = FETCH_STATUS = 

تنظهر جميع التعديلات التي تمت على البيانات أثناء التجوال على البيانات. 

يمنع هذا الخيار أي تعديل على السجلات المستخدمة من قبل المؤشر ( التعديل باستخدام المؤشر نفسه ) لكنه لا يمنع التعديل الخارجي عليها. 

FAST_FORWARD تعني هذه التعليمة: 

FORWARD_ONLY, READ_ONLY 

وضع قفل على السجل الحالي الذي يؤشر عليه المؤشر، الأمر الذي يسمح بتعديل السجل الحالي أو حذفه بنجاح. 

لا يضع هذا الخيار أي قفل على السجل الذي يؤشر عليه المؤشر، وبالتالي لا يمكن ضمان نجاح عمليات التعديل والحذف للسجل الحالي. 

يظهر مخدم قواعد البيانات رسالة خطأ إذا تم تحويل المؤشر إلى نمط آخر. 

تعليمة الاختيار التي تحدد البيانات التي سوف نستخدمها بالمؤشر cursor_name 

تحديد الأعمدة التي يسمح المؤشر بتعديلها عبر المؤشر نفسه. 

FOR UPDATE

--- Page 15 ---

مثال سوف نقوم في المثال التالي بتعريف مؤشر يحضر اسم الموظف وكنيته ومن ثم يطبع
الاسم الكامل للموظف من قاعدة البيانات northwind. 

declare @fname varchar(20), @lname varchar(20), @full varchar(255) 

declare cur cursor for 

select firstname, lastname 

from employees 

order by firstname, lastname 

open cur 

fetch next from cur into @fname, @lname 

while @@fetch_status = 0 

begin 

if @@fetch_status <> -2 

begin 

set @full = @fname + '' + @lname 

print @full 

end 

fetch next from cur into @fname, @lname 

end 

close cur 

deallocate cur

--- Page 16 ---

مثال 

سوف نقوم في هذا المثال باستخدام المؤشرات من أجل بناء تقرير. التقرير المراد بناؤه هو على الشكل التالي: 

السطر الأول يحوي اسم المؤلف: 

مجموعة الأسطر التالية هي مجموعة الكتب التي ألفها هذا المؤلف. 

نكرر العملية السابقة من أجل جميع المؤلفين في قاعدة البيانات. 

DECLARE @au_id varchar(11), @au_fname varchar(20), 

@au_lname varchar(40), @message varchar(80), 

@title varchar(80) 

PRINT '--- Authors report ---' 

DECLARE authors_cursor CURSOR FOR 

SELECT au_id, au_fname, au_lname 

FROM authors 

ORDER BY au_id 

OPEN authors_cursor

--- Page 17 ---

FETCH NEXT FROM authors_cursor INTO @au_id, @au_fname, @au_lname WHILE @@FETCH_STATUS = 0 BEGIN PRINT "' SELECT @message = '---- Books by Author: ' + @au_fname + ' ' + @au_lname PRINT @message -- Declare an inner cursor based -- on au_id from the outer cursor. DECLARE titles_cursor CURSOR FOR SELECT t.title FROM titleauthor ta, titles t WHERE ta.title_id = t.title_id AND ta.au_id = @au_id -- Variable value from the outer cursor OPEN titles_cursor FETCH NEXT FROM titles_cursor INTO @title IF @@FETCH_STATUS <> 0 PRINT ' <<No Books>>' WHILE @@FETCH_STATUS = 0 BEGIN SELECT @message = ' ' + @title PRINT @message FETCH NEXT FROM titles_cursor INTO @title END CLOSE titles_cursor DEALLOCATE titles_cursor -- Get the next author. FETCH NEXT FROM authors_cursor INTO @au_id, @au_fname, @au_lname

--- Page 18 ---

END
CLOSE authors_cursor
DEALLOCATE authors_cursor 

<table><tr><td>au_id</td><td>au_fname</td><td>au_name</td></tr><tr><td>172-32-1176</td><td>Johnson</td><td>White</td></tr><tr><td>213-46-8915</td><td>Marjorie</td><td>Green</td></tr><tr><td>238-95-7766</td><td>Cheryl</td><td>Carson</td></tr><tr><td>267-41-2394</td><td>Michael</td><td>O'Leary</td></tr><tr><td>274-80-9391</td><td>Dean</td><td>Straight</td></tr><tr><td>341-22-1782</td><td>Meander</td><td>Smith</td></tr><tr><td>409-56-7008</td><td>Abraham</td><td>Bennet</td></tr><tr><td>427-17-2319</td><td>Ann</td><td>Dull</td></tr><tr><td>472-27-2349</td><td>Butt</td><td>Gringlesby</td></tr><tr><td>486-29-1786</td><td>Charlene</td><td>Locksley</td></tr><tr><td>527-72-3246</td><td>Morningstar</td><td>Greene</td></tr><tr><td>648-92-1872</td><td>Reginald</td><td>Blotchet-Halls</td></tr><tr><td>672-71-3249</td><td>Akiko</td><td>Yokomoto</td></tr></table>

<table><tr><td>au_id</td><td>title_id</td><td>au_ord</td><td>royaltyper</td></tr><tr><td>172-32-1176</td><td>PS3333</td><td>1</td><td>100</td></tr><tr><td>213-46-8915</td><td>BU1032</td><td>2</td><td>40</td></tr><tr><td>213-46-8915</td><td>BU2075</td><td>1</td><td>100</td></tr><tr><td>238-95-7766</td><td>PC1035</td><td>1</td><td>100</td></tr><tr><td>267-41-2394</td><td>BU1111</td><td>2</td><td>40</td></tr><tr><td>267-41-2394</td><td>TC7777</td><td>2</td><td>30</td></tr><tr><td>274-80-9391</td><td>BU7832</td><td>1</td><td>100</td></tr><tr><td>409-56-7008</td><td>BU1032</td><td>1</td><td>60</td></tr><tr><td>427-17-2319</td><td>PC8888</td><td>1</td><td>50</td></tr><tr><td>472-27-2349</td><td>TC7777</td><td>3</td><td>30</td></tr><tr><td>486-29-1786</td><td>PC9999</td><td>1</td><td>100</td></tr></table>

<table><tr><td>title_id</td><td>title</td></tr><tr><td>BU1032</td><td>The Busy Executive's Database Guide</td></tr><tr><td>BU1111</td><td>Cooking with Computers: Sumptuous Balance Sheets</td></tr><tr><td>BU2075</td><td>You Can Combat Computer Stress!</td></tr><tr><td>BU7832</td><td>Straight Talk About Computers</td></tr><tr><td>MC2222</td><td>Silicon Valley Gastronomic Treats</td></tr><tr><td>MC3021</td><td>The Gourmet Microwave</td></tr><tr><td>MC3026</td><td>The Psychology of Computer Cooking</td></tr><tr><td>PC1035</td><td>But Is It User Friendly?</td></tr><tr><td>PC8888</td><td>Secrets of Silicon Valley</td></tr><tr><td>PC9999</td><td>Net Etiquette</td></tr><tr><td>PS1372</td><td>Computer Phobic AND Non-Phobic Individuals: Beha...</td></tr><tr><td>PS2091</td><td>Is Anger the Enemy?</td></tr><tr><td>PS2106</td><td>Life Without Fear</td></tr><tr><td>PS3333</td><td>Prolonged Data Deprivation: Four Case Studies</td></tr></table>

-انتهت المحاضرة-
