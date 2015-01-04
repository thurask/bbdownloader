/*OSRepo.qml
 -----------
 Reads remote XML repo. Handy.
 
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
                        }
                        else {
                            mainheader.title = qsTr("Known Software (network copy)") + Retranslate.onLanguageChanged
                            repoDataSource.source = "http://thurask.github.io/repo.xml";
                            repoDataSource.remote = true;
                            repoDataSource.load();
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
                id: listView
                dataModel: repoDataModel
                listItemComponents: [
                    ListItemComponent {
                        type: "header"
                    },
                    ListItemComponent {
                        type: "item"
                        StandardListItem {
                            title: (ListItemData.trueos == "" ? ListItemData.os : ListItemData.trueos)
                            description: "SR: " + ListItemData.software + " | Radio: " + ListItemData.radio
                            status: ListItemData.notes
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
            "series"
            ]
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
            body: qsTr("Values copied to OS Downloader") + Retranslate.onLanguageChanged
        }
    ]
    onCreationCompleted: {
        repoDataSource.load();
    }
}