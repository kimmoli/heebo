/*
  Copyright 2012 Mats Sjöberg
  
  This file is part of the Heebo programme.
  
  Heebo is free software: you can redistribute it and/or modify it
  under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.
  
  Heebo is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
  or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public
  License for more details.
  
  You should have received a copy of the GNU General Public License
  along with Heebo.  If not, see <http://www.gnu.org/licenses/>.
*/

import QtQuick 2.0

Item {
    id: container
    
    property string text: "OK";
    property string buttonImage: "";
    property string pressedButtonImage: "";

    signal clicked
    /* signal pressAndHold */

    height: 140
    width: 140

    Image {
        id: imageComponent
        source: container.buttonImage
        anchors {
            top: container.top
            horizontalCenter: container.horizontalCenter
        }
    }

    Text {
        id: textComponent
        text: container.text
        font.family: constants.font_family
        color: constants.color_dark
        font.pixelSize: constants.fontsize_dialog

        anchors {
            top: imageComponent.bottom
            horizontalCenter: container.horizontalCenter
        }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: container
        onClicked: container.clicked();
        onPressed: imageComponent.source = container.pressedButtonImage
        onReleased: imageComponent.source = container.buttonImage
        /* onPressAndHold: container.pressAndHold(); */
    }
}
