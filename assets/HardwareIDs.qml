/*HardwareIDs.qml
 ----------------
 List of hardware IDs, duh.
 
 --Thurask*/

import bb.cascades 1.4
import bb.data 1.0

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
                            title: ListItemData.id
                            description: ListItemData.name + " " + ListItemData.variant
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
