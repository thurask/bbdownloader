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
                        title: qsTr("Colors") + Retranslate.onLanguageChanged
                    }
                    DropDown {
                        id: colordropdown_main
                        title: qsTr("Primary Color") + Retranslate.onLanguageChanged
                        Option { text: qsTr("Default") + Retranslate.onLanguageChanged; value: Color.create(0xFF0092CC); selected: true }
                        Option { text: qsTr("Red") + Retranslate.onLanguageChanged; value: Color.Red }
                        Option { text: qsTr("Green") + Retranslate.onLanguageChanged; value: Color.Green }
                        Option { text: qsTr("Yellow") + Retranslate.onLanguageChanged; value: Color.Yellow }
                        Option { text: qsTr("Blue") + Retranslate.onLanguageChanged; value: Color.Blue }
                        Option { text: qsTr("Cyan") + Retranslate.onLanguageChanged; value: Color.Cyan }
                        Option { text: qsTr("Gray") + Retranslate.onLanguageChanged; value: Color.Gray }
                        Option { text: qsTr("Magenta") + Retranslate.onLanguageChanged; value: Color.Magenta }
                        onSelectedValueChanged: {
                            Application.themeSupport.setPrimaryColor(colordropdown_main.selectedValue,colordropdown_base.selectedValue)
                        }
                    }
                    DropDown {
                        id: colordropdown_base
                        title: qsTr("Base Color") + Retranslate.onLanguageChanged
                        Option { text: qsTr("Default") + Retranslate.onLanguageChanged; value: Color.create(0xFF087099); selected: true }
                        Option { text: qsTr("Dark Red") + Retranslate.onLanguageChanged; value: Color.DarkRed }
                        Option { text: qsTr("Dark Green") + Retranslate.onLanguageChanged; value: Color.DarkGreen }
                        Option { text: qsTr("Dark Yellow") + Retranslate.onLanguageChanged; value: Color.DarkYellow }
                        Option { text: qsTr("Dark Blue") + Retranslate.onLanguageChanged; value: Color.DarkBlue}
                        Option { text: qsTr("Dark Cyan") + Retranslate.onLanguageChanged; value: Color.DarkCyan}
                        Option { text: qsTr("Dark Gray") + Retranslate.onLanguageChanged; value: Color.DarkGray}
                        Option { text: qsTr("Dark Magenta") + Retranslate.onLanguageChanged; value: Color.DarkMagenta}
                        onSelectedValueChanged: {
                            Application.themeSupport.setPrimaryColor(colordropdown_main.selectedValue,colordropdown_base.selectedValue)
                        }
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
                            defaultlabel.setText(qsTr("Current Directory:\n%1").arg(Settings.getValueFor("defaultdir", "shared/downloads/bbdownloader/")) + Retranslate.onLanguageChanged)
                        }
                    }
                    Label {
                        id: defaultlabel
                        text: qsTr("Current Directory:\n%1").arg(Settings.getValueFor("defaultdir", "shared/downloads/bbdownloader/")) + Retranslate.onLanguageChanged
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
                defaultlabel.setText(qsTr("Current Directory:\n%1").arg(Settings.getValueFor("defaultdir", "shared/downloads/bbdownloader/")) + Retranslate.onLanguageChanged)
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