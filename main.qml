import QtQuick 2.15
import QtQuick.Window 2.15
import QtWebSockets 1.1
import QtQuick.Controls 2.3

import "json.js" as Json

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")
    id: root
    color: "darkgrey"

    property color bgcolor: "white"
    property color buttoncolor: "darkblue"
    property color hovercolor: "lightblue"
    property color clickcolor: "white"
    property int size: 100

	WebSocket {
	        id: secureWebSocketReceive
	        url: "wss://python-websockets-redis.herokuapp.com/receive"
	        onBinaryMessageReceived: {
	            console.log( "\nReceived secure message: " + message )
	            Json.parse(root, message)
	        }
	        onStatusChanged: if (secureWebSocketReceive.status === WebSocket.Error) {
	                             console.log("Error: " + secureWebSocketReceive.errorString)
	                         } else if (secureWebSocketReceive.status === WebSocket.Open) {
	                             console.log("Connected")
	                             //secureWebSocketReceive.sendTextMessage("{ \"handle\": \"qml\", \"text\": \"123456\" }")
	                         } else if (secureWebSocketReceive.status === WebSocket.Closed) {
	                             console.log("\nSecure socket closed")
	                             active: false
	                         }
	        //       active: false
	    }

	WebSocket {
	        id: secureWebSocketSubmit
	        url: "wss://python-websockets-redis.herokuapp.com/submit"
	        onBinaryMessageReceived: {
	            console.log( "\nReceived secure message: " + message )
	            Json.parse(message)
	        }
	        onStatusChanged: if (secureWebSocketSubmit.status === WebSocket.Error) {
	                             console.log("Error: " + secureWebSocketSubmit.errorString)
	                         } else if (secureWebSocketSubmit.status === WebSocket.Open) {
	                             console.log("Connected")
	                             //secureWebSocketSubmit.sendTextMessage("{ \"handle\": \"qml\", \"text\": \"123456\" }")
	                         } else if (secureWebSocketSubmit.status === WebSocket.Closed) {
	                             console.log("\nSecure socket closed")
	                             active: false
	                         }
	        //        active: false
	    }



    Rectangle {
        id: background
        color: root.buttoncolor
        width: 100
        height: parent.height

        Column {
            id: column
            anchors.fill: parent

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
                    mainLoader.source = "FormTwo.qml"
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
                    mainLoader.source = "FormChart.qml"
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
                }
            }


        }

    }

    Loader {
        id: mainLoader
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
		                enabled: false

		            }
		        }

		        TextField {
		            id: textField
		            focus: true
		            placeholderText: qsTr("Digite aqui sua Mensagem. Tecle ENTER para enviar.")
		            width: parent.width

		            Keys.onReturnPressed: {
		                if (!secureWebSocketReceive.active) {
		                    secureWebSocketReceive.active = true
		                }

		                if (!secureWebSocketSubmit.active) {
		                    secureWebSocketSubmit.active = true
		                }

		                if (secureWebSocketSubmit.status === WebSocket.Open) {
		                    secureWebSocketSubmit.sendTextMessage("{ \"handle\": \"" + nomeTextField.text + "\", \"text\": \"" + textField.text + "\" }")
		                }

		//                textArea.append(nomeTextField.text + ": " + textField.text)
		//                textField.clear()
		//                scrollView.contentItem.contentY = textArea.height - scrollView.contentItem.height
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
		        }
		    }
    }



}
