<html>

<head><title>Calorie</title></head>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<body onload="updatetable()">

<div id="change" class="w3-margin">
  <table id="foodtable">
    <tr>
      <th>
        <div width=100 class="w3-card-4 w3-padding" style="min-width: 100px"> Food  </div>
      </th>
      <th>
        <div width=100 class="w3-card-4 w3-padding" style="min-width: 100px"> Amount </div>
      </th>
      <th>
          <div width=100 class="w3-card-4 w3-padding" style="min-width: 100px"> Calorie </div>
      </th>
      <th>
          <div width=100 class="w3-card-4 w3-padding" style="min-width: 100px"> Total </div>
      </th>
    </tr>
    <tr>
        <form action="/new-food" method="post">
      <td>
        <div class="w3-card-4 w3-padding">
          <input required autofocus type="text" name="new_food_name" placeholder="New food" style="min-width: 100px">
        </div>
      </td>
      <td>
        <div class="w3-padding w3-padding">
          <input required autofocus type="text" name="new_food_amount" placeholder="amount" style="min-width: 100px">
      </div>
      </td>
      <td>
        <div class="w3-padding w3-padding">
            <input required autofocus type="text" name="new_food_calorie" placeholder="calorie" style="min-width: 100px">      
        </div>
      </td>
     
      <td>
          <div id = "total" class="w3-card-4 w3-padding">
             0
          </div>
        </td>
        <td>
            <div  class="w3-card-4 w3-padding">
                
                  <input type="image" src="/static/save-task.png"/>
                
                </div>  
          </td>
        </form>
    </tr>
    %for food in foods:
      <tr>
        <form action="/update-food/{{food['_id']}}" method="post">
        <input id="foodname" type="hidden" name="food" value="">
        <input id="foodamount" type="hidden" name="amount" value="">          
        <input id="foodcalorie" type="hidden" name="calorie" value="">
        <td>
          <div id="change" contenteditable class="w3-card-4 w3-padding">
            {{food['food']}}
          </div>
        </td>
        <td>
          <div id="change" contenteditable class="w3-card-4 w3-padding">
            {{food['amount']}}
          </div>
        </td>
        <td>
          <div id="change" contenteditable class="w3-card-4 w3-padding">
            {{food['calorie']}}
          </div>
        </td>
        <td>
          <div id ="etotal" class="w3-card-4 w3-padding">
            0
          </div>
        </td>
        <td>
            <div  class="w3-card-4 w3-padding">
              
                <input type = "image" src="/static/save-task.png">
              
            </div>
            
          </td>
          <td>
              <div class="w3-card-4 w3-padding">
                <a href="/discard-food/{{food['_id']}}">
                  <img src="/static/discard-task.png">
                </a>
              </div>
              
            </td>
            </form>
      </tr>
    %end
  </table>
  <hr/>
  <div style="padding-left:5px">
  
  </div>
</div>
</body>

<script type="text/javascript">

  var change = document.getElementById('change');

  change.addEventListener('input', updatefood);

function updatetable (){
  
  var alltotal = 0.0;
  var table = document.getElementById("foodtable");
  var rows = table.getElementsByTagName("tr");
  
  for( var i = 2; i <rows.length; i ++){

    var amount = rows[i].getElementsByTagName('div')[1].innerHTML;
   
    var calorie = rows[i].getElementsByTagName('div')[2].innerHTML;
    var total;
  
    total = parseFloat(amount) * parseFloat(calorie);
    
  if(isNaN( total)){
    total = 0;
   
  }
     
    rows[i].getElementsByTagName('div')[3].innerHTML = total.toString()
  
    alltotal += total;

  }
  document.getElementById('total').innerHTML = alltotal.toString()
  updatefood();
}

function updatefood(){


var table = document.getElementById("foodtable");
  var rows = table.getElementsByTagName("tr");
  
  for( var i = 2; i <rows.length; i ++){
    inputs = rows[i].getElementsByTagName('input');
    inputs[0].value = rows[i].getElementsByTagName('div')[0].innerHTML;
    inputs[1].value = rows[i].getElementsByTagName('div')[1].innerHTML;
    inputs[2].value = rows[i].getElementsByTagName('div')[2].innerHTML;

  }

}


</script>

</html>