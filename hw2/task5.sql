select gender, app, count(case when sessions_num > 2 then 1 end) * 100.0 / count(*) more_then_two_sessions
from (
         select users.id, max(users.gender) gender, max(users.app) app, count(*) sessions_num
         from product.users users
                  left join product.user_session_end sessions
                            on users.id = sessions.user_id
         group by users.id
     ) Claims
group by gender, app
order by more_then_two_sessions desc
