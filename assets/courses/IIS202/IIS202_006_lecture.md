--- Page 1 ---

الفصل السادس:
(1) (Normalization)

--- Page 2 ---

الصفحة 

3 

3 

6 

7 

10 

13 

15 

العنوان 

1. مقدمة 

2. إشكاليات التصميم السين ل قاعدة البيانات 

3. مستويات التنظيم 

1.3 الشكل النظامي الأول (1NF) 

2.3 الشكل النظامي الثاني (2NF) 

3.5 الشكل النظامي الثالث (3NF) 

4. تدريبات

--- Page 3 ---

ملخص 

يركز هذا الفصل على تعريف إشكاليات التصميم السبعي لقاعدة البيانات، وطرق تنظيم القاعدة. 

الأهداف التعليمية 

يتضمن هذا الفصل: 

- تعريف إشكاليات التصميم السبعي لقاعدة البيانات 

- اشكالية الادخال (Insertion anomaly). 

- اشكالية الحذف (Deletion anomaly). 

- اشكالية التعديل (Update anomaly). 

- الشكل النظامي الأول (1NF). 

- الشكل النظامي الثاني (2NF). 

- الشكل النظامي الثالث (3NF).

--- Page 4 ---

## 1. مقدمة 

تعرفنا سابقاً على مستويات التجريد الثلاثة التي يمر بها بناء قاعدة البيانات، وهي المستوى المفهومي والمستوى المنطقي والمستوى الفيزيائي، ورأينا أن المستوى المفهومي ينتهي ببناء مخطط ERD ويتضمن ما يلي: 

- عزل الكيانات. 

- تحديد الواصفات ومجالات تعريفها 

- تحديد العلاقات بين الكيانات 

- تحديد المفاتيح المرشحة والمفاتيح الأساسية للكيانات 

- إنشاء مخطط ERD 

- تدقيق مخطط ERD من قبل مصمم قاعدة البيانات بالتعاون مع المستثمرين 

يبدأ المستوى المنطقي في بناء قاعدة المعطيات بعملية التنظيم، ويقصد بالتنظيم (Normalization) تصميم جداول قاعدة البيانات بحيث نتحكم بتكرر المعطيات وتجنب حالات الشذوذ التي يمكن أن تنتج عن عمليات الإضافة والحذف والتعديل على المعطيات. 

سنقوم بداية بدراسة الإشكاليات التي يعاني منها التصميم السيئ لقاعدة البيانات، ومن ثم سندرس مستويات التنظيم وخصائص كل منها. 

## 2. إشكاليات التصميم السيئ لقاعدة البيانات 

بفرض أن شركة ما تضم مجموعة من مسؤولي المبيعات يعملون في عدة مواقع، وتريد الإدارة تخزين البيانات المتعلقة بموظفيها وبيانات مستودعاتها في قاعدة معطيات. المحاولة الأولى لبناء القاعدة نتج عنها الجدول التالي: 

<table><tr><td>Id</td><td>Name</td><td>Address</td><td>Title</td><td>Store</td><td>Store_Address</td><td>Store_Phone</td></tr><tr><td>Sr1</td><td>Jane</td><td>E1</td><td>Sales Rep</td><td>A1</td><td>S1</td><td>011-1234567</td></tr><tr><td>Sr2</td><td>Fred</td><td>E2</td><td>Sales Rep</td><td>A1</td><td>S1</td><td>011-1234567</td></tr><tr><td>Sr3</td><td>Ed</td><td>E3</td><td>Manager</td><td>A1</td><td>S1</td><td>011-1234567</td></tr><tr><td>Sr4</td><td>Ann</td><td>E4</td><td>Sales Rep</td><td>A2</td><td>S2</td><td>011-7891234</td></tr><tr><td>Sr5</td><td>Jone</td><td>E5</td><td>Sales Rep</td><td>A2</td><td>S2</td><td>011-7891234</td></tr><tr><td>Sr6</td><td>Smith</td><td>E6</td><td>Manager</td><td>A2</td><td>S2</td><td>011-7891234</td></tr></table>

--- Page 5 ---

يتضمن هذا الجدول 1 بيانات الموظفين وبيانات المستودعات، ومن الواضح وجود تكرار في بيانات المستودعات. إذا أردنا إدخال بيانات موظف جديد فيجب إدخال بيانات موقعه (المستودع) أيضاً، وللحفاظ على عدم تناقض البيانات في القاعدة يجب إدخال بيانات المستودع بدقة وبشكل مطابق للقيم المدخلة سابقاً (لأحد الموظفين السابقين في نفس المستودع)، هنا تظهر مشكلة تكرار البيانات بالإضافة طبعاً لحجم التخزين المهدر. 

1. بفرض أننا نريد إدخال بيانات مستودع جديد قبل توظيف أحد فيه، هذا يتطلب إدخال قيم Null في بيانات الموظف ومن ضمنها الحقل المفتاح (Id) مما يخرق شرط تكامل البيانات. هذا ما يدعى 

بإشكالية الإدخال (Insertion anomaly). 

<table><tr><td>Id</td><td>Name</td><td>Address</td><td>Title</td><td>Store</td><td>Store_Address</td><td>Store_Phone</td></tr><tr><td>Sr1</td><td>Jane</td><td>E 1</td><td>Sales Rep</td><td>A1</td><td>S1</td><td>011-1234567</td></tr><tr><td>Sr2</td><td>Fred</td><td>E 2</td><td>Sales Rep</td><td>A1</td><td>S1</td><td>011-1234567</td></tr><tr><td>Sr3</td><td>Ed</td><td>E 3</td><td>Manager</td><td>A1</td><td>S1</td><td>011-1234567</td></tr><tr><td>Sr4</td><td>Ann</td><td>E 4</td><td>Sales Rep</td><td>A2</td><td>S2</td><td>011-7891234</td></tr><tr><td>Sr5</td><td>Jone</td><td>E 5</td><td>Sales Rep</td><td>A2</td><td>S2</td><td>011-7891234</td></tr><tr><td>Sr6</td><td>Smith</td><td>E 6</td><td>Manager</td><td>A2</td><td>S2</td><td>011-7891234</td></tr><tr><td>Null</td><td>Null</td><td>Null</td><td>Null</td><td>A3</td><td>S3</td><td>011-9123456</td></tr></table>

2. بفرض أننا حذفنا تسجيلة الموظف الأخير في أحد المستودعات، سيؤدي ذلك إلى فقدان بيانات مستودع موجود في الشركة. هذا ما يدعى بإشكالية الحذف (Deletion anomaly). 

<table><tr><td>Id</td><td>Name</td><td>Address</td><td>Title</td><td>Store</td><td>Store_Address</td><td>Store_Phone</td></tr><tr><td>Sr1</td><td>Jane</td><td>E 1</td><td>Sales Rep</td><td>A1</td><td>S1</td><td>011-1234567</td></tr><tr><td>Sr2</td><td>Fred</td><td>E 2</td><td>Sales Rep</td><td>A1</td><td>S1</td><td>011-1234567</td></tr><tr><td>Sr3</td><td>Ed</td><td>E 3</td><td>Manager</td><td>A1</td><td>S1</td><td>011-1234567</td></tr><tr><td>Sr4</td><td>Ann</td><td>E 4</td><td>Manager</td><td>A1</td><td>S1</td><td>011-7891234</td></tr><tr><td>Sr5</td><td>Jone</td><td>E 5</td><td>Manager</td><td>A1</td><td>S1</td><td>011-7891234</td></tr><tr><td>Sr6</td><td>Smith</td><td>E 6</td><td>Manager</td><td>A2</td><td>S2</td><td>011-7891234</td></tr><tr><td>Null</td><td>Null</td><td>Null</td><td>Null</td><td>A3</td><td>S3</td><td>011-9123456</td></tr></table>

 

Store A2 data is missing

--- Page 6 ---

<table><tr><td>Store</td><td>Store_Address</td><td>Store_phone</td></tr><tr><td>A1</td><td>S1</td><td>011-1234567</td></tr><tr><td>A2</td><td>S2</td><td>011-7891234</td></tr></table>

بدلك فإنه: 

1. عند إدخال بيانات موظف جديد، يتم تسجيل مفتاح المستودع الذي يعمل فيه، أما بقية بيانات المستودع فهي مخزنة في جدول مستقل وبالتالي لن تظهر بيانات متناقضة في قاعدة البيانات بشأن المستودعات، وإذا أردنا إدخال بيانات مستودع جديد فيمكن إدخالها بصرف النظر عن يعمل في المستودع، مما يجنبنا إشكالية الإدخال. 

2. عند حذف الموظف الأخير في مستودع، تبقى بيانات المستودع في جدول مستقل. 

3. عند تعديل رقم هاتف المستودع، يتم التعديل على تسجيله واحدة في جدول المستودعات. 

الإجراءات السابقة (تجزيع الجدول) هي عملية تنظيم قاعدة البيانات، والتي سنتعرف عليها بتفصيل أكثر في هذا الفصل والفصل القادم. 

## 3. مستويات التنظيم 

كما سبق وعرفنا، التنظيم هو عملية ترتيب وتوزيع جداول قاعدة المعطيات العلاقية، للتقليل من تكرار المعطيات وتقليص حجم التخزين المطلوب ولحل إشكاليات الإدخال والحذف والتعديل. وغالباً ما ينتج عن عملية التنظيم زيادة في عدد جداول القاعدة. 

يتم تنظيم قاعدة البيانات من خلال إخضاعها لمجموعة اختبارات والتعديل على البنية لتحقيق مجموعة معايير. 

مستويات التنظيم الأساسية هي ثلاث (الشكل النظامي الأول INF، الشكل النظامي الثاني 2NF، الشكل النظامي الثالث 3NF)، ويقصد عادةً بتنظيم القاعدة وضعها في الشكل النظامي الثالث. 

يضاف إلى المستويات الثلاثة الشكل المقترح من قبل R.Boyce ويطلق عليه تسمية BCNF، والشكلين 

النظاميين الرابع والخامس. 

سنتناول في هذا الفصل الأشكال النظامية الثلاثة الأساسية، وسنتناول المستويات BCNF، 4NF، 5NF، BCNF، 4NF، 5NF في الفصل اللاحق.

--- Page 7 ---

## 1.3 الشكل النظامي الأول (1NF) 

يقال عن جدول في قاعدة البيانات أنه من الشكل النظامي الأول إذا كان تقاطع كل سطر وعمود فيه، يتضمن قيمة وحيدة غير قابلة للتجزئة. 

مثال: 

يمثل الشكل التالي بيانات شركة تأجير عقارات: 

<table><tr><td>C_id</td><td>P_num</td><td>C_name</td><td>P_address</td><td>R_start</td><td>R_end</td><td>Rent</td><td>O_num</td><td>Owner</td></tr><tr><td>01</td><td>Pr3</td><td>Jane</td><td>A</td><td>1-1-96</td><td>12-1-98</td><td>785</td><td>Po23</td><td>Jones</td></tr><tr><td>02</td><td>Pr22</td><td>Fred</td><td>B</td><td>2-1-98</td><td>3-30-00</td><td>1200</td><td>Po44</td><td>Jan</td></tr><tr><td>03</td><td>Pr17</td><td>Ed</td><td>C</td><td>2-1-88</td><td>1-11-90</td><td>1000</td><td>Po32</td><td>Jill</td></tr><tr><td></td><td>Pr32</td><td></td><td>D</td><td>6-1-90</td><td>3-1-95</td><td>950</td><td>Po32</td><td>Jill</td></tr><tr><td></td><td>Pr22</td><td></td><td>B</td><td>4-1-00</td><td>null</td><td>1200</td><td>Po44</td><td>Jan</td></tr></table>

<table><tr><td>رقم الزبون</td><td>2C_id</td></tr><tr><td>رقم العقار</td><td>P_num</td></tr><tr><td>اسم الزبون</td><td>C_name</td></tr><tr><td>عنوان العقار</td><td>P_address</td></tr><tr><td>تاريخ بدء الإيجار</td><td>R_start</td></tr><tr><td>تاريخ نهاية الإيجار</td><td>R_end</td></tr><tr><td>قيمة الإيجار</td><td>Rent</td></tr><tr><td>رقم مالك العقار</td><td>O_num</td></tr><tr><td>اسم مالك العقار</td><td>Owner</td></tr></table>

--- Page 8 ---

مثال (تتمة): 

يمكن ملاحظة أن قيم خلايا الجدول قابلة للتجزئة، وهذا التصميم سيء حيث لا يمكن فيه استخلاص معلومات
مالك عقار معين بسهولة. يعاني التصميم أيضاً من مشكلة تكرار المعطيات فكلما تم تأجير عقار يجب أن تدخل
بياناته التفصيلية (بيانات العقار) من جديد. 

<table><tr><td>C_id</td><td>P_num</td><td>C_name</td><td>P_address</td><td>R_start</td><td>R_end</td><td>Rent</td><td>O_num</td><td>Owner</td></tr><tr><td>01</td><td>Pr3<br/>Pr22</td><td>Jane</td><td>A<br/>B</td><td>1-1-96<br/>2-1-98</td><td>12-1-98<br/>3-30-00</td><td>785<br/>1200</td><td>Po23<br/>Po44</td><td>Jones<br/>Jan</td></tr><tr><td>02</td><td>Pr17</td><td>Fred</td><td>C</td><td>2-1-88</td><td>1-11-90</td><td>1000</td><td>Po32</td><td>Jill</td></tr><tr><td>03</td><td>Pr32<br/>Pr22</td><td>Ed</td><td>D<br/>B</td><td>6-1-90<br/>4-1-00</td><td>3-1-95<br/>null</td><td>950<br/>1200</td><td>Po32<br/>Po44</td><td>Jill<br/>Jan</td></tr></table>

مثال (تتمة): 

لوضع الجدول السابق في الشكل النظامي الأول يجب تجزئة الخلايا الحاوية على معطيات قابلة للتجزئة، يمكن
عمل ذلك من خلال إدخال بيانات كل عملية إيجار في سطر جديد، أي يجب أن يصبح المفتاح الأساسي هو
نتيجة تركيب رقم الزبون ورقم العقار (c_id, p_num) علماً أن التصميم مبني على أساس تخزين بيانات
العقارات المؤجرة حالياً دون حفظ تاريخ حركات الإيجار، بمعنى أن نفس الزبون لا يمكن أن تتواجد له حركتي
إيجار لنفس العقار. 

<table><tr><td>C_id</td><td>P_num</td><td>C_name</td><td>P_address</td><td>R_start</td><td>R_end</td><td>Rent</td><td>O_num</td><td>Owner</td></tr><tr><td>01</td><td>Pr3<br/>Pr22</td><td>Jane</td><td>A<br/>B</td><td>1-1-96<br/>2-1-98</td><td>12-1-98<br/>3-30-00</td><td>785<br/>1200</td><td>Po23<br/>Po44</td><td>Jones<br/>Jan</td></tr><tr><td>02</td><td>Pr17</td><td>Fred</td><td>C</td><td>2-1-88</td><td>1-11-90</td><td>1000</td><td>Po32</td><td>Jill</td></tr><tr><td>03</td><td>Pr32<br/>Pr22</td><td>Ed</td><td>D<br/>B</td><td>6-1-90<br/>4-1-00</td><td>3-1-95<br/>null</td><td>950<br/>1200</td><td>Po32<br/>Po44</td><td>Jill<br/>Jan</td></tr></table>

<table><tr><td>C_id</td><td>P_num</td><td>C_name</td><td>P_address</td><td>R_start</td><td>R_end</td><td>Rent</td><td>O_num</td><td>Owner</td></tr><tr><td>01</td><td>Pr3</td><td>Jane</td><td>A</td><td>1-1-96</td><td>12-1-98</td><td>785</td><td>Po23</td><td>Jones</td></tr><tr><td>01</td><td>Pr22</td><td>Jane</td><td>B</td><td>2-1-98</td><td>3-30-00</td><td>1200</td><td>Po44</td><td>Jan</td></tr><tr><td>02</td><td>Pr17</td><td>Fred</td><td>C</td><td>2-1-88</td><td>1-11-90</td><td>1000</td><td>Po32</td><td>Jill</td></tr><tr><td>03</td><td>Pr32</td><td>Ed</td><td>D</td><td>6-1-90</td><td>3-1-95</td><td>950</td><td>Po32</td><td>Jill</td></tr><tr><td>03</td><td>Pr22</td><td>Ed</td><td>B</td><td>4-1-00</td><td>null</td><td>1200</td><td>Po44</td><td>Jan</td></tr></table>

--- Page 9 ---

:طبيق 

طبق معيار INF على الجدول التالي: 

<table><tr><td>id</td><td>name</td><td>children</td><td>birth_date</td></tr><tr><td>1001</td><td>John Doe</td><td>Betty, Frank</td><td>2-2-88, 4-3-90</td></tr><tr><td>1002</td><td>Jane Doe</td><td>Betty, Frank</td><td>2-2-88, 4-3-90</td></tr><tr><td>1003</td><td>Freda Fish</td><td>Henry, Jane, Jill, Bill</td><td>4-4-79, 2-8-84, 7-9-88, 10-3-90</td></tr><tr><td>1004</td><td>Bill Bass</td><td>Hank, April, Ellen</td><td>5-4-89, 9-9-94, 7-10-98</td></tr></table>

الحل: 

<table><tr><td>id</td><td>f_name</td><td>l_name</td></tr><tr><td>1001</td><td>John</td><td>Doe</td></tr><tr><td>1002</td><td>Jane</td><td>Doe</td></tr><tr><td>1003</td><td>Freda</td><td>Fish</td></tr><tr><td>1004</td><td>Bill</td><td>Bass</td></tr></table>

<table><tr><td>id</td><td>name</td><td>birth_date</td></tr><tr><td>1001</td><td>Betty</td><td>2-2-88</td></tr><tr><td>1002</td><td>Frank</td><td>4-3-90</td></tr><tr><td>1003</td><td>Betty</td><td>2-2-88</td></tr><tr><td>1004</td><td>Betty</td><td>4-3-90</td></tr><tr><td>1003</td><td>Henry</td><td>4-4-79</td></tr><tr><td>1003</td><td>Jane</td><td>2-8-84</td></tr><tr><td>1003</td><td>Jill</td><td>7-9-88</td></tr><tr><td>1003</td><td>Bill</td><td>10-3-90</td></tr><tr><td>1004</td><td>Hank</td><td>5-4-89</td></tr><tr><td>1004</td><td>April</td><td>9-9-94</td></tr><tr><td>1004</td><td>Ellen</td><td>7-10-98</td></tr></table>

--- Page 10 ---

وضع الجدول في الشكل النظامي الأول لا يحل مشاكل التصميم السيئ إنما هو خطوة في طريق حلها، فبالرغم من وضع جدول إيجار العقارات في الشكل النظامي الأول فإنه لا يزال يعاني من مشكلة تكرر البيانات، وإشكاليات الإضافة والتعديل والحذف. 

## 2.3 الشكل النظامي الثاني (2NF) 

يقال عن جدول أنه من الشكل النظامي الثاني إذا حقق ما يلي: 

- هو من الشكل النظامي الأول. 

- كل الواصفات التي لا تشكل جزءاً من المفتاح الأساسي، تعتمد وظيفياً وبشكل كلي على المفتاح الأساسي. 

## التبعية الوظيفية (functional dependency) 

تعتمد الواصفة B على الواصفة A وظيفياً إذا كانت كل قيمة ل A تقابلها قيمة وحيدة ل B، فمثلاً رقم الزبون يحدد اسمه وكل قيمة ل c_id تقابلها قيمة وحيدة ل c_name لذلك يقال أن c_name تتبع وظيفياً ل c_id أو يقال أن c_id تعدد c_name (Determine) 

B تعتمد وظيفياً بشكل كلي على مفتاح مركب (fully functional dependency)، إذا كان المفتاح المركب يحدد B، و B لا تعتمد وظيفياً على جزء منه. 

تكتب علاقات التبعية بين الواصفات على الشكل التالي: 

\[C\_id \rightarrow c\_name\]

\[P\_num \rightarrow p\_address,owner\_num,owner\]

وضع الجداول في الشكل النظامي الثاني يبدأ بتحديد جميع علاقات التبعية بين الواصفات، ومن ثم تجزئه الجداول (decomposition) بشكل يضمن اعتماد جميع الواصفات التي لا تشكل جزءاً من المفتاح الأساسي كلياً وبشكل مباشر على المفتاح الأساسي. 

يمكن الاستنتاج من التعريف السابق أن جميع الجداول ذات المفتاح البسيط (غير المركب) والتي تخضع لمعيار 1NF هي حتماً من الشكل النظامي الثاني.

--- Page 11 ---

p_num, p_address, r_end, r_start, rent, owner, owner_num تحدد c_id + r_start ولكن (c_id, r_start) هي مفتاح مرشح ممكن أن يكون مفتاح أساسي، وبما أننا لم نقرر بعد (نحن في طور إعادة تصميم قاعدة البيانات) فإن هذه العلاقة لا تخرق شرط 2NF. 

6. P_num + r_start → c_id, c_name, r_end. 

هذه الحالة تشابه الحالة (5). 

يبدأ تطبيق معيار 2NF بتجزئيء الجدول إنطلاقاً من علاقة التبعية الكاملة (1): 

C_id + p_num → r_start, r_end 

<table><tr><td>C_id</td><td>P_num</td><td>C_name</td><td>P_address</td><td>R_start</td><td>R_end</td><td>Rent</td><td>O_num</td><td>Owner</td></tr><tr><td>01</td><td>Pr3</td><td>Jane</td><td>A</td><td>1-1-96</td><td>12-1-98</td><td>785</td><td>Po23</td><td>Jones</td></tr><tr><td>01</td><td>Pr22</td><td>Jane</td><td>B</td><td>2-1-98</td><td>3-30-00</td><td>1200</td><td>Po44</td><td>Jan</td></tr><tr><td>02</td><td>Pr17</td><td>Fred</td><td>C</td><td>2-1-88</td><td>1-11-90</td><td>1000</td><td>Po32</td><td>Jill</td></tr><tr><td>03</td><td>Pr32</td><td>Ed</td><td>D</td><td>6-1-90</td><td>3-1-95</td><td>950</td><td>Po32</td><td>Jill</td></tr><tr><td>03</td><td>Pr22</td><td>Ed</td><td>B</td><td>4-1-00</td><td>null</td><td>1200</td><td>Po44</td><td>Jan</td></tr></table>

Rental 

<table><tr><td>C_id</td><td>P_num</td><td>R_start</td><td>R_end</td></tr><tr><td>01</td><td>Pr3</td><td>1-1-96</td><td>12-1-98</td></tr><tr><td>01</td><td>Pr22</td><td>2-1-98</td><td>3-30-00</td></tr><tr><td>02</td><td>Pr17</td><td>2-1-88</td><td>1-11-90</td></tr><tr><td>03</td><td>Pr32</td><td>6-1-90</td><td>3-1-95</td></tr><tr><td>03</td><td>Pr22</td><td>4-1-00</td><td>Null</td></tr></table>

Customer 

<table><tr><td>C_id</td><td>C_name</td></tr><tr><td>01</td><td>Jane</td></tr><tr><td>02</td><td>Fred</td></tr><tr><td>03</td><td>Ed</td></tr></table>

--- Page 12 ---

## Property 

<table><tr><td>P_num</td><td>P_address</td><td>rent</td><td>O_num</td><td>Owner</td></tr><tr><td>Pr3</td><td>A</td><td>785</td><td>Po23</td><td>Jones</td></tr><tr><td>Pr22</td><td>B</td><td>1200</td><td>Po44</td><td>Jan</td></tr><tr><td>Pr17</td><td>C</td><td>1000</td><td>Po32</td><td>Jill</td></tr><tr><td>Pr32</td><td>D</td><td>950</td><td>Po32</td><td>Jill</td></tr></table>

تحل جداول الشكل النظامي الثاني إشكاليات الحذف والإضافة ولا تحل إشكالية التعديل، فمثلاً إذا أردنا تعديل بيانات أحد المالكين فيجب تعديل مجموعة من التسجيلات مما يتفق مع إشكالية التعديل سابقة الذكر. 

### 3.3. الشكل النظامي الثالث (3NF) 

يكون الجدول من الشكل النظامي الثالث إذا حقق ما يلي: 

- من الشكل النظامي الثاني. 

- لا توجد فيه واصفات لا تشكل جزءاً من المفتاح الأساسي وتعتمد بالتعدي على المفتاح الأساسي. 

لا تحوي الجداول Customer و Rental واصفات تعتمد بالتعدي على المفتاح الأساسي، بينما تعتمد الواصفة owner في الجدول Property على owner_num الذي يعتمد بدوره على P_num ولوضع هذا الجدول في الشكل النظامي الثالث يجب تجزئه إلى جدولين كما يلي: 

## Property 

<table><tr><td>P_num</td><td>P_address</td><td>rent</td><td>O_num</td><td>Owner</td></tr><tr><td>Pr3</td><td>A</td><td>785</td><td>Po23</td><td>Jones</td></tr><tr><td>Pr22</td><td>B</td><td>1200</td><td>Po44</td><td>Jan</td></tr><tr><td>Pr17</td><td>C</td><td>1000</td><td>Po32</td><td>Jill</td></tr><tr><td>Pr32</td><td>D</td><td>950</td><td>Po32</td><td>Jill</td></tr></table>

--- Page 13 ---

Property 

<table><tr><td>P_num</td><td>P_address</td><td>rent</td><td>O_num</td></tr><tr><td>Pr3</td><td>A</td><td>785</td><td>Po23</td></tr><tr><td>Pr22</td><td>B</td><td>1200</td><td>Po44</td></tr><tr><td>Pr17</td><td>C</td><td>1000</td><td>Po32</td></tr><tr><td>Pr32</td><td>D</td><td>950</td><td>Po32</td></tr></table>

Owner 

<table><tr><td>O_num</td><td>Owner</td></tr><tr><td>Po23</td><td>Jones</td></tr><tr><td>Po44</td><td>Jan</td></tr><tr><td>Po32</td><td>Jill</td></tr></table>

الشكل النظامي الثالث يحل إشكاليات التعديل والحذف والإضافة، بالإضافة إلى حل مشكلة تكرار البيانات، وعندما يطلب تنظيم قاعدة بيانات فيقصد بذلك عادةً وضعها في الشكل النظامي الثالث.

--- Page 14 ---

## 4. تدريبات 

- في الشكل النظامي الأول، تقاطع السطر مع العمود هو قيمة غير قابلة للتجزئ. 

1. صح 

2. خطأ 

الإجابة: صح 

- يمكن الإنتقال إلى الشكل النظامي الثالث من الشكل الأول دون المرور بالشكل النظامي الثاني. 

1. صح 

2. خطأ 

الإجابة: خطأ 

- في حال كان المفتاح الأساسي للجدول بسيط (غير مركب)، فلا فرق بين التبعية الوظيفية والتبعية 

الوظيفية الكلية. 

1. صح 

2. خطأ 

الإجابة: صح 

- أي من العبارات التالية تصف الشكل النظامي الثالث (اختر 2 من الإجابات) 

1. هو حتماً من الشكل النظامي الأول والثاني. 

2. المفتاح الأساسي للجدول هو حتماً مفتاح بسيط (غير مركب). 

3. لا توجد في الجدول علاقات تبعية بالتعدي. 

4. الشكل النظامي الثالث يحل اشكالية الإدخال والحذف ولا يحل اشكالية التعديل. 

الإجابة: (1-3) 

- في حال الشكل النظامي الأول، كل خلية هي وحيدة القيمة (لا يمكن أن يكون محتوى الخلية هو 

مصفوفة من القيم). 

1. صح 

2. خطأ 

الإجابة: صح 

- في حال الشكل النظامي الأول، المدخلات في عمود هي من نفس النمط حتماً. 

1. صح 

2. خطأ 

الإجابة: صح
