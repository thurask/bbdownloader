/*main.qml
 ---------
 Get the party started. Formerly the bulk of the QML, now just a bridge between separate tabs. Extensible!
 
 --Thurask*/

import bb.cascades 1.3

TabbedPane {
    attachedObjects: [
        ComponentDefinition {
            id: helpSheetDefinition
            HelpSheet {
            }
        }
    ]
    Menu.definition: MenuDefinition {
        helpAction: HelpActionItem {
            imageSource: "asset:///images/ic_info.png"
            onTriggered: {
                var help = helpSheetDefinition.createObject()
                help.open();
            }
        }
        actions: [
            ActionItem {
                title: qsTr("Change Theme") + Retranslate.onLanguageChanged
                imageSource: "asset:///images/ic_select.png"
                onTriggered: {
                    if (Application.themeSupport.theme.colorTheme.style == VisualStyle.Bright) {
                        Application.themeSupport.setVisualStyle(VisualStyle.Dark);
                        Settings.saveValueFor("theme", "dark");
                    }
                    else {
                        Application.themeSupport.setVisualStyle(VisualStyle.Bright);
                        Settings.saveValueFor("theme", "bright");
                    }
                }
            }
        ]
    }
    Tab {
        title: qsTr("OS Downloader") + Retranslate.onLanguageChanged
        imageSource: "asset:///images/1.png"
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
        imageSource: "asset:///images/2.png"
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
        imageSource: "asset:///images/3.png"
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
        imageSource: "asset:///images/4.png"
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
        imageSource: "asset:///images/5.png"
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
        imageSource: "asset:///images/6.png"
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
        imageSource: "asset:///images/7.png"
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
}