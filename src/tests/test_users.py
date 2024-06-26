import time
from functools import wraps

import pytest


def timeit(duration):
    def wrapper(method):
        @wraps(method)
        async def timed(*args, **kwargs):
            # прогрев
            ts = time.time()
            result = await method(*args, **kwargs)
            te = time.time()
            execute_time = int((te - ts) * 1000)
            assert execute_time < duration

            return result

        return timed

    return wrapper


# def test():
#     """Показывает время выполнения без SQL запросов"""
#     assert True is True

@timeit(duration=20)
async def test_async():
    """Показывает время выполнения без SQL запросов"""
    assert True is True


@pytest.mark.parametrize(
    "search",
    ("Josh", "Иван", "Dunin", "NotFoundValue"),
)
@timeit(duration=20)
async def test_v1(user, search):
    response = await user.get(f"/v1/users/?search={search}")
    assert response.status_code == 200, response.status_code


@pytest.mark.parametrize(
    "search",
    ("Josh", "Ivan", "Dunin", "NotFoundValue"),
)
@timeit(duration=150)
async def test_v2(user, search):
    response = await user.get(f"/v2/users/?search={search}")
    assert response.status_code == 200, response.status_code


@pytest.mark.parametrize(
    "search",
    ("Иван", "Сергеевич", "Иванова"),
)
@timeit(duration=150)
async def test_v2_ru(user, search):
    response = await user.get(f"/v2/users/?search={search}")
    assert response.status_code == 200, response.status_code
