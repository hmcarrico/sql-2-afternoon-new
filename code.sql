
--Part 1(join)

--1
select * from invoice i
join ivoiceLine il 
on il.invoiceId = i.invoiceId
where il.unitprice > 0.99;

--2
select i.invoicedate, c.firstname, c.lastname, i.total from invoice i
join customer c 
on i.customerId = c.customerId;

--3
select c.firstname, c.lastname, e.firstname, e.lastname
from customer c
join employee e 
on c.supportrepid = e.employeeid;

--4
select al.title, ar.name from album al
join artist ar
on al.artistid = ar.artistid;

--5
select pt.trackid from playlisttrack pt
join Playlist p
on p.playlistid = pt.playlistid
where p.Name = 'Music';

--6
select t.name from track t
join playlisttrack pt
on pt.trackid = t.trackid
where pt.playlistid = 5;

--7
select t.name, p.name from track t
join product playlisttrack pt
on t.trackid = pt.trackid
join playlist p
on p.playlistid = p.playlistid

--8
select name, title from track t
join album a
on a.albumid = t.albumid
join genre
on g.genreid = t.genreid
where g.name = 'alternative'

--Part 2(nested queries)

--1
select * from invoice
where invoiceid in
(select invoiceid from invoiceline where unitprice > 0.99)

--2
select * from playlisttrack
where playlistid in
(select playlistid from playlist where name = "Music")

--3
select name from track
where genreid in
(select trackid from playlisttrack where playlistid = 5)

--4
select * from track
where genreid in
(select genreid from genre where name='Comedy')

--5
select * from track
where albumid in
(select albumid from album where name='Fireball')

--6
select * from track
where albumid in
(select albumid from album where artistid in
(select artistid from artist where name="Queen"));

--Part 3(updating Rows)

--1
update customer
set fax=null where fax is not null;

--2
update customer
set company='self' where company is null;

--3
update customer 
set lastname="Thompson" 
where firstname="Julia" and lastname="Barnett";

--4
update customer 
set supportrepid=4 where email="luisrojas@yahoo.cl"

--5
update track
set composer="The darkness around us"
where genreid=(select genreid from genre where name="Metal")
and composer is null;

--Part 4(group by)

--1
select count(*), g.Name
from track t
join genre g 
on t.genreid = g.genreid
group by g.name;

--2
select count(*), g.name
track t
join genre g
on g.genrid = t.genreid
where g.name='Pop' or g.name='Rock'
group by g.name

--3
select ar.name, count(*)
from artist ar
join album al
on ar.artistId = al.artistid
group by al.artistid

--Part 5(distict)

--1
select distinct composer
from track

--2
select distinct billingpostalcode
from invoice;

--3
select distinct company
from customer;

--part 6(delete)

--1
delete from practice_delete
where type="Bronze"

--2
delete from practice_delete
where type="Silver"

--3
delete from practice_delete
where value=150

--Part 7(eCommerce)

create table users (
    userid serial primary key,
    name text,
    email text
)

create table products (
    productid serial primary key,
    name text,
    price int
)

create table orders (
    id serial primary key,
    product_id int references products(id),
    qty int
);

insert into products (name, price)
values('tshirt', 25),
('jacket', 35),
('shoes', 27);


insert into orders (product_id, qty)
values(1, 1),
(2, 4),
(3, 3);

select * from orders;

select sum(o.qty * p.price)
from orders o
join products p on o.product_id = p.id
where o.id = 2;

alter table orders 
add user_id int references users(id);

update orders
set user_id =
