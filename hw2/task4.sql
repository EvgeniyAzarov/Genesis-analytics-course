select avg(sessions)
from (
         select user_id, count(*) sessions
         from product.user_session_end
         group by user_id
     ) Claims
