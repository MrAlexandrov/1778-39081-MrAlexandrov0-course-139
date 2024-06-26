from enum import Enum

from tortoise import fields, models


class Company(models.Model):
    class Meta:
        table = "users_company"

    id = fields.IntField(pk=True)
    title = fields.CharField(max_length=200)
    address = fields.CharField(max_length=200)

    def __str__(self) -> str:
        return f"<{self.id}: {self.title}>"


class Job(models.Model):
    class Meta:
        table = "users_job"

    id = fields.IntField(pk=True)
    title = fields.CharField(max_length=200)

    def __str__(self) -> str:
        return f"<{self.id}: {self.title}>"


class User(models.Model):
    class Meta:
        table = "users_user"

    id = fields.IntField(pk=True)
    first_name = fields.CharField(max_length=200)
    second_name = fields.CharField(max_length=200)
    last_name = fields.CharField(max_length=200)
    email = fields.CharField(max_length=200)
    address = fields.CharField(max_length=300)
    phone_number = fields.CharField(max_length=40)
    company = fields.ForeignKeyField(
        "models.Company",
        on_delete=fields.RESTRICT,
        related_name="users",
    )
    job = fields.ForeignKeyField(
        "models.Job",
        on_delete=fields.RESTRICT,
        related_name="+",
    )

    def __str__(self) -> str:
        return f"<{self.id}: {self.last_name} {self.first_name} {self.second_name}>"


# class Seller(models.Model):
#     class Meta:
#         table = "users_company"

#     id = fields.IntField(pk=True)
#     title = fields.CharField(max_length=200)

#     def __str__(self) -> str:
#         return f"<{self.id}: {self.title}>"


# class SellersItem(models.Model):
#     id = fields.UUIDField(pk=True)
#     price = fields.DecimalField(max_digits=10, decimal_places=2)
#     currency = fields.CharField(max_length=10)
#     count = fields.IntField()
#     seller = fields.ForeignKeyField(
#         "models.Seller",
#         on_delete=fields.RESTRICT,
#         related_name="sellers_items",
#     )
#     item = fields.ForeignKeyField(
#         "models.Item",
#         on_delete=fields.RESTRICT,
#         related_name="sellers_items",
#     )


# class OrderStatus(str, Enum):
#     NEW = "NEW"
#     CANCELLED = "CANCELLED"


# class Order(models.Model):
#     id = fields.UUIDField(pk=True)
#     status = fields.CharEnumField(OrderStatus, default=OrderStatus.NEW)
#     seller = fields.ForeignKeyField(
#         "models.Seller",
#         on_delete=fields.RESTRICT,
#         related_name="orders",
#     )
#     item = fields.ForeignKeyField(
#         "models.Item",
#         on_delete=fields.RESTRICT,
#         related_name="orders",
#     )


# class Payment(models.Model):
#     id = fields.UUIDField(pk=True)
#     order = fields.ForeignKeyField(
#         "models.Order",
#         on_delete=fields.RESTRICT,
#         related_name="payments",
#     )


# class Item(models.Model):
#     id = fields.UUIDField(pk=True)
#     description = fields.TextField()

#     def __str__(self) -> str:
#         return f"<{self.id}: {self.description}>"
