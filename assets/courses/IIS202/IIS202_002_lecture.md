--- Page 1 ---

الصفحة 

العنوان 

3 

1. مقدمة 

3 

2. بنى المعطيات في النموذج العلائق 

5 

3. خصائص الجداول 

5 

4. العلاقات والمفاتيح 

7 

5. قواعد التكامل 

7 

6. معالجة البيانات 

7 

1.6 الاجتما (Union) 

8 

2.6 التقاطع (Intersection) 

8 

3.6 الفرق (Difference) 

9 

4.6 الجداء (Product) 

9 

5.6 الاختيار (Selection) 

10 

6.6 الإسقاط (Projection) 

10 

7.6 الضم (Join) 

10 

8.6 التقسيم (Division) 

11 

7. المراجع

--- Page 2 ---

الكلمات المفتاحية 

علاقة، جدول، تسجيلية، عمود، حقل، نمط بيانات، مفتاح أساسي، مفتاح مستورد، تكامل المعطيات، التنظيم، المنظور المنطقي، المنظور الفيزيائي. 

ملخص 

يركز هذا الفصل على التعريف بنموذج البيانات العلائق، والمفاهيم الخاصة به. 

الأهداف التعليمية 

يهدف هذا الفصل إلى: 

- تعريف المفاهيم الخاصة بالنموذج العلائق للبيانات 

- خصائص الجداول في النموذج العلائق 

- دراسة العلاقات وطرق تنفيذها في النموذج العلائق 

- تعريف تكامل المعطيات ومعالجتها 

- مقدمة عن التنظيم

--- Page 3 ---

## 1. مقدمة 

تم التقديم للنموذج العلائق في تصميم قواعد البيانات عام 1970 من قبل Dr.E.F.Codd، وقد تطور منذ ذلك الحين من خلال سلسلة من المقالات والكتابات، إلى أن أخذ شكلاً مستقراً حالياً. 

تتألف قاعدة البيانات المبنية على النموذج العلائق، من مجموعة جداول ثنائية البعد، يمثل كل جدول منها كياناً (شخص، مكان، شيئ، حدث...) له مجموعة من المواصفات، أو يمثل علاقة بين أكثر من كيان. 

ويعني المنظور المنطقي لقاعدة البيانات Logical view النظر للقاعدة كمجموعة من الجداول والعلاقات بينها. 

بينما يعني المنظور الداخلي Internal view النظر لقاعدة البيانات كمجموعة من الملفات الفيزيائية وطريقة تخزين على الأقراص الصلبة. 

فيما يلي سنعرض أهم المفاهيم الخاصة بالنموذج العلائق لتصميم قواعد المعطيات، مع شرح مفصل عنها، من خلال الفقرات التالية: 

- بنى المعطيات في النموذج العلائق 

- خصائص الجداول 

- العلاقات والمفاتيح 

- قواعد التكامل 

- معالجة البيانات 

## 2. بنى المعطيات في النموذج العلائق 

قاعدة المعطيات العلائقية هي مجموعة من الجداول. 

الجدول هو بنية ثنائية البعد تتألف من أعمدة وأسطر. لكل عمود اسم وحيد ونمط معطيات ويمثل العمود موصّفة للكيان الذي يعبر عنه الجدول أو للعلاقة التي نتج عنها الجدول. 

السطر في الجدول يمثل ورود لأحد عناصر الكيان، فمثلاً إذا كان الجدول يحمل بيانات موظفي شركة، فكل عمود يمثل موصّفة للموظف (اسمه، تاريخ توظيفه، منصبه،...) وكل سطر يمثل بيانات موظف محدد. 

تقاطع السطر والعمود يمثل قيمة موصّفة لأحد عناصر الكيان (تقاطع عمود تاريخ التوظيف مع السطر الخاص بالموظف Scott يمثل تاريخ توظيف Scott في الشركة).

--- Page 4 ---

الشكل التالي يظهر التصميم العلائق لقاعدة بيانات تخص مجموعة من الكتب وعلاقتها بالملفين ودور النشر: 

## A Relational Data Base 

### AUTHOR 

<table><tr><td>au_id</td><td>au_lname</td><td>au_fname</td><td>address</td><td>city</td><td>state</td></tr><tr><td>172-32-1176</td><td>White</td><td>Johnson</td><td>10932 Bigge Rd.</td><td>Menlo Park</td><td>CA</td></tr><tr><td>213-46-8915</td><td>Green</td><td>Marjorie</td><td>309 63rd St. #411</td><td>Oakland</td><td>CA</td></tr><tr><td>238-95-7766</td><td>Carson</td><td>Cheryl</td><td>589 Darwin Ln.</td><td>Berkeley</td><td>CA</td></tr><tr><td>267-41-2394</td><td>O'Leary</td><td>Michael</td><td>22 Cleveland Av. #14</td><td>San Jose</td><td>CA</td></tr><tr><td>274-80-9391</td><td>Straight</td><td>Dean</td><td>5420 College Av.</td><td>Oakland</td><td>CA</td></tr><tr><td>341-22-1782</td><td>Smith</td><td>Meander</td><td>10 Mississippi Dr.</td><td>Lawrence</td><td>KS</td></tr><tr><td>409-56-7008</td><td>Bennett</td><td>Abraham</td><td>6223 Bateman St.</td><td>Berkeley</td><td>CA</td></tr><tr><td>427-17-2319</td><td>Dull</td><td>Ann</td><td>3410 Blonde St.</td><td>Palo Alto</td><td>CA</td></tr><tr><td>472-27-2349</td><td>Gringlesby</td><td>Burt</td><td>PO Box 792</td><td>Covelo</td><td>CA</td></tr><tr><td>486-29-1786</td><td>Locksley</td><td>Charlene</td><td>18 Broadway Av.</td><td>San Francisco</td><td>CA</td></tr></table>

### TITLE 

<table><tr><td>title_id</td><td>title</td><td>type</td><td>price</td><td>pub_id</td></tr><tr><td>BU1032</td><td>The Busy Executive's Database Guide</td><td>business</td><td>19.99</td><td>1389</td></tr><tr><td>BU1111</td><td>Cooking with Computers</td><td>business</td><td>11.95</td><td>1389</td></tr><tr><td>BU2075</td><td>You Can Combat Computer Stress!</td><td>business</td><td>2.99</td><td>736</td></tr><tr><td>BU7832</td><td>Straight Talk About Computers</td><td>business</td><td>19.99</td><td>1389</td></tr><tr><td>MC2222</td><td>Silicon Valley Gastronomic Treats</td><td>mod_cook</td><td>19.99</td><td>877</td></tr><tr><td>MC3021</td><td>The Gourmet Microwave</td><td>mod_cook</td><td>2.99</td><td>877</td></tr><tr><td>MC3026</td><td>The Psychology of Computer Cooking</td><td>UNDECIDED</td><td></td><td>877</td></tr><tr><td>PC1035</td><td>But Is It User Friendly?</td><td>popular_comp</td><td>22.95</td><td>1389</td></tr><tr><td>PC8888</td><td>Secrets of Silicon Valley</td><td>popular_comp</td><td>20</td><td>1389</td></tr><tr><td>PC9999</td><td>Net Etiquette</td><td>popular_comp</td><td></td><td>1389</td></tr><tr><td>PS2091</td><td>Is Anger the Enemy?</td><td>psychology</td><td>10.95</td><td>736</td></tr></table>

### PUBLISHER 

<table><tr><td>pub_id</td><td>pub_name</td><td>city</td></tr><tr><td>736</td><td>New Moon Books</td><td>Boston</td></tr><tr><td>877</td><td>Binnet &amp; Hardley</td><td>Washington</td></tr><tr><td>1389</td><td>Algodata Infosystems</td><td>Berkeley</td></tr><tr><td>1622</td><td>Five Lakes Publishing</td><td>Chicago</td></tr><tr><td>1756</td><td>Ramona Publishers</td><td>Dallas</td></tr><tr><td>9901</td><td>GGG&G</td><td>München</td></tr><tr><td>9952</td><td>Scootney Books</td><td>New York</td></tr><tr><td>9999</td><td>Lucerne Publishing</td><td>Paris</td></tr></table>

### AUTHOR TITLE 

<table><tr><td>au_id</td><td>title_id</td></tr><tr><td>172-32-1176</td><td>PS3333</td></tr><tr><td>213-46-8915</td><td>BU1032</td></tr><tr><td>213-46-8915</td><td>BU2075</td></tr><tr><td>238-95-7766</td><td>PC1035</td></tr><tr><td>267-41-2394</td><td>BU1111</td></tr><tr><td>267-41-2394</td><td>TC7777</td></tr><tr><td>274-80-9391</td><td>BU7832</td></tr><tr><td>409-56-7008</td><td>BU1032</td></tr><tr><td>427-17-2319</td><td>PC8888</td></tr><tr><td>472-27-2349</td><td>TC7777</td></tr></table>

الجدول التالي يظهر مجموعة من المصطلحات المتداولة في النموذج العلائق، مع المرادفات المستخدمة لكل 

منها: 

<table><tr><td>In This Document</td><td>Formal Terms</td><td>Many Database Manuals</td></tr><tr><td>Relational Table</td><td>Relation</td><td>Table</td></tr><tr><td>Column</td><td>Attribute</td><td>Field</td></tr><tr><td>Row</td><td>Tuple</td><td>Record</td></tr></table>

--- Page 5 ---

يمكن عرض تصميم قاعدة البيانات السابقة من خلال العبارات التالية (بدون المعطيات المتضمنة في الجداول وبدون تحديد أنماط الحقول): 

<table><tr><td>AUTHOR</td><td>(au_id, au_iname, au_fname, address, city, state, zip)</td></tr><tr><td>TITLE</td><td>(title_id, title, type, price, pub_id)</td></tr><tr><td>PUBLISHER</td><td>(pub_id, pub_name, city)</td></tr><tr><td>AUTHOR_TITLE</td><td>(au_id, title_id)</td></tr></table>

الجدول AUTHORTITLE يعبر عن العلاقة بين المؤلفين والكتب، بينما تعبر الجداول الأخرى عن الكيانات: مؤلف، كتاب، دار نشر. 

## 3. خصائص الجداول 

- بنية ثانية مؤلفة من أعمدة وأسطر 

- يمثل كل سطر (تسجيلة) كياناً واحداً من مجموعة الكيانات 

- يمثل كل حقل في الجدول واصفة، وله اسم مميز 

- تمثل تقاطعات الأسطر والأعمدة قيمة معطيات واحدة 

- ينبغي أن تطابق جميع القيم في حقل صيغة معطيات واحدة، كأن تكون كلها أعداد صحيحة أو أن 

- تكون كلها من نمط تاريخ 

- لكل عمود مجال محدد من القيم يعرف باسم مجال الواصفات 

- ترتيب الأسطر والأعمدة غير مهم بالنسبة لنظام إدارة قواعد البيانات، ويمكن استرجاعها بالترتيب 

المطلوب 

- يجب أن يحوي كل جدول على واصفة أو مجموعة واصفات تميز كل سطر عن غيره (مفتاح أساسي) 

## 4. العلاقات والمفاتيح 

العلاقة Relationship هي الرابط بين جدولين أو أكثر، يعبر عنها في قاعدة المعطيات من خلال المفتاح الأساسي Primary key والمفتاح المستورد Foreign key. 

المفتاح الأساسي Primary key هو حقل أو مجموعة حقول تميز بمجموعها كل تسجيلة في الجدول. 

المفتاح المستورد Foreign key هو حقل قيمته تطابق حتماً قيمة مفتاح أساسي في جدول آخر (ان لم تكن NULL)، ويمكن النظر للمفتاح المستورد على أنه نسخة من قيمة مفتاح أساسي في جدول آخر، تحدد التسجيلة المرتبطة من الجدول الآخر بالتسجيلة الحاوية على المفتاح المستورد من هذا الجدول.

--- Page 6 ---

5. قواعد التكامل 

يضمن التكامل للمستخدم التجوال والمعالجة الصحيحة للبيانات في جداول قاعدة المعطيات، ويقصد به نوعين من التكامل: 

- تكامل المعطيات: وهو يعني أن تكون قيم المفتاح الأساسي فريدة، وألا يكون أي جزء من المفتاح الأساسي Null، وذلك لضمان أن يكون لكل كيان هوية مميزة، ولضمان أن تكون قيم المفتاح المستوردة تشير بشكل صحيح إلى تسجيلات محتواة في الجدول الأساسي. 

- التكامل المرجعي: يقصد به أن تكون قيمة المفتاح المستوردة إما Null أو قيمة موجودة في حقل المفتاح الأساسي للجدول الذي تم الاستيراد منه. 

6. معالجة البيانات 

الجدول هي مجموعات عناصرها التسجيلات، والعمليات الممكن إجراؤها على المجموعات يمكن إجراؤها أيضاً على الجدول، هذه العمليات هي: 

- الاجتماع (Union)، التفاعل (Intersection)، الفرق (Difference)، الجداء (Product)، الاختيار (Selection)، الإسقاط (Projection)، الضم (Join)، التقسيم (Division). 

- الاجتماع (Union) 

تجمع هذه العملية كافة الأسطر من الجدولين، دون تكرار الأسطر الموجودة في الجدولين. لتطبيق هذه العملية يجب أن يتطابق الجدولين في ترتيب وأنماط الأعمدة. 

A 

| K | X | Y |
|---|---|---|
| 1 | A | 2 |
| 2 | B | 4 |
| 3 | C | 6 |

B 

| K | X | Y |
|---|---|---|
| 1 | A | 2 |
| 4 | D | 8 |
| 5 | E | 10 |

A UNION B 

| K | X | Y |
|---|---|---|
| 1 | A | 2 |
| 2 | B | 4 |
| 3 | C | 6 |
| 4 | D | 8 |
| 5 | E | 10 |

--- Page 7 ---

## (Intersection) التقطيع 

ينتج عن هذه العملية جدول يضم الأسطر المشتركة بين الجدولين الأساسيين، يجب أن يكون الجدولان المطبق عليهما هذه العملية منسجمان من حيث عدد الأعمدة وترتيبها وأنماطها. 

### A 

<table><tr><td>K</td><td>X</td><td>Y</td></tr><tr><td>1</td><td>A</td><td>2</td></tr><tr><td>2</td><td>B</td><td>4</td></tr><tr><td>3</td><td>C</td><td>6</td></tr></table>

### B 

<table><tr><td>K</td><td>X</td><td>Y</td></tr><tr><td>1</td><td>A</td><td>2</td></tr><tr><td>4</td><td>D</td><td>8</td></tr><tr><td>5</td><td>E</td><td>10</td></tr></table>

### A INTERSECT B 

<table><tr><td>K</td><td>X</td><td>Y</td></tr><tr><td>1</td><td>A</td><td>2</td></tr><tr><td>2</td><td>B</td><td>4</td></tr><tr><td>3</td><td>C</td><td>6</td></tr><tr><td>4</td><td>D</td><td>8</td></tr><tr><td>5</td><td>E</td><td>10</td></tr></table>

## (Difference) الفرق 

ينتج عن هذه العملية جدول يتضمن الأسطر التي تظهر في الجدول الأول ولا تظهر في الجدول الثاني. 

### A 

<table><tr><td>K</td><td>X</td><td>Y</td></tr><tr><td>1</td><td>A</td><td>2</td></tr><tr><td>2</td><td>B</td><td>4</td></tr><tr><td>3</td><td>C</td><td>6</td></tr></table>

### B 

<table><tr><td>K</td><td>X</td><td>Y</td></tr><tr><td>1</td><td>A</td><td>2</td></tr><tr><td>4</td><td>D</td><td>8</td></tr><tr><td>5</td><td>E</td><td>10</td></tr></table>

### A - B 

<table><tr><td>K</td><td>X</td><td>Y</td></tr><tr><td>2</td><td>B</td><td>4</td></tr><tr><td>3</td><td>C</td><td>6</td></tr></table>

### B - A 

<table><tr><td>K</td><td>X</td><td>Y</td></tr><tr><td>4</td><td>D</td><td>8</td></tr><tr><td>5</td><td>E</td><td>10</td></tr></table>

--- Page 8 ---

## الجداء (Product): 

ينتج عن هذه العملية كافة أزواج التسجيلات الممكنة من كلا الجدولين. 

### A 

<table><tr><td>K</td><td>X</td><td>Y</td></tr><tr><td>1</td><td>A</td><td>2</td></tr><tr><td>2</td><td>B</td><td>4</td></tr><tr><td>3</td><td>C</td><td>6</td></tr></table>

### B 

<table><tr><td>K</td><td>X</td><td>Y</td></tr><tr><td>1</td><td>A</td><td>2</td></tr><tr><td>4</td><td>D</td><td>8</td></tr><tr><td>5</td><td>E</td><td>10</td></tr></table>

### A TIMES B 

<table><tr><td>AK</td><td>AX</td><td>AY</td><td>BK</td><td>BX</td><td>BY</td></tr><tr><td>1</td><td>A</td><td>2</td><td>1</td><td>A</td><td>2</td></tr><tr><td>1</td><td>A</td><td>2</td><td>4</td><td>D</td><td>8</td></tr><tr><td>1</td><td>A</td><td>2</td><td>5</td><td>E</td><td>10</td></tr><tr><td>2</td><td>B</td><td>4</td><td>1</td><td>A</td><td>2</td></tr><tr><td>2</td><td>B</td><td>4</td><td>4</td><td>D</td><td>8</td></tr><tr><td>2</td><td>B</td><td>4</td><td>5</td><td>E</td><td>10</td></tr><tr><td>3</td><td>C</td><td>6</td><td>1</td><td>A</td><td>2</td></tr><tr><td>3</td><td>C</td><td>6</td><td>4</td><td>D</td><td>8</td></tr><tr><td>3</td><td>C</td><td>6</td><td>5</td><td>E</td><td>10</td></tr></table>

## الاختيار (Selection) 

ترجع هذه العملية مجموعة جزئية من أسطر الجدول، المجموعة الجزئية تحقق شرط معين. 

### A 

<table><tr><td>K</td><td>X</td><td>Y</td></tr><tr><td>1</td><td>A</td><td>2</td></tr><tr><td>2</td><td>B</td><td>4</td></tr><tr><td>3</td><td>C</td><td>6</td></tr></table>

## SELECT BASED ON A CONDITION 

<table><tr><td>K</td><td>X</td><td>Y</td></tr><tr><td>2</td><td>B</td><td>4</td></tr><tr><td>3</td><td>C</td><td>6</td></tr></table>

--- Page 9 ---

الإسقاط (Projection) 

يرجع مجموعة جزئية من أعمدة الجدول. 

الضم (Join) 

تسمح هذه العملية بجمع الواصفات من جدولين أو أكثر، هذه العملية هي من أهم ميزات نظم قواعد المعطيات العلائقية، إذ أنها تسمح بربط جداول مستقلة عن بعضها من خلال واصفات مشتركة. 

 

التقسيم (Division) 

ينتج عن هذه العملية جدول بقيم أعمدة متممها من أعمدة الجدول الأول موجود كأسطر في الجدول الثاني.

--- Page 10 ---

## 7. المراجع: 

- http://database.ittoolbox.com 

- http://www.utexas.edu/its/windows/database/datamodeling/Rm/
