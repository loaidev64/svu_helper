--- Page 1 ---

الفصل السابع:
(2) (Normalization)

--- Page 2 ---

الصفحة 

العنوان 

3 

1. مقدمة 

3 

2. الشكل النظامي (BCNF) Boyce-Codd 

7 

3. الشكل النظامي الرابع (4NF) 

9 

4. الشكل النظامي الخامس (5NF)

--- Page 3 ---

ملخص 

يستكمل هذا الفصل أشكال تنظيم قاعدة البيانات، التي يدعنا بدراستها في الدرس السابق. 

الأهداف التعليمية 

يتضمن هذا الفصل: 

- الشكل النظامي BCNF (Boyce–Codd Normal form) 

- الشكل النظامي الرابع (4NF) 

- الشكل النظامي الخامس (5NF)

--- Page 4 ---

## 1. مقدمة 

رأينا سابقاً أنه عندما يطلب تنظيم قاعدة البيانات، فالمقصود بذلك عادةً وضعها في الشكل النظامي الثالث (3NF)، ونادراً ما تحقق القاعدة شروط 3NF وتخرق الأشكال النظامية التالية (4Nf, 5NF, BCNF)، يضاف إلى ذلك أن الفائدة من تحويل القاعدة من 3NF إلى 4NF أو 5NF بسيطة ولا تقابل الجهد اللازم لهذا التحويل. 

## 2. الشكل النظامي (BCNF) Boyce-Codd 

يطبق الشكل النظامي BCNF على الجداول الحاوية على: 

- عدة مفاتيح مرشحة 

- مفاتيح مرشحة مركبة 

- مفاتيح مرشحة متقاطعة 

يكون الجدول من الشكل BCNF إذا كان كل محدد فيه هو مفتاح مرشح. 

الواصفة (أو مجموعة الواصفات) المحددة هي واصفة تعتمد عليها واصفات أخرى بشكل كلي. 

يحدث خرق شرط BCNF عادةً في الجداول الحاوية على أكثر من مفتاح مرشح مركب وفي حالات تقاطع 

المفاتيح المرشحة في الجدول. 

مثال 1: 

ليكن لدينا الجداول التالية: 

### Rental 

<table><tr><td>C_id</td><td>P_num</td><td>R_start</td><td>R_end</td></tr><tr><td>01</td><td>Pr3</td><td>1-1-96</td><td>12-1-98</td></tr><tr><td>01</td><td>Pr22</td><td>2-1-98</td><td>3-30-00</td></tr><tr><td>02</td><td>Pr17</td><td>2-1-88</td><td>1-11-90</td></tr><tr><td>03</td><td>Pr32</td><td>6-1-90</td><td>3-1-95</td></tr><tr><td>03</td><td>Pr22</td><td>4-1-00</td><td>Null</td></tr></table>

--- Page 5 ---

Customer 

<table><tr><td>C_id</td><td>C_name</td></tr><tr><td>01</td><td>Jane</td></tr><tr><td>02</td><td>Fred</td></tr><tr><td>03</td><td>Ed</td></tr></table>

Property 

<table><tr><td>P_num</td><td>P_address</td><td>rent</td><td>O_num</td></tr><tr><td>Pr3</td><td>A</td><td>785</td><td>Po23</td></tr><tr><td>Pr22</td><td>B</td><td>1200</td><td>Po44</td></tr><tr><td>Pr17</td><td>C</td><td>1000</td><td>Po32</td></tr><tr><td>Pr32</td><td>D</td><td>950</td><td>Po32</td></tr></table>

Owner 

<table><tr><td>O_num</td><td>Owner</td></tr><tr><td>Po23</td><td>Jones</td></tr><tr><td>Po44</td><td>Jan</td></tr><tr><td>Po32</td><td>Jill</td></tr></table>

يتضمن كل من الجداول Customer, Owner, Property مفتاح بسيط تعتمد عليه بقية الحقول، فهي حتماً من الشكل BCNF. 

نجد في الجدول Rental علاقات التبعية التالية: 

1. C_id + p_num → r_start, r_end. 

2. C_id + r_start → p_num, r_end 

3. P_num + r_start → c_id, r_end. 

(افترضنا في هذا الشكل أن المستأجر لا يستأجر شقة مرتين بنفس التاريخ، والشقة لا يمكن تأجيرها أكثر من مرة بنفس اليوم، وإلا فإن تصميم القاعدة سيختلف).

--- Page 6 ---

المحددات (C_id + r_start), (C_id + r_start), (P_num + r_start), (C_id + r_start), (P_num) كلها مفاتيح مرشحة، بالتالي فإن الجدول Rental هو من الشكل BCNF¹. 

مثال 2: 

لننظر إلى الجدول التالي: 

Client_Meeting 

<table><tr><td>C_id</td><td>I_date</td><td>I_time</td><td>Room_num</td><td>Emp_num</td></tr><tr><td>08</td><td>04-20-00</td><td>09:30</td><td>P70</td><td>Pe-23</td></tr><tr><td>17</td><td>05-01-00</td><td>09:30</td><td>P60</td><td>Pe-32</td></tr><tr><td>20</td><td>05-01-00</td><td>10:30</td><td>P70</td><td>Pe-23</td></tr></table>

يتضمن هذا الجدول بيانات لقاءات موظفي التسويق مع الزبائن, (C_id, I_date), هو المفتاح الأساسي, ويفترض هذا الجدول أن الزبون لا يمكنه إجراء أكثر من مقابلة في نفس اليوم, بينما يستطيع الموظف إجراء أكثر من مقابلة في اليوم, وفي غرفة واحدة. 

علاقات التبعية في الجدول السابق تتضمن: 

1. C_id + I_date 

→ I_time, room_num, Emp_num. 

2. I_date + I_time + Emp_num 

→ C_id. 

3. I_date + I_time + Room_num 

→ C_id, Emp_num. 

4. I_date + Emp_num 

→ Room_num. 

1, 2, 3 لأن المحدد فيها هو مفتاح مرشح. 

في 4 نجد أن الطرف اليساري لا يشكل مفتاح مرشح (يمكن للموظف إجراء أكثر من مقابلة في نفس اليوم), هذه العلاقة لا تخرق شرط 3NF لأن الطرف اليميني هو جزء من مفتاح مرشح (3) ولكنها تخرق شرط BCNF. 

لوضع الجدول في الشكل BCNF يجب تجزئته على الشكل: 

<table><tr><td>C_id</td><td>I_date</td><td>I_time</td><td>Room_num</td><td>Emp_num</td></tr><tr><td>08</td><td>04-20-00</td><td>09:30</td><td>P70</td><td>Pe-23</td></tr><tr><td>17</td><td>05-01-00</td><td>09:30</td><td>P60</td><td>Pe-32</td></tr><tr><td>20</td><td>05-01-00</td><td>10:30</td><td>P70</td><td>Pe-23</td></tr></table>

--- Page 7 ---

<table><tr><td>C_id</td><td>I_date</td><td>I_time</td><td>Emp_num</td></tr><tr><td>08</td><td>04-20-00</td><td>09:30</td><td>Pe-23</td></tr><tr><td>17</td><td>05-01-00</td><td>09:30</td><td>Pe-32</td></tr><tr><td>20</td><td>05-01-00</td><td>10:30</td><td>Pe-23</td></tr></table>

<table><tr><td>Emp_num</td><td>I_date</td><td>Room_num</td></tr><tr><td>Pe-23</td><td>04-20-00</td><td>P70</td></tr><tr><td>Pe-32</td><td>05-01-00</td><td>P60</td></tr><tr><td>Pe-23</td><td>05-01-00</td><td>P70</td></tr></table>

الشكل النظامي الثالث هو شكل كاف لتنظيم قاعدة البيانات، وهو كاف لتلافي تكرار البيانات ومشاكل الحذف والتعديل والإضافة. 

قد يكون من المفيد في بعض الأحيان إعادة تركيب الجداول الناتجة عن التنظيم، لاعتبارات تسريع أداء قاعدة البيانات وهذا ما يدعى بإعادة التنظيم (denormalization). 

مثال 3: 

يضم الجدول التالي بيانات توريد مواد. 

<table><tr><td>Supplier_id</td><td>Supplier_name</td><td>Part_num</td><td>Quantity</td></tr><tr><td></td><td></td><td></td><td></td></tr></table>

بفرض أن اسم المورد لا يتكرر، فهناك مفتاحان مرشحان لهذه العلاقة (supplier_id, part_num) و (supplier_name, part_num).

--- Page 8 ---

التبعات الموجودة في الجدول هي: 

1. Supplier_id → supplier_name. 

2. Supplier_name → supplier_id. 

3. Supplier_id + part_num → quantity. 

4. Supplier_id + part_num → supplier_name. 

5. Supplier_name + part_num → supplier_id. 

6. Supplier_name + part_num → quantity. 

هذا الجدول هو من الشكل 3NF لأن الواصفة الوحيدة التي لا تشكل جزء من مفتاح مرشح هي quantity وهي لا تتحدد بجزء من مفتاح مرشح. 

BCNF كلاها محمد وليس مفتاح مرشح، فالجدول ليس من الشكل Supplier_id, supplier_name 

لجعل الجدول من الشكل BCNF يجب تجزئته على الشكل: 

<table><tr><td>Supplier_id</td><td>Supplier_name</td><td>Part_num</td><td>Quantity</td></tr><tr><td></td><td></td><td></td><td></td></tr></table>

<table><tr><td>Supplier_id</td><td>Part_num</td><td>Quantity</td></tr><tr><td></td><td></td><td></td></tr></table>

<table><tr><td>Supplier_id</td><td>Supplier_name</td></tr><tr><td></td><td></td></tr></table>

## 3. الشكل النظامي الرابع (4NF) 

يعتمد تعريف 4NF على مفهوم التبعية متعددة القيم (<<>>) (multivalued dependency)، تحدث التبعية متعددة القيم في جدول يضم ثلاثة حقول على الأقل، عندما تتطابق قيم عدة أسطر من عمود مع قيمة سطر وحيد في عمود آخر، أي أن قيمة حقل تحدد مجموعة قيم لحقل آخر. 

يكون الجدول من الشكل 4NF إذا كان من الشكل BCNF وكل واصفة تحددها (تحديد متعدد القيم) مجموعة واصفات أخرى يجب أن تعتمد كلياً على مجموعة الواصفات هذه.

--- Page 9 ---

مثال: 

موظفين تسند لهم مشاريع ويتمتعون بكفاءات معينة: 

<table><tr><td>Emp</td><td>Prj</td><td>Skill</td></tr><tr><td>1211</td><td>1</td><td>Analysis</td></tr><tr><td>1211</td><td>5</td><td>Analysis</td></tr><tr><td>1211</td><td>1</td><td>Design</td></tr><tr><td>1211</td><td>1</td><td>Prog</td></tr></table>

مفتاح الجدول السابق هو الواصفات الثلاث مجتمعة. 

علاقات التبعية للجدول السابق هي: 

1. Emp + prj --> skill. 

2. Emp + skill --> prj. 

الجدول السابق هو من الشكل BCNF, ولكنه ليس من الشكل 4NF, لأن: 

skill تعتمد على emp أي تعتمد جزئياً على (emp, prj), والأمر نفسه نجده في العلاقة 2, حيث prj تعتمد جزئياً على (emp, skill). 

لوضع الجدول في الشكل 4NF يجب تجزئته على الشكل: 

<table><tr><td>Emp</td><td>Prj</td><td>Skill</td></tr><tr><td>1211</td><td>1</td><td>Analysis</td></tr><tr><td>1211</td><td>5</td><td>Analysis</td></tr><tr><td>1211</td><td>1</td><td>Design</td></tr><tr><td>1211</td><td>1</td><td>Prog</td></tr></table>

<table><tr><td>Emp</td><td>Prj</td></tr><tr><td></td><td></td></tr></table>

<table><tr><td>Emp</td><td>Skill</td></tr><tr><td></td><td></td></tr></table>
