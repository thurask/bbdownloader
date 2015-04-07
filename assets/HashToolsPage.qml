/*HashToolsPage.qml
 * ----------------
 * Miscellaneous tools (hash, nomedia, blank icon). Most of this is hash tools, hence the name.
 *
 --Thurask*/

import bb.cascades 1.4
import bb.cascades.pickers 1.0
import bb.platform 1.3
import bb.system 1.2

Page {
    property bool pickermode
    property string hashmode
    actions: [
        ActionItem {
            title: qsTr("Blank Icon") + Retranslate.onLanguageChanged
            imageSource: "asset:///images/menus/ic_home.png"
            ActionBar.placement: ActionBarPlacement.Signature
            onTriggered: {
                homeScreen.addShortcut("asset:///images/blank/blank.png", "\uFEFF", "sicwipe://"); //URI does nothing, duh
                icontoast.show()
            }
        }
    ]
    Container {
        Header {
            title: qsTr("Hash Tools") + Retranslate.onLanguageChanged
        }
        attachedObjects: [
            FilePicker {
                id: picker
                property string selectedFile
                title: qsTr("File Picker") + Retranslate.onLanguageChanged
                mode: FilePickerMode.Picker
                type: FileType.Other
                viewMode: FilePickerViewMode.Default
                sortBy: FilePickerSortFlag.Default
                sortOrder: FilePickerSortOrder.Default
                onFileSelected: {
                    selectedFile = selectedFiles[0]
                }
            },
            SystemToast {
                id: hashToast
                body: ""
            },
            HomeScreen {
                id: homeScreen
            },
            SystemToast {
                id: icontoast
                body: qsTr("Added!") + Retranslate.onLanguageChanged
            }
        ]
        Container {
            layout: StackLayout {
                orientation: LayoutOrientation.TopToBottom
            }
            topPadding: ui.du(0.5)
            Container {
                layout: StackLayout {
                    orientation: LayoutOrientation.LeftToRight
                }
                horizontalAlignment: HorizontalAlignment.Center
                Label {
                    text: qsTr("File mode:") + Retranslate.onLanguageChanged
                    verticalAlignment: VerticalAlignment.Center
                }
                ToggleButton {
                    id: togglebutton
                    verticalAlignment: VerticalAlignment.Center
                    onCheckedChanged: {
                        if (checked == true) {
                            pickermode = true;
                        } else {
                            pickermode = false;
                        }
                    }
                }
            }
            Divider {
            }
            Container {
                id: textmodecontainer
                visible: (pickermode == false)
                Label {
                    text: qsTr("Enter text:") + Retranslate.onLanguageChanged
                }
                TextField {
                    id: hashinput
                    hintText: qsTr("Text to be hashed") + Retranslate.onLanguageChanged
                    clearButtonVisible: true
                }
            }
            Container {
                id: pickermodecontainer
                visible: (pickermode == true)
                layout: StackLayout {
                    orientation: LayoutOrientation.TopToBottom
                }
                horizontalAlignment: HorizontalAlignment.Center
                Button {
                    text: qsTr("Choose a file") + Retranslate.onLanguageChanged
                    onClicked: {
                        resultLabel.visible = true;
                        picker.open();
                    }
                }
                Label {
                    id: resultLabel
                    horizontalAlignment: HorizontalAlignment.Center
                    text: picker.selectedFile
                    multiline: true
                }
            }
            Container {
                layout: StackLayout {
                    orientation: LayoutOrientation.TopToBottom
                }
                Container {
                    topPadding: ui.du(0.5)
                    layout: StackLayout {
                        orientation: LayoutOrientation.LeftToRight
                    }
                    Button {
                        text: "MD4"
                        horizontalAlignment: HorizontalAlignment.Left
                        onClicked: {
                            hashmode = "MD4";
                            hashoutput_label.text = qsTr("Hashed output (MD4):") + Retranslate.onLanguageChanged;
                            if (pickermode == false) {
                                _hashgen.calculateHash(hashinput.text, 0, 0)
                                hashoutput.text = _hashgen.returnHash()
                            } else {
                                _hashgen.calculateHash(picker.selectedFile, 0, 1)
                                hashoutput.text = _hashgen.returnHash()
                            }
                        }
                    }
                    Button {
                        text: "SHA-1"
                        horizontalAlignment: HorizontalAlignment.Center
                        onClicked: {
                            hashmode = "SHA1"
                            hashoutput_label.text = qsTr("Hashed output (SHA-1):") + Retranslate.onLanguageChanged;
                            if (pickermode == false) {
                                _hashgen.calculateHash(hashinput.text, 2, 0)
                                hashoutput.text = _hashgen.returnHash()
                            } else {
                                _hashgen.calculateHash(picker.selectedFile, 2, 1)
                                hashoutput.text = _hashgen.returnHash()
                            }
                        }
                    }
                    Button {
                        text: "MD5"
                        horizontalAlignment: HorizontalAlignment.Right
                        onClicked: {
                            hashmode = "MD5"
                            hashoutput_label.text = qsTr("Hashed output (MD5):") + Retranslate.onLanguageChanged;
                            if (pickermode == false) {
                                _hashgen.calculateHash(hashinput.text, 1, 0)
                                hashoutput.text = _hashgen.returnHash()
                            } else {
                                _hashgen.calculateHash(picker.selectedFile, 1, 1)
                                hashoutput.text = _hashgen.returnHash()
                            }
                        }
                    }
                }
            }
            Container {
                topPadding: ui.du(1.5)
                layout: StackLayout {
                    orientation: LayoutOrientation.TopToBottom
                }
                Label {
                    id: hashoutput_label
                    text: qsTr("Hashed output:") + Retranslate.onLanguageChanged
                }
                TextArea {
                    id: hashoutput
                    editable: false
                }
                Container {
                    horizontalAlignment: HorizontalAlignment.Center
                    layout: StackLayout {
                        orientation: LayoutOrientation.LeftToRight
                    }
                    Button {
                        id: exportbutton
                        text: qsTr("Export to file") + Retranslate.onLanguageChanged
                        onClicked: {
                            hashToast.body = qsTr("Hash saved to default directory") + Retranslate.onLanguageChanged;
                            hashToast.show();
                            if (togglebutton.checked == false) {
                                var exporthash = (hashinput.text + " -- " + hashoutput.text);
                                _fsmanager.saveTextFile(exporthash, hashmode);
                            }
                            if (togglebutton.checked == true) {
                                var exporthash_file = (picker.selectedFile + " -- " + hashoutput.text);
                                _fsmanager.saveTextFile(exporthash_file, hashmode);
                            }
                        }
                    }
                    Button {
                        id: clipboardbutton
                        text: qsTr("Copy to clipboard") + Retranslate.onLanguageChanged
                        onClicked: {
                            hashToast.body = qsTr("Hash copied to clipboard") + Retranslate.onLanguageChanged;
                            hashToast.show();
                            Clipboard.copyToClipboard(hashoutput.text);
                        }
                    }
                }
            }
        }
    }
}