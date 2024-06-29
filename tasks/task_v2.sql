-- ### Задание-2: Ускорение поиска

-- ```sql

DROP INDEX IF EXISTS idx_users_user_upper_first_name_like_varchar;
DROP INDEX IF EXISTS idx_users_user_upper_last_name_like_varchar;
DROP INDEX IF EXISTS idx_users_user_upper_email_like_varchar;


CREATE INDEX idx_users_user_upper_first_name_like_varchar ON public.users_user (UPPER(first_name) varchar_pattern_ops);
CREATE INDEX idx_users_user_upper_last_name_like_varchar ON public.users_user (UPPER(last_name) varchar_pattern_ops ASC);
CREATE INDEX idx_users_user_upper_email_like_varchar ON public.users_user (UPPER(email) varchar_pattern_ops);


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
--         UPPER("users_user"."first_name") LIKE UPPER('%John%') 
--         OR UPPER("users_user"."last_name") LIKE UPPER('%John%') 
--         OR UPPER("users_user"."email") LIKE UPPER('%John%')
--     ) 
-- ORDER BY 
--     "users_user"."last_name" ASC;

-- ```

-- **Подсказки:**

-- - Использование функций, таких как `UPPER()`, в условиях фильтрации может мешать использованию индексов.
-- - Преобразование типов, такое как `::text`, также может негативно сказываться на производительности.
-- - Подумайте о создании функциональных индексов, если использование функций неизбежно.

-- **Дополнительные материалы:**

-- - Документация PostgreSQL по индексам: https://www.postgresql.org/docs/current/indexes.html
