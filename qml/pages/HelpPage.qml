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
import Sailfish.Silica 1.0

import "../components"

Page {
    id: mainPage

    SilicaFlickable {
        id: flickList
        anchors.fill: parent
        clip: true
        contentWidth: parent.width
        contentHeight: titleText.paintedHeight +
                       help_topic_1.paintedHeight + help_text_1.paintedHeight +
                       help_topic_2.paintedHeight + help_text_2.paintedHeight +
                       help_topic_3.paintedHeight + help_text_3.paintedHeight +
                       help_topic_4.paintedHeight + help_text_4.paintedHeight +
                       help_text_5.paintedHeight + 30*11

        PageHeader
        {
            title: "Heebo HELP"
        }
        
        FullPageText {
            id: titleText
            text: " "
            style: "header"
            anchors.top: parent.top
        }
        FullPageText {
            id: help_topic_1
            text: constants.heebo_help_topic_1
            style: "title"
            anchors.top: titleText.bottom
        }

        FullPageText {
            id: help_text_1
            text: constants.heebo_help_1
            anchors.top: help_topic_1.bottom
        }

        FullPageText {
            id: help_topic_2
            text: constants.heebo_help_topic_2
            style: "title"
            anchors.top: help_text_1.bottom
        }

        FullPageText {
            id: help_text_2
            text: constants.heebo_help_2
            anchors.top: help_topic_2.bottom
        }

        FullPageText {
            id: help_topic_3
            text: constants.heebo_help_topic_3
            style: "title"
            anchors.top: help_text_2.bottom
        }

        FullPageText {
            id: help_text_3
            text: constants.heebo_help_3
            anchors.top: help_topic_3.bottom
        }

        FullPageText {
            id: help_topic_4
            text: constants.heebo_help_topic_4
            style: "title"
            anchors.top: help_text_3.bottom
        }

        FullPageText {
            id: help_text_4
            text: constants.heebo_help_4
            anchors.top: help_topic_4.bottom
        }

        FullPageText {
            id: help_text_5
            text: constants.heebo_help_5
            style: "emphasis"
            anchors.top: help_text_4.bottom
        }
        VerticalScrollDecorator {
                flickable: flickList
        }

    }
}
