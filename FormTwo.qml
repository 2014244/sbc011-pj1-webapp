import QtQuick 2.14
import QtQuick.Controls 2.3
import Qt.labs.qmlmodels 1.0

Item {
    id: tableConsulta

    property var anObject: root.anObject

    anchors.fill: parent

    Rectangle {
        id: recContent
        color: "darkgrey"
        anchors.fill: parent

        Rectangle {
            id: recHeader
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            height: 27

            TableView {
                id:tableHeader
                anchors.fill: parent
                columnSpacing: 1
                rowSpacing: 1
                clip: true


                model: TableModel {
                    TableModelColumn { display: "id" }
                    TableModelColumn { display: "nome" }
                    TableModelColumn { display: "sobrenome" }

                    rows: [
                        {
                            "id": "ID",
                            "nome": "Nome",
                            "sobrenome": "Sobrenome"
                        }
                    ]
                }

                delegate: Rectangle {
                    id: cellHeader
                    implicitWidth: parent.width / 3
                    implicitHeight: 25
                    border.width: 1
                    color: "darkblue"

                    Text {
                        text: display
                        color: "white"
                        anchors.centerIn: parent
                    }
                }
            }
        }

        Column {
            id: recTable
            anchors.top: recHeader.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom

            ScrollView {
                id: scrollTable
                anchors.fill: parent
                ScrollBar.vertical.interactive: true

                TableView {
                    id:table
                    anchors.fill: parent
                    columnSpacing: 1
                    rowSpacing: 1
                    clip: true

                    model: TableModel {
                        id: tabelaCad

                        Component.onCompleted: {
                            var index = anObject.count

                            setRow(0, { id: anObject.resp[0].ID, nome: anObject.resp[0].nome, sobrenome: anObject.resp[0].sobrenome })
                            for (var i = 1 ; i < index ; i++) {
                                appendRow({ id: anObject.resp[i].ID, nome: anObject.resp[i].nome, sobrenome: anObject.resp[i].sobrenome })
                            }
                        }

                        TableModelColumn { display: "id" }
                        TableModelColumn { display: "nome" }
                        TableModelColumn { display: "sobrenome" }

                        rows: [
                            {
                                "id": "0",
                                "sobrenome": "null",
                                "nome": "null"
                            }
                        ]
                    }

                    delegate: Rectangle {
                        id: cell
                        implicitWidth: parent.width / 3
                        implicitHeight: 25
                        border.width: 1
                        color: "lightblue"

                        Text {
                            text: display
                            color: "black"
                            anchors.centerIn: parent
                            MouseArea {
                                anchors.fill: parent
//                                onPressed: {
//                                    mainLoader.source = "StackViewPage.qml"
//                                }
                                onClicked: {
                                    mainLoader.cadId = tabelaCad.getRow(row).id;
                                    mainLoader.cadObj.ID = tabelaCad.getRow(row).id;
                                    mainLoader.source = "StackViewPage.qml"
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
