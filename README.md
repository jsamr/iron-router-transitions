# iron-router-transitions
A simple source to add hooks on specific path changes, like 
> when *path* changes from **/fields/** to **/users/** do *hook*

# How to use it
Example : the route is switching from `http://myapp.co/fields/item4587` to `http://myapp.co/users/789654f5ab`, 
therefore both hooks will be run. 

## coffescript

    RouterTransitions.register '/fields', null    , -> console.log "switching from /fields to any"
    RouterTransitions.register '/fields', '/users', -> console.log "switching from /fields to /users"

## javascript

    RouterTransitions.register('/fields',null, function(){ console.log("switching from /fields to any"); });
    RouterTransitions.register('/fields','/users', function(){ console.log("switching from /fields to /users"); });
    
# Conditions using *register(origin,destination,hook)*

* The `origin` (1st arg) can be a subroute of the `destination` (2d arg)
* The `origin` (1st arg) must be unique. The last key registered will override any key registered before. 
* The `destination` (2st arg) **cannot** be a subroute of the `origin` (1st arg)
* The `origin` - `destination` pair must be unique. The last pair will override any pair registered before.