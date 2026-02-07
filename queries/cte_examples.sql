with base as (select shipmode,segment, '2014' as year , count(distinct orderid) unikal
from superstore
where year(orderdate)=2014
group by 1,2
union
select shipmode,segment, '2015' as year , count(distinct orderid) unikal
from superstore
where year(orderdate)=2015
group by 1,2)
select *
from base
order by unikal desc;

select orderid, orderdate, date_add(orderdate, interval 3 day) day4ship, shipdate
from superstore
where shipdate>date_add(orderdate, interval 3 day);

with base as (select p.pos_name,e.sales,m.product_name
from ee_take2 e
left join pos_map p
on p.pos_id=e.pos_id
left join product_map m
on e.product_id=m.product_id)

select pos_name,
case 
when sales>50000 then "extra"
when sales>30000 then "d"
when sales>1000 then "c"
when sales>500 then "b"
when sales>0 then"a" end as category 
from base;

select region, pos_name,comm_rate,product_name,subs_price,count(distinct cust_id) mushteri_sayi,sum(sales) toplam_gelir, round(avg(sales-sales*comm_rate),2) ortalama_net,
case
when age>=0 and age<10 then "0-10"
when age>=10 and age<20 then "10-20"
when age>=20 and age<30 then "20-30"
when age>=30 and age<40 then "30-40"
when age>=40 and age<50 then "40-50"
when age>=50 and age<60 then "50-60"
when age>=60 and age<70 then "60-70"
when age>=70 and age<80 then "70-80"
when age>=   80  then "80+" end as  yash_category 
from ee_take2 t1
left join pos_map t2
on t1.pos_id=t2.pos_id
left join reg_map t3
on t1.region_id=t3.region_id
left join product_map t4
on t1.product_id=t4.product_id and t1.product_sub_id=t4.product_sub_id
group by region, pos_name,comm_rate,product_name,subs_price,yash_category;


select "baki ve ya lenkeran" as reg, sum(sales) toplam_satish, count(distinct cust_id) mushteri_sayi, sum(sales)/count(distinct cust_id) mushteri_bashigelir
from ee_take2 t1
left join reg_map t2
on t1.region_id=t2.region_id
where region="Bakı" or region="Lənkəran"
union 
select "gence ve ya imishli" as reg, sum(sales) toplam_satish, count(distinct cust_id) mushteri_sayi, sum(sales)/count(distinct cust_id) mushteri_bashigelir
from ee_take2 t1
left join reg_map t2
on t1.region_id=t2.region_id
where region="Gəncə" or region="İmişli";

select concat(city," ",country), sum(sales) umumi_gelir
from superstore
group by 1
order by umumi_gelir desc
limit 10;


select subcategory, concat(round(sum(profit)/sum(sales),2)*100,"%")marja
from superstore
group by 1
order by marja desc;


select region, city, count(distinct customerid) mushteri_sayi, count(distinct orderid) sifarish_sayi
from superstore
group by 1,2
having mushteri_sayi>10
order by mushteri_sayi desc;



select country,type,title, year(date_added),
case when duration like "%season%"then  500* CAST(REPLACE(duration,' Season','') AS SIGNED)
 when duration like "%seasons%"then  500* CAST(REPLACE(duration,' Seasons','') AS SIGNED)
when  duration like "%min%" then CAST(REPLACE(duration,'min','')AS SIGNED)
else "xeta var" end duration_temiz
from netflix;

with base as(select
case when duration like "%season%"then  500* CAST(REPLACE(duration,' Seasons','') AS SIGNED)
when  duration like "%min%" then CAST(REPLACE(duration,'min','')AS SIGNED)
else "xeta var" end duration_temiz, country, type, show_id
from netflix)
select country, type,count(distinct show_id) verlish_sayi, sum(duration_temiz) toplam_verlish_muddetideq
from base
group by 1,2;




