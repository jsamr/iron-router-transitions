

class RouterTransitions

  #could be any sequence of characters with at least one forbidden in URL standards (RFC 3986, section 2 characters)
  WILDCARD:'>>'

  # Autorun is called so that
  constructor:->
    Tracker.autorun =>
      newPath=Router.current()?.location.get().path
      if @_oldPath!=newPath
        @_matchingDestinations.forEach (destinations) =>
          origin=destinations.origin
          Object.keys(destinations.targets).forEach (key) =>
            #if the new path does not match the origin selector, and matches the destination, then call the hook
            if !newPath.match("#{origin}.*")&&(key==@WILDCARD or newPath.match("#{key}.*"))
              #call the hook
              destinations.targets[key]()
      @_matchingOrigins =Object.keys(@dictionnary).filter (origin) => newPath.match("#{origin}.*")
      @_matchingDestinations = @_matchingOrigins.map (key)=> {
      targets:@dictionnary[key]
      origin:key
      }
      @_oldPath=newPath


  ###
  @param {String} origin : the namespace of the incoming path, null for any match. Origin can be a subroute of destination.
  @param {String} destination : the namespace of the forthcoming path, null for any match.
    !IMPORTANT! destination cannot be a subroute of origin
  @param {String} hook : the callback to be run on matching conditions
  ###
  register:(origin,destination,hook) =>
    origin=origin||@WILDCARD
    destination=destination||@WILDCARD
    if @dictionnary[origin]
      @dictionnary[origin][destination]=hook
    else
      hooks=@dictionnary[origin]={}
      hooks[destination]=hook

  #A simple dict with keys='origin' and values plain objects with destinations mapped to hooks
  dictionnary:{}

  #The previous path
  _oldPath:'/'

  #An array of all the matching destinations from the current path context
  _matchingDestinations:[]

  #An array of all the matching origins from the current path context
  _matchingOrigins:[]

###
  To register a transition, simply call register() method
###
window.RouterTransitions=new RouterTransitions()
