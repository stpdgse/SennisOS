import QtQuick 2.0
import calamares.slideshow 1.0

Presentation {
    id: presentation

    Timer {
        interval: 1000000
        running: true
        repeat: false
    }

    Slide {
        Image {
            id: background
            source: "welcome.png"
            anchors.fill: parent
            fillMode: Image.PreserveAspectCrop
        }
    }
}
