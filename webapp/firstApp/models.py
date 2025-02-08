from django.db import models

# Create your models here.

class aissms(models.Model):
    age = models.IntegerField()
    sex = models.IntegerField(max_length=10)
    bmi = models.FloatField()
    children = models.IntegerField()
    smoker = models.IntegerField(max_length=10)
    region = models.IntegerField(max_length=20)
    charges = models.FloatField()
