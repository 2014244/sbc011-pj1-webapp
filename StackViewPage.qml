import QtQuick 2.0
import QtQuick.Controls 2.15

Item {
    id: stackView
    anchors.fill: parent
    StackView {
        id: stackview
        anchors.fill: parent
        initialItem: "FormOne.qml"
    }
}
