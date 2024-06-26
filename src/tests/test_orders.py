
# import random
# from dataclasses import dataclass
# from uuid import UUID

# from enterprise import models


# @dataclass
# class SellersItem:
#     item_id: UUID
#     seller_id: UUID
#     count: int


# async def _test_create_and_delete_orders(user):
#     sellers_items = []

#     for i in range(3):
#         seller = await models.Seller.create(
#             title=f"Test seller {i + 1}",
#             description=f"Test seller {i + 1}",
#         )
#         item = await models.Item.create(
#             title=f"Test item {i + 1}",
#             description=f"Test item {i + 1}",
#         )
#         sellers_item = await models.SellersItem.create(
#             item_id=item.id,
#             seller_id=seller.id,
#             count=3,
#         )
#         sellers_items.append(SellersItem(item_id=item.id, seller_id=seller.id, count=3))

#     order_ids = []
#     for _ in range(1000):
#         for _ in range(random.randint(5)):
#             sellers_item = random.choice(sellers_items)
#             order_data = {
#                 "item_id": sellers_item.item_id,
#                 "seller_id": sellers_item.seller_id,
#             }
#             response = await user.post("/orders", json=order_data)
#             if sellers_item.count > 0:
#                 assert response.status_code == 200
#                 created_order = response.json()
#                 assert created_order["item_id"] == str(item.id)
#                 assert created_order["seller_id"] == str(seller.id)
#                 assert created_order["status"] == "NEW"
#                 order_ids.append(created_order["id"])
#                 sellers_item.count -= 1
#             else:
#                 assert response.status_code == 200

#         for _ in range(random.randint(5)):
#             order_id = order_ids.pop(random.randrange(len(order_ids)))
#             response = await user.delete(f"/orders/{order_id}")
#             assert response.status_code == 200
#             deleted_order = response.json()
#             assert deleted_order["item_id"] == str(item.id)
#             assert deleted_order["seller_id"] == str(seller.id)
#             assert deleted_order["status"] == "CANCELLED"
