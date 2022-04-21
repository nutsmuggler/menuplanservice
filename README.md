# Menu Plan Service	
A super simple implementation of a service taking advantage of the [Menu Plan](http://menuplan.app) webhoooks function.  
Using [Sinatra](http://sinatrarb.com), my tool of choice for simple services.  

The service has two endpoints, where you can `POST` a *JSON* and then `GET` an *HTML*:

- plan
- shopping_list

You can also send a `DELETE` message to the plan endpoint, specifying a `meal` and `date` parameter.  
Since this demo implementation doesn't manage data at the menu granularity, I am just logging the received parameters.  
If you use a database you can use these parameters to delete a specific row.  

Be sure to make the directory writable, or modify the script to write the JSON files in a writable directory.
Please use this as a simple canvas, or to draw inspiration: this sample performs no validations and thus is intrinsically insecure.

Be sure to use `https`, otherwise iOS App Transport security will block Menu Plan from talking to your server.

If you're wondering what Menu Plan is, check the [Support website](http://menuplan.app).