import QtQuick 2.0
import com.nokia.meego 2.0
import "qml"

PageStackWindow {
    id: appWindow
    property bool errorDialogOpen

    initialPage: MainPage {
    }

    Connections {
        target: appcore
        onSslError: {
            if (appWindow.errorDialogOpen)
                return

            appWindow.errorDialogOpen = true
            var dialog = pageStack.openDialog(Qt.resolvedUrl("SslWarningDialog.qml"))
            dialog.text="<b>SSL error</b><p>Site cannot be securely authenticated. <p>Error Message:<br>"+errorMsg;
            dialog.accepted.connect(function() { appWindow.errorDialogOpen = false })
            dialog.rejected.connect(function() { appWindow.errorDialogOpen = false })
        }
    }
}
