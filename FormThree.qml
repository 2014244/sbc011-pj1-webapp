import QtQuick 2.15
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.15

Item {
    id: content

    property alias cancel: cancel
    property alias save: save
    property alias back: back
    property alias textArea: textArea

    width: 480
    height: 480

    ColumnLayout {
        anchors.rightMargin: 12
        anchors.leftMargin: 12
        anchors.bottomMargin: 12
        anchors.topMargin: 12
        anchors.fill: parent

        TextArea {
            id: textArea
            x: 8
            y: 8
            width: 624
            height: 320
            opacity: 1
            placeholderTextColor: "#00ffffff"
            Layout.fillHeight: true
            Layout.fillWidth: true
        }
        RowLayout {
            Layout.alignment: Qt.AlignTop | Qt.AlignRight
            Button {
                id: back
                text: qsTr("Voltar")
                enabled: true
                onClicked: stackview.pop()
            }

            Button {
                id: cancel
                text: qsTr("Cancelar")
                enabled: true
            }

            Button {
                id: save
                text: qsTr("Salvar")
                enabled: false
            }

        }
    }
}
