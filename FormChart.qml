import QtQuick 2.0
import QtCharts 2.15

Item {
    id: mainChart
    anchors.fill: parent
    property int othersSlice: 0
    property int othersSlice_p: 0
    property string oneSlice: "null"
    property string twoSlice: "null"
    property string threeSlice: "null"
    property string fourSlice: "null"
    property string fiveSlice: "null"
    property int oneSlice_p: 20
    property int twoSlice_p: 20
    property int threeSlice_p: 20
    property int fourSlice_p: 20
    property int fiveSlice_p: 20
    property var anObject: root.anObject

    Rectangle{
        id: rectangle
        color: "darkgrey"
        anchors.fill: parent

        ChartView {
            id: chart
            theme: ChartView.ChartThemeBlueIcy
            title: "Top-5 Municípios"
            anchors.fill: parent
            legend.alignment: Qt.AlignBottom
            antialiasing: true

            PieSeries {
                id: pieSeries
                PieSlice { label: oneSlice; value: oneSlice_p }
                PieSlice { label: twoSlice; value: twoSlice_p }
                PieSlice { label: threeSlice; value: threeSlice_p }
                PieSlice { label: fourSlice; value: fourSlice_p }
                PieSlice { label: fiveSlice; value: fiveSlice_p }
            }
        }
    }

    Component.onCompleted: {
        var i = 0
        for( i; 5 > i; i++ ) {
            switch (i)
            {
            case 0:
                oneSlice = anObject.resp[i].cidade
                oneSlice_p = anObject.resp[i].cidades_percent
                break
            case 1:
                twoSlice = anObject.resp[i].cidade
                twoSlice_p = anObject.resp[i].cidades_percent
                break
            case 2:
                threeSlice = anObject.resp[i].cidade
                threeSlice_p = anObject.resp[i].cidades_percent
                break
            case 3:
                fourSlice = anObject.resp[i].cidade
                fourSlice_p = anObject.resp[i].cidades_percent
                break
            case 4:
                fiveSlice = anObject.resp[i].cidade
                fiveSlice_p = anObject.resp[i].cidades_percent
                break
            }
        }
        var j = anObject.count - 5
        for ( var x = 0; x < j; x++)
        {
            othersSlice_p = othersSlice_p + anObject.resp[x + i].cidades_percent
        }
        pieSeries.find(oneSlice).exploded = true;
        pieSeries.append("Outros", othersSlice_p);
    }
}
