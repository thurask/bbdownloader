/*NomediaPage.qml
 * --------------
 * Work with .nomedia files (delete and create).
 *
 --Thurask*/

import bb.cascades 1.4
import bb.cascades.pickers 1.0
import bb.system 1.2

Sheet {
    id: nomediaSheet
    property string selecteddir
    property bool fileexists
    content: Page {
        titleBar: TitleBar {
            title: qsTr(".nomedia") + Retranslate.onLanguageChanged
            dismissAction: ActionItem {
                title: qsTr("Close") + Retranslate.onLanguageChanged
                onTriggered: {
                    nomediaSheet.close()
                    if (nomediaSheet) metadataSheet.destroy();
                }
            }
        }
        Container {
            Header {
                title: qsTr(".nomedia") + Retranslate.onLanguageChanged
            }
            Container {
                horizontalAlignment: HorizontalAlignment.Center
                attachedObjects: [
                    FilePicker {
                        id: dirpicker
                        title: qsTr("File Picker") + Retranslate.onLanguageChanged
                        mode: FilePickerMode.SaverMultiple
                        onFileSelected: {
                            selecteddir = (selectedFiles[0] + "/")
                            Nomedia.setDir(selecteddir)
                            fileexists = Nomedia.checkNomedia()
                        }
                    },
                    SystemToast {
                        id: toast
                        body: ""
                    }
                ]
                Container {
                    horizontalAlignment: HorizontalAlignment.Center
                    topPadding: ui.du(1.5)
                    Button {
                        text: qsTr("Choose a Directory") + Retranslate.onLanguageChanged
                        horizontalAlignment: HorizontalAlignment.Center
                        onClicked: {
                            dirpicker.open()
                        }
                    }
                    Label {
                        text: qsTr("Current Directory:") + Retranslate.onLocaleOrLanguageChanged
                        horizontalAlignment: HorizontalAlignment.Center
                    }
                    Label {
                        text: selecteddir
                        horizontalAlignment: HorizontalAlignment.Center
                    }
                    Label {
                        text: qsTr(".nomedia File Exists: %1").arg((fileexists == true ? qsTr("True") + Retranslate.onLanguageChanged : qsTr("False") + Retranslate.onLanguageChanged)) + Retranslate.onLanguageChanged
                        horizontalAlignment: HorizontalAlignment.Center
                    }
                    Container {
                        topPadding: ui.du(1.0)
                        layout: StackLayout {
                            orientation: LayoutOrientation.LeftToRight
                        }
                        horizontalAlignment: HorizontalAlignment.Center
                        Button {
                            text: qsTr("Write .nomedia File") + Retranslate.onLanguageChanged
                            enabled: (fileexists == true ? false : true)
                            onClicked: {
                                Nomedia.writeNomedia()
                                fileexists = Nomedia.checkNomedia()
                                toast.body = qsTr("File created!") + Retranslate.onLanguageChanged
                                toast.show()
                            }
                        }
                        Button {
                            text: qsTr("Delete .nomedia File") + Retranslate.onLanguageChanged
                            enabled: (fileexists == false ? false : true) //exists if .nomedia does
                            onClicked: {
                                Nomedia.deleteNomedia()
                                fileexists = Nomedia.checkNomedia()
                                toast.body = qsTr("File deleted!") + Retranslate.onLanguageChanged
                                toast.show()
                            }
                        }
                    }
                }
            }
        }
    }
}
