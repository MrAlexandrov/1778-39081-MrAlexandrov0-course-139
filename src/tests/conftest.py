import json
import os

import pytest
from httpx import AsyncClient
from tortoise import Tortoise
from tortoise.contrib.test import finalizer, initializer

from enterprise.app import app

DATABASE_NAME = os.getenv("DATABASE_NAME", "homework")
DATABASE_USER = os.getenv("DATABASE_USER", "user")
DATABASE_PASSWORD = os.getenv("DATABASE_PASSWORD", "random")
DATABASE_HOST = os.getenv("DATABASE_HOST", "store")
DATABASE_PORT = os.getenv("DATABASE_PORT", "5432")

DATABASE_URL = f"postgres://{DATABASE_USER}:{DATABASE_PASSWORD}@{DATABASE_HOST}:{DATABASE_PORT}/{DATABASE_NAME}"

successful_tests = []


@pytest.fixture(scope="session", autouse=True)
def test_db():
    initializer(["enterprise.models"], db_url=DATABASE_URL)
    yield
    finalizer()


@pytest.fixture
async def user(test_db):
    async with AsyncClient(app=app, base_url="http://test") as ac:
        yield ac


@pytest.fixture(scope="session", autouse=True)
async def read_indexes():
    solutions = (
        # проверяем 1е два решения
        "../solution/task_v1.sql",
        "../solution/task_v2.sql",
        # вдруг есть один файл с решениями
        "../solution/solution.sql",
    )

    conn = Tortoise.get_connection("default")
    for file in solutions:
        try:
            with open(file) as sql:
                raw_sql = sql.read()
                if raw_sql:
                    await conn.execute_script(raw_sql)
        except Exception as e:
            print(e)
    await conn.execute_query("SELECT pg_stat_reset();")


def pytest_runtest_logreport(report):
    if report.when == "call" and report.passed:
        successful_tests.append(report.nodeid)


@pytest.fixture(scope="session", autouse=True)
def send_report(request):
    def _send_report():
        with open("../score.json", "w") as f:
            json.dump({"score": len(successful_tests)}, f)

    request.addfinalizer(_send_report)
