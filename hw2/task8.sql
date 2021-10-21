select orders.user_id, listagg(dict.type using parameters on_overflow='TRUNCATE')
from marketing.orders orders
         left join marketing.subscription_status subs
                   on orders.order_id = subs.parent_order_id
         left join product.user_session_end sessions
                   on orders.user_id = sessions.user_id
         left join product.activities activities
                   on orders.user_id = activities.user_id
         left join dictionary.activity_type dict
                   on activities.activity_type = dict.id
where subs.status = 'subscribe'
  and sessions.session_number = 0
  and sessions.dt > orders.dt
  and activities.dt < orders.dt
group by orders.user_id
order by orders.user_id;


select orders.user_id, listagg(dict.type using parameters on_overflow='TRUNCATE')
from product.user_session_end sessions
         left join marketing.orders orders
                   on sessions.user_id = orders.user_id
         left join marketing.subscription_status subs
                   on orders.order_id = subs.parent_order_id
         left join product.activities activities
                   on orders.user_id = activities.user_id
         left join dictionary.activity_type dict
                   on activities.activity_type = dict.id
where sessions.session_number = 0
  and (orders.dt IS NULL or sessions.dt < orders.dt)
  and activities.dt < sessions.dt
group by orders.user_id
order by orders.user_id;
