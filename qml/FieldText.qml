/*--------------------------------------------------------
* Module Name : Helium Mobile Browser
* Version : 1.0
*
* Software Name : Helium Mobile Browser
* Version : 1.0
*
* Copyright (c) 2010 - 2011 France Telecom
* This software is distributed under the LGPL v2.1 license,
* the text of which is available at http://www.gnu.org/licenses/lgpl-2.1.html
* or see the "LICENSE.txt" file for more details.
*
*--------------------------------------------------------
* File Name   : FieldText.qml
*
* Created     : 15 June 2011
*
*--------------------------------------------------------
* 1.0 - First open source release
*
*/


import QtQuick 2.0
import com.nokia.meego 2.0

// TextInput box in which the User types the URL
TextField {
    id: textEdit
    platformSipAttributes: SipAttributes {
        actionKeyEnabled: true
        actionKeyHighlighted: true
        actionKeyLabel: "Go"
    }
    platformStyle: TextFieldStyle { paddingRight: defaultFavIcon.width + 32 ; paddingLeft:reloadIcon.width + 32; }
    placeholderText: "Enter URL"

    property bool loading: false

    signal editFinished
    signal reloadRequested
    signal stopRequested

    function updateFavIcon() {
        defaultFavIcon.opacity = 0;
        favIcon.opacity = 1;
    }

    function setDefaultFavIcon() {
        favIcon.opacity = 0;
        defaultFavIcon.opacity = 0.7;
    }

    Image {
        id: favIcon
        height: parent.height-16
        width: height
        asynchronous: true;
        fillMode: Image.PreserveAspectFit
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: 16
        opacity: 0;
        source: "image://favicons/"+webView.url
    }

    Image {
        id: defaultFavIcon
        height: parent.height-16
        width: height
        fillMode: Image.PreserveAspectFit
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: 16
        source: "pics/default-favico-30x30.png"
        opacity: 1
    }

    Image {
        id: reloadIcon
        height: parent.height-16
        width: height
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        anchors.rightMargin: 16
        source: "pics/reload-30x30.png"
        opacity: 0.7
        MouseArea {
            anchors.fill: parent
            onClicked: { textEdit.reloadRequested(); }
            onPressed: { parent.opacity = 1; }
            onReleased: { parent.opacity = 0.7; }
        }
    }

    Image {
        id: clearIcon
        height: parent.height-16
        width: height
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        anchors.rightMargin: 16
        source: "pics/clear-30x30.png"
        opacity: 0
        MouseArea {
            anchors.fill: parent
            onClicked: { textEdit.text = ''; }
            onPressed: { parent.opacity = 1; }
            onReleased: { parent.opacity = 0.7; }
        }
    }
    Image {
        id: stopIcon
        height: parent.height-16
        width: height
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        anchors.rightMargin: 16
        source: "pics/stop-30x30.png"
        opacity: 0
        MouseArea {
            anchors.fill: parent
            onClicked: { textEdit.stopRequested(); }
            onPressed: { parent.opacity = 1; }
            onReleased: { parent.opacity = 0.7; }
        }
    }

    Keys.onEnterPressed: {
        textEdit.editFinished();
    }
    Keys.onReturnPressed: {
        textEdit.editFinished();
    }

    onFocusChanged: {
        if (focus)
            selectTimer.start()
    }

    // we must delay the selection on a timer, otherwise something else overwrites it
    Timer {
        id: selectTimer
        interval: 1
        onTriggered: {
            parent.selectAll()
        }
    }

    states: [
        State {
            name: "editingUrl"
            when: textEdit.focus
            PropertyChanges {
                target: clearIcon
                opacity: 0.7
            }
            PropertyChanges {
                target: reloadIcon
                opacity: 0
            }
            PropertyChanges {
                target: stopIcon
                opacity: 0
            }
            PropertyChanges {
                target: textEdit
                readOnly: false
            }
        },
        State {
            name: "loadingUrl"
            when: textEdit.loading
            PropertyChanges {
                target: clearIcon
                opacity: 0
            }
            PropertyChanges {
                target: reloadIcon
                opacity: 0
            }
            PropertyChanges {
                target: stopIcon
                opacity: 0.7
            }
        }
    ]

    transitions: [
        Transition {
            from: ""
            to: "*"
            reversible: true
            NumberAnimation {
                property: "opacity"
                duration: 200
            }
        }
    ]
}
