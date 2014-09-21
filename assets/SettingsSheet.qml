/*SettingsSheet.qml
 ------------------
 Settings menu, including theme select.
 
 --Thurask*/

import bb.cascades 1.3
import bb.cascades.pickers 1.0
import bb.system 1.2

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
        Container {
            horizontalAlignment: HorizontalAlignment.Center
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
            id: hashToast
            body: ""
        }]
}