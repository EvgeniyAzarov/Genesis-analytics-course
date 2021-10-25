select avg(sessions_num)
from (
         select users.id, count(*) sessions_num
         from product.users users
                  left join product.user_session_end sessions
                            on users.id = sessions.user_id
         group by users.id
     ) Claims