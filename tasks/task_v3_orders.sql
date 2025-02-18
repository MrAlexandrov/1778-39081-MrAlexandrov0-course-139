-- #### Задание-3: Оптимизация индексов в SQL

-- ```sql

DROP INDEX IF EXISTS idx_orders_status;
-- DROP INDEX IF EXISTS idx_orders_order_date_asc;

-- DROP INDEX IF EXISTS idx_orders_status_order_date;

CREATE INDEX idx_orders_status ON public.orders (status);
-- CREATE INDEX idx_orders_order_date_asc ON public.orders (order_date ASC);

-- CREATE INDEX idx_orders_status_order_date ON public.orders (status, order_date ASC);

-- EXPLAIN ANALYZE
-- SELECT
--     order_id,
--     customer_id,
--     order_date,
--     total_amount,
--     status,
--     shipping_address,
--     billing_address
-- FROM
--     orders
-- WHERE
--     status = 'Pending'
-- ORDER BY
--     order_date;

-- ```

-- #### Подсказки:
-- - Обратите внимание на использование индексов для условий фильтрации и сортировки.
-- - Составные индексы могут быть полезны, если запрос использует несколько столбцов в условиях фильтрации и сортировки.
-- - Убедитесь, что новые индексы не создадут значительных накладных расходов на вставку и обновление данных в таблице.


-- #### Дополнительные материалы:
-- - Документация PostgreSQL по индексам: https://www.postgresql.org/docs/current/indexes.html
