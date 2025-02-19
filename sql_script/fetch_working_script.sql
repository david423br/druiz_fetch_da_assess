-- ## Data exploration and assessment completed in Python, you can find the exploratory notebook in Github HERE -> https://github.com/david423br/druiz_fetch_da_assess/tree/main/notebook

-- ## Created 'products' table

-- CREATE TABLE public.products
-- (
--     category_1 CHARACTER VARYING,
--     category_2 CHARACTER VARYING,
--     category_3 CHARACTER VARYING,
--     category_4 CHARACTER VARYING,
--     manufacturer CHARACTER VARYING,
--     brand CHARACTER VARYING,
--     barcode CHARACTER VARYING
-- );

-- ALTER TABLE IF EXISTS public.products
--     OWNER to postgres;

-- ## Created 'transaction' table

-- CREATE TABLE public.transaction
-- (
--     receipt_id CHARACTER VARYING,
--     purchase_date DATE,
--     scan_date TIMESTAMP with TIME ZONE,
--     store_name CHARACTER VARYING,
--     barcode CHARACTER VARYING,
--     final_quantity CHARACTER VARYING,
--     final_sale CHARACTER VARYING
-- );

-- ALTER TABLE IF EXISTS public.transaction
--     OWNER to postgres;

-- ## Created 'user' table

-- CREATE TABLE public.user
-- (
--     id CHARACTER VARYING,
--     created_date TIMESTAMP with TIME ZONE,
--     birth_date TIMESTAMP with TIME ZONE,
--     state CHARACTER VARYING,
--     language CHARACTER VARYING,
--     gender CHARACTER VARYING
-- );

-- ALTER TABLE IF EXISTS public.user
--     OWNER to postgres;

-- 1a. Closed-ended: What are the top 5 brands by receipts scanned among users 21 and over?

SELECT brand, COUNT(DISTINCT receipt_id) AS dist_rcpt_cnt
FROM transaction AS t
FULL JOIN public.user AS u
	ON t.user_id = u.id
LEFT JOIN products AS p
	ON t.barcode = p.barcode
WHERE birth_date::DATE <= now()::DATE - INTERVAL '21 years'
	AND scan_date IS NOT NULL
	AND brand IS NOT NULL
GROUP BY brand
ORDER BY dist_rcpt_cnt DESC
LIMIT 5;

-- 2a. Closed-ended: What are the top 5 brands by sales among users that have had their account for at least six months?

SELECT brand, SUM(NULLIF(final_sale, ' ')::numeric) AS sum_final_sale
FROM transaction AS t
FULL JOIN public.user AS u
	ON t.user_id = u.id
LEFT JOIN products AS p
	ON t.barcode = p.barcode
WHERE created_date::DATE <= now()::DATE - INTERVAL '6 months'
	AND brand IS NOT NULL
	AND final_quantity != 'zero'
	AND final_sale != ' '
GROUP BY brand
ORDER BY sum_final_sale DESC
LIMIT 5;

-- 1b. Open-ended: Who are Fetch’s power users?

-- ## First approach, top 10 based on sum_total_sale. Decided to pivot to account_duration.

-- ## Second approach, top 10 based on account_duration. Decided to pivot to distinct receipt count.

-- ## Third and final approach, top 10 based on distinct receipt count but also included sum_total_sale and account_duration. I found it interesting that power users under this distinction weren't among the top spenders, but all have had accounts for 1-5 years.

SELECT u.id AS user_id, COUNT(DISTINCT receipt_id) AS dist_rcpt_cnt, SUM(NULLIF(final_sale, ' ')::numeric) AS sum_total_sale, NOW() - created_date::DATE AS account_duration
FROM transaction AS t
FULL JOIN public.user AS u
	ON t.user_id = u.id
LEFT JOIN products AS p
	ON t.barcode = p.barcode
WHERE final_quantity != 'zero'
	AND final_sale != ' '
	AND u.id IS NOT NULL
GROUP BY u.id
ORDER BY dist_rcpt_cnt DESC
LIMIT 10;

-- 2b. Open-ended: Which is the leading brand in the Dips & Salsa category?

-- ## Whether ordered by 'sum_total_quantity' or 'sum_total_sale' TOSTITOS is the leading brand

SELECT brand, SUM(NULLIF(final_quantity, 'zero')::numeric) AS sum_total_quantity, SUM(NULLIF(final_sale, ' ')::numeric) AS sum_total_sale
FROM transaction AS t
LEFT JOIN products AS p
	ON t.barcode = p.barcode
WHERE brand IS NOT NULL
	AND category_1 = 'Dips & Salsa'
		OR category_2 = 'Dips & Salsa'
		OR category_3 = 'Dips & Salsa'
		OR category_4 = 'Dips & Salsa'
	AND final_quantity != 'zero'
	AND final_sale != ' '
GROUP BY brand
ORDER BY sum_total_quantity DESC
LIMIT 1;