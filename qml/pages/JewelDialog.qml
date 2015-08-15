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

Image {
    id: container

    property int mode: 0
    
    signal closed(int mode)
    signal opened
    
    function show(text, answer) {
        dialogText.text = text;
        answerText.text = answer;
        container.opacity = 1;
        container.opened()
    }

    function hide( newMode) {
        container.opacity = 0;
        container.closed(newMode);
    }

    function isClosed() {
        return container.opacity === 0;
    }

    opacity: 0
    visible: opacity > 0

    source: "../images/dialog_small.png"
    scale: (0.6 * parent.width) / sourceSize.width
    smooth: true
        
    Text {
        id: dialogText
        text: ""

        font.family: constants.font_family
        font.pixelSize: constants.fontsize_dialog
        font.bold: true
        color: constants.color_dark

        width: container.paintedWidth-60
        wrapMode: Text.Wrap
        
        anchors {
            top: parent.top
            left: parent.left
            leftMargin: 30
            rightMargin: 30
            topMargin: 30
            bottomMargin: 10
        }
    }

    Item {
        id: answerItem
        anchors {
            horizontalCenter: container.horizontalCenter
            bottom: container.bottom
            bottomMargin: 25
        }

        width: parent.width //answerText.paintedWidth + buttonImage.paintedWidth+50
        height: 84
        
        Text {
            id: answerText
            text: "OK!"
            font.family: constants.font_family
            font.pixelSize: constants.fontsize_dialog
            color: constants.color_uiaccent
            anchors {
                verticalCenter: answerItem.verticalCenter
                left: answerItem.left
                leftMargin: 25
            }
        }

        Image {
            id: buttonImage
            source: "../images/icon_next_black.png"

            anchors {
                verticalCenter: answerItem.verticalCenter
                right: parent.right
                rightMargin: 30
            }
        }
        Image {
            id: retryButtonImage
            visible: ((mode == 3) || (mode == 4))
            source: "../images/icon_back_black.png"

            anchors {
                verticalCenter: answerItem.verticalCenter
                left: parent.left
                leftMargin: 30
            }
        }

    }

    MouseArea {
        id: mouseArea
        height: parent.height
        width: ((mode == 3) || (mode == 4)) ? parent.width/2 : parent.width
        anchors {
            right: parent.right
            top: parent.top
        }
        onClicked: container.hide( (mode == 3) ? 0 : ((mode == 4) ? 1 : mode) )
        onPressed: buttonImage.source="../images/icon_next_pressed.png"
        onReleased: buttonImage.source="../images/icon_next_black.png"
    }

    MouseArea {
        id: mouseAreaLeft
        enabled: ((mode == 3) || (mode == 4))
        height: parent.height
        width: parent.width/2
        anchors {
            left: parent.left
            top: parent.top
        }
        onClicked: container.hide( mode )
        onPressed: retryButtonImage.source="../images/icon_back_pressed.png"
        onReleased: retryButtonImage.source="../images/icon_back_black.png"
    }

}
