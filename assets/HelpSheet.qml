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
        Label  {
            text: "BB10 OS Downloader developed by Thurask. Apologies for the reset button, but I'm a noob with Cascades/QML/C++/programming in general. Of course, smart people can trudge through this on Github."
            multiline: true
            horizontalAlignment: HorizontalAlignment.Center
            textFit.mode: LabelTextFitMode.Default
            textStyle.textAlign: TextAlign.Center
        }
        Label {
            text: "Source Code"
            horizontalAlignment: HorizontalAlignment.Center
            translationY: 210.0
        }
        Label {
            text: "https://github.com/thurask/bbdownloader"
            horizontalAlignment: HorizontalAlignment.Center
            content.flags: TextContentFlag.ActiveText
            translationX: 0.0
            translationY: 200.0
        }
    }
    }
}