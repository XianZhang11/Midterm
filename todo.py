import warnings

with warnings.catch_warnings():
    warnings.filterwarnings("ignore",category=DeprecationWarning)
    from bottle import get, post, run, debug, default_app, request, template, static_file 

import mongodb 

@get('/')
def get_food_list():
   
    foods = mongodb.get_foods()
    output = template('food_list.tpl', foods=foods)
    return output

@post('/new-food')
def post_new_food():
    food_name = request.POST.new_food_name.strip()
    food_amount = request.POST.new_food_amount.strip()
    food_calorie = request.POST.new_food_calorie.strip()

    food={
        'food':food_name,
        'amount':food_amount,
        'calorie':food_calorie
    }
    mongodb.save_food(food)
    return get_food_list()

@get('/discard-food/<id>')
def get_discard_food(id):
    mongodb.delete_food(id)
    return get_food_list()

@post('/update-food/<id>')
def post_update_food(id):
    food_name = request.POST.foodname.strip()
    food_amount = request.POST.foodamount.strip()
    food_calorie = request.POST.foodcalorie.strip()
    mongodb.update_food(id,food=food_name,amount=food_amount,calorie=food_calorie)
    return food_name


@get('/static/<filepath:path>')
def server_static(filepath):
    print(filepath)
    return static_file(filepath, root='./static')

def setup():
    mongodb.save_food({'food' : "apple", "amount": "3", 'calorie' : "100"})
    mongodb.save_food({'food' : "pizza", "amount": "3", 'calorie' : "500"})


#setup()
#application = default_app()
debug(True)
run(host='0.0.0.0', port=8080)

