import QtQuick 2.15
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.15

import "json.js" as Json

Item {
    id: itemCadastro

    anchors.fill: parent

    property var anObject: root.anObject

    property alias address: address
    property alias gridLayout: gridLayout
    property alias back: back
    property alias next: next

    property alias title: title
    property alias zipCode: zipCode
    property alias city: city
    property alias phoneNumber: phoneNumber
    property alias customerId: customerId
    property alias email: email
    property alias lastName: lastName
    property alias firstName: firstName

    GridLayout {
        id: gridLayout

        anchors.right: parent.right
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.rightMargin: 12
        anchors.leftMargin: 12
        anchors.topMargin: 12
        columnSpacing: 8
        rowSpacing: 8
        rows: 8
        columns: 7
        enabled: true

        Component.onCompleted: {
            var i = 0
            while( anObject.resp[i].ID !== mainLoader.cadId ) {i++}
            //            firstName.text = anObject.resp[i].nome
            firstName.text = anObject.resp[i].nome
            lastName.text = anObject.resp[i].sobrenome
            phoneNumber.text = anObject.resp[i].telefone
            email.text = anObject.resp[i].email
            address.text = anObject.resp[i].endereco
            city.text = anObject.resp[i].cidade
            zipCode.text = anObject.resp[i].cep
            customerId.text = anObject.resp[i].ID
        }

        Label {
            id: label1
            text: qsTr("Titulo")
            Layout.columnSpan: 2
        }

        Label {
            id: label2
            text: qsTr("Nome")
            Layout.columnSpan: 2
        }

        Item {
            id: spacer10
            Layout.preferredHeight: 14
            Layout.preferredWidth: 14
        }

        Label {
            id: label3
            text: qsTr("Sobrenome")
        }

        Item {
            id: spacer15
            Layout.preferredHeight: 14
            Layout.preferredWidth: 14
        }

        ComboBox {
            id: title
            Layout.columnSpan: 2
            Layout.fillWidth: true
            model: ["Sr.", "Sra."]
        }

        TextField {
            id: firstName
            Layout.minimumWidth: 140
            Layout.fillWidth: true
            Layout.columnSpan: 3
            placeholderText: qsTr("Nome")
            selectByMouse: true
            maximumLength: 25
        }

        TextField {
            id: lastName
            Layout.minimumWidth: 140
            Layout.fillWidth: true
            Layout.columnSpan: 2
            placeholderText: qsTr("Sobrenome")
            selectByMouse: true
            maximumLength: 100
        }

        Label {
            id: label4
            text: qsTr("Telefone")
            Layout.columnSpan: 5
        }

        Label {
            id: label5
            text: qsTr("Email")
            Layout.preferredHeight: 13
            Layout.preferredWidth: 24
        }

        Item {
            id: spacer16
            Layout.preferredHeight: 14
            Layout.preferredWidth: 14
        }

        TextField {
            id: phoneNumber
            Layout.fillWidth: true
            Layout.columnSpan: 5
            placeholderText: qsTr("Telefone")
            selectByMouse: true
            validator: RegExpValidator{regExp: /[0-9]+/}
            maximumLength: 17
        }

        TextField {
            id: email
            Layout.fillWidth: true
            Layout.columnSpan: 2
            placeholderText: qsTr("email")
            selectByMouse: true
            maximumLength: 100
        }

        Label {
            id: label6
            text: qsTr("Endereço")
        }

        Item {
            id: spacer3
            Layout.columnSpan: 6
            Layout.preferredHeight: 14
            Layout.preferredWidth: 14
        }

        TextField {
            id: address
            Layout.fillWidth: true
            Layout.columnSpan: 7
            placeholderText: qsTr("Endereço")
            selectByMouse: true
            maximumLength: 100
        }

        Label {
            id: label7
            text: qsTr("Cidade")
        }

        Item {
            id: spacer4
            Layout.columnSpan: 4
            Layout.preferredHeight: 14
            Layout.preferredWidth: 14
        }

        Label {
            id: label8
            text: qsTr("CEP")
        }

        Item {
            id: spacer18
            Layout.preferredHeight: 14
            Layout.preferredWidth: 14
        }

        TextField {
            id: city
            Layout.fillWidth: true
            Layout.columnSpan: 5
            placeholderText: qsTr("Cidade")
            selectByMouse: true
            maximumLength: 60
        }

        TextField {
            id: zipCode
            Layout.fillWidth: true
            Layout.columnSpan: 2
            validator: RegExpValidator{regExp: /[0-9]+/}
            maximumLength: 8
            placeholderText: qsTr("CEP")
            selectByMouse: true
        }

        Label {
            id: label9
            text: qsTr("Identificador")
        }

        Item {
            id: spacer19
            Layout.columnSpan: 6
            Layout.preferredHeight: 14
            Layout.preferredWidth: 14
        }

        TextField {
            id: customerId
            Layout.columnSpan: 7
            Layout.fillWidth: true
            placeholderText: qsTr("Identificador")
            enabled: false
        }
    }

    RowLayout {
        anchors.topMargin: 12
        anchors.right: parent.right
        anchors.rightMargin: 12
        anchors.top: gridLayout.bottom

        Button {
            id: back
            text: qsTr("Voltar")
            enabled: false
        }

        Button {
            id: del
            text: qsTr("Deletar")
            enabled: true
            onClicked: {
                if (customerId.text) {
                    dialog.open()
                } else {
                    console.log("Nada a deletar")
                    delErro.open()
                }
            }
        }

        Button {
            id: next
            text: qsTr("Próximo")
            enabled: true
            onClicked: {
                mainLoader.cadObj.ID = customerId.text
                mainLoader.cadObj.titulo = title.textAt(title.currentIndex)
                mainLoader.cadObj.nome = firstName.text
                mainLoader.cadObj.sobrenome = lastName.text
                mainLoader.cadObj.telefone = phoneNumber.text
                mainLoader.cadObj.email = email.text
                mainLoader.cadObj.endereco = address.text
                mainLoader.cadObj.cidade = city.text
                mainLoader.cadObj.cep = zipCode.text
                stackview.push( "FormThree.qml" )
            }
        }
    }

    Popup {
        id: delErro
        anchors.centerIn: parent
        width: 250
        height: 150
        modal: true
        focus: true
        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside

        Column {
            id: column
            anchors.fill: parent
            spacing: 5
            Label {
                id: lbl1
                text: "Para Deletar, selecione um"
                anchors.bottom: lbl2.top
                anchors.bottomMargin: 5
                font.pointSize: 13
                anchors.horizontalCenter: parent.horizontalCenter

            }
            Label {
                id: lbl2
                text: "cadastro na aba \"Cadastros\"."
                anchors.centerIn: parent

            }
            Button {
                id: btErro
                text: "OK"
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 5
                anchors.horizontalCenter: parent.horizontalCenter
                onClicked: {
                    delErro.close()
                }
            }
        }
    }

    Popup {
        id: popupDel
        anchors.centerIn: parent
        width: 250
        height: 150
        modal: true
        focus: true
        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside

        Column {
            id: columnDel
            anchors.fill: parent
            spacing: 5
            Label {
                id: lbl1Del
                text: "Cadastro deletado"
                anchors.bottom: lbl2Del.top
                anchors.bottomMargin: 5
                font.pointSize: 13
                anchors.horizontalCenter: parent.horizontalCenter

            }
            Label {
                id: lbl2Del
                text: "com sucesso."
                anchors.centerIn: parent

            }
            Button {
                id: btErroDel
                text: "OK"
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 5
                anchors.horizontalCenter: parent.horizontalCenter
                onClicked: {
                    popupDel.close()
                }
            }
        }
    }

    Popup {
        id: dialog
        anchors.centerIn: parent
        width: 250
        height: 150
        modal: true
        focus: true

        Column {
            id: columnDialog
            anchors.fill: parent
            spacing: 5
            Label {
                id: lbl1Dialog
                text: "Tem certeza que deseja"
                anchors.bottom: lbl2Dialog.top
                anchors.bottomMargin: 5
                font.pointSize: 13
                anchors.horizontalCenter: parent.horizontalCenter

            }
            Label {
                id: lbl2Dialog
                text: "excluir este cadastro?"
                anchors.centerIn: parent

            }
            Row{
                id: rowDialog
                height: 50
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                anchors.leftMargin: 0
                anchors.rightMargin: 0
                anchors.bottomMargin: 0
                Button {
                    id: no
                    text: "Não"
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    anchors.rightMargin: 8
                    anchors.bottomMargin: 8
                    onClicked: {
                        dialog.close()
                    }
                }

                Button {
                    id: sim
                    text: qsTr("Sim")
                    anchors.left: parent.left
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 8
                    anchors.leftMargin: 8
                    onClicked: {
                        var objTmp = ({ "cmd": "deleteCadastro", "ID": customerId.text })
                        Json.deleta_cadastro(root, objTmp)
                        dialog.close()
                        popupDel.open()
                    }
                }
            }
        }
    }
}
