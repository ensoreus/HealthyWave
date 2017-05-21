import QtQuick 2.0
import QtQuick.Controls 2.1

Item {
    id: nextBtn
    signal pressed
    Button {
        id: btnNext
        x: 253
        width: 44
        height: 44
        text: ""
        background: Image {
                id: btnGlyph
                source: "btn-next.png"
                anchors.fill: parent
        }
        onPressed: {
            nextBtn.onPressed()
        }
    }
}
