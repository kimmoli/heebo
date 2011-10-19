/*
  Copyright 2011 Mats Sjöberg
  
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

import QtQuick 1.0

import "qrc:///js/jewels.js" as Jewels

JewelPage {
    id: mainPage
    
    property int block_width: Jewels.block_width;
    property int block_height: Jewels.block_height;
    property int toolbar_height: 99

    property string mainFont: "Nokia Pure Text"
    property int dialogFontSize: 22
    property int mainFontSize: 36
    property color darkColour:     "#333333"
    property color uiAccentColour: "#D800D8"
    property color mainFontColour: "#F2F2F2"

    property int font_size: 42

    property real buttonOffset: 0.0

    property bool isRunning: false
    
    signal animDone()
    signal jewelKilled();
    
    SystemPalette { id: activePalette }

    Component.onCompleted: {
        Jewels.init();
        animDone.connect(Jewels.onChanges);
        jewelKilled.connect(Jewels.onChanges);
        okDialog.closed.connect(Jewels.dialogClosed);
        okDialog.closed.connect(tintRectangle.hide);
        okDialog.opened.connect(tintRectangle.show);

        /* okDialog.mode = 42; */
        /* okDialog.show("ZÖMG!", "ÖKÖÖ"); */
        /* okDialog.show("ZÖMG! You cleared the level! "+ */
        /*               "Want to have a go at the "+ */
        /*               "next one?", */
        /*               "Yes, bring it on!"); */
        /* mainMenu.show() */
    }

    JewelDialog {
        id: okDialog
        anchors.centerIn: background
        z: 50
    }

    Item {
        id: background;
        width: parent.width
        anchors { top: parent.top; bottom: toolBar.top }

        MouseArea {
            anchors.fill: parent
            onPressed: Jewels.mousePressed(mouse.x, mouse.y)
            onPositionChanged: if (pressed) Jewels.mouseMoved(mouse.x, mouse.y)
        }
    }

    ToolBar {
        id: toolBar

        Row {
            anchors {
                left: parent.left
                verticalCenter: parent.verticalCenter
                leftMargin: 100
            }
            Text {
                text: "Level: "
                font.family: mainPage.mainFont
                font.pixelSize: mainPage.mainFontSize
                color: mainPage.uiAccentColour
            }
            Text {
                id: currentLevelText
                text: "??"
                font.family: mainPage.mainFont
                font.pixelSize: mainPage.mainFontSize
                color: mainPage.mainFontColour
            }                
            Text {
                text: "/"
                font.family: mainPage.mainFont
                font.pixelSize: mainPage.mainFontSize
                color: mainPage.uiAccentColour
            }                
            Text {
                id: lastLevelText
                text: "??"
                font.family: mainPage.mainFont
                font.pixelSize: mainPage.mainFontSize
                color: mainPage.mainFontColour
            }                
        }
        Image {
            id: menuButton
            source: "qrc:///images/icon_menu.png"
            width: 64; height: 64

            anchors {
                right: parent.right
                verticalCenter: parent.verticalCenter
                verticalCenterOffset: -40*mainPage.buttonOffset
                rightMargin: 20
            }

            MouseArea {
                anchors.fill: parent
                onClicked: mainMenu.toggle()
                onPressed: menuButton.source="qrc:///images/icon_menu_pressed.png"
                onReleased: menuButton.source="qrc:///images/icon_menu.png"
            }

            Behavior on anchors.verticalCenterOffset {
                /* SmoothedAnimation { velocity: 150 } */
                SpringAnimation {
                    epsilon: 0.25
                    damping: 0.1
                    spring: 3
                    /* velocity: 150 */
                }
            }

        }
    }

    Rectangle {
        id: tintRectangle
        anchors.fill: parent
        color: "#3399FF"
        opacity: 0.0
        visible: opacity > 0

        z: 10

        function show() {
            var colors = ["#3399FF", "#11FF00", "#7300E6", "#FF3C26",
                          "#B300B3", "#FFD500"];

            tintRectangle.color = colors[Jewels.random(0,5)];
            tintRectangle.opacity = 0.65;
        }

        function hide() {
            tintRectangle.opacity = 0;
        }            

        MouseArea {
            anchors.fill: parent
            onClicked: { mainMenu.hide(); okDialog.hide(); }
        }

        Behavior on opacity {
            SmoothedAnimation { velocity: 2.0 }
        }
    }

   Image {
        id: mainMenu
        z: 50

        source: "qrc:///images/main_menu_bg.png"

        signal closed

        function toggle() {
            visible ? hide() : show();
        }
    
        function show() {
            mainMenu.opacity = 1;
            tintRectangle.show();
            mainPage.buttonOffset = 1.0;
        }
        
        function hide() {
            mainMenu.opacity = 0;
            tintRectangle.hide();
            mainMenu.closed();
            mainPage.buttonOffset = 0.0;
        }

        opacity: 0
        visible: opacity > 0
        
        anchors {
            horizontalCenter: parent.horizontalCenter
            verticalCenter: parent.verticalCenter
            verticalCenterOffset: -16
        }

        Image {
            source: "qrc:///images/heebo_logo.png"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.baseline: parent.top
            anchors.baselineOffset: -32
        }
        
        JMenuLayout {
            id: menuLayout
            JMenuItem {
                text: "Restart Level"
                onClicked: Jewels.startNewGame()
            }
            JMenuItem {
                text: "New Game"
                onClicked: Jewels.firstLevel()
            }
            JMenuItem {
                text: "Help"
                onClicked: {
                    okDialog.mode = 42;
                    okDialog.show("ZÖMG! You cleared the level!\n"+
                                  "Want to have a go at the\n"+
                                  "next one?",
                                  "Yes, bring it on!");
                }

            }
            JMenuItem {
                text: "About"
                onClicked: Jewels.nextLevel()
            }
        }
    }

}

