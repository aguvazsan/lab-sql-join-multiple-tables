
# Lab | SQL Joins on multiple tables

-- In this lab, you will be using the [Sakila](https://dev.mysql.com/doc/sakila/en/) database of movie rentals.

USE sakila;

### Instructions

-- 1. Write a query to display for each store its store ID, city, and country.

select s.store_id AS Store, c.city AS City, co.country AS Country
from sakila.store s 
join sakila.address a on s.address_id = a.address_id
join sakila.city c on a.city_id = c.city_id
join sakila.country co on c.country_id = co.country_id;

-- 2. Write a query to display how much business, in dollars, each store brought in.

select s.store_id AS Store, SUM(c.amount) AS Total_Income
from sakila.store s 
join sakila.staff a on s.store_id = a.store_id
join sakila.payment c on a.staff_id = c.staff_id
GROUP BY Store;

-- 3. What is the average running time of films by category?

select c.name AS Category, AVG(f.length) AS AVG_Duration
from sakila.category c 
join sakila.film_category fc on c.category_id = fc.category_id
join sakila.film f on f.film_id = fc.film_id
GROUP BY Category;

-- 4. Which film categories are longest?

select c.name AS Category, COUNT(f.film_id) AS Films
from sakila.category c 
join sakila.film_category fc on c.category_id = fc.category_id
join sakila.film f on f.film_id = fc.film_id
GROUP BY Category
ORDER BY Films DESC;

-- 5. Display the most frequently rented movies in descending order.

SELECT f.title AS Movie_Title, COUNT(*) AS Rental_Count
FROM sakila.film f
JOIN sakila.inventory i ON f.film_id = i.film_id
JOIN sakila.rental r ON i.inventory_id = r.inventory_id
GROUP BY Movie_Title
ORDER BY Rental_Count DESC;


-- 6. List the top five genres in gross revenue in descending order.


SELECT c.name AS Category, SUM(p.amount) AS Gross_Revenue
FROM sakila.category c
JOIN sakila.film_category fc ON c.category_id = fc.category_id
JOIN sakila.film f ON fc.film_id = f.film_id
JOIN sakila.inventory i ON f.film_id = i.film_id
JOIN sakila.rental r ON i.inventory_id = r.inventory_id
JOIN sakila.payment p ON r.rental_id = p.rental_id
GROUP BY Category
ORDER BY Gross_Revenue DESC
LIMIT 5;


-- 7. Is "Academy Dinosaur" available for rent from Store 1?

SELECT f.title AS Movie_Title, s.store_id AS Store_ID, i.inventory_id AS Inventory_ID
FROM sakila.film f
JOIN sakila.inventory i ON f.film_id = i.film_id
JOIN sakila.store s ON i.store_id = s.store_id
WHERE f.title = 'Academy Dinosaur' AND s.store_id = 1;
