from tortoise.contrib.pydantic import pydantic_model_creator

from enterprise import models

UserSerializer = pydantic_model_creator(models.User)
CompanySerializer = pydantic_model_creator(models.Company)
JobSerializer = pydantic_model_creator(models.Job)
# OrderSerializer = pydantic_model_creator(models.Order)
# PaymentSerializer = pydantic_model_creator(models.Payment)
# ItemSerializer = pydantic_model_creator(models.Item)
