import bb.cascades 1.3
import bb.cascades.pickers 1.0
import bb.system 1.2

Page {
    property string selecteddir
    property bool fileexists
    attachedObjects: [
        FilePicker {
            id: picker
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
        topPadding: 20.0
        Button {
            text: qsTr("Choose a Directory") + Retranslate.onLanguageChanged
            horizontalAlignment: HorizontalAlignment.Center
            onClicked: {
                picker.open()
            }
        }
        Label {
            text: qsTr("Current Directory:") + Retranslate.onLocaleOrLanguageChanged            
        }
        Label {
            text: selecteddir
        }
        Label {
            text: qsTr(".nomedia File Exists: ") + Retranslate.onLanguageChanged + fileexists
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
