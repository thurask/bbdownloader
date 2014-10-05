/*main.qml
 ---------
 Get the party started. Formerly the bulk of the QML, now just a bridge between separate tabs. Extensible!
 
 --Thurask*/

import bb.cascades 1.3
import bb.system 1.2
import qt.timer 1.0

TabbedPane {
    attachedObjects: [
        ComponentDefinition {
            id: helpSheetDefinition
            HelpSheet {
            }
        },
        ComponentDefinition {
            id: settingsSheetDefinition
            SettingsSheet {
            }
        },
        SystemToast {
            id: updateToast
            body: qsTr("Update available") + Retranslate.onLanguageChanged
            button.enabled: true
            button.label: qsTr("Update!") + Retranslate.onLanguageChanged
            onFinished: {
                if (updateToast.result == SystemUiResult.ButtonSelection){
                    invoke.trigger("bb.action.OPEN")
                }
            }
        },
        Invocation {
            id: invoke
            query {
                mimeType: "text/html"
                uri: "http://github.com/thurask/bbdownloader/releases/latest"
                invokeActionId: "bb.action.OPEN"
            }
        },
        QTimer {
            id: timer
            interval: 1000
            onTimeout:{
                if (Checker.returnUpdate() == true){
                    updateToast.show();
                }
                timer.stop();
            }
        },
        ActiveFrame {
            id: multi
        }
    ]
    Menu.definition: MenuDefinition {
        helpAction: HelpActionItem {
            onTriggered: {
                var help = helpSheetDefinition.createObject()
                help.open();
            }
        }
        settingsAction: SettingsActionItem {
            onTriggered: {
                var settings = settingsSheetDefinition.createObject()
                settings.open();
            }
        }
    }
    Tab {
        title: qsTr("OS Downloader") + Retranslate.onLanguageChanged
        imageSource: "asset:///images/tabs/1.png"
        delegate: Delegate {
            OSDownloader {
                id:osDownloaderPage
                titleBar: TitleBar {
                    title: qsTr("BB10 OS Downloader %1").arg(AppInfo.version)
                }
            }
        }
        delegateActivationPolicy: TabDelegateActivationPolicy.ActivateWhenSelected
    }
    Tab {
        title: qsTr("Delta OS Downloader") + Retranslate.onLanguageChanged
        imageSource: "asset:///images/tabs/2.png"
        delegate: Delegate {
            DeltaOSDownloader {
                id:deltaOsDownloaderPage
                titleBar: TitleBar {
                    title: qsTr("BB10 OS Downloader %1").arg(AppInfo.version)
                }
            }
        }
        delegateActivationPolicy: TabDelegateActivationPolicy.ActivateWhenSelected
    }
    Tab {
        title: qsTr("OS Lookup Tool") + Retranslate.onLanguageChanged
        imageSource: "asset:///images/tabs/3.png"
        delegate: Delegate {
            AutoLookup {
                id:autoLookupPage
                titleBar: TitleBar {
                    title: qsTr("BB10 OS Downloader %1").arg(AppInfo.version)
                }
            }
        }
        delegateActivationPolicy: TabDelegateActivationPolicy.ActivateWhenSelected
    }
    Tab {
        title: qsTr("Hash Tools") + Retranslate.onLanguageChanged
        imageSource: "asset:///images/tabs/4.png"
        delegate: Delegate {
            HashTools {
                id:hashToolsPage
                titleBar: TitleBar {
                    title: qsTr("BB10 OS Downloader %1").arg(AppInfo.version)
                }
            }
        }
        delegateActivationPolicy: TabDelegateActivationPolicy.ActivateWhenSelected
    }
    Tab {
        title: qsTr("Engineering Screens") + Retranslate.onLanguageChanged
        imageSource: "asset:///images/tabs/5.png"
        delegate: Delegate {
            EScreens {
                id:eScreensPage
                titleBar: TitleBar {
                    title: qsTr("BB10 OS Downloader %1").arg(AppInfo.version)
                }
            }
        }
        delegateActivationPolicy: TabDelegateActivationPolicy.ActivateImmediately
    }
    Tab {
        title: qsTr("System Info") + Retranslate.onLanguageChanged
        imageSource: "asset:///images/tabs/6.png"
        delegate: Delegate {
            SysInfo {
                id:sysInfoPage
                titleBar: TitleBar {
                    title: qsTr("BB10 OS Downloader %1").arg(AppInfo.version)
                }
            }
        }
        delegateActivationPolicy: TabDelegateActivationPolicy.ActivatedWhileSelected
    }
    Tab {
        title: qsTr("Hardware ID List") + Retranslate.onLanguageChanged
        imageSource: "asset:///images/tabs/7.png"
        delegate: Delegate {
            HardwareIDs {
                id:hardwareIDsPage
                titleBar: TitleBar {
                    title: qsTr("BB10 OS Downloader %1").arg(AppInfo.version)
                }
            }
        }
        delegateActivationPolicy: TabDelegateActivationPolicy.ActivateWhenSelected
    }
    Tab {
        title: qsTr(".nomedia Helper") + Retranslate.onLanguageChanged
        imageSource: "asset:///images/tabs/8.png"
        delegate: Delegate {
            Nomedia {
                id: nomediaPage
                titleBar: TitleBar {
                    title: qsTr("BB10 OS Downloader %1").arg(AppInfo.version)
                }
            }
        }
        delegateActivationPolicy: TabDelegateActivationPolicy.ActivateWhenSelected
    }
    onCreationCompleted: {
        var defaultdir = Settings.getValueFor("defaultdir", "shared/downloads/bbdownloader/");
        _manager.setDefaultDir(defaultdir);
        Checker.checkForUpdates();
        timer.start();
        Application.setCover(multi);
    }
}