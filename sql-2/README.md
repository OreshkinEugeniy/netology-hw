# Домашнее задание к занятию "`Расширенные возможности SQL`" - `Орешкин Евгений`


### Задание 1
Одним запросом получите информацию о магазине, в котором обслуживается более 300 покупателей, и выведите в результат следующую информацию:

фамилия и имя сотрудника из этого магазина;
город нахождения магазина;
количество пользователей, закреплённых в этом магазине.

SELECT
    CONCAT(st.first_name, ' ', st.last_name) AS employee,
    ci.city,
    COUNT(c.customer_id) AS customer_count
FROM store s
JOIN staff st
    ON st.staff_id = s.manager_staff_id
JOIN address a
    ON a.address_id = s.address_id
JOIN city ci
    ON ci.city_id = a.city_id
JOIN customer c
    ON c.store_id = s.store_id
GROUP BY
    s.store_id,
    st.staff_id,
    st.first_name,
    st.last_name,
    ci.city
HAVING COUNT(c.customer_id) > 300;

### Задание 2


Получите количество фильмов, продолжительность которых больше средней продолжительности всех фильмов.

SELECT
    COUNT(*) AS film_count
FROM film
WHERE length > (
    SELECT AVG(length)
    FROM film
);
### Задание 3

Получите информацию, за какой месяц была получена наибольшая сумма платежей, и добавьте информацию по количеству аренд за этот месяц.

WITH monthly_payments AS (
    SELECT
        DATE_FORMAT(payment_date, '%Y-%m') AS payment_month,
        SUM(amount) AS payment_sum
    FROM payment
    GROUP BY DATE_FORMAT(payment_date, '%Y-%m')
),
monthly_rentals AS (
    SELECT
        DATE_FORMAT(rental_date, '%Y-%m') AS rental_month,
        COUNT(*) AS rental_count
    FROM rental
    GROUP BY DATE_FORMAT(rental_date, '%Y-%m')
)
SELECT
    mp.payment_month,
    mp.payment_sum,
    mr.rental_count
FROM monthly_payments mp
JOIN monthly_rentals mr
    ON mr.rental_month = mp.payment_month
ORDER BY mp.payment_sum DESC
LIMIT 1;
