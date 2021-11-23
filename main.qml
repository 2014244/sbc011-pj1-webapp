import QtQuick 2.12
import QtQuick.Window 2.12
import QtWebSockets 1.2
import QtQuick.Controls 2.12

import "json.js" as Json

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")
    id: root
    color: "darkgrey"

    property var anObject: ({})
    property color bgcolor: "white"
    property color buttoncolor: "darkblue"
    property color hovercolor: "lightblue"
    property color clickcolor: "white"
    property int size: 100

    Component.onCompleted: {
        secureWebSocketReceive.active = true
        secureWebSocketSubmit.active = true

    }

    WebSocket {
        id: secureWebSocketReceive
        url: "wss://sbc011-pj1-redis.herokuapp.com/receive"
        //url: "ws://127.0.0.1:8000/receive"
        onTextMessageReceived: {
            console.log( "\nReceived secure message: " + message )
            Json.message_proc(root, message)
        }
        onBinaryMessageReceived: {
            console.log( "\nReceived secure message: " + message )
            Json.message_proc(root, message)
        }
        onStatusChanged: if (secureWebSocketReceive.status === WebSocket.Error) {
                             console.log("Error: " + secureWebSocketReceive.errorString)
                         } else if (secureWebSocketReceive.status === WebSocket.Open) {
                             console.log("Connected")
                         } else if (secureWebSocketReceive.status === WebSocket.Closed) {
                             console.log("\nSecure socket closed")
                             active: false
                         }
    }

    WebSocket {
        id: secureWebSocketSubmit
        url: "wss://sbc011-pj1-redis.herokuapp.com/submit"
        //url: "ws://127.0.0.1:8000/submit"
        onTextMessageReceived: {
            console.log( "\nReceived secure message: " + message )
            Json.message_proc(root, message)
        }
        onBinaryMessageReceived: {
            console.log( "\nReceived secure message: " + message )
            Json.message_proc(root, message)
        }
        onStatusChanged: if (secureWebSocketSubmit.status === WebSocket.Error) {
                             console.log("Error: " + secureWebSocketSubmit.errorString)
                         } else if (secureWebSocketSubmit.status === WebSocket.Open) {
                             console.log("Connected")
                         } else if (secureWebSocketSubmit.status === WebSocket.Closed) {
                             console.log("\nSecure socket closed")
                             active: false
                         }
    }

    Rectangle {
        id: background
        color: root.buttoncolor
        width: 100
        height: parent.height
        z: 1

        Column {
            id: column
            anchors.fill: parent

            Timer {
                interval: 20000; running: true; repeat: true
                onTriggered: {
                    Json.websocket_ping()
                    console.log(Date().toString())
                }
            }

            HoverButton {
                width: 100
                height: 50
                title.text: "Cadastro"
                color: root.buttoncolor
                hoverColor: root.hovercolor
                clickColor: root.clickcolor
                area.onPressed: {
                    mainLoader.source = "StackViewPage.qml"
                }
            }
            HoverButton {
                width: 100
                height: 50
                title.text: "Consulta"
                color: root.buttoncolor
                hoverColor: root.hovercolor
                clickColor: root.clickcolor
                area.onPressed: {
                    Json.requisita_todo_cadastro(root)
                }
            }
            HoverButton {
                width: 100
                height: 50
                title.text: "Estatísticas"
                color: root.buttoncolor
                hoverColor: root.hovercolor
                clickColor: root.clickcolor
                area.onPressed: {
                    Json.requisita_estatisticas(root)
                }
            }
            HoverButton {
                width: 100
                height: 50
                title.text: "Chat"
                color: root.buttoncolor
                hoverColor: root.hovercolor
                clickColor: root.clickcolor
                area.onPressed: {
                    onClicked: chatPopup.open()

                    if (!secureWebSocketReceive.active) {
                        secureWebSocketReceive.active = true
                    }

                    if (!secureWebSocketSubmit.active) {
                        secureWebSocketSubmit.active = true
                    }
                }
            }


        }

    }

    Loader {
        id: mainLoader
        property int cadId: 0
        property var cadObj: ({ "cmd": "salvaCadastro", ID: 0, titulo: "", nome: "", sobrenome: "",
                                  telefone: "", email: "", endereco: "",
                                  cidade: "", cep: "", texto: "" })
        anchors {
            left: background.right
            right: parent.right
            top: parent.top
            bottom: parent.bottom
        }
        source: "StackViewPage.qml"
    }

    Popup {
        id: chatPopup
        anchors.centerIn: parent
        width: 300
        height: 400
        modal: true
        focus: true
        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside

        Column {
            id: popupColumn
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: row.bottom
            anchors.bottom: parent.bottom
            anchors.rightMargin: 5
            anchors.leftMargin: 5
            anchors.bottomMargin: 5
            anchors.topMargin: 5
            spacing: 5

            ScrollView {
                id: scrollView
                width: parent.width
                height: parent.height - (textField.height + 10)

                TextArea {
                    id: textArea
                    width: parent.width
                    text: ""
                    readOnly: true
                    font.bold: true
                    selectByMouse: true
                    textFormat: Text.RichText
                    horizontalAlignment: Text.AlignLeft
                }
            }

            TextField {
                id: textField
                placeholderText: qsTr("Digite aqui sua Mensagem. Tecle ENTER para enviar.")
                width: parent.width
                selectByMouse: true
                maximumLength: 250

                Keys.onReturnPressed: {
                    if (!secureWebSocketReceive.active) {
                        secureWebSocketReceive.active = true
                    }

                    if (!secureWebSocketSubmit.active) {
                        secureWebSocketSubmit.active = true
                    }

                    if (secureWebSocketSubmit.status === WebSocket.Open) {
                        Json.envia_chat(root, nomeTextField.text, textField.text)
                    }
                }
            }
        }

        Row {
            id: row
            height: 47
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.rightMargin: 1
            anchors.leftMargin: 1
            anchors.topMargin: 1

            Label {
                id: lblName
                text: qsTr("Seu Nome: ")
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                font.pointSize: 15
                anchors.leftMargin: 5
            }

            TextField {
                id: nomeTextField
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: lblName.right
                anchors.right: parent.right
                anchors.rightMargin: 10
                anchors.leftMargin: 10
                placeholderText: qsTr("Nome")
                focus: true
                selectByMouse: true
                maximumLength: 20
            }
        }
    }
}
