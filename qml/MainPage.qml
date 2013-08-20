import QtQuick 2.0
import com.nokia.meego 2.0
import "common"

Page {
    id: mainPage
    tools: ToolBarLayout {
        ToolIcon {
            iconSource: "pics/back-30x30.png"
            onClicked: { mainPage.back(); }
        }

        ToolIcon {
            iconSource: "pics/home-30x30.png"
            onClicked: { if (appcore) appcore.loadHomeUrl(); }

        }

        ToolIcon {
            iconSource: "pics/forward-30x30.png"
            onClicked: { mainPage.forward(); }

        }

        InfoBanner {
            id: bookmarkAdded
            text: "Bookmark added"
            iconSource:"pics/bookmark-icon-30x30.png"
        }

        ToolIcon {
            iconSource: "pics/new-bookmark-30x30.png"
            onClicked: {
                bookmarkAdded.show();
                if (appcore)
                    appcore.bookmarkCurrentUrl();
            }
        }

        ToolIcon {
            iconSource: "pics/bookmarks-30x30.png"
            onClicked: { pageStack.openSheet(Qt.resolvedUrl("LogbookSheet.qml")) }

        }

        ToolIcon {
            platformIconId: "toolbar-view-menu";
            anchors.right: parent===undefined ? undefined : parent.right
            onClicked: pageStack.openDialog(Qt.resolvedUrl("MainPageMenu.qml"))
        }
    }

    function back() {
        webView.back.trigger();
    }

    function forward() {
        webView.forward.trigger();
    }

    // Header
    Header {
        id: header
        width: parent.width
        onUrlChanged: { webView.changeUrl(urlString); }
        loading: webView.loading
        z: 3
    }

    // WebView
    FlickableWebView {
        id: webView
        width: parent.width
        anchors.top: header.bottom
        anchors.bottom: parent.bottom

        anchors.left: parent.left
        anchors.right: parent.right
        onGotFocus: { header.abortEdit(); }
        onUrlChanged: { header.setDefaultFavIcon(); header.changeUrl(urlString); }
        onIconChanged: { header.updateFavIcon(); }
        z: 1
    }

    ScrollDecorator {
        flickableItem: webView
        z: 3
    }
}
