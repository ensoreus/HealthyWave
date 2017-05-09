import QtQuick 2.0
import QtQuick.Controls 2.1

TextField{
    height: 40
    font.pointSize: 15
    background: Rectangle{
        color: "white"
        Rectangle{
            border.width: 2
            height: 2
            x: 0
            y: parent.height - 2
            width: parent.width
            color: "black"
        }
    }
}
