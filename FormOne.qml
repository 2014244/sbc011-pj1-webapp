import QtQuick 2.15
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.15

Item {
    id: content

    width: 480
    height: 480

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
        }

        TextField {
            id: lastName
            Layout.minimumWidth: 140
            Layout.fillWidth: true
            Layout.columnSpan: 2
            placeholderText: qsTr("Sobrenome")
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
        }

        TextField {
            id: email
            Layout.fillWidth: true
            Layout.columnSpan: 2
            placeholderText: qsTr("email")
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
        }

        TextField {
            id: zipCode
            Layout.fillWidth: true
            Layout.columnSpan: 2
            placeholderText: qsTr("CEP")
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
            id: next
            text: qsTr("Próximo")
            enabled: true
            onClicked: stackview.push( "FormThree.qml" )
        }
    }
}
