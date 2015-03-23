/*SettingsSheet.qml
 ------------------
 Settings menu, including theme select.

 --Thurask*/

import bb.cascades 1.4
import bb.cascades.pickers 1.0
import bb.system 1.2
import qt.timer 1.0

Sheet {
    signal colorsChanged(variant maincolor, variant basecolor)
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
            scrollRole: ScrollRole.Main
            scrollViewProperties.pinchToZoomEnabled: false
            scrollViewProperties.scrollMode: ScrollMode.Vertical
            scrollViewProperties.overScrollEffectMode: OverScrollEffectMode.None
            Container {
                horizontalAlignment: HorizontalAlignment.Center
                Container {
                    horizontalAlignment: HorizontalAlignment.Center
                    topPadding: ui.du(0.5)
                    Button {
                        text: qsTr("Check for Updates") + Retranslate.onLanguageChanged
                        horizontalAlignment: HorizontalAlignment.Center
                        onClicked: {
                            Checker.checkForUpdates();
                            timer.start();
                        }
                    }
                }
                Container {
                    Header {
                        title: qsTr("Colors") + Retranslate.onLanguageChanged
                    }
                    DropDown {
                        id: colordropdown_main
                        title: qsTr("Primary") + Retranslate.onLanguageChanged
                        selectedIndex: Settings.getValueFor("index_maincolor", 0)
                        options: [
                            Option {
                                text: qsTr("Default") + Retranslate.onLanguageChanged
                                value: dummy_main.background
                            },
                            Option {
                                text: qsTr("Red") + Retranslate.onLanguageChanged
                                value: Color.Red
                            },
                            Option {
                                text: qsTr("Green") + Retranslate.onLanguageChanged
                                value: Color.Green
                            },
                            Option {
                                text: qsTr("Yellow") + Retranslate.onLanguageChanged
                                value: Color.Yellow
                            },
                            Option {
                                text: qsTr("Blue") + Retranslate.onLanguageChanged
                                value: Color.Blue
                            },
                            Option {
                                text: qsTr("Cyan") + Retranslate.onLanguageChanged
                                value: Color.Cyan
                            },
                            Option {
                                text: qsTr("Gray") + Retranslate.onLanguageChanged
                                value: Color.Gray
                            },
                            Option {
                                text: qsTr("Magenta") + Retranslate.onLanguageChanged
                                value: Color.Magenta
                            }
                        ]
                        onSelectedOptionChanged: {
                            Settings.saveValueFor("index_maincolor", colordropdown_main.selectedIndex)
                            Settings.saveValueFor("maincolor", colordropdown_main.selectedValue)
                            Application.themeSupport.setPrimaryColor(colordropdown_main.selectedValue,colordropdown_base.selectedValue)
                            Application.themeSupport.setPrimaryColor(colordropdown_main.selectedValue,colordropdown_base.selectedValue) //have to do this twice to get *everything* to update
                            colorsChanged(colordropdown_main.selectedValue, colordropdown_base.selectedValue)
                        }
                    }
                    DropDown {
                        id: colordropdown_base
                        title: qsTr("Base") + Retranslate.onLanguageChanged
                        selectedIndex: Settings.getValueFor("index_basecolor", 0)
                        options: [
                            Option {
                                text: qsTr("Default") + Retranslate.onLanguageChanged
                                value: dummy_base.background
                            },
                            Option {
                                text: qsTr("Dark Red") + Retranslate.onLanguageChanged
                                value: Color.DarkRed
                            },
                            Option {
                                text: qsTr("Dark Green") + Retranslate.onLanguageChanged
                                value: Color.DarkGreen
                            },
                            Option {
                                text: qsTr("Dark Yellow") + Retranslate.onLanguageChanged
                                value: Color.DarkYellow
                            },
                            Option {
                                text: qsTr("Dark Blue") + Retranslate.onLanguageChanged
                                value: Color.DarkBlue
                            },
                            Option {
                                text: qsTr("Dark Cyan") + Retranslate.onLanguageChanged
                                value: Color.DarkCyan
                            },
                            Option {
                                text: qsTr("Dark Gray") + Retranslate.onLanguageChanged
                                value: Color.DarkGray
                            },
                            Option {
                                text: qsTr("Dark Magenta") + Retranslate.onLanguageChanged
                                value: Color.DarkMagenta
                            }
                        ]
                        onSelectedOptionChanged: {
                            Settings.saveValueFor("index_basecolor", colordropdown_base.selectedIndex)
                            Settings.saveValueFor("basecolor", colordropdown_base.selectedValue)
                            Application.themeSupport.setPrimaryColor(colordropdown_main.selectedValue,colordropdown_base.selectedValue)
                            Application.themeSupport.setPrimaryColor(colordropdown_main.selectedValue,colordropdown_base.selectedValue) //seriously, screw themeSupport
                            colorsChanged(colordropdown_main.selectedValue, colordropdown_base.selectedValue)
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
                    Container {
                        id: dummy_main
                        visible: false
                        background: Color.create("#FF0092CC")
                    }
                    Container {
                        id: dummy_base
                        visible: false
                        background: Color.create("#FF087099")
                    }
                }
            }
        }
    }
    onCreationCompleted: {
        colordropdown_base.at(0).value = dummy_base.background
        colordropdown_main.at(0).value = dummy_main.background
        var baseindex = Settings.getValueFor("index_basecolor", "0")
        var primindex = Settings.getValueFor("index_maincolor", "0")
        colordropdown_base.setSelectedIndex(baseindex)
        colordropdown_main.setSelectedIndex(primindex)
        Application.themeSupport.setPrimaryColor(colordropdown_main.selectedValue,colordropdown_base.selectedValue)
        Application.themeSupport.setPrimaryColor(colordropdown_main.selectedValue,colordropdown_base.selectedValue)
        colorsChanged(colordropdown_main.selectedValue, colordropdown_base.selectedValue)
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