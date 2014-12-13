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
    title: qsTr("BB10 OS Downloader %1").arg(AppInfo.version)
}
