import QtQuick 2.15
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.15

import "json.js" as Json

Item {
    id: content

    //    property alias cancel: cancel
    property alias save: save
    property alias back: back
    property alias textArea: textArea
    property var anObject: root.anObject

    anchors.fill: parent

    Component.onCompleted: {
        if ((!textArea.text) && (mainLoader.cadObj.ID))
            textArea.text = mainLoader.cadObj.text
    }

    Rectangle {

        anchors.fill: parent
        color: "darkgrey"

        ColumnLayout {
            anchors.rightMargin: 12
            anchors.leftMargin: 12
            anchors.bottomMargin: 12
            anchors.topMargin: 12
            anchors.fill: parent

            Label {
                id: lblArea
                anchors.top: parent.top
                anchors.left: parent.left
                text: "Comentários (0/ 1000):"
            }

            Rectangle {
                id: recTextArea
                x: 8
                y: 8
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: rowLayout.top - 12
                opacity: 1
                Layout.fillHeight: true
                Layout.fillWidth: true
                color: "white"

                ScrollView {
                    id: scrollViewTextArea
                    anchors.fill: parent

                    TextArea {
                        id: textArea
                        x: 0
                        y: 0
                        width: 26
                        height: 38
                        opacity: 1
                        anchors.fill: parent
                        anchors.rightMargin: -600
                        anchors.bottomMargin: -362
                        selectByMouse: true
                        //                        Layout.fillHeight: true
                        //                        Layout.fillWidth: true
                        Component.onCompleted: {
                            if (!textArea.text) {
                                var i = 0
                                while( anObject.resp[i].ID !== mainLoader.cadId ) {i++}
                                textArea.text = anObject.resp[i].texto
                            }
                        }
                        onTextChanged: {
                            mainLoader.cadObj.text = textArea.text
                            if (length > 1000) { remove(1000, length) }
                            lblArea.text = ("Comentários (" + textArea.text.length + "/ 1000):")

                        }
                    }
                }
            }

            RowLayout {
                id: rowLayout
                Layout.alignment: Qt.AlignTop | Qt.AlignRight
                Button {
                    id: back
                    text: qsTr("Voltar")
                    enabled: true
                    onClicked: stackview.pop()
                }

                //                Button {
                //                    id: cancel
                //                    text: qsTr("Cancelar")
                //                    enabled: true
                //                }

                Button {
                    id: save
                    text: qsTr("Salvar")
                    enabled: true
                    onClicked: {
                        mainLoader.cadObj.texto = textArea.text
                        if (mainLoader.cadObj.ID) { mainLoader.cadObj.cmd = "updateCadastro" }
                        Json.salva_cadastro(root, mainLoader.cadObj)
                        popupSalvo.open()
                    }

                    Component.onCompleted: {
                        print (mainLoader.cadObj.ID)
                        if (mainLoader.cadObj.ID) { save.text = "Alterar" }
                    }
                }

            }
        }
    }

    Popup {
        id: popupSalvo
        anchors.centerIn: parent
        width: 250
        height: 150
        modal: true
        focus: true
        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside

        Column {
            id: columnSalvo
            anchors.fill: parent
            spacing: 5
            Label {
                id: lbl1Salvo
                text: "Cadastro salvo"
                anchors.bottom: lbl2Salvo.top
                anchors.bottomMargin: 5
                font.pointSize: 13
                anchors.horizontalCenter: parent.horizontalCenter

                Component.onCompleted: {
                    if (mainLoader.cadObj.ID) { lbl1Salvo.text = "Cadastro alterado" }
                }

            }
            Label {
                id: lbl2Salvo
                text: "com sucesso."
                anchors.centerIn: parent

            }
            Button {
                id: btErroSalvo
                text: "OK"
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 5
                anchors.horizontalCenter: parent.horizontalCenter
                onClicked: {
                    popupSalvo.close()
                }
            }
        }
    }
}
