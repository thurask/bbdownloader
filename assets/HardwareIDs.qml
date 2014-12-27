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
        }
        Container {
            horizontalAlignment: HorizontalAlignment.Fill
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
                    repoDataModel.clear();
                    repoDataModel.insertList(data)
                }
            }
        ]
        onCreationCompleted: {
            repoDataSource.load();
        }
    }
}
