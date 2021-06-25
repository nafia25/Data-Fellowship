--A customer wants to know the films about “astronauts”. How many recommendations could you give for him?
select count(film_id) as num_of_film from film
where description like '%Astronaut%';

--I wonder, how many films have a rating of “R” and a replacement cost between $5 and $15?
select count(film_id) as num_of_film from film
where rating = 'R' and replacement_cost between 5 and 15;

--We have two staff members with staff IDs 1 and 2. We want to give a bonus to the staff member that handled the most payments.
--How many payments did each staff member handle? And how much was the total amount processed by each staff member?
select s.staff_id, s.first_name, s.last_name, count(p.payment_id) as num_of_transaction, sum(p.amount) as sum_of_transaction
from staff s 
join payment p on s.staff_id = p.staff_id 
group by s.staff_id;

--Corporate headquarters is auditing the store! They want to know the average replacement cost of movies by rating!
select rating, round(avg(replacement_cost),2) as avg_replacement_cost
from film f 
group by rating;

--We want to send coupons to the 5 customers who have spent the most amount of money. Get the customer name, email and their spent amount!
select c.first_name, c.last_name, c.email, sum(p.amount) as sum_of_transaction
from customer c 
join payment p ON c.customer_id = p.customer_id 
group by c.customer_id 
order by sum(p.amount) desc 
limit 5;

--We want to audit our stock of films in all of our stores. How many copies of each movie in each store, do we have?
select f.film_id, f.title, s.store_id, count(i.film_id) as in_inventory
from film f 
join inventory i on f.film_id = i.film_id 
join store s on i.store_id = s.store_id 
group by f.film_id, s.store_id 
order by f.film_id;

--We want to know what customers are eligible for our platinum credit card. The requirements are that the customer has at least a total of 40 transaction payments. 
--Get the customer name, email who are eligible for the credit card! 
select c.first_name, c.last_name, c.email, count(p.payment_id) as num_of_transaction
from customer c 
join payment p ON c.customer_id = p.customer_id 
group by c.customer_id 
having count(p.payment_id) >= 40;