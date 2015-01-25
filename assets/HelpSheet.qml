/*HelpSheet.qml
 --------------
 Help menu, including credits and notes.
 
 --Thurask*/

import bb.cascades 1.3

Sheet {
    id: helpSheet
    content: Page {
        titleBar: TitleBar {
            title: qsTr("Help") + Retranslate.onLanguageChanged
            dismissAction: ActionItem {
                title: qsTr("Close") + Retranslate.onLanguageChanged
                onTriggered: {
                    helpSheet.close()
                    if (helpSheet) helpSheet.destroy();
                }
            }
        }
        Container {
            Label {
                text: qsTr("BB10 OS Downloader %1 FINAL").arg(((AppInfo.version.split('.')).slice(0,3)).join('.'))
                horizontalAlignment: HorizontalAlignment.Center
                textStyle.fontWeight: FontWeight.Bold
                textStyle.fontSize: FontSize.Large
            }
            Label  {
                text: qsTr("BB10 OS Downloader developed by Thurask.") + Retranslate.onLanguageChanged
                horizontalAlignment: HorizontalAlignment.Center
                textFit.mode: LabelTextFitMode.Default
                textStyle.textAlign: TextAlign.Center
            }
            Label {
                text: qsTr("Updates posted to Github or Twitter: @thuraski") + Retranslate.onLanguageChanged
                horizontalAlignment: HorizontalAlignment.Center
                textFit.mode: LabelTextFitMode.Default
                textStyle.textAlign: TextAlign.Center
                content.flags: TextContentFlag.ActiveText
            }
            Label {
                text: qsTr("Default save folder: \n%1").arg("/accounts/1000/shared/downloads/bbdownloader") + Retranslate.onLanguageChanged
                horizontalAlignment: HorizontalAlignment.Center
                textFit.mode: LabelTextFitMode.Default
                textStyle.textAlign: TextAlign.Center
                multiline: true
            }
            Label {
                text: qsTr("Do what you want with the source code: \n%1").arg("https://github.com/thurask/bbdownloader") + Retranslate.onLanguageChanged
                horizontalAlignment: HorizontalAlignment.Center
                textFit.mode: LabelTextFitMode.Default
                textStyle.textAlign: TextAlign.Center
                content.flags: TextContentFlag.ActiveText
                multiline: true
            }
        }
    }
}