import QtQuick 2.0
import QtQuick.Controls 2.1

TextField{
    background: Rectangle{
        color: "white"
        height: 40
        Rectangle{
            border.width: 3
            height: 3
            x: 0
            y: parent.height - 3
            width: parent.width
            color: "black"
        }
    }
}
