import bb.cascades 1.4

Sheet {
    id: metadataSheet
    content: Page {
        titleBar: TitleBar {
            title: qsTr("Metadata") + Retranslate.onLanguageChanged
            dismissAction: ActionItem {
                title: qsTr("Close") + Retranslate.onLanguageChanged
                onTriggered: {
                    metadataSheet.close()
                    if (metadataSheet) metadataSheet.destroy();
                }
            }
            acceptAction: ActionItem {
                title: qsTr("Refresh") + Retranslate.onLanguageChanged
                onTriggered: {
                    _metadata.getMetadata();
                    runtimelabel.text = _metadata.getRuntimeMetadata();
                    simulatorlabel.text = _metadata.getSimulatorMetadata();
                }
            }
        }
        ScrollView {
            Container {
                Header {
                    title: qsTr("Runtime Metadata") + Retranslate.onLanguageChanged
                }
                TextArea {
                    id: runtimelabel
                    text: _metadata.getRuntimeMetadata()
                    editable: false
                }
                Header {
                    title: qsTr("Simulator Metadata") + Retranslate.onLanguageChanged
                }
                TextArea {
                    id: simulatorlabel
                    text: _metadata.getSimulatorMetadata()
                    editable: false
                }
            }
        }
    }
}