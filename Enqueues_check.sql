# script to check enqueue holders in database

SELECT /*+ rule */ inst_id,DECODE(request,0,'Holder: ','Waiter: ')|| sid sess, id1, id2, lmode,
request, type
   FROM gV$LOCK
 WHERE (id1, id2, type) IN (SELECT id1, id2, type FROM gV$LOCK WHERE request>0)
   ORDER BY id1, request
/
