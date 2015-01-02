import bb.cascades 1.4
import bb.cascades.pickers 1.0
import bb.system 1.2
import bb.platform 1.3

NavigationPane {
    id: navigationPane
    property alias pageBar: navPage.titleBar
    Page {
        id: navPage
        Container {
            HashToolsPage {
                
            }
        }
        actions: [
            ActionItem {
                title: qsTr("Add Blank Icon")
                ActionBar.placement: ActionBarPlacement.OnBar   
                onTriggered: {
                    homeScreen.addShortcut("asset:///images/blank/blank.png","\uFEFF","sicwipe://"); //URI does nothing, duh
                    icontoast.show()
                }
                imageSource: "asset:///images/menus/ic_home.png"
            },
            ActionItem {
                title: qsTr(".nomedia")
                ActionBar.placement: ActionBarPlacement.OnBar
                onTriggered: {
                    navigationPane.push(nomediaPageDef.createObject());
                }
                imageSource: "asset:///images/menus/ic_zoom_out.png"
            }
        ]
    }
    attachedObjects: [
        ComponentDefinition {
            id: nomediaPageDef
            NomediaPage {
            
            }
        },
        HomeScreen {
            id: homeScreen
        },
        SystemToast {
            id: icontoast
            body: qsTr("Added!") + Retranslate.onLanguageChanged
        }
    ]
    onPopTransitionEnded: {
        page.deleteLater();
    }
}
