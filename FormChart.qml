import QtQuick 2.0
import QtCharts 2.3

Item {
    id: mainChart
    anchors.fill: parent
    property int othersSlice: 0

    Rectangle{
        id: rectangle
        anchors.fill: parent

        ChartView {
            id: chart
            theme: ChartView.ChartThemeBlueCerulean
            title: "Top-5 Municípios"
            anchors.fill: parent
            legend.alignment: Qt.AlignBottom
            antialiasing: true

            PieSeries {
                id: pieSeries
                PieSlice { label: "São Paulo"; value: 13.5 }
                PieSlice { label: "São Bernardo do Campo"; value: 10.9 }
                PieSlice { label: "Santo André"; value: 8.6 }
                PieSlice { label: "Guarulhos"; value: 8.2 }
                PieSlice { label: "Osasco"; value: 6.8 }
            }
        }
    }

    Component.onCompleted: {
        othersSlice = pieSeries.append("Outros", 52.0);
        pieSeries.find("São Paulo").exploded = true;
    }
}
