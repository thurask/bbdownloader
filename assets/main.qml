/*main.qml
 ---------
 Get the party started. Formerly the bulk of the QML, now just a bridge between separate tabs. Extensible!
 
 --Thurask*/

import bb.cascades 1.2

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
            //title: "Change Theme"
            onTriggered: {
                var settings = settingsSheetDefinition.createObject()
                settings.open();
            }
        }
    }
    Tab {
        title: qsTr("OS Downloader") + Retranslate.onLanguageChanged
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
        title: qsTr("OS Lookup Tool") + Retranslate.onLanguageChanged
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
}