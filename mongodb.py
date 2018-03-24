import pymongo
import private

from pymongo import MongoClient
from bson.objectid import ObjectId
client = MongoClient("mongodb://{u}:{p}@ds121238.mlab.com:21238/cloudapps".format(u=private.mongo_user, p = private.mongo_password))

db = client.cloudapps
current_foods = db.midterm

def get_foods():
    foods = list(current_foods.find())
    for food in foods:
        food['_id'] = str(food['_id'])
    return foods

# def get_foods_by_status(status):
#     foods = list(current_foods.find({"status":status}))
#     for food in foods:
#         food['_id'] = str(food['_id'])
#     return foods

def get_food(food_id):
    # Convert from string to ObjectId:
    object_id = ObjectId(food_id)
    food = current_foods.find_one({'_id': object_id})
    food['_id'] = str(food['_id'])
    return food

def save_food(food):
    food_id = current_foods.insert_one(food).inserted_id
    return str(food_id)

def delete_food(food_id):
    object_id = ObjectId(food_id)
    food = current_foods.delete_one({'_id': object_id})    

def update_food(food_id, food=None, amount=None, calorie=None):
    if food:
        update = {'$set':{'food':food}}
        object_id = ObjectId(food_id)
        current_foods.update_one({'_id': object_id}, update)    
    if amount:
        update = {'$set':{'amount':amount}}
        object_id = ObjectId(food_id)
        current_foods.update_one({'_id': object_id}, update) 
    if calorie:
        update = {'$set':{'calorie':calorie}}
        object_id = ObjectId(food_id)
        current_foods.update_one({'_id': object_id}, update)    


