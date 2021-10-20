select * from product.users
where (gender='m' and lang not in ('ru', 'es'))
or (gender='f' and lang='ru' and app='desktop')