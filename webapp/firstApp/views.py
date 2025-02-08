from django.shortcuts import render
import yaml, os, json
import joblib
import psycopg2
from .models import aissms


def index(request):
    return render(request, 'index.html')


def result(request):
    cls = joblib.load("../models/model.joblib")
    lst = []
# Convert input values to float (or int where applicable)
    lst = [
        int(request.GET.get('age')),        # Age as integer
        int(request.GET.get('sex')),        # 0 or 1 (int)
        float(request.GET.get('bmi')),      # BMI as float
        int(request.GET.get('children')),   # Number of children as int
        int(request.GET.get('smoker')),     # 0 or 1 (int)
        int(request.GET.get('region'))      # 0, 1, 2, or 3 (int)
    ]
    
    answer = cls.predict([lst])
    
    b = aissms(
        age=int(request.GET['age']),
        sex=int(request.GET['sex']),
        bmi=int(request.GET['bmi']),
        children=int(request.GET['children']),
        smoker=int(request.GET['smoker']),
        region=int(request.GET['region']),
        charges=answer[0]
    )

    b.save()

    return render(request, 'index.html', {'answer': answer[0]})