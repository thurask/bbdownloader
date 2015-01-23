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
        Container {
            Container {
                layout: StackLayout {
                    orientation: LayoutOrientation.LeftToRight
                }
                Header {
                    title: qsTr("Runtime Metadata") + Retranslate.onLanguageChanged
                    layoutProperties: StackLayoutProperties {
                        spaceQuota: 0.5
                    }
                }
                Header {
                    title: qsTr("Simulator Metadata") + Retranslate.onLanguageChanged
                    layoutProperties: StackLayoutProperties {
                        spaceQuota: 0.5
                    }
                }
            }
            ScrollView {
                Container {
                    layout: StackLayout {
                        orientation: LayoutOrientation.LeftToRight
                    }
                    Container {
                        horizontalAlignment: HorizontalAlignment.Left
                        TextArea {
                            id: runtimelabel
                            text: _metadata.getRuntimeMetadata()
                            editable: false
                        }
                    }
                    Container {
                        horizontalAlignment: HorizontalAlignment.Right
                        TextArea {
                            id: simulatorlabel
                            text: _metadata.getSimulatorMetadata()
                            editable: false
                        }
                    }
                }
            }
        }
    }
}