select t1.user_app, msgs_number, chats_number
from (
         select user_app, count(*) msgs_number
         from product.activities
         where activity_type = (select id from dictionary.activity_type where type = 'message')
         group by user_app
     ) t1
         inner join
     (
         select user_app, cast(count(*) / 2 as INT) chats_number
         from (select user_app, user_id user1, contact_id user2
               from product.activities
               where activity_type = (select id from dictionary.activity_type where type = 'message')
               union
               select user_app, user_id user2, contact_id user1
               from product.activities
               where activity_type = (select id from dictionary.activity_type where type = 'message')
              ) Claims
         group by user_app
     ) t2
     on t1.user_app = t2.user_app