import bb.cascades 1.4

TitleBar {
    id: customtitlebar
    dismissAction: ActionItem {
        id: dismissaction
        enabled: false
    }
    acceptAction: ActionItem {
        id: acceptaction
        enabled: false
    }
    title: qsTr("BBDownloader %1").arg(((AppInfo.version.split('.')).slice(0,3)).join('.')) + Retranslate.onLanguageChanged
}
