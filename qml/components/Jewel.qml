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
import QtQuick.Particles 2.0

import "../js/constants.js" as Constants

Item {
    id: jewel

    width: Constants.block_width
    height: Constants.block_height

    property ParticleSystem particleSystem

    z: 0

    property int type: 0;
    property bool spawned: false;
    property bool selected: false;
    property bool to_remove: false;
    property bool dying: false;
    property int locked: 0;

    property int fdPause: 0

    property variant xAnim: xAnimation;
    property variant yAnim: yAnimation;
    //property variant dAnim: dyingAnimation;

    property string typeName: (type == 1 ? "circle" :
                                  type == 2 ? "polygon" :
                                  type == 3 ? "square" :
                                  type == 4 ? "triangle_down" :
                                  type == 5 ? "triangle_up" :
                                  "empty")

    Image {
        id: img
        anchors {
            horizontalCenter: parent.horizontalCenter
            verticalCenter: parent.verticalCenter
        }
        
        width: jewel.width; height: jewel.width

        source: "../images/" + typeName
                                 + (mainPage.isRunning && type?"_eyeshut":"")
                                 + ".png"
        opacity: 1

        smooth: true

        Behavior on opacity {
            NumberAnimation { properties:"opacity"; duration: 200 }
        }
    }

    Image {
        anchors {
            horizontalCenter: parent.horizontalCenter
            verticalCenter: parent.verticalCenter
        }
        
        width: jewel.width; height: jewel.width

        source: "../images/lock" + (parent.locked==2 ? "2" : "") + ".png"
        opacity: parent.locked && !parent.dying
        z: 1
    }

/*    Particles {
        id: particles

        width: 1; height: 1
        anchors.centerIn: parent

        emissionRate: 0
        lifeSpan: 700; lifeSpanDeviation: 600
        angle: 0; angleDeviation: 360;
        velocity: 100; velocityDeviation: 30
        source: type == 0 ? "" : "../images/particle_"+typeName+".png"
    }
*/
    Emitter {
        id: particles
        system: particleSystem
        //property Item block: parent
        anchors.centerIn: parent
        emitRate: 0
        lifeSpan: 500
        lifeSpanVariation: 400
        velocity: AngleDirection {angleVariation: 360; magnitude: 70; magnitudeVariation: 40}
        size: 16
        group: typeName
    }

    function moveToBlock(pt) {
        x = pt.x * Constants.block_width;
        y = pt.y * Constants.block_height
    }

    function moveToPoint(pt) {
        x = pt.x;
        y = pt.y;
    }

    function animationChanged() {
        if (!yAnimation.running && !xAnimation.running)
        {
            mainPage.animDone();
        }
    }

    function jewelKilled() {
        mainPage.jewelKilled();
    }

    Behavior on y {
        enabled: spawned;
        //SmoothedAnimation {
         NumberAnimation {
            id: yAnimation
            duration: 350
            onRunningChanged: if (!running) animationChanged();
        }
    }

    Behavior on x {
        enabled: spawned;
        // SmoothedAnimation {
        NumberAnimation {
            id: xAnimation
            duration: 350
            onRunningChanged: if (!running) animationChanged();
        }
    }

    states: [
        State {
            name: "AliveState"
            when: spawned == true && dying == false
            PropertyChanges { target: img; opacity: 1 }
        },
        State {
            name: "DyingState"
            when: dying == true
            StateChangeScript { script: { particleSystem.paused = false; particles.burst(20);} }
            PropertyChanges { target: img; opacity: 0 }
            StateChangeScript { script: { jewel.destroy(1000); jewelKilled(); } }
        }
    ]

//    transitions: [
//        Transition {
//            from: "AliveState"
//            to: "DyingState"
//            SequentialAnimation {
//                id: dyingAnimation
//                PauseAnimation { duration: fdPause }
//                //ScriptAction { script: { particleSystem.paused = false; particles.burst(50); console.log("burst!")} }
//                PropertyAction { target: img; property: "opacity"; value: 0 }
//                ScriptAction {
//                    script: { jewel.destroy(1000); jewelKilled(); }
//                }
//            }
//        }
//    ]
}
