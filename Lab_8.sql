use sakila;

-- 1

select title, length, rank () over (order by length desc) as "rank" from film
having length > 0;

-- 2

select title, length, rating, rank () over (partition by rating order by length desc) as "rank" from film
having length > 0;

-- 3


select * from category;
select * from film_category;

select a.category_id, count(*) as "number of films" from sakila.film_category a
join sakila.category c on a.category_id = c.category_id
group by a.category_id
order by c.category_id
limit 100;

-- 4 First solution is right in some way but i know i must use max (update : it was the expected result)

select * from actor;
select * from film_actor;

select a.first_name, a.last_name, count(a.actor_id) as films_played from sakila.actor a
join sakila.film_actor f on a.actor_id = f.actor_id
group by a.actor_id
order by count(a.actor_id) desc
limit 1;

-- try to put count() in the max() but I guess sql doesnt understand

select a.first_name, a.last_name, max(count(a.actor_id)) from sakila.actor a
join sakila.film_actor f on a.actor_id = f.actor_id;

select a.first_name, a.last_name, count(a.actor_id) films_played from sakila.actor a
join sakila.film_actor f on a.actor_id = f.actor_id
group by a.actor_id
having (max(films_played)) = count(a.actor_id);

-- I found this solution without the join but i got this error : "Error Code: 1248. Every derived table must have its own alias"


select a.first_name, a.last_name, a.actor_id, count(a.actor_id) films_played from sakila.actor a
join sakila.film_actor f on a.actor_id = f.actor_id
group by a.actor_id
having count(a.actor_id) = (
select max(films_played)
from (
select a.first_name, a.last_name, a.actor_id, count(a.actor_id) films_played
from sakila.actor
group by a.actor_id));

-- 5 ok we can use the first solution apparenrtly but I guess there is a problem in the question
-- they said "count the rental_id" but the rental_id values are unique in the rental table, I think it's "customer id" but in the rental table like below

select * from customer;
select * from rental limit 100;

select c.first_name, c.last_name, count(r.customer_id) as goodguy from customer c
join rental r on c.customer_id = r.customer_id
group by r.customer_id
order by goodguy desc
limit 1;


