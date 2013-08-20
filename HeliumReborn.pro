TARGET = heliumreborn

TEMPLATE = app

QT += qml quick \
    gui \
    core \
    network \
    webkit \
    opengl \
    sql

# Additional import path used to resolve QML modules in Creator's code model
#QML_IMPORT_PATH =

#symbian:TARGET.UID3 = 0xE244D944

# Smart Installer package's UID
# This UID is from the protected range and therefore the package will
# fail to install if self-signed. By default qmake uses the unprotected
# range value if unprotected UID is defined for the application and
# 0x2002CCCF value if protected UID is given to the application
#symbian:DEPLOYMENT.installer_header = 0x2002CCCF

# Allow network access on Symbian
#symbian:TARGET.CAPABILITY += NetworkServices

# If your application uses the Qt Mobility libraries, uncomment the following
# lines and add the respective components to the MOBILITY variable.
# CONFIG += mobility
# MOBILITY +=

# Speed up launching on MeeGo/Harmattan when using applauncherd daemon
CONFIG += qdeclarative5-boostable

# Add dependency to Symbian components
# CONFIG += qt-components

# The .cpp file which was generated for your project. Feel free to hack it.
SOURCES += main.cpp \
    src/Core.cpp \
    src/Logbook.cpp \
    src/FaviconImageProvider.cpp \
    src/CoreDbHelper.cpp \
    src/models/LinkItemsSharedCaches.cpp \
    src/models/HistoryListModel.cpp \
    src/models/BookmarksListModel.cpp \
    src/WebViewInterface.cpp \
    src/Settings.cpp \
    src/models/MostVisitedListModel.cpp \
    src/utility/SqliteDbHelper.cpp



#RESOURCES += \
#    res.qrc

HEADERS += \
    src/Core.h \
    src/LogbookLinkItems.h \
    src/Logbook.h \
    src/LinkItem.h \
    src/FaviconImageProvider.h \
    src/CoreDbHelper.h \
    src/models/LinkItemsSharedCaches.h \
    src/models/HistoryListModel.h \
    src/models/BookmarksListModel.h \
    src/WebViewInterface.h \
    src/Settings.h \
    src/models/MostVisitedListModel.h \
    src/utility/SqliteDbHelper.h \
    src/utility/macros.h \
    src/utility/Declarativable.h \
    src/buildconfig.h

INCLUDEPATH+=src \
             src/utility

#OTHER_FILES += \
#    main.qml \
#    qml/MainPage.qml \
#    qml/LogbookView.qml \
#    qml/Header.qml \
#    qml/FlickableWebView.qml \
#    qml/FieldText.qml \
#    qml/common/VScrollDropShadow.qml \
#    qml/common/TopDropShadow.qml \
#    qml/common/EmbossedButton.qml \
#    qml/common/BottomDropShadow.qml \
#    qml/common/Background.qml \
#    qml/LogbookViewComponents/TabButton.qml \
#    qml/LogbookViewComponents/TabBar.qml \
#    qml/LogbookViewComponents/MostVisitedListView.qml \
#    qml/LogbookViewComponents/LogbookListView.qml \
#    qml/LogbookViewComponents/HistoryListView.qml \
#    qml/LogbookViewComponents/Header.qml \
#    qml/LogbookViewComponents/BookmarksListView.qml \
#    rpm/heliumreborn.desktop




# QML files and folders
#qml.files += \
#    main.qml \
#    qml/MainPage.qml \
#    qml/LogbookView.qml \
#    qml/Header.qml \
#    qml/FlickableWebView.qml \
#    qml/FieldText.qml \
#    qml/common/VScrollDropShadow.qml \
#    qml/common/TopDropShadow.qml \
#    qml/common/EmbossedButton.qml \
#    qml/common/BottomDropShadow.qml \
#    qml/common/Background.qml \
#    qml/LogbookViewComponents/TabButton.qml \
#    qml/LogbookViewComponents/TabBar.qml \
#    qml/LogbookViewComponents/MostVisitedListView.qml \
#    qml/LogbookViewComponents/LogbookListView.qml \
#    qml/LogbookViewComponents/HistoryListView.qml \
#    qml/LogbookViewComponents/Header.qml \
#    qml/LogbookViewComponents/BookmarksListView.qml \

qml.files = main.qml *.qml qml qml/common qml/LogBookViewcomponents

# The .desktop file
desktop.files = heliumreborn.desktop

# Please do not modify the following two lines. Required for deployment.
#target.path=/usr/bin
#include(qmlapplicationviewer/qmlapplicationviewer.pri)
#qtcAddDeployment()

DEPLOYMENT_PATH = /usr/share/$$TARGET

# Icons
icons.files = pics/*.png
icons.path = $$DEPLOYMENT_PATH/qml/pics
INSTALLS += icons

OTHER_FILES = rpm/heliumreborn.yaml


SOURCES += qmlapplicationviewer/qmlapplicationviewer.cpp
HEADERS += qmlapplicationviewer/qmlapplicationviewer.h
INCLUDEPATH += qmlapplicationviewer

TARGETPATH = /usr/bin
target.path = $$TARGETPATH

qml.path = $$DEPLOYMENT_PATH
desktop.path = /usr/share/applications

contains(CONFIG, desktop) {
    DEFINES *= DESKTOP
    QT += opengl
}

INSTALLS += target qml desktop

DEFINES += DEPLOYMENT_PATH=\"\\\"\"$${DEPLOYMENT_PATH}/\"\\\"\"

CONFIG += link_pkgconfig
packagesExist(qdeclarative5-boostable) {
    message("Building with qdeclarative5-boostable support")
    DEFINES += HAS_BOOSTER
    PKGCONFIG += qdeclarative5-boostable
} else {
    warning("qdeclarative5-boostable not available; startup times will be slower")
}








