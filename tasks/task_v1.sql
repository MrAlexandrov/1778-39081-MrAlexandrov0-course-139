-- ### Задание-1: Ускорение поиска

-- ```sql

DROP INDEX IF EXISTS idx_users_user_upper_id_text_like;
DROP INDEX IF EXISTS idx_users_user_upper_first_name_text_like;
DROP INDEX IF EXISTS idx_users_user_upper_last_name_text_like;


CREATE INDEX idx_users_user_upper_id_text_like on public.users_user (UPPER(id::text) text_pattern_ops);
CREATE INDEX idx_users_user_upper_first_name_text_like ON public.users_user (UPPER(first_name::text) text_pattern_ops);
CREATE INDEX idx_users_user_upper_last_name_text_like ON public.users_user (UPPER(last_name::text) text_pattern_ops);


-- EXPLAIN ANALYZE
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
--     (
--         UPPER("users_user"."id"::text) = UPPER('John') 
--         OR UPPER("users_user"."first_name"::text) LIKE UPPER('John%') 
--         OR UPPER("users_user"."last_name"::text) LIKE UPPER('John%')
--     );


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
