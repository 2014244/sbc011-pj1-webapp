import QtQuick 2.0
import QtQuick.Controls 2.15

Item {
    anchors.fill: parent
    StackView {
        id: stackview
        anchors.fill: parent
        initialItem: "FormOne.qml"
    }
}
