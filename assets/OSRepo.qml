/*OSRepo.qml
 * -----------
 * Reads remote XML repo. Handy.
 *
 --Thurask*/

import bb.cascades 1.4
import bb.data 1.0
import bb.system 1.2

Sheet {
    id: osRepo
    signal releaseSelected(string reposoftware, string repoos, string reporadio)
    content: Page {
        titleBar: TitleBar {
            title: qsTr("Software List") + Retranslate.onLanguageChanged
            dismissAction: ActionItem {
                title: qsTr("Close") + Retranslate.onLanguageChanged
                onTriggered: {
                    osRepo.close()
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
                topPadding: ui.du(0.5)
                horizontalAlignment: HorizontalAlignment.Center
                Label {
                    text: qsTr("Tap to select, long press to copy") + Retranslate.onLanguageChanged
                    horizontalAlignment: HorizontalAlignment.Center
                }
                Container {
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
                                mainheader.title = qsTr("Known Software (local copy)") + Retranslate.onLanguageChanged
                                repoDataSource.source = "asset:///xml/repo.xml";
                                repoDataSource.remote = false;
                                repoDataSource.load();
                            } else {
                                mainheader.title = qsTr("Known Software (network copy)") + Retranslate.onLanguageChanged
                                repoDataSource.source = "http://thurask.github.io/repo.xml";
                                repoDataSource.remote = true;
                                repoDataSource.load();
                            }
                        }
                    }
                }
            }
            Header {
                id: mainheader
                title: (localtoggle.checked == true ? qsTr("Known Software (local copy)") + Retranslate.onLanguageChanged : qsTr("Known Software (network copy)") + Retranslate.onLanguageChanged)
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
                            title: (ListItemData.trueos == "" ? ListItemData.os : ListItemData.trueos)
                            description: qsTr("SR: %1 | Radio: %2").arg(ListItemData.software).arg(ListItemData.radio) + Retranslate.onLanguageChanged
                            status: ListItemData.notes
                            contextActions: [
                                ActionSet {
                                    actions: [
                                        ActionItem {
                                            title: qsTr("Copy OS") + Retranslate.onLanguageChanged
                                            imageSource: "asset:///images/menus/ic_copy.png"
                                            onTriggered: {
                                                var smeg = (slistitem.ListItem.data.trueos.toString() == "" ? slistitem.ListItem.data.os.toString() : slistitem.ListItem.data.trueos.toString())
                                                Clipboard.copyToClipboard(smeg)
                                                copytoast.show()
                                            }
                                        },
                                        ActionItem {
                                            title: qsTr("Copy Radio") + Retranslate.onLanguageChanged
                                            imageSource: "asset:///images/menus/ic_copy.png"
                                            onTriggered: {
                                                Clipboard.copyToClipboard(slistitem.ListItem.data.radio.toString())
                                                copytoast.show()
                                            }
                                            enabled: (slistitem.ListItem.data.radio.toString != "N/A")
                                        },
                                        ActionItem {
                                            title: qsTr("Copy Software") + Retranslate.onLanguageChanged
                                            imageSource: "asset:///images/menus/ic_copy.png"
                                            onTriggered: {
                                                Clipboard.copyToClipboard(slistitem.ListItem.data.software.toString())
                                                copytoast.show()
                                            }
                                            enabled: (slistitem.ListItem.data.software.toString != "N/A")
                                        },
                                        ActionItem {
                                            title: qsTr("Copy All") + Retranslate.onLanguageChanged
                                            imageSource: "asset:///images/menus/ic_copy.png"
                                            onTriggered: {
                                                Clipboard.copyToClipboard(qsTr("OS %1 | Radio %2 | Software %3").arg(slistitem.ListItem.data.trueos.toString() == "" ? slistitem.ListItem.data.os.toString() : slistitem.ListItem.data.trueos.toString()).arg(slistitem.ListItem.data.radio.toString()).arg(slistitem.ListItem.data.software.toString()) + Retranslate.onLanguageChanged)
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
                onTriggered: {
                    var indexi = repoDataModel.data(indexPath);
                    osRepo.releaseSelected(indexi.software, (indexi.trueos == "" ? indexi.os : indexi.trueos), indexi.radio)
                    xmlToast.show();
                }
                scrollIndicatorMode: ScrollIndicatorMode.ProportionalBar
            }
        }
    }
    attachedObjects: [
        GroupDataModel {
            id: repoDataModel
            sortingKeys: [ "series" ]
            grouping: ItemGrouping.ByFullValue
            sortedAscending: false
        },
        DataSource {
            id: repoDataSource
            remote: false
            source: "asset:///xml/repo.xml"
            query: "repo/release"
            type: DataSourceType.Xml
            onDataLoaded: {
                errorlabel.visible = false;
                repoDataModel.clear();
                repoDataModel.insertList(data)
            }
            onError: {
                mainheader.title = qsTr("Known Software (local copy)") + Retranslate.onLanguageChanged
                repoDataSource.source = "asset:///xml/repo.xml";
                repoDataSource.remote = false;
                repoDataSource.load();
                errorlabel.visible = true;
            }
        },
        SystemToast {
            id: xmlToast
            body: qsTr("Values sent to generator") + Retranslate.onLanguageChanged
        }
    ]
    onCreationCompleted: {
        repoDataSource.load();
    }
}