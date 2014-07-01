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
        }
    }
    Tab {
        title: "OS Lookup Tool"
        AutoLookup {
            id:autoLookupPage
        }
    }
}