/*HardwareIDs.qml
 ----------------
 List of hardware IDs, duh.
 
 --Thurask*/

import bb.cascades 1.3
import bb.data 1.0
import bb.system 1.2

Sheet {
    id: hardwareIDs
    content: Page {
        titleBar: TitleBar {
            title: qsTr("Hardware IDs") + Retranslate.onLanguageChanged
            dismissAction: ActionItem {
                title: qsTr("Close") + Retranslate.onLanguageChanged
                onTriggered: {
                    hardwareIDs.close()
                }
            }
            acceptAction: ActionItem {
                enabled: localtoggle.checked ? false : true
                title: qsTr("Refresh") + Retranslate.onLanguageChanged
                onTriggered: {
                    repoDataSource.load();
                }
            }
        }
        Container {
            horizontalAlignment: HorizontalAlignment.Fill
            Container {
                topPadding: 5.0
                layout: StackLayout {
                    orientation: LayoutOrientation.LeftToRight
                }
                horizontalAlignment: HorizontalAlignment.Center
                verticalAlignment: VerticalAlignment.Center
                Label {
                    text: qsTr("Use local file") + Retranslate.onLanguageChanged
                    verticalAlignment: VerticalAlignment.Center
                }
                ToggleButton {
                    id: localtoggle
                    verticalAlignment: VerticalAlignment.Center
                    checked: true
                    onCheckedChanged: {
                        if (localtoggle.checked == true) {
                            mainheader.title = qsTr("Hardware IDs (local copy)") + Retranslate.onLanguageChanged
                            repoDataSource.source = "asset:///xml/hwid.xml";
                            repoDataSource.remote = false;
                            repoDataSource.load();
                        }
                        else {
                            mainheader.title = qsTr("Hardware IDs (network copy)") + Retranslate.onLanguageChanged
                            repoDataSource.source = "http://thurask.github.io/hwid.xml";
                            repoDataSource.remote = true;
                            repoDataSource.load();
                        }
                    }
                }
            }
            Header {
                id: mainheader
                title: (localtoggle.checked == true ? qsTr("Hardware IDs (local copy)") + Retranslate.onLanguageChanged : qsTr("Hardware IDs (network copy)") + Retranslate.onLanguageChanged)
            }
            Label {
                id: errorlabel
                text: qsTr("Could not access online file. Loading local copy.") + Retranslate.onLanguageChanged
                multiline: true
                visible: false
            }
            ListView {
                id: listView
                dataModel: repoDataModel
                listItemComponents: [
                    ListItemComponent {
                        type: "header"
                    },
                    ListItemComponent {
                        type: "item"
                        StandardListItem {
                            id: slistitem
                            title: ListItemData.id
                            description: qsTr("%1 %2").arg(ListItemData.name).arg(ListItemData.variant) + Retranslate.onLanguageChanged
                            imageSource: ListItemData.image
                            contextActions: [
                                ActionSet {
                                    actions: [
                                        ActionItem {
                                            title: qsTr("Copy ID") + Retranslate.onLanguageChanged
                                            imageSource: "asset:///images/menus/ic_copy.png"
                                            onTriggered: {
                                                Clipboard.copyToClipboard(slistitem.ListItem.data.id.toString())
                                                copytoast.show()
                                            }
                                        },
                                        ActionItem {
                                            title: qsTr("Copy Full Name") + Retranslate.onLanguageChanged
                                            imageSource: "asset:///images/menus/ic_copy.png"
                                            onTriggered: {
                                                Clipboard.copyToClipboard(qsTr("%1 %2 (%3)").arg(slistitem.ListItem.data.name.toString()).arg(slistitem.ListItem.data.variant.toString()).arg(slistitem.ListItem.data.id.toString()) + Retranslate.onLanguageChanged)
                                                copytoast.show()
                                            }
                                        }
                                    ]
                                }
                            ]
                            attachedObjects: [
                                SystemToast { //Toast must be attached to ListItem in order to appear
                                    id: copytoast
                                    body: qsTr("Copied") + Retranslate.onLanguageChanged
                                }
                            ]
                        }
                    }
                ]
                scrollIndicatorMode: ScrollIndicatorMode.ProportionalBar
            }
        }  
        attachedObjects: [
            GroupDataModel {
                id: repoDataModel
                sortingKeys: [
                "name",
                "variant"
                ]
                sortedAscending: true
                grouping: ItemGrouping.ByFullValue
            },
            DataSource {
                id: repoDataSource
                remote: false
                source: "asset:///xml/hwid.xml"
                query: "repo/hardware"
                type: DataSourceType.Xml
                onDataLoaded: {
                    errorlabel.visible = false;
                    repoDataModel.clear();
                    repoDataModel.insertList(data)
                }
                onError: {
                    mainheader.title = qsTr("Hardware IDs (local copy)") + Retranslate.onLanguageChanged
                    repoDataSource.source = "asset:///xml/hwid.xml";
                    repoDataSource.remote = false;
                    repoDataSource.load();
                    errorlabel.visible = true;
                }
            }
        ]
        onCreationCompleted: {
            repoDataSource.load();
        }
    }
}
