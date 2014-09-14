/*HardwareIDs.qml
 ----------------
 List of hardware IDs, duh.
 
 --Thurask*/

import bb.cascades 1.3
import bb.data 1.0

Page {
    titleBar: TitleBar {
        title: qsTr("Hardware IDs") + Retranslate.onLanguageChanged
        acceptAction: ActionItem {
            title: qsTr("Refresh") + Retranslate.onLanguageChanged
            onTriggered: {
                repoDataSource.load();
            }
        }
    }
    Container {
        horizontalAlignment: HorizontalAlignment.Fill
        Header {
            title: qsTr("Info") + Retranslate.onLanguageChanged
        }
        Label {
            text: qsTr("If something is missing, notify me") + Retranslate.onLanguageChanged
            content.flags: TextContentFlag.ActiveText
            textStyle.textAlign: TextAlign.Center
            horizontalAlignment: HorizontalAlignment.Center
            multiline:true
        }
        Header {
            title: qsTr("Hardware IDs") + Retranslate.onLanguageChanged
        }
        Label {
            id: errorlabel
            text: qsTr("Could not access online repo. Loading local copy.") + Retranslate.onLanguageChanged
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
            remote: true
            source: "http://thurask.github.io/hwid.xml"
            query: "repo/hardware"
            type: DataSourceType.Xml
            onDataLoaded: {
                errorlabel.visible = false;
                repoDataModel.clear();
                repoDataModel.insertList(data)
            }
            onError: {
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
