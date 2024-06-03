USE SAKILA;
# 1. 배우의 이름을 알파벳 내림차순 10명을 보여주세요.
SELECT first_name FROM actor
ORDER BY first_name DESC
LIMIT 10;

# 2. 카테고리를 보여주세요.
SELECT * FROM category;

# 3. 고객 중에 휴면 회원들을 모두 보여주세요.
SELECT * FROM customer
where active = 0;

# 4. 영화를 대여기간 순으로 오름차순 정렬하세요
SELECT * FROM film
ORDER BY rental_duration;

# 5. 영화를 대여료 순으로 내림차순 정렬하세요.
SELECT * FROM film
ORDER BY rental_rate DESC;

# 6. 영화 중 개(dog)가 나오는 것을 모두 보여주세요.
SELECT * FROM film
WHERE description like '%dog%';

# 7. 영화 중 2000년 이전에 나온 영화들을 모두 보여주세요.
SELECT * FROM film
WHERE release_year <= 2000;

# 8. 필름 액터 테이블로 페넬로페 귀네스가 나온 영화의 제목들을 출력해주세요.
SELECT * FROM film;
SELECT * FROM film_actor;
SELECT * FROM actor;

SELECT * FROM actor
WHERE first_name = 'penelope' AND last_name = 'guiness';

SELECT * FROm film_actor
INNER JOIN actor
ON film_actor.actor_id = actor.actor_id
WHERE actor.first_name = 'penelope' AND actor.last_name = 'guiness';

SELECT film.title FROM film
INNER JOIN film_actor
ON film.film_id = film_actor.film_id
INNER JOIN actor
ON film_actor.actor_id = actor.actor_id
WHERE actor.first_name = 'penelope' AND actor.last_name = 'guiness';

# 9. 가장 많은 영화에 출연한 배우의 성과 이름과 출연한 영화의 갯수를 출력해주세요.
SELECT actor.first_name, actor.last_name, count(fa.actor_id)
FROM film_Actor AS fa
INNER JOIN actor
ON fa.actor_id = actor.actor_id
GROUP BY fa.actor_id
ORDER BY count(fa.actor_id) DESC
LIMIT 1;

# 10. 회원 번호와 그 회원이 대여료를 총 얼마 냈는지 보여주세요.
SELECT * FROM payment;
SELECT customer_id, sum(amount) FROM payment
GROUP BY customer_id;

# 11. 1번 store가 가지고 있는 총 비디오의 갯수를 보여주세요.
SELECT * FROM inventory;
SELECT * FROM inventory WHERE store_id  = 1;
SELECT count(*) FROM inventory WHERE store_id = 1;

# 12. 1번 store가 가지고 있는 영화와 해당 영화의 비디오 갯수를 보여주세요.
SELECT * FROM inventory;
SELECT * FROM inventory WHERE store_id = 1;
SELECT * FROM inventory
INNER JOIN film
ON inventory.film_id = film.film_id
WHERE store_id = 1;
SELECT film.title, count(*) FROM inventory
INNER JOIN film
ON inventory.film_id = film.film_id
WHERE store_id = 1
GROUP BY inventory.film_id;

# 13. 영화의 제목과 카테고리를 텍스트로 보여주세요.
SELECT * FROM film;
SELECT * FROM category;
SELECT * FROM film_category;

SELECT title FROM film_category
INNER JOIN film
ON film_category.film_id = film.film_id;

SELECT name from film_category
INNER JOIN category
ON film_category.category_id = category.category_id;

SELECT title, name from film_category
INNER JOIN category
ON film_category.category_id = category.category_id
INNER JOIN film
ON film_category.film_id = film.film_id;

# 14. 도시와 해당 국가를 보여주세요.
SELECT * FROM city;
SELECT * FROM country;
SELECT * FROM city
INNER JOIN country
ON city.country_id = country.country_id;
SELECT city, country FROM city
INNER JOIN country
ON city.country_id = country.country_id;

# 15. 고객 중 미국에 살고 있는 회원의 이름과 이메일을 보여주세요.
SELECT * FROM country;
SELECT country_id FROM country
WHERE country = 'United States';

SELECT * FROM address;

SELECT * FROM city;

SELECT * FROM city
WHERE country_id = (SELECT country_id FROM country WHERE country = 'United States');

SELECT * FROM address
WHERE city_id IN
(SELECT city_id FROM city
WHERE country_id = (SELECT country_id FROM country WHERE country = 'United States'));

SELECT first_name, last_name, email FROM customer
WHERE address_id IN
(SELECT address_id FROM address
	WHERE city_id IN
		(SELECT city_id FROM city
			WHERE country_id = 
				(SELECT country_id FROM country
                 WHERE country = 'United States')));


# 16. 영화 중 대여횟수가 가장 많은 영화의 이름을 보여주세요.
SELECT * FROM rental;
SELECT * FROM inventory;

SELECT * FROM rental
INNER JOIN inventory
ON rental.inventory_id = inventory.inventory_id;

SELECT title, count(inventory.film_id) FROM rental 
INNER JOIN inventory
ON rental.inventory_id = inventory.inventory_id
INNER JOIN film
ON film.film_id = inventory.film_id
GROUP BY inventory.film_id
ORDER BY count(film_id) DESC
LIMIT 1;

# 17. 영화 중 대여기간이 4일 미만이고 주연의 이름이 JOHNNY LOLLOBRIGIDA 이고
#     비디오 부록에 예고편이 있는 영화의 제목을 보여주세요.
SELECT * FROM film
WHERE film.special_features like '%Trailers%'
AND rental_duration < 4;

SELECT * FROM actor
WHERE first_name = 'JOHNNY' AND last_name = 'LOLLOBRIGIDA';

SELECT * FROM actor
INNER JOIN film_actor
ON actor.actor_id = film_actor.actor_id
WHERE first_name = 'JOHNNY' AND last_name = 'LOLLOBRIGIDA';

SELECT * FROM film
INNER JOIN film_actor
ON film.film_id = film_actor.film_id
INNER JOIN actor
ON film_actor.actor_id = actor.actor_id
WHERE actor.first_name = 'JOHNNY'
AND actor.last_name = 'LOLLOBRIGIDA'
AND film.special_features LIKE '%Trailers%'
AND film.rental_duration < 4;

# 18. 직원 중 Mike Hillyer가 LINDA WILLIAMS 에게 대여해준 영화의 제목, 대여일, 반납일을 보여주세요.
SELECT * FROM staff
WHERE first_name = 'Mike' AND last_name = 'Hillyer';

SELECT * FROM customer
WHERE first_name = 'Linda' AND last_name = 'Williams';

SELECT film.title, rental.rental_date, rental.return_date FROM rental
INNER JOIN staff
ON rental.staff_id = staff.staff_id
INNER JOIN customer
ON rental.customer_id = customer.customer_id
INNER JOIN inventory
ON rental.inventory_id = inventory.inventory_id
INNER JOIN film
ON inventory.film_id = film.film_id
WHERE staff.first_name = 'Mike' AND staff.last_name = 'Hillyer'
AND customer.first_name = 'Linda' AND customer.last_name = 'Williams';

# 19. 영화의 이름과 출연한 배우의 숫자를 배우의 숫자로 내림차순해서 보여주되 출연한배우의 숫자 컬럼의 이름을 출연배우수로 만들어 보여세요.
SELECT title, count(*) AS '출연배우수' FROM film_actor
INNER JOIN film
ON film_actor.film_id = film.film_id
GROUP BY film_actor.film_id
ORDER BY 출연배우수 DESC;

# 20. 회원의 이름, 빌린 비디오의 숫자, 빌린 비디오 대여점의 주소, 
#     회원의 거주 도시를 회원 번호순으로 정렬하여 보여주세요.
SELECT * FROM customer;
SELECT COUNT(*) FROM rental
GROUP BY inventory_id;
SELECT * FROM STORE;
SELECT * FROM address;
SELECT * FROM city;

SET @@sql_mode = (SELECT REPLACE(@@sql_mode, 'ONLY_FULL_GROUP_BY,', ''));

SELECT count(*), customer.first_name, customer.last_name, address.address, customer_city.city FROM rental
INNER JOIN customer
ON rental.customer_id = customer.customer_id
INNER JOIN staff
ON rental.staff_id = staff.staff_id
INNER JOIN store
ON staff.store_id = store.store_id
INNER JOIN address
ON store.address_id = address.address_id
INNER JOIN city
ON address.city_id = city.city_id
INNER JOIN address as customer_address
ON customer.address_id = customer_address.address_id
INNER JOIN city as customer_city
ON customer_address.city_id = customer_city.city_id
GROUP BY rental.customer_id;









