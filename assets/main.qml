/*main.qml
 ---------
 Get the party started. Formerly the bulk of the QML, now just a bridge between separate tabs. Extensible!
 
 --Thurask*/

import bb.cascades 1.4
import bb.system 1.2
import qt.timer 1.0

TabbedPane {
    id: tabbedpane
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
        SystemDialog {
            id: shortcutDialog
            title: qsTr("Keyboard Shortcuts") + Retranslate.onLanguageChanged
            cancelButton.enabled: false
            customButton.enabled: false
            body: qsTr("o = OS Link Generator") + Retranslate.onLanguageChanged + "\n"
            + qsTr("l = OS Lookup Tool") + Retranslate.onLanguageChanged + "\n"
            + qsTr("e = Engineering Screens") + Retranslate.onLanguageChanged + "\n"
            + qsTr("s = System Info") + Retranslate.onLanguageChanged + "\n"
            + qsTr("f = File Operations") + Retranslate.onLanguageChanged + "\n"
            + qsTr("p = Certification Browser") + Retranslate.onLanguageChanged
            includeRememberMe: false
            rememberMeChecked: false
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
            singleShot: true
            interval: 5000
            onTimeout:{
                if (Checker.returnUpdate() == true){
                    updateToast.show();
                }
            }
        },
        ActiveFrame {
            id: multi
        }
    ]
    shortcuts: [
        Shortcut {
            key: "o"
            onTriggered: {
                tabbedpane.activeTab = tab_osgen
            }  
        },
        Shortcut {
            key: "l"
            onTriggered: {
                tabbedpane.activeTab = tab_lookup
            }
        },
        Shortcut {
            key: "e"
            onTriggered: {
                tabbedpane.activeTab = tab_escreens
            }
        },
        Shortcut {
            key: "s"
            onTriggered: {
                tabbedpane.activeTab = tab_sysinfo
            }
        },
        Shortcut {
            key: "f"
            onTriggered: {
                tabbedpane.activeTab = tab_fileops
            }
        },
        Shortcut {
            key: "p"
            onTriggered: {
                tabbedpane.activeTab = tab_ptcrb
            }
        }
    ]
    Menu.definition: MenuDefinition {
        id: menu
        helpAction: HelpActionItem {
            imageSource: "asset:///images/menus/ic_help.png"
            onTriggered: {
                var help = helpSheetDefinition.createObject()
                help.open();
            }
        }
        settingsAction: SettingsActionItem {
            imageSource: "asset:///images/menus/ic_settings.png"
            onTriggered: {
                var settings = settingsSheetDefinition.createObject()
                settings.open();
            }
        }
        actions: [
            ActionItem {
                title: qsTr("Keyboard Shortcuts") + Retranslate.onLanguageChanged
                imageSource: "asset:///images/menus/ic_show_vkb.png"
                onTriggered: {
                    shortcutDialog.show()
                }
            }
        ]
    }
    Tab {
        id: tab_osgen
        title: qsTr("OS Link Generator") + Retranslate.onLanguageChanged
        imageSource: "asset:///images/tabs/1.png"
        delegate: Delegate {
            OSDownloader {
                id: osDownloaderPage
                titleBar: CustomTitleBar {
                }
            }
        }
        delegateActivationPolicy: TabDelegateActivationPolicy.ActivateWhenSelected
    }
    Tab {
        id: tab_lookup
        title: qsTr("OS Lookup Tool") + Retranslate.onLanguageChanged
        imageSource: "asset:///images/tabs/2.png"
        delegate: Delegate {
            AutoLookup {
                id: autoLookupPage
                titleBar: CustomTitleBar {
                    acceptAction.enabled: true
                    acceptAction.title: qsTr("Metadata") + Retranslate.onLanguageChanged
                    acceptAction.onTriggered: {
                        var metadata = metadatadefinition.createObject()
                        metadata.open();
                    }
                    attachedObjects: [
                        ComponentDefinition {
                            id: metadatadefinition
                            MetadataSheet {
                            }
                        }
                    ]
                }
            }
        }
        delegateActivationPolicy: TabDelegateActivationPolicy.ActivateWhenSelected
    }
    Tab {
        id: tab_escreens
        title: qsTr("Engineering Screens") + Retranslate.onLanguageChanged
        imageSource: "asset:///images/tabs/3.png"
        delegate: Delegate {
            EScreens {
                id: eScreensPage
                titleBar: CustomTitleBar {
                }
            }
        }
        delegateActivationPolicy: TabDelegateActivationPolicy.ActivateImmediately
    }
    Tab {
        id: tab_sysinfo
        title: qsTr("System Info") + Retranslate.onLanguageChanged
        imageSource: "asset:///images/tabs/4.png"
        delegate: Delegate {
            SysInfo {
                id: sysInfoPage
                titleBar: CustomTitleBar {
                    acceptAction.enabled: true
                    acceptAction.title: qsTr("Hardware IDs") + Retranslate.onLanguageChanged
                    acceptAction.onTriggered: {
                        var hwids = hardwareIDsDefinition.createObject()
                        hwids.open();
                    }
                    attachedObjects: [
                        ComponentDefinition {
                            id: hardwareIDsDefinition
                            HardwareIDs {
                            }
                        }
                    ]
                }
            }
        }
        delegateActivationPolicy: TabDelegateActivationPolicy.ActivatedWhileSelected
    }
    Tab {
        id: tab_fileops
        title: qsTr("File Operations") + Retranslate.onLanguageChanged
        imageSource: "asset:///images/tabs/5.png"
        delegate: Delegate {
            FileOps {
                id: fileOpsPage
                titleBar: CustomTitleBar {
                }
            }
        }
        delegateActivationPolicy: TabDelegateActivationPolicy.ActivateWhenSelected
    }
    Tab {
        id: tab_ptcrb
        title: qsTr("Certification Browser") + Retranslate.onLanguageChanged
        imageSource: "asset:///images/tabs/6.png"
        delegate: Delegate {
            CertViewer {
                id: certViewerPage
                tbar: CustomTitleBar {
                }
            }
        }
        delegateActivationPolicy: TabDelegateActivationPolicy.ActivateWhenSelected
    }
    onCreationCompleted: {
        _metadata.getMetadata()
        var defaultdir = Settings.getValueFor("defaultdir", "shared/downloads/bbdownloader/");
        _manager.setDefaultDir(defaultdir);
        Checker.checkForUpdates();
        timer.start();
        Application.setCover(multi);
    }
}