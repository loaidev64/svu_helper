--- Page 1 ---

<table><tr><td>Isolation level</td><td>Allow</td><td>Block</td></tr><tr><td>Read uncommitted</td><td>Phantom read, dirty read</td><td></td></tr><tr><td>Read committed</td><td>Phantom read</td><td>Dirty read</td></tr><tr><td>Repeatable read</td><td>Phantom read</td><td>Dirty read</td></tr><tr><td>Serializable</td><td></td><td>Phantom read, dirty read</td></tr><tr><td>Snapshot</td><td></td><td>Phantom read, dirty read</td></tr></table>

Read uncommitted: it reads dirty read and phantom read.

Read committed: insert, delete are allow, it allows phantom read, but doesn't support dirty read which mean if the running transaction is "select" transaction, we can insert, delete from other transaction on same table, but not vice versa, which mean if the running transaction is about insert, delete, and update, we can't run a select" transaction.

Repeatable read: insert is allowed, but delete is not because repeatable read guarantees that what I read is exactly the same thing as I read before within the transaction, so when you insert a row, it guarantees that you will read it again as same.

Serializable: it's like repeatable read except it's a little bit stricter because it doesn't even allow phantom read, which mean we can't insert or delete. In addition, it's the only isolation level that prevents phantom read and allows repeatable read. In conclusion the initiate reads must be the same till transaction end.
