TARGET = QtCloudMessagingFirebase
QT = core cloudmessaging
CONFIG += static
HEADERS += \
    qcloudmessagingfirebaseclient.h \
    qcloudmessagingfirebaseprovider.h \
    qcloudmessagingfirebaseclient_p.h \
    qcloudmessagingfirebaseprovider_p.h \
    qcloudmessagingfirebaserest.h

SOURCES += \
    $$PWD/qcloudmessagingfirebaseclient.cpp \
    $$PWD/qcloudmessagingfirebaseprovider.cpp \
    qcloudmessagingfirebaserest.cpp

# Check for GOOGLE_FIREBASE_SDK environment variable
ENV_GOOGLE_FIREBASE_SDK = $$(GOOGLE_FIREBASE_SDK)

# Or define GOOGLE_FIREBASE_SDK path here
GOOGLE_FIREBASE_SDK =

isEmpty(ENV_GOOGLE_FIREBASE_SDK) {
    isEmpty(GOOGLE_FIREBASE_SDK) {
        message("GOOGLE_FIREBASE_SDK" environment variable not detected!)
    }
}

INCLUDEPATH += $$(GOOGLE_FIREBASE_SDK)
INCLUDEPATH += $$(GOOGLE_FIREBASE_SDK)/include

android {
   QT += androidextras
   LIBS += $$(GOOGLE_FIREBASE_SDK)/libs/android/$$ANDROID_TARGET_ARCH/gnustl/libfirebase_messaging.a
   LIBS += $$(GOOGLE_FIREBASE_SDK)/libs/android/$$ANDROID_TARGET_ARCH/gnustl/libfirebase_app.a
} else: macos {
    LIBS += -F$$(GOOGLE_FIREBASE_SDK)/frameworks/darwin \
       -framework firebase \
       -framework firebase_messaging
} else: ios {
    LIBS += -F$$(GOOGLE_FIREBASE_SDK)/frameworks/ios/universal \
       -framework firebase_messaging \
       -framework firebase \
       -framework Foundation \
       -framework UserNotifications \
       -framework UIKit \
       -framework CoreGraphics
}

load(qt_module)
