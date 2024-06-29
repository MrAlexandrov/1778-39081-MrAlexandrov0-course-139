-- ### Задание-2: Ускорение поиска

-- ```sql

-- DROP INDEX IF EXISTS idx_users_user_upper_id_text_like;
-- DROP INDEX IF EXISTS idx_users_user_upper_first_name_text_like;
-- DROP INDEX IF EXISTS idx_users_user_upper_last_name_text_like;
-- DROP INDEX IF EXISTS idx_users_user_upper_phone_number_text_like;
-- DROP INDEX IF EXISTS idx_users_user_upper_email_text_like;
-- DROP INDEX IF EXISTS idx_users_user_last_name;

-- DROP INDEX IF EXISTS idx_users_user_upper_id_varchar_like;
-- DROP INDEX IF EXISTS idx_users_user_upper_first_name_varchar_like;
-- DROP INDEX IF EXISTS idx_users_user_upper_last_name_varchar_like;
-- DROP INDEX IF EXISTS idx_users_user_upper_phone_number_varchar_like;
-- DROP INDEX IF EXISTS idx_users_user_upper_email_varchar_like;

-- DROP INDEX IF EXISTS idx_users_user_upper_id_first_name_last_name_phone_number_email_like;

-- DROP INDEX IF EXISTS idx_users_user_upper_id_first_name_last_name_phone_number_email_text_like;

-- DROP INDEX IF EXISTS idx_users_user_upper_id_first_name_last_name_phone_number_email_varchar_like;

-- DROP INDEX IF EXISTS idx_users_user_last_name;

-- DROP INDEX IF EXISTS idx_users_user_upper_id;
-- DROP INDEX IF EXISTS idx_users_user_upper_first_name;
-- DROP INDEX IF EXISTS idx_users_user_upper_last_name;
-- DROP INDEX IF EXISTS idx_users_user_upper_phone_number;
-- DROP INDEX IF EXISTS idx_users_user_upper_email;

-- DROP INDEX IF EXISTS idx_users_user_upper_id_gist;
-- DROP INDEX IF EXISTS idx_users_user_upper_first_name_gist;
-- DROP INDEX IF EXISTS idx_users_user_upper_last_name_gist;
-- DROP INDEX IF EXISTS idx_users_user_upper_phone_number_gist;
-- DROP INDEX IF EXISTS idx_users_user_upper_email_gist;

DROP INDEX IF EXISTS idx_users_user_upper_id_gin;
DROP INDEX IF EXISTS idx_users_user_upper_first_name_gin;
DROP INDEX IF EXISTS idx_users_user_upper_last_name_gin;
DROP INDEX IF EXISTS idx_users_user_upper_phone_number_gin;
DROP INDEX IF EXISTS idx_users_user_upper_email_gin;

-- CREATE INDEX idx_users_user_upper_id_text_like ON public.users_user (UPPER(id::text) text_pattern_ops);
-- CREATE INDEX idx_users_user_upper_first_name_text_like ON public.users_user (UPPER(first_name::text) text_pattern_ops);
-- CREATE INDEX idx_users_user_upper_last_name_text_like ON public.users_user (UPPER(last_name::text) text_pattern_ops);
-- CREATE INDEX idx_users_user_upper_phone_number_text_like ON public.users_user (UPPER(phone_number::text) text_pattern_ops);
-- CREATE INDEX idx_users_user_upper_email_text_like ON public.users_user (UPPER(email::text) text_pattern_ops);
-- CREATE INDEX idx_users_user_last_name ON users_user (last_name ASC);


-- CREATE INDEX idx_users_user_upper_id_varchar_like ON public.users_user (UPPER(id::text) varchar_pattern_ops);
-- CREATE INDEX idx_users_user_upper_first_name_varchar_like ON public.users_user (UPPER(first_name::text) varchar_pattern_ops);
-- CREATE INDEX idx_users_user_upper_last_name_varchar_like ON public.users_user (UPPER(last_name::text) varchar_pattern_ops);
-- CREATE INDEX idx_users_user_upper_phone_number_varchar_like ON public.users_user (UPPER(phone_number::text) varchar_pattern_ops);
-- CREATE INDEX idx_users_user_upper_email_varchar_like ON public.users_user (UPPER(email::text) varchar_pattern_ops);

-- CREATE INDEX idx_users_user_upper_id_first_name_last_name_phone_number_email_like ON public.users_user (UPPER(id::text), UPPER(first_name::text), UPPER(last_name::text), UPPER(phone_number::text), UPPER(email::text));

-- CREATE INDEX idx_users_user_upper_id_first_name_last_name_phone_number_email_text_like ON public.users_user (UPPER(id::text) text_pattern_ops, UPPER(first_name::text) text_pattern_ops, UPPER(last_name::text) text_pattern_ops, UPPER(phone_number::text) text_pattern_ops, UPPER(email::text) text_pattern_ops);

-- CREATE INDEX idx_users_user_upper_id_first_name_last_name_phone_number_email_varchar_like ON public.users_user (UPPER(id::text) varchar_pattern_ops, UPPER(first_name::text) varchar_pattern_ops, UPPER(last_name::text) varchar_pattern_ops, UPPER(phone_number::text) varchar_pattern_ops, UPPER(email::text) varchar_pattern_ops);

-- CREATE INDEX idx_users_user_last_name ON public.users_user (last_name ASC);

-- CREATE INDEX idx_users_user_upper_id ON public.users_user (UPPER(id::text));
-- CREATE INDEX idx_users_user_upper_first_name ON public.users_user (UPPER(first_name::text));
-- CREATE INDEX idx_users_user_upper_last_name ON public.users_user (UPPER(last_name::text));
-- CREATE INDEX idx_users_user_upper_phone_number ON public.users_user (UPPER(phone_number::text));
-- CREATE INDEX idx_users_user_upper_email ON public.users_user (UPPER(email::text));

CREATE EXTENSION IF NOT EXISTS pg_trgm;

-- CREATE INDEX idx_users_user_upper_id_gist ON public.users_user USING gist (UPPER(id::text) gist_trgm_ops);
-- CREATE INDEX idx_users_user_upper_first_name_gist ON public.users_user USING gist (UPPER(first_name::text) gist_trgm_ops);
-- CREATE INDEX idx_users_user_upper_last_name_gist ON public.users_user USING gist (UPPER(last_name::text) gist_trgm_ops);
-- CREATE INDEX idx_users_user_upper_phone_number_gist ON public.users_user USING gist (UPPER(phone_number::text) gist_trgm_ops);
-- CREATE INDEX idx_users_user_upper_email_gist ON public.users_user USING gist (UPPER(email::text) gist_trgm_ops);

CREATE INDEX idx_users_user_upper_id_gin ON public.users_user USING gin (UPPER(id::text) gin_trgm_ops);
CREATE INDEX idx_users_user_upper_first_name_gin ON public.users_user USING gin (UPPER(first_name::text) gin_trgm_ops);
CREATE INDEX idx_users_user_upper_last_name_gin ON public.users_user USING gin (UPPER(last_name::text) gin_trgm_ops);
CREATE INDEX idx_users_user_upper_phone_number_gin ON public.users_user USING gin (UPPER(phone_number::text) gin_trgm_ops);
CREATE INDEX idx_users_user_upper_email_gin ON public.users_user USING gin (UPPER(email::text) gin_trgm_ops);



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
--         OR UPPER("users_user"."first_name"::text) LIKE UPPER('%John%') 
--         OR UPPER("users_user"."last_name"::text) LIKE UPPER('%John%') 
--         OR UPPER("users_user"."phone_number"::text) LIKE UPPER('John%') 
--         OR UPPER("users_user"."email"::text) LIKE UPPER('%John%')
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
