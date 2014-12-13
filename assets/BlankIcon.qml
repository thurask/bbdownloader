import bb.cascades 1.4
import bb.platform 1.3
import bb.system 1.2
import bb.device 1.4

Page {
    attachedObjects: [
        HomeScreen {
            id: homeScreen
        },
        SystemToast {
            id: toast
            body: qsTr("Added!") + Retranslate.onLanguageChanged
        },
        DisplayInfo {
            id: dispinfo
        }
    ]
    Container {
        Button {
            text: qsTr("Add blank icon") + Retranslate.onLanguageChanged
            onClicked: {
                homeScreen.addShortcut("asset:///images/blank/blank.png","\uFEFF","sicwipe://"); //URI does nothing, duh
                toast.show()
            }
            horizontalAlignment: HorizontalAlignment.Center
        }
    }
}
