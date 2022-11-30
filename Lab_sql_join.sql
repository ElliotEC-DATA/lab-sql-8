use sakila;

-- 1 

select  category_id ,count(film_id) Nb_films from film_category
group by category_id;

-- 2

select s.first_name, s.last_name, a.address from staff s
join address a on s.address_id = a.address_id;

-- 3

select s.staff_id, sum(p.amount) from staff s
join payment p on s.staff_id = p.staff_id
group by s.staff_id;

-- 4

select f.title, sum(fa.actor_id) from film f
join film_actor fa on f.film_id = fa.film_id
group by f.title;

-- 5

select c.first_name, c.last_name, sum(p.amount) from customer c
join payment p on c.customer_id = p.customer_id
group by c.customer_id
order by c.last_name asc;