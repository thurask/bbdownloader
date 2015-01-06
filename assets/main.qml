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
            body: qsTr("%1 = OS Link Generator").arg(qsTr("o") + Retranslate.onLanguageChanged) + Retranslate.onLanguageChanged + "\n"
            + qsTr("%1 = OS Lookup Tool").arg(qsTr("l") + Retranslate.onLanguageChanged) + Retranslate.onLanguageChanged + "\n"
            + qsTr("%1 = Engineering Screens").arg(qsTr("e") + Retranslate.onLanguageChanged) + Retranslate.onLanguageChanged + "\n"
            + qsTr("%1 = System Info").arg(qsTr("s") + Retranslate.onLanguageChanged) + Retranslate.onLanguageChanged + "\n"
            + qsTr("%1 = File Operations").arg(qsTr("f") + Retranslate.onLanguageChanged) + Retranslate.onLanguageChanged + "\n"
            + qsTr("%1 = Certification Browser").arg(qsTr("p") + Retranslate.onLanguageChanged) + Retranslate.onLanguageChanged
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
            interval: 5000
            onTimeout:{
                if (Checker.returnUpdate() == true){
                    updateToast.show();
                    timer.stop();
                }
            }
        },
        ActiveFrame {
            id: multi
        }
    ]
    shortcuts: [
        Shortcut {
            id: shortcut_o
            key: "o"
            onTriggered: {
                tabbedpane.activeTab = tab_osgen
            }  
        },
        Shortcut {
            id: shortcut_l
            key: "l"
            onTriggered: {
                tabbedpane.activeTab = tab_lookup
            }
        },
        Shortcut {
            id: shortcut_e
            key: "e"
            onTriggered: {
                tabbedpane.activeTab = tab_escreens
            }
        },
        Shortcut {
            id: shortcut_s
            key: "s"
            onTriggered: {
                tabbedpane.activeTab = tab_sysinfo
            }
        },
        Shortcut {
            id: shortcut_f
            key: "f"
            onTriggered: {
                tabbedpane.activeTab = tab_fileops
            }
        },
        Shortcut {
            id: shortcut_p
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
        imageSource: "asset:///images/menus/ic_qs_mobilehotspot.png"
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
        imageSource: "asset:///images/menus/ic_search.png"
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
                onLookupStarted: {
                    shortcut_o.enabled = false;
                    shortcut_l.enabled = false;
                    shortcut_e.enabled = false;
                    shortcut_s.enabled = false;
                    shortcut_f.enabled = false;
                    shortcut_p.enabled = false;
                    tab_osgen.enabled = false;
                    tab_escreens.enabled = false;
                    tab_sysinfo.enabled = false;
                    tab_fileops.enabled = false;
                    tab_ptcrb.enabled = false;
                }
                onLookupStopped: {
                    shortcut_o.enabled = true;
                    shortcut_l.enabled = true;
                    shortcut_e.enabled = true;
                    shortcut_s.enabled = true;
                    shortcut_f.enabled = true;
                    shortcut_p.enabled = true;
                    tab_osgen.enabled = true;
                    tab_escreens.enabled = true;
                    tab_sysinfo.enabled = true;
                    tab_fileops.enabled = true;
                    tab_ptcrb.enabled = true;
                }
            }
        }
        delegateActivationPolicy: TabDelegateActivationPolicy.ActivateWhenSelected
    }
    Tab {
        id: tab_escreens
        title: qsTr("Engineering Screens") + Retranslate.onLanguageChanged
        imageSource: "asset:///images/menus/ic_qs_developer_mode.png"
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
        imageSource: "asset:///images/menus/ic_info.png"
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
        imageSource: "asset:///images/menus/ic_doctype_generic.png"
        delegate: Delegate {
            FileOps {
                id: fileOpsPage
                pageBar: CustomTitleBar {
                }
            }
        }
        delegateActivationPolicy: TabDelegateActivationPolicy.ActivateWhenSelected
    }
    Tab {
        id: tab_ptcrb
        title: qsTr("Certification Browser") + Retranslate.onLanguageChanged
        imageSource: "asset:///images/menus/ic_certificate_import.png"
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