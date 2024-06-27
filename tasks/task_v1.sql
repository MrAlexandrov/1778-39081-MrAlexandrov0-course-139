-- ### Задание-1: Ускорение поиска

-- ```sql
-- SELECT 
--     "users_user"."id", 
--     "users_user"."first_name", 
--     "users_user"."second_name", 
--     "users_user"."last_name", 
--     "users_user"."email", 
--     "users_user"."address", 
--     "users_user"."phone_number", 
--     "users_user"."company_id", 
--     "users_user"."job_id" 
-- FROM 
--     "users_user" 
-- WHERE 
--     (UPPER("users_user"."id"::text) = UPPER('John') 
--     OR UPPER("users_user"."first_name"::text) LIKE UPPER('John%') 
--     OR UPPER("users_user"."last_name"::text) LIKE UPPER('John%'));
-- ```

-- #### Задача:

-- 1. **Анализ запроса:**
--    - Объясните, какие данные извлекает данный запрос и какие условия фильтрации применяются.
--    - Определите потенциальные проблемы с производительностью данного запроса.

-- 2. **Оптимизация запроса:**
--    - Предложите возможные индексы для ускорения выполнения данного запроса.

-- 3. **Тестирование производительности:**
--    - Сравните производительность запросов с различными индексами.

-- **Подсказки:**

-- - Использование функций, таких как `UPPER()`, в условиях фильтрации может мешать использованию индексов.
-- - Преобразование типов, такое как `::text`, также может негативно сказываться на производительности.
-- - Подумайте о создании функциональных индексов, если использование функций неизбежно.


-- **Дополнительные материалы:**

-- - Документация PostgreSQL по индексам: https://www.postgresql.org/docs/current/indexes.html

CREATE INDEX IF NOT EXISTS users_user_id ON users_user (UPPER(id::text));
CREATE INDEX IF NOT EXISTS users_user_names ON users_user (UPPER(first_name::text) varchar_pattern_ops, UPPER(last_name::text) varchar_pattern_ops);
CREATE INDEX IF NOT EXISTS users_user_firstname ON users_user (UPPER(first_name::text) varchar_pattern_ops);
CREATE INDEX IF NOT EXISTS users_user_lastname ON users_user (UPPER(last_name::text) varchar_pattern_ops);

CREATE INDEX IF NOT EXISTS users_user_id_btree_idx ON users_user USING btree (id);
CREATE INDEX IF NOT EXISTS users_user_firstname_gin_idx ON users_user USING gin (UPPER(first_name) gin_trgm_ops);
CREATE INDEX IF NOT EXISTS users_user_lastname_gin_idx ON users_user USING gin (UPPER(last_name) gin_trgm_ops);
CREATE INDEX IF NOT EXISTS users_user_phone_gin_idx ON users_user USING gin (UPPER(phone_number) gin_trgm_ops);
CREATE INDEX IF NOT EXISTS users_user_email_gin_idx ON users_user USING gin (UPPER(email) gin_trgm_ops);

CREATE INDEX IF NOT EXISTS orders_status_pending_order_date_idx
ON orders (status, order_date)
WHERE status = 'Pending';
