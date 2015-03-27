/*CustomTitleBar.qml
 * -----------------
 * TitleBar that's reused in every tab, with toggleable acceptAction
 *
 --Thurask*/

import bb.cascades 1.4
import bb 1.3

TitleBar {
    id: customtitlebar
    acceptAction: ActionItem {
        id: acceptaction
        enabled: false
    }
    title: qsTr("BBDownloader %1").arg(((appinfo.version.split('.')).slice(0, 3)).join('.')) + Retranslate.onLanguageChanged
    attachedObjects: [
        ApplicationInfo {
            id: appinfo
        }
    ]
}