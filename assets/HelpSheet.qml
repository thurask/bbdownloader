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
                text: "BB10 OS Downloader developed by Thurask. \nTwitter: @thuraski\n\nBar files save to /downloads/bbdownloader. \n\nSo I heard you like spreadsheets (thank you Kyle): \n http://bit.ly/bb10oslist \n\nDo what you want with the source code: \nhttps://github.com/thurask/bbdownloader"
                multiline: true
                horizontalAlignment: HorizontalAlignment.Center
                textFit.mode: LabelTextFitMode.Default
                textStyle.textAlign: TextAlign.Center
                content.flags: TextContentFlag.ActiveText
            }
        }
    }
}