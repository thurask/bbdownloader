/*OSRepo.qml
 -----------
 Reads remote XML repo. Handy.
 
 --Thurask*/

import bb.cascades 1.3
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
                title: qsTr("Known Software (pull to reload)") + Retranslate.onLanguageChanged
            }
            Label {
                id: errorlabel
                text: qsTr("Make sure you are connected to the Internet, \nhave data service and Github is up.") + Retranslate.onLanguageChanged
                multiline: true
                visible: false
            }
            ListView {
                id: listView
                dataModel: repoDataModel
                property bool isTouched: false
                onTouch: {
                    if (event.isDown() | event.isMove()) {
                        isTouched = true
                    } else {
                        isTouched = false
                    }
                }
                leadingVisual: PullToRefresh {
                    id: pullRefresh
                    preferredWidth: listhandler.layoutFrame.width
                    touchActive: listView.isTouched
                    onRefreshTriggered: {                      
                        repoDataSource.load();                 
                    }
                }
                listItemComponents: [
                    ListItemComponent {
                        type: "header"
                        Container {
                            Label {
                                text: ""
                            }
                        }
                    },
                    ListItemComponent {
                        type: "item"
                        Container {
                            Label {
                                text: "OS: " + (ListItemData.trueos == "" ? ListItemData.os : ListItemData.trueos)
                                textStyle.fontWeight: FontWeight.Bold
                                multiline: true
                            }
                            Label {
                                text: "Software Release: " + ListItemData.software + " | Radio: " + ListItemData.radio
                            }
                            Label {
                                text: ListItemData.notes
                                textStyle.fontSize: FontSize.Small
                                multiline: true
                            }
                            Divider {
                            }
                        }
                    }
                ]
                onTriggered: {
                    var indexi = repoDataModel.data(indexPath);
                    osRepo.releaseSelected(indexi.software, (indexi.trueos == "" ? indexi.os : indexi.trueos), indexi.radio)
                    xmlToast.show();
                }
            }
        }
    }
    attachedObjects: [
        GroupDataModel {
            id: repoDataModel
            sortingKeys: [
            "os"
            ]
            sortedAscending: false
            grouping: ItemGrouping.ByFullValue
        },
        DataSource {
            id: repoDataSource
            remote: true
            source: "http://thurask.github.io/xml/repo.xml"
            query: "repo/release"
            type: DataSourceType.Xml
            onDataLoaded: {
                errorlabel.visible = false;
                repoDataModel.clear();
                repoDataModel.insertList(data)
            }
            onError: {
                errorlabel.visible = true;
            }
        },
        SystemToast {
            id: xmlToast
            body: qsTr("Values copied to OS Downloader") + Retranslate.onLanguageChanged
        },
        LayoutUpdateHandler {
            id: listhandler
        }
    ]
    onCreationCompleted: {
        repoDataSource.load();
    }
}