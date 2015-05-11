TEMPLATE = app
CONFIG += console
CONFIG -= app_bundle
CONFIG -= qt

SOURCES += main.cpp \
    files.cpp \
    filedir.cpp \
    perl.cpp

include(deployment.pri)
qtcAddDeployment()

HEADERS += \
    files.h \
    error.h \
    filedir.h \
    perl.h

DISTFILES += \
    Email.pl

