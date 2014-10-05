/*SettingsSheet.qml
 ------------------
 Settings menu, including theme select.
 
 --Thurask*/

import bb.cascades 1.3
import bb.cascades.pickers 1.0
import bb.system 1.2
import qt.timer 1.0

Sheet {
    id: settingsSheet
    content: Page {
        titleBar: TitleBar {
            title: qsTr("Settings") + Retranslate.onLanguageChanged
            dismissAction: ActionItem {
                title: qsTr("Close") + Retranslate.onLanguageChanged
                onTriggered: {
                    settingsSheet.close()
                    if (settingsSheet) settingsSheet.destroy();
                }
            }
        }
        ScrollView{
            scrollViewProperties.pinchToZoomEnabled: false
            scrollViewProperties.scrollMode: ScrollMode.Vertical
            scrollViewProperties.overScrollEffectMode: OverScrollEffectMode.None
            Container {
                horizontalAlignment: HorizontalAlignment.Center
                Container {
                    Header {
                        title: qsTr("Change Theme") + Retranslate.onLanguageChanged
                    }
                    Button {
                        text: qsTr("Change Theme") + Retranslate.onLanguageChanged
                        horizontalAlignment: HorizontalAlignment.Center
                        onClicked: {
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
                }
                Container {
                    Header {
                        title: qsTr("Download Folder") + Retranslate.onLanguageChanged
                    }
                    Button {
                        text: qsTr("Choose Download Location") + Retranslate.onLanguageChanged
                        horizontalAlignment: HorizontalAlignment.Center
                        onClicked: {
                            picker.open()
                        }
                    }
                    Button {
                        text: qsTr("Default") + Retranslate.onLanguageChanged
                        horizontalAlignment: HorizontalAlignment.Center
                        onClicked: {
                            Settings.saveValueFor("defaultdir", "shared/downloads/bbdownloader/");
                            _manager.setDefaultDir("shared/downloads/bbdownloader/");
                            defaultlabel.setText(qsTr("Current Directory: ") + Retranslate.onLanguageChanged + "\n" + Settings.getValueFor("defaultdir", "shared/downloads/bbdownloader/"))
                        }
                    }
                    Label {
                        id: defaultlabel
                        text: qsTr("Current Directory: ") + Retranslate.onLanguageChanged + "\n" + Settings.getValueFor("defaultdir", "shared/downloads/bbdownloader/")
                        horizontalAlignment: HorizontalAlignment.Center
                        multiline: true
                        textStyle.textAlign: TextAlign.Center
                    }
                }
                Container {
                    Header {
                        title: qsTr("Check for Updates") + Retranslate.onLanguageChanged
                    }
                    Button {
                        text: qsTr("Check") + Retranslate.onLanguageChanged
                        horizontalAlignment: HorizontalAlignment.Center
                        onClicked: {
                            Checker.checkForUpdates();
                            timer.start();
                        }
                    }
                }
            }
        }
    }
    attachedObjects: [
        FilePicker {
            id: picker
            title: qsTr("File Picker") + Retranslate.onLanguageChanged
            mode: FilePickerMode.SaverMultiple
            type: FileType.Other
            defaultType: FileType.Other
            viewMode: FilePickerViewMode.Default
            sortBy: FilePickerSortFlag.Default
            sortOrder: FilePickerSortOrder.Default
            onFileSelected: {
                Settings.saveValueFor("defaultdir", (selectedFiles[0] + "/"))
                _manager.setDefaultDir(selectedFiles[0] + "/")
                defaultlabel.setText(qsTr("Current Directory: ") + Retranslate.onLanguageChanged + "\n" + Settings.getValueFor("defaultdir", "shared/downloads/bbdownloader/"))
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
                    updateToast.body = qsTr("Update available") + Retranslate.onLanguageChanged;
                    updateToast.button.enabled = true;
                    updateToast.button.label =  qsTr("Update!") + Retranslate.onLanguageChanged
                    updateToast.show();
                }
                else {
                    updateToast.body = qsTr("No updates available") + Retranslate.onLanguageChanged;
                    updateToast.button.enabled = false;
                    updateToast.button.label = "";
                    updateToast.show();
                }
                timer.stop()
            }
        }
    ]
}