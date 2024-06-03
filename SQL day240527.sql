USE SAKILA;
select * from actor;

# 1. 배우의 이름을 알파벳 내림차순 10명을 보여주세요.
SELECT first_name from actor
ORDER BY first_name DESC
LIMIT 10;

# 2. 영화의 카테고리를 보여주세요.
SELECT * from category;

# 3. 고객 중에 휴면 회원들을 모두 보여주세요.
SELECT * FROM customer WHERE active=0;

# 4. 영화를 대여기간 순으로 오름차순 정렬하세요
SELECT * FROM film ORDER BY rental_duration;

# 5. 영화를 대여료 순으로 내림차순 정렬하세요.
SELECT * FROM film ORDER BY rental_rate DESC;

# 6. 영화 중 개(dog)가 나오는 것을 모두 보여주세요.
SELECT * FROM film WHERE description like '%dog%';

# 7. 영화 중 2000년 이전에 나온 영화들을 모두 보여주세요.
SELECT * FROM film
WHERE release_year<=2000;

# 8. 필름 액터 테이블로 페넬로페 귀네스가 나온 영화의 제목들을 출력해주세요.
# 순차적으로 결과 확인할 것
/*SELECT * FROM film;
SELECT * FROM film_actor;
SELECT * FROM actor;

SELECT * FROM actor
WHERE first_name = 'penelope' AND last_name = 'guiness';

SELECT * FROM film_actor
INNER JOIN actor
ON film_actor.actor_id = actor.actor_id
WHERE actor.first_name = 'penelope' AND actor.last_name = 'guiness';

SELECT * FROM film
INNER JOIN film_actor
ON film.film_id = film_actor.film_id;*/

# 최종
SELECT film.title FROM film
INNER JOIN film_actor
ON film.film_id = film_actor.film_id
INNER JOIN actor
ON film_actor.actor_id = actor.actor_id
WHERE actor.first_name = 'penelope' AND actor.last_name = 'guiness';

# 9. 가장 많은 영화에 출연한 배우의 성과 이름과 출연한 영화의 갯수를 출력해주세요. !!!!!!!!!!!!
/*SELECT actor_id, COUNT(actor_id) FROM film_actor
GROUP BY actor_id
ORDER BY count(actor_id)
LIMIT 1; # 가장 많은 배우 한명만 보여주면 되기 때문*/

# 최종
SELECT fa.actor_id, a.first_name, a.last_name, COUNT(fa.actor_id) FROM film_actor as fa
INNER JOIN actor AS a
ON fa.actor_id = a.actor_id
GROUP BY fa.actor_id
ORDER BY count(actor_id) DESC
LIMIT 1;

# 10. 회원 번호와 그 회원이 대여료를 총 얼마 냈는지 보여주세요.alter
SELECT customer_id, SUM(amount) FROM payment GROUP BY customer_id;


#--------------------------------------------------------숙제
# 11. 1번 store가 가지고 있는 총 비디오의 갯수를 보여주세요.
SELECT SUM(store_id) FROM inventory WHERE store_id = 1; # 내코드
SELECT count(*) FROM inventory WHERE store_id = 1; # 선생님코드

# 12. 1번 store가 가지고 있는 영화와 해당 영화의 비디오 갯수를 보여주세요.
# -> 1번의 필름 id를 이용해서 이름을 가져오고 count 써서 그 비디오 개수 세기
SELECT i.film_id, f.title, COUNT(i.film_id) FROM  film AS f
INNER JOIN inventory as i
On f.film_id=i.film_id
where store_id=1
group by film_id;
SELECT film.title, count(*) FROM inventory INNER JOIN film ON inventory.film_id = film.film_id WHERE store_id = 1 GROUP BY inventory.film_id; # 선생님코드

# 13. 영화의 제목과 카테고리를 텍스트로 보여주세요.
/*SELECT title FROM film;
SELECT name FROM category;

# 13-1 카테고리는 숫자로, 제목은 정상출력되도록 하는 코드
SELECT title, fc.category_id FROM film
INNER JOIN film_category as fc
ON film.film_id=fc.film_id ;*/

#최종 카테고리도 숫자로 나오게하기
SELECT film.film_id, title, c.name FROM film
INNER JOIN film_category as fc
ON film.film_id=fc.film_id
INNER JOIN category as c
ON fc.category_id=c.category_id;

# 선생님코드
#######ON film_category.category_id = category.category_id 

# 14. 도시와 해당 국가를 보여주세요.
/*SELECT city FROM city;
SELECT country FROM country;
*/
SELECT city.city_id, city.city, c.country FROM city
INNER JOIN country AS c
ON city.country_id=c.country_id
ORDER BY city.city_id;

# 선생님코드
SELECT city, country FROM city INNER JOIN country ON city.country_id = country.country_id;

# 15. 고객 중 미국에 살고 있는 회원의 이름과 이메일을 보여주세요.
/*SELECT * FROM customer;
SELECT * FROM address;
SELECT * FROM city;
SELECT * FROM country;

SELECT country_id, country FROM country
WHERE country='United States'; # 미국의 country_id

SELECT country.country_id, city.city from city
INNER JOIN country
ON city.country_id=country.country_id
WHERE country='United States'; # 미국의 CITY

SELECT country.country_id, city.city, address from address
INNER JOIN country
INNER JOIN city
ON city.country_id=country.country_id
ON address.city_id = city.city_id
WHERE country='United States'; # 미국의 주소*/

#SELECT country.country_id, city.city, address.address, customer.customer_id, customer.first_name, customer.email from customer
# SELECT address.address_id, customer.customer_id, customer.first_name, customer.email from customer
SELECT customer.first_name, customer.email from customer
INNER JOIN country
INNER JOIN city
ON city.country_id=country.country_id
INNER JOIN address
ON address.city_id = city.city_id
ON customer.address_id = address.address_id
WHERE country='United States'; # 미국의 주소에 살고 있는 사람들의 주소

# 선생님코드
SELECT * FROM customer
WHERE address_id IN(
SELECT address_id FROM address
	WHERE city_id IN
		(SELECT city_id FROM city
			WHERE country_id = (SELECT country_id FROM country WHERE country = 'United States')));


# 16. 영화 중 대여횟수가 가장 많은 영화의 이름을 보여주세요.
/*SELECT film_id, title FROM film;
SELECT * FROM rental;
SELECT * FROM inventory;*/

SELECT f.film_id, f.title, COUNT(i.film_id) FROM film as f
INNER JOIN inventory as i
ON f.film_id = i.film_id
group by f.film_id
ORDER BY count(i.film_id) DESC
LIMIT 1;

#선생님 코드


# 17. 영화 중 대여기간이 4일 미만이고 주연의 이름이 JOHNNY LOLLOBRIGIDA 이고 비디오 부록에 예고편이 있는 영화의 제목을 보여주세요.
/*SELECT * FROM film;

SELECT film_id, special_features FROM film
WHERE special_features LIKE "%Trailers%"; # 비디오부록에 예고편이 있는 영화

SELECT title, rental_duration FROM film
WHERE rental_duration<4; # 대여기간 4일 미만

SELECT actor_id, first_name, last_name FROM actor
WHERE first_name='johnny' AND last_name='LOLLOBRIGIDA'; # 배우 id 5

SELECT actor.actor_id, film.film_id, film.title FROM film
INNER JOIN actor
INNER JOIN film_actor
ON actor.actor_id = film_actor.actor_id
ON film.film_id=film_actor.film_id
WHERE actor.first_name='johnny' AND actor.last_name='LOLLOBRIGIDA';# 배우가 출연한 영화 아이디 가져오기*/
# 최종
SELECT film.film_id, film.title, actor.actor_id, film.rental_duration, film.special_features  FROM film
INNER JOIN actor
INNER JOIN film_actor
ON actor.actor_id = film_actor.actor_id
ON film.film_id=film_actor.film_id
WHERE actor.first_name='johnny' AND actor.last_name='LOLLOBRIGIDA' AND film.special_features LIKE '%Trailers%' AND film.rental_duration < 4; 

#선생님코드
SELECT * FROM film
INNER JOIN film_actor
ON film.film_id = film_actor.film_id
INNER JOIN actor
ON film_actor.actor_id = actor.actor_id
WHERE actor.first_name = 'JOHNNY'
AND actor.last_name="LOLLOBR" AND film.special_features LIKE '%Trailers%' AND film.rental_duration < 4;

# 18. 직원 중 Mike Hillyer가 LINDA WILLIAMS 에게 대여해준 영화의 제목, 대여일, 반납일을 보여주세요.
/*SELECT * FROM rental;
SELECT * FROM staff;
SELECT * FROM customer;
SELECT * FROM inventory;
SELECT * FROM staff WHERE first_name="Mike" AND last_name="Hillyer";
SELECT * FROM customer WHERE first_name="LINDA" AND last_name="WILLIAMS";

SELECT * FROM rental
INNER JOIN customer
ON rental.customer_id = customer.customer_id
INNER JOIN staff
ON rental.staff_id = staff.staff_id
WHERE customer.first_name="LINDA" AND customer.last_name="WILLIAMS" AND staff.first_name="Mike" AND staff.last_name="Hillyer"; # linda가 빌린 mike를 통해 빌린 비디오 목록*/
# 내코드
SELECT film.title, rental.rental_date, rental.return_date from rental
INNER JOIN customer
ON rental.customer_id = customer.customer_id
INNER JOIN staff
ON rental.staff_id = staff.staff_id
INNER JOIN inventory
ON rental.inventory_id = inventory.inventory_id
INNER JOIN film
ON inventory.film_id = film.film_id
WHERE customer.first_name="LINDA" AND customer.last_name="WILLIAMS" AND staff.first_name="Mike" AND staff.last_name="Hillyer";

#선생님코드
SELECT film.title, rental.rental_date, rental.return_date FROM rental
INNER JOIN staff ON rental.staff_id = staff.staff_id
INNER JOIN customer ON rental.customer_id = customer.customer_id
INNER JOIN inventory ON rental.inventory_id = inventory.inventory_id
INNER JOIN film ON inventory.film_id = film.film_id
WHERE staff.first_name="Mike" AND staff.last_name="Hillyer"
AND customer.first_name="LINDA" AND customer.last_name="WILLIAMS";

# 19. 영화의 이름과 출연한 배우의 숫자를 배우의 숫자로 내림차순해서 보여주되 출연한 배우의 숫자 컬럼의 이름을 출연배우수로 만들어 보이세요.
SELECT * FROM film_actor;
# 내코드
SELECT film.title, count(actor_id) AS "출연배우 수" FROM film_actor
INNER JOIN film
ON film_actor.film_id = film.film_id
GROUP BY film_actor.film_id
ORDER BY count(actor_id) DESC;

# 선생님코드
SELECT title, count(*) AS '출연배우수' FROM film_actor
INNER JOIN film ON film_actor.film_id = film.film_id
GROUP BY film_actor.film_id
ORDER BY 출연배우수 DESC;

# 20. 회원의 이름, 빌린 비디오의 숫자, 빌린 비디오 대여점의 주소, 회원의 거주 도시를 회원 번호순으로 정렬하여 보여주세요.
SELECT * FROM customer; # rental에서 각 회원이 각각의 store에서 빌린 비디오 숫자 customer_id로 카운트, 그 해당 회원의 주소를 정렬해서 보여줌
SELECT * FROM rental;
SELECT * FROM address;
SELECT * FROM city;
SELECT * FROM store;
SELECT * FROM staff;
SELECT * FROM inventory;

select * from rental WHERE customer_id =1;
select * from store s, address a, city c
where s.address_id = a.address_id
and a.city_id = c.city_id;

# 내코드
SELECT rental.customer_id, customer.first_name, customer.last_name, store_address.address, city.city, count(rental.customer_id) FROM rental
INNER JOIN customer ON rental.customer_id = customer.customer_id # 회원이름과  빌린 비디오의 숫자 출력하기 위함
#INNER JOIN staff ON rental.staff_id = staff.staff_id
#INNER JOIN store ON staff.store_id = store.store_id
INNER JOIN store ON customer.store_id = store.store_id
INNER JOIN address AS store_address
ON store.address_id = store_address.address_id
# 비디오 대여점 주소
INNER JOIN address ON customer.address_id = address.address_id 
INNER JOIN city ON address.city_id = city.city_id # 회원거주 도시 프린트


# 지점별 빌린 비디오??

GROUP BY rental.customer_id;


# 선생님코드

SET @@sql_mode = (SELECT REPLACE(@@sql_mode, 'ONLY_FULL_GROUP_BY',''));
SELECT count(*), customer.first_name, customer.last_name, address.address, customer_city.city FROM rental
INNER JOIN customer ON rental.customer_id = customer.customer_id
INNER JOIN staff ON rental.staff_id = staff.staff_id
INNER JOIN store ON staff.store_id = store.store_id
INNER JOIN address ON store.address_id = address.address_id
INNER JOIN city ON address.city_id = city.city_id
INNER JOIN address AS customer_address ON customer.address_id = customer_address.address_id
INNER JOIN city AS customer_city ON customer_address.city_id = customer_city.city_id
GROUP BY rental.customer_id;


SELECT count(*), customer.first_name, customer.last_name, address.address, customer_city.city FROM rental
INNER JOIN customer
ON rental.customer_id = customer.customer_id
INNER JOIN staff
ON rental.staff_id = staff.staff_id
INNER JOIN store
ON staff.store_id = store.store_id #??????????????????????????????????????????????????????????????????????????????????????????????????
INNER JOIN address
ON store.address_id = address.address_id
INNER JOIN city
ON address.city_id = city.city_id
INNER JOIN address as customer_address
ON customer.address_id = customer_address.address_id
INNER JOIN city as customer_city
ON customer_address.city_id = customer_city.city_id
GROUP BY rental.customer_id;
