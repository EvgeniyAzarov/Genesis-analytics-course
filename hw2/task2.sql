select count(distinct sessions.user_id) * 100.0 / count(distinct users.id)
from product.users users
         left outer join product.user_session_end sessions
                         on users.id = sessions.user_id