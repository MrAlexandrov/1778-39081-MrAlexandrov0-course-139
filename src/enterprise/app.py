from fastapi import FastAPI, HTTPException, Path, Query
from fastapi.responses import HTMLResponse
from tortoise import functions
from tortoise.expressions import Q

import models
from serializers import (
    CompanySerializer,
    ItemSerializer,
    JobSerializer,
    OrderSerializer,
    PaymentSerializer,
    UserSerializer,
)

app = FastAPI()


@app.get("/")
async def home_view():
    return HTMLResponse("<h1>Hello Student!</h1>")


@app.get("/v1/users", response_model=list[UserSerializer])
async def list_users_v1(search: str | None = Query(None)):
    query = models.User.all()

    if search:
        query = query.filter(
            (
                Q(id=search)
                | Q(first_name__istartswith=search)
                | Q(last_name__istartswith=search)
            )
        )

    return await UserSerializer.from_queryset(query)


@app.get("/v2/users", response_model=list[UserSerializer])
async def list_users_v2(search: str | None = Query(None)):
    query = models.User.all().order_by("last_name")

    if search:
        query = query.filter(
            Q(id=search)
            | Q(first_name__icontains=search)
            | Q(last_name__icontains=search)
            | Q(phone_number__istartswith=search)
            | Q(email__icontains=search)
        )

    return await UserSerializer.from_queryset(query)


@app.get("/companies", response_model=list[JobSerializer])
async def list_companies(search: str | None = Query(None)):
    query = models.Company.all()

    if search:
        query = query.filter(
            Q(id=search) | Q(title__istartswith=search) | Q(address__icontains=search)
        )

    return await CompanySerializer.from_queryset(query)


@app.get("/jobs", response_model=list[JobSerializer])
async def list_jobs(search: str | None = Query(None)):
    query = models.Job.all()

    if search:
        query = query.filter(Q(id=search) | Q(title__istartswith=search))

    return await JobSerializer.from_queryset(query)


@app.get("/orders", response_model=list[OrderSerializer])
async def list_orders(status: models.OrderStatus | None = Query(None)):
    if status:
        orders = await models.Order.filter(status=status).all()
    else:
        orders = await models.Order.all()
    return await OrderSerializer.from_queryset(orders)


@app.get("/payments", response_model=list[PaymentSerializer])
async def list_payments(order_id: str | None = Query(None)):
    payments = await models.Payment.filter(order_id=order_id).all()
    return await PaymentSerializer.from_queryset(payments)


@app.get("/items", response_model=list[ItemSerializer])
async def list_items(q: str | None = Query(None)):
    items = await models.Item.filter(description__icontains=q).all()
    return await ItemSerializer.from_queryset(items)


@app.get("/prices", response_model=dict)
async def list_prices(q: str | None = Query(None)):
    prices = await models.SellersItem.filter(item__title=q).aggregate(
        max_price=functions.Max("price"), min_price=functions.Min("price")
    )
    return {
        "title": q,
        "max_price": prices["max_price"],
        "min_price": prices["min_price"],
    }


@app.post("/orders", response_model=OrderSerializer)
async def create_order(order: OrderSerializer):
    sellers_item = await models.SellersItem.get_or_none(
        item_id=order.item_id, seller_id=order.seller_id
    )
    if not sellers_item or sellers_item.count <= 0:
        raise HTTPException(status_code=400, detail="Item is not available")

    sellers_item.count -= 1
    await sellers_item.save()

    new_order = await models.Order.create(**order.dict())

    return await OrderSerializer.from_tortoise_orm(new_order)


@app.delete("/orders/{order_id}", response_model=OrderSerializer)
async def cancel_order(order_id: str | None = Path()):
    order = await models.Order.get_or_none(id=order_id)
    if not order:
        raise HTTPException(status_code=404, detail="Order not found")

    sellers_item = await models.SellersItem.get_or_none(
        item_id=order.item_id, seller_id=order.seller_id
    )
    if sellers_item:
        sellers_item.count += 1
        await sellers_item.save()

    order.status = models.OrderStatus.CANCELLED
    await order.save()

    return await OrderSerializer.from_tortoise_orm(order)
