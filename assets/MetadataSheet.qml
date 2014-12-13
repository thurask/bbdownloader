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
                Label {
                    id: runtimelabel
                    text: _metadata.getRuntimeMetadata()
                    multiline: true
                }
                Header {
                    title: qsTr("Simulator Metadata") + Retranslate.onLanguageChanged
                }
                Label {
                    id: simulatorlabel
                    text: _metadata.getSimulatorMetadata()
                    multiline: true
                }
            }
        }
    }
}