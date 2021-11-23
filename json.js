function envia_chat(root, handle, text) {
    var comando = JSON.stringify({
                                     "cmd": "chat",
                                     "handle": handle,
                                     "text": text
                                 })
    if (secureWebSocketSubmit.status === WebSocket.Open) {
        secureWebSocketSubmit.sendTextMessage(comando)
    }
}

function salva_cadastro(root, obj)
{
    var comando = JSON.stringify(obj)
//    if (secureWebSocketSubmit.status === root.WebSocket.Open) {
        secureWebSocketSubmit.sendTextMessage(comando)
//    }
}

function deleta_cadastro(root, obj)
{
    var comando = JSON.stringify(obj)
//    if (secureWebSocketSubmit.status === root.WebSocket.Open) {
        secureWebSocketSubmit.sendTextMessage(comando)
//    }
}

function requisita_cadastro(root) {
    var comando = JSON.stringify({
                                     "cmd": "leCadastro",
                                     "coluna": "id",
                                     "dados": "nome"
                                 })
    if (secureWebSocketSubmit.status === WebSocket.Open) {
        secureWebSocketSubmit.sendTextMessage(comando)
    }
}

function requisita_todo_cadastro(root) {
    var comando = JSON.stringify({
                                     "cmd": "leTodoCadastro"
                                 })
    if (secureWebSocketSubmit.status === WebSocket.Open) {
        secureWebSocketSubmit.sendTextMessage(comando)
    }
}

function requisita_estatisticas(root) {
    var comando = JSON.stringify({
                                     "cmd": "leEstatisticas"
                                 })
    if (secureWebSocketSubmit.status === WebSocket.Open) {
        secureWebSocketSubmit.sendTextMessage(comando)
    }
}

function websocket_ping(root) {
    var comando = JSON.stringify({
                                     "cmd": "ping"
                                 })
    if (secureWebSocketSubmit.status === WebSocket.Open) {
        secureWebSocketSubmit.sendTextMessage(comando)
    }
}

function chat(root, message) {
    var JsonObject = JSON.parse(message);

    var aString = JsonObject.handle;
    var bString = JsonObject.text;

    if (aString === nomeTextField.text) {
        textArea.append('<p style="color:DodgerBlue;">' + aString + ': ' + bString + '</p>')
    } else {
        textArea.append('<p style="color:Tomato;">' + aString + ': ' + bString + '</p>')
    }
    textField.clear()
    scrollView.contentItem.contentY = textArea.height - scrollView.contentItem.height
}

function leCadastro(root, message) {
    const JsonObject = JSON.parse(message);

    var id = JsonObject.resp[0].ID;
    var nome = JsonObject.resp[0].nome;
    var sobrenome = JsonObject.resp[0].sobrenome;
}

function leTodoCadastro(root, message) {
    anObject = JSON.parse(message);
    mainLoader.source = "FormTwo.qml"
}

function leEstatisticas(root, message) {
    anObject = JSON.parse(message);
    mainLoader.source = "FormChart.qml"
}

function message_proc(root, message) {
    const JsonObject = JSON.parse(message);

    if(JsonObject.cmd === 'chat') {
        chat(root, message);
    }

    if(JsonObject.cmd === 'leCadastro') {
        leCadastro(root, message);
    }

    if(JsonObject.cmd === 'leTodoCadastro') {
        leTodoCadastro(root, message);
    }

    if(JsonObject.cmd === 'leEstatisticas') {
        leEstatisticas(root, message);
    }

    if(JsonObject.cmd === 'ping') {
        console.log('ping')
    }
}
