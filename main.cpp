#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QLoggingCategory>
#include <QScreen>
#include <QObject>
#include <string>
#include <main.h>
#include <QQmlContext>
#include <QInputMethod>
#if defined (Q_OS_ANDROID)
#include <QtAndroid>

bool requestAndroidPermissions(){
    //Request requiered permissions at runtime

    const QVector<QString> permissions({"android.permission.ACCESS_FINE_LOCATION"
                                        });

    for(const QString &permission : permissions){
        auto result = QtAndroid::checkPermission(permission);
        if(result == QtAndroid::PermissionResult::Denied){
            auto resultHash = QtAndroid::requestPermissionsSync(QStringList({permission}));
            if(resultHash[permission] == QtAndroid::PermissionResult::Denied)
                return false;
        }
    }

    return true;
}
#endif



int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    QScreen *screen = QGuiApplication::screens().at(0);

    int width = screen->availableGeometry().width();
    int height = screen->availableGeometry().height();

    SData sd;
    sd.setWidth(width);
    sd.setHeight(height);




//    int scale = width/360;
//    printf("Hight: %f, Widh: %f",height,  width);
//    std::string sc;
//    sc = std::to_string(scale);+
//    char scle[sc.size()+1];
//    sc.copy(scle,sc.size());

//    qputenv("QT_SCALE_FACTOR",scle);

#if defined (Q_OS_ANDROID)
    if(!requestAndroidPermissions())
        return -1;
#endif
    QLoggingCategory::setFilterRules("default.debug=true");

    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("sd",&sd);
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
