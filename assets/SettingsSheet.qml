import bb.cascades 1.2

Sheet {
    id: settingsSheet
    content: Page {
        titleBar: TitleBar {
            title: "Settings"
            dismissAction: ActionItem {
                title: "Close"
                onTriggered: {
                    settingsSheet.close()
                    if (settingsSheet) settingsSheet.destroy();
                }
            }
        }
        Container {
            topPadding: 20
            DropDown {
                id: themeDropDown
                title: "Theme Select"
                Option {
                    text: "Bright"
                    value: VisualStyle.Bright
                }
                Option {
                    text: "Dark"
                    value: VisualStyle.Dark
                }
                onSelectedOptionChanged: {
                    Settings.saveValueFor("theme", VisualStyle.Bright == themeDropDown.selectedValue ? "bright" : "dark");
                }
            }
            Label {
                text: "Restart app to save theme setting."
                horizontalAlignment: HorizontalAlignment.Center
            }
        }
        onCreationCompleted: {
            var theme = Settings.getValueFor("theme", VisualStyle.Bright == themeDropDown.selectedValue ? "bright" : "dark");
            themeDropDown.setSelectedIndex("bright" == theme ? 0 : 1);
        }
    }
}