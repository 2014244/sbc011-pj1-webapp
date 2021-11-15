import QtQuick 2.15
import QtQuick.Layouts 1.12
import QtQuick.Dialogs 1.2
import QtQuick.Controls 2.12
import QtQuick.Controls 1.4 as OldControls

Item {
    id: content

    width: 680
    height: 480

    OldControls.TableView {
        id: tableView

        property int columnWidth: width / 3
        Layout.minimumWidth: splitView.width / 3
        anchors.fill: parent

        OldControls.TableViewColumn {
            role: "Identificador"
            title: qsTr("Identificador")
            width: tableView.columnWidth
        }

        OldControls.TableViewColumn {
            role: "Nome"
            title: qsTr("Nome")
            width: tableView.columnWidth
        }

        OldControls.TableViewColumn {
            role: "Sobrenome"
            title: qsTr("Sobrenome")
            width: tableView.columnWidth
        }
    }
}
