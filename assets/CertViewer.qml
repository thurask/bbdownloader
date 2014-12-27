import bb.cascades 1.4
import bb.data 1.0

Page {
    property alias tbar: certpage.titleBar
    property string selectedid
    id: certpage
    Container {
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
                        title: ListItemData.variant
                        description: ListItemData.id
                    }
                }
            ]
            onTriggered: {
                var indexi = repoDataModel.data(indexPath);  
                selectedid = indexi.url
                var wview = certPageDef.createObject()
                wview.open();
            }
        }
    }
    attachedObjects: [
        ComponentDefinition {
            id: certPageDef
            Sheet {
                id: certviewpage
                content: Page {
                    titleBar: TitleBar {
                        title: qsTr("Certification Browser") + Retranslate.onLanguageChanged
                        dismissAction: ActionItem {
                            title: qsTr("Close") + Retranslate.onLanguageChanged
                            onTriggered: {
                                certviewpage.close()
                            }
                        }
                    }
                    WebView {
                        id: mainwebview
                        url: ("https://ptcrb.com/vendor/complete/view_complete_request_guest.cfm?modelid=" + selectedid)
                    }
                }
            }
        },
        GroupDataModel {
            id: repoDataModel
            sortingKeys: [
            "name",
            "variant",
            "id"
            ]
            sortedAscending: true
            grouping: ItemGrouping.ByFullValue
        },
        DataSource {
            id: repoDataSource
            remote: false
            source: "asset:///xml/ptcrb.xml"
            query: "repo/device"
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