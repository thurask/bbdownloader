import bb.cascades 1.4

Sheet {
    id: osconfig
    content: Page {
        titleBar: TitleBar {
            title: qsTr("Link Config") + Retranslate.onLanguageChanged
            dismissAction: ActionItem {
                title: qsTr("Close") + Retranslate.onLanguageChanged
                onTriggered: {
                    osconfig.close()
                }
            }
        }
        Container {
            Label {
                horizontalAlignment: HorizontalAlignment.Center
                text: qsTr("Default: everything except Obsolete") + Retranslate.onLanguageChanged
            }
            ScrollView {
                scrollRole: ScrollRole.Main
                scrollViewProperties.pinchToZoomEnabled: false
                scrollViewProperties.scrollMode: ScrollMode.Vertical
                scrollViewProperties.overScrollEffectMode: OverScrollEffectMode.OnPinch
                Container {
                    bottomPadding: ui.du(1.0)
                    Header {
                        title: qsTr("Operating System Types") + Retranslate.onLanguageChanged
                    }
                    CheckBox {
                        id: checkbox_8960
                        text: qsTr("8960") + Retranslate.onLanguageChanged
                        checked: Settings.getValueFor("qcom", "true")
                        onCheckedChanged: {
                            Settings.saveValueFor("qcom", checked);
                        }
                    }
                    CheckBox {
                        id: checkbox_vzw
                        text: qsTr("Verizon 8960") + Retranslate.onLanguageChanged
                        checked: Settings.getValueFor("verizon", "true")
                        onCheckedChanged: {
                            Settings.saveValueFor("verizon", checked);
                        }
                    }
                    CheckBox {
                        id: checkbox_core
                        text: qsTr("Core (any)") + Retranslate.onLanguageChanged
                        checked: Settings.getValueFor("core", "true")
                        onCheckedChanged: {
                            Settings.saveValueFor("core", checked);
                        }
                    }
                    Header {
                        title: qsTr("Devices") + Retranslate.onLanguageChanged
                    }
                    CheckBox {
                        id: checkbox_omap
                        text: qsTr("Z10 (STL100-1)") + Retranslate.onLanguageChanged
                        checked: Settings.getValueFor("winchester", "true")
                        onCheckedChanged: {
                            Settings.saveValueFor("winchester", checked);
                        }
                    }
                    CheckBox {
                        id: checkbox_z10
                        text: qsTr("Z10 (STL100-2/3)/P9982") + Retranslate.onLanguageChanged
                        checked: Settings.getValueFor("lseries", "true")
                        onCheckedChanged: {
                            Settings.saveValueFor("lseries", checked);
                        }
                    }
                    CheckBox {
                        id: checkbox_laguna
                        text: qsTr("Z10 (STL100-4)") + Retranslate.onLanguageChanged
                        checked: Settings.getValueFor("laguna", "true")
                        onCheckedChanged: {
                            Settings.saveValueFor("laguna", checked);
                        }
                    }
                    CheckBox {
                        id: checkbox_q10
                        text: qsTr("Q10/Q5/P9983") + Retranslate.onLanguageChanged
                        checked: Settings.getValueFor("nseries", "true")
                        onCheckedChanged: {
                            Settings.saveValueFor("nseries", checked);
                        }
                    }
                    CheckBox {
                        id: checkbox_z30
                        text: qsTr("Z30/Leap/Classic") + Retranslate.onLanguageChanged
                        checked: Settings.getValueFor("aseries", "true")
                        onCheckedChanged: {
                            Settings.saveValueFor("aseries", checked);
                        }
                    }
                    CheckBox {
                        id: checkbox_z3
                        text: qsTr("Z3") + Retranslate.onLanguageChanged
                        checked: Settings.getValueFor("jakarta", "true")
                        onCheckedChanged: {
                            Settings.saveValueFor("jakarta", checked);
                        }
                    }
                    CheckBox {
                        id: checkbox_8974
                        text: qsTr("Passport") + Retranslate.onLanguageChanged
                        checked: Settings.getValueFor("passport", "true")
                        onCheckedChanged: {
                            Settings.saveValueFor("passport", checked);
                        }
                    }
                    Header {
                        title: qsTr("Obsolete") + Retranslate.onLanguageChanged
                    }
                    CheckBox {
                        id: checkbox_aquarius
                        text: qsTr("AQ Series") + Retranslate.onLanguageChanged
                        checked: Settings.getValueFor("aquarius", "false")
                        onCheckedChanged: {
                            Settings.saveValueFor("aquarius", checked);
                        }
                    }
                    CheckBox {
                        id: checkbox_china
                        text: qsTr("China 8960") + Retranslate.onLanguageChanged
                        checked: Settings.getValueFor("china", "false")
                        onCheckedChanged: {
                            Settings.saveValueFor("china", checked);
                        }
                    }
                    CheckBox {
                        id: checkbox_sdk
                        text: qsTr("SDK") + Retranslate.onLanguageChanged
                        checked: Settings.getValueFor("sdk", "false")
                        onCheckedChanged: {
                            Settings.saveValueFor("sdk", checked);
                        }
                    }
                }
            }
        }
    }
}