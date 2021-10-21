select (
           select count(*)
           from (
                    select count(sessions.user_id)
                    from product.users users
                             left outer join product.user_session_end sessions
                                             on users.id = sessions.user_id
                    group by users.id
                    having count(sessions.user_id) > 2
                ) Claims
       ) * 100.0 /
       (select count(*) from product.users)