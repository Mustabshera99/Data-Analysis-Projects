select category.name, count(rental.rental_id) as rental_count, sum(payment.amount) as total_rent, 
count(distinct film.film_id) as total_films,
dense_rank() over (order by sum(payment.amount) desc) as rank_category
from rental
left join inventory
on rental.inventory_id = inventory.inventory_id
left join film 
on inventory.film_id = film.film_id
left join film_category 
on  inventory.film_id = film_category.film_id
left join category
on film_category.category_id = category.category_id
left join payment
on payment.rental_id = rental.rental_id

group by category.name