/*HelpSheet.qml
 --------------
 Help menu, including credits and notes.
 
 --Thurask*/

import bb.cascades 1.2

Sheet {
    id: helpSheet
    content: Page {
        titleBar: TitleBar {
            title: "Help"
            dismissAction: ActionItem {
                title: "Close"
                onTriggered: {
                    helpSheet.close()
                    if (helpSheet) helpSheet.destroy();
                }
            }
        }
        Container {
            Label {
                text: qsTr("BB10 OS Downloader %1").arg(AppInfo.version)
                horizontalAlignment: HorizontalAlignment.Center
                textStyle.fontWeight: FontWeight.Bold
            }
            Label  {
                text: qsTr("BB10 OS Downloader developed by Thurask.") + Retranslate.onLanguageChanged
                horizontalAlignment: HorizontalAlignment.Center
                textFit.mode: LabelTextFitMode.Default
                textStyle.textAlign: TextAlign.Center
            }
            Label {
                text: "Twitter: @thuraski"
                horizontalAlignment: HorizontalAlignment.Center
                textFit.mode: LabelTextFitMode.Default
                textStyle.textAlign: TextAlign.Center
                content.flags: TextContentFlag.ActiveText
            }
            Label {
                text: qsTr("Save folder: /downloads/bbdownloader") + Retranslate.onLanguageChanged
                horizontalAlignment: HorizontalAlignment.Center
                textFit.mode: LabelTextFitMode.Default
                textStyle.textAlign: TextAlign.Center
            }
            Label {
                text: qsTr("Do what you want with the source code: \nhttps://github.com/thurask/bbdownloader") + Retranslate.onLanguageChanged
                horizontalAlignment: HorizontalAlignment.Center
                textFit.mode: LabelTextFitMode.Default
                textStyle.textAlign: TextAlign.Center
                content.flags: TextContentFlag.ActiveText
                multiline: true
            }
        }
    }
}