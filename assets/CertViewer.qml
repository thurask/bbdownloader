import bb.cascades 1.4
import bb.data 1.0

Page {
    property alias tbar: certpage.titleBar
    property string selectedid
    id: certpage
    actions: [
        ActionItem {
            enabled: localtoggle.checked ? false : true
            title: qsTr("Refresh") + Retranslate.onLanguageChanged
            onTriggered: {
                repoDataSource.load();
            }
            imageSource: "asset:///images/menus/ic_reload.png"
            ActionBar.placement: ActionBarPlacement.Signature
        }
    ]
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
                        mainheader.title = qsTr("Certifications (local copy)") + Retranslate.onLanguageChanged
                        repoDataSource.source = "asset:///xml/ptcrb.xml";
                        repoDataSource.remote = false;
                        repoDataSource.load();
                    }
                    else {
                        mainheader.title = qsTr("Certifications (network copy)") + Retranslate.onLanguageChanged
                        repoDataSource.source = "http://thurask.github.io/ptcrb.xml";
                        repoDataSource.remote = true;
                        repoDataSource.load();
                    }
                }
            }
        }
        Header {
            id: mainheader
            title: (localtoggle.checked == true ? qsTr("Certifications (local copy)") + Retranslate.onLanguageChanged : qsTr("Certifications (network copy)") + Retranslate.onLanguageChanged)
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
                        title: ListItemData.variant
                        description: ListItemData.id
                        enabled: (ListItemData.url == "" ? false : true)
                    }
                }
            ]
            onTriggered: {
                var indexi = repoDataModel.data(indexPath);  
                if (indexi.url != ""){
                    selectedid = indexi.url
                    var wview = certPageDef.createObject()
                    wview.open();
                }
            }
            scrollIndicatorMode: ScrollIndicatorMode.ProportionalBar
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
                errorlabel.visible = false;
                repoDataModel.clear();
                repoDataModel.insertList(data)
            }
            onError: {
                mainheader.title = qsTr("Certifications (local copy)") + Retranslate.onLanguageChanged
                repoDataSource.source = "asset:///xml/ptcrb.xml";
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