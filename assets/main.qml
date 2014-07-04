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
            onTriggered: {
                var settings = settingsSheetDefinition.createObject()
                settings.open();
            }
        }
    }
    Tab {
        title: "OS Downloader"
        OSDownloader {
            id:osDownloaderPage
            titleBar: TitleBar {
                title: qsTr("BB10 OS Downloader %1").arg(AppInfo.version)
            }
        }
    }
    Tab {
        title: "OS Lookup Tool"
        AutoLookup {
            id:autoLookupPage
            titleBar: TitleBar {
                title: qsTr("BB10 OS Downloader %1").arg(AppInfo.version)
            }
        }
    }
    Tab {
        title: "Hash Tools"
        HashTools {
            id:hashToolsPage
            titleBar: TitleBar {
                title: qsTr("BB10 OS Downloader %1").arg(AppInfo.version)
            }
        }
    }
}