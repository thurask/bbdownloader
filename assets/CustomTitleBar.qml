import bb.cascades 1.3

TitleBar {
    id: customtitlebar
    acceptAction: ActionItem {
        id: acceptaction
        enabled: false
    }
    title: qsTr("BBDownloader %1").arg(((AppInfo.version.split('.')).slice(0,3)).join('.')) + Retranslate.onLanguageChanged
}