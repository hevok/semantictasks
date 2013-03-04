class Batman.MockSocket extends Batman.Object
  constructor: (@url)->

  send: (str)=>
    if typeof str == 'string'
      @onmessage(data :str)
    else
      if(str.hasOwnProperty("data"))
        @onmessage str
      else
        @onmessage data: JSON.stringify(str)


  onopen: =>
    console.log "open"

  onmessage: (event)=>
    data = event.data;
    console.log "onmessage: "+data

  onclose: =>
    console.log "close"


  #random int generating function
  randomInt: (min, max)=> Math.floor(Math.random() * (max - min + 1)) + min