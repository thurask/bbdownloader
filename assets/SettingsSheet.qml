/*SettingsSheet.qml
 ------------------
 Settings menu, including theme select.
 
 --Thurask*/

import bb.cascades 1.2

Sheet {
    id: settingsSheet
    content: Page {
        titleBar: TitleBar {
            title: qsTr("Settings") + Retranslate.onLanguageChanged
            dismissAction: ActionItem {
                title: qsTr("Close") + Retranslate.onLanguageChanged
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
                title: qsTr("Theme Select") + Retranslate.onLanguageChanged
                Option {
                    text: qsTr("Bright") + Retranslate.onLanguageChanged
                    value: VisualStyle.Bright
                }
                Option {
                    text: qsTr("Dark") + Retranslate.onLanguageChanged
                    value: VisualStyle.Dark
                }
                onSelectedOptionChanged: {
                    Settings.saveValueFor("theme", VisualStyle.Bright == themeDropDown.selectedValue ? "bright" : "dark");
                }
            }
            Label {
                text: qsTr("Restart app to save theme setting.") + Retranslate.onLanguageChanged
                horizontalAlignment: HorizontalAlignment.Center
            }
        }
        onCreationCompleted: {
            var theme = Settings.getValueFor("theme", VisualStyle.Bright == themeDropDown.selectedValue ? "bright" : "dark");
            themeDropDown.setSelectedIndex("bright" == theme ? 0 : 1);
        }
    }
}