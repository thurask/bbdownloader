import bb.cascades 1.4
import bb.cascades.pickers 1.0
import bb.system 1.2

Page {
    property string selecteddir
    property bool fileexists
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
                topPadding: 20.0
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
                    text: qsTr(".nomedia File Exists: ") + Retranslate.onLanguageChanged + (fileexists == true ? qsTr("True") + Retranslate.onLanguageChanged : qsTr("False") + Retranslate.onLanguageChanged)
                    horizontalAlignment: HorizontalAlignment.Center
                }
                Container {
                    topPadding: 10.0
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
