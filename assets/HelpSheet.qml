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
            text: "BB10 OS Downloader v2.1.1"
            horizontalAlignment: HorizontalAlignment.Center
            textStyle.fontWeight: FontWeight.Bold
            }
        Label  {
            text: "BB10 OS Downloader developed by Thurask. \n Fight the power. \n\n Downloads to /downloads/bbdownloader."
            multiline: true
            horizontalAlignment: HorizontalAlignment.Center
            textFit.mode: LabelTextFitMode.Default
            textStyle.textAlign: TextAlign.Center
        }
        Label {
            text: "Source Code"
            horizontalAlignment: HorizontalAlignment.Center
            translationY: 210.0
            textStyle.fontWeight: FontWeight.Bold
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