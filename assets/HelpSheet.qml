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
            text: "BB10 OS Downloader v2.2.0"
            horizontalAlignment: HorizontalAlignment.Center
            textStyle.fontWeight: FontWeight.Bold
            }
        Label  {
            text: "BB10 OS Downloader developed by Thurask. \n Twitter: @thuraski"
            multiline: true
            horizontalAlignment: HorizontalAlignment.Center
            textFit.mode: LabelTextFitMode.Default
            textStyle.textAlign: TextAlign.Center
            content.flags: TextContentFlag.ActiveText
        }
        Label {
            horizontalAlignment: HorizontalAlignment.Center
            textStyle.textAlign: TextAlign.Center
            text: "Bar files save to /downloads/bbdownloader."
        }
        Label {
            text: "Do what you want with the source code:"
            multiline: true
            translationY: 210.0
                horizontalAlignment: HorizontalAlignment.Center
            }
        Label {
            text: "https://github.com/thurask/bbdownloader"
            horizontalAlignment: HorizontalAlignment.Center
            content.flags: TextContentFlag.ActiveText
            translationY: 200.0
        }
    }
    }
}