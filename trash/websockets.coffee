#will be completely rewritten soon

class Socket
  init: (url,username)->
    chatSocket = if(window['MozWebSocket']) then new MozWebSocket(url) else new WebSocket(url)
    $("#talk").keypress(handleReturnKey(chatSocket))
    chatSocket.onmessage = receiveEvent(chatSocket)

  sendMessage = (chatSocket)->
    message =
      text: $("#talk").val()
    str = JSON.stringify(message)
    chatSocket.send(str)

    $("#talk").val('')

  createMessage = (data)->
    el = $('<div class="message"><span></span><p></p></div>')
    $("span", el).text(data.user)
    $("p", el).text(data.message)
    $(el).addClass(data.kind)
    if(data.user == username)
      $(el).addClass('me')
    $('#messages').append(el)

  updateMembersList = (data)->
    $("#members").html('')
    append = ()->
      $("#members").append('<li>' + this + '</li>')
    $(data.members).each append

  handleErrors = (chatsocket,data)->
    if(data.error)
      chatSocket.close()
      $("#onError span").text(data.error)
      $("#onError").show()
    else
      $("#onChat").show()

  receiveEvent = (chatSocket) ->
    (event)->
      data = JSON.parse(event.data)
      handleErrors(chatSocket,data)
      createMessage(data)
      updateMembersList(data)

  handleReturnKey = (chatSocket)->
    (e)->
      if(e.charCode == 13 or e.keyCode == 13)
        e.preventDefault()
        sendMessage(chatSocket)



chat = new websocket
chat.init(url,username)
