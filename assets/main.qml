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
                /* 10.3:
                if (Application.themeSupport.theme.colorTheme.style == VisualStyle.Bright) {
                Application.themeSupport.setVisualStyle(VisualStyle.Dark);
                }
                else {
                Application.themeSupport.setVisualStyle(VisualStyle.Bright);
                }*/
            }
        }
    }
    Tab {
        title: "OS Downloader"
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
        title: "OS Lookup Tool"
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
        title: "Hash Tools"
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
        title: "Engineering Screens"
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
        title: "System Info"
        delegate: Delegate {
            SysInfo {
                id:sysInfoPage
                titleBar: TitleBar {
                    title: qsTr("BB10 OS Downloader %1").arg(AppInfo.version)
                }
            }
        }
        delegateActivationPolicy: TabDelegateActivationPolicy.ActivateWhenSelected
    }
}