import bb.cascades 1.3

Sheet {
    property string osversion
    property string radioversion
    property string hashedswrelease
    property string osinitversion
    property string radinitversion
    property list exportlist
    id: exportSheet
    content: Page {
        titleBar: TitleBar {
            title: qsTr("Export Options") + Retranslate.onLanguageChanged
            dismissAction: ActionItem {
                title: qsTr("Close") + Retranslate.onLanguageChanged
                onTriggered: {
                    exportSheet.close()
                }
            }
        }
        Container {
            Header {
                title: "Select OS Types to Export"
            }
            CheckBox {
                text: "Z10 STL100-1"
                onCheckedChanged: {
                    if (checked) {
                        
                    }
                }
            }
        }
    }
}