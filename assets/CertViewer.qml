import bb.cascades 1.4
import bb.data 1.0
import bb.system 1.2

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
            topPadding: ui.du(0.5)
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
            scrollRole: ScrollRole.Main
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
                        title: ListItemData.variant
                        description: ListItemData.id
                        visible: ((ListItemData.id == "" || ListItemData.variant == "" || ListItemData.name == "") ? false : true)
                        status: (ListItemData.url == "" ? qsTr("Invalid") + Retranslate.onLanguageChanged : qsTr("Valid") + Retranslate.onLanguageChanged)
                        imageSource: ListItemData.image
                        contextActions: [
                            ActionSet {
                                actions: [
                                    ActionItem {
                                        title: qsTr("Copy URL") + Retranslate.onLanguageChanged
                                        imageSource: "asset:///images/menus/ic_copy.png"
                                        onTriggered: {
                                            Clipboard.copyToClipboard("https://ptcrb.com/vendor/complete/view_complete_request_guest.cfm?modelid=" + slistitem.ListItem.data.url.toString())
                                            copytoast.show()
                                        }
                                        enabled: (slistitem.ListItem.data.url.toString() == "" ? false : true)
                                    },
                                    ActionItem {
                                        title: qsTr("Copy Name/Variant") + Retranslate.onLanguageChanged
                                        imageSource: "asset:///images/menus/ic_copy.png"
                                        onTriggered: {
                                            Clipboard.copyToClipboard(qsTr("%1 %2 (%3)").arg(slistitem.ListItem.data.name.toString()).arg(slistitem.ListItem.data.variant.toString()).arg(slistitem.ListItem.data.id.toString()) + Retranslate.onLanguageChanged)
                                            copytoast.show()
                                        }
                                        enabled: (slistitem.ListItem.data.variant.toString() == "" ? false : true)
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
                    actions: [
                        ActionItem {
                            title: qsTr("Open in Browser") + Retranslate.onLanguageChanged
                            imageSource: "asset:///images/menus/ic_browser.png"
                            onTriggered: {
                                myQuery.trigger(myQuery.query.invokeActionId);
                            }
                            ActionBar.placement: ActionBarPlacement.OnBar
                        }
                    ]
                    WebView {
                        id: mainwebview
                        url: ("https://ptcrb.com/vendor/complete/view_complete_request_guest.cfm?modelid=" + selectedid)
                        settings.zoomToFitEnabled: true
                        settings.textAutosizingEnabled: true
                    }
                    attachedObjects: [
                        Invocation {
                            id: myQuery
                            query {
                                uri: mainwebview.url
                                invokeActionId: "bb.action.OPEN"
                                onQueryChanged: {
                                    myQuery.query.updateQuery()
                                }
                            }
                        }
                    ]
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