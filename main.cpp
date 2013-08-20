#include <QGuiApplication>
#include "qmlapplicationviewer.h"
#include "src/Core.h"

Q_DECL_EXPORT int main(int argc, char *argv[])
{
    QScopedPointer<QGuiApplication> app(createApplication(argc, argv));
    QScopedPointer<QmlApplicationViewer> viewer(QmlApplicationViewer::create());

    viewer->setOrientation(QmlApplicationViewer::ScreenOrientationAuto);
    Core *core;
    if( app->arguments().length() > 1 ) {
        core = new Core(viewer.data(), app->arguments().last());
    } else {
        core = new Core(viewer.data());
    }

    viewer->setTitle("Browser");
    viewer->setMainQmlFile("/usr/share/heliumreborn/main.qml");

    core->start();

    viewer->showExpanded();




    return app->exec();
}
