import logging

logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s - %(name)s - %(levelname)s - %(message)s",
)
logger = logging.getLogger(__name__)

# Логирование SQL запросов
sql_logger = logging.getLogger("tortoise.db_client")
sql_logger.setLevel(logging.DEBUG)
