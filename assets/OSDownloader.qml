/*OSDownloader.qml
 ------------------
 The meat of the application. Generates and downloads CSE Prod links.

 --Thurask*/

import bb.cascades 1.4
import bb.system 1.2

Page {
    property string hashedswversion
    property string swrelease
    property string osversion
    property string radioversion
    property bool verizon
    property bool core
    property bool qcom
    property bool winchester
    property bool passport
    property bool lseries
    property bool nseries
    property bool aseries
    property bool jakarta
    property bool aquarius
    property bool china
    property bool sdk
    property bool laguna
    actions: [
        ActionItem {
            title: qsTr("Generate") + Retranslate.onLanguageChanged
            onTriggered: {
                verizon = Settings.getValueFor("verizon", "true")
                core = Settings.getValueFor("core", "true")
                qcom = Settings.getValueFor("qcom", "true")
                winchester = Settings.getValueFor("winchester", "true")
                passport = Settings.getValueFor("passport", "true")
                lseries = Settings.getValueFor("lseries", "true")
                nseries = Settings.getValueFor("nseries", "true")
                aseries = Settings.getValueFor("aseries", "true")
                jakarta = Settings.getValueFor("jakarta", "true")
                laguna = Settings.getValueFor("laguna", "true")
                aquarius = Settings.getValueFor("aquarius", "false")
                china = Settings.getValueFor("china", "false")
                sdk = Settings.getValueFor("sdk", "false")
                _manager.setExportUrls(swrelease, hashedswversion, osversion, radioversion, verizon, winchester, passport, core, qcom, lseries, nseries, aseries, jakarta, aquarius, china, sdk, laguna);
                ostext.text = _manager.returnOsLinks();
                coretext.text = _manager.returnCoreLinks();
                radiotext.text = _manager.returnRadioLinks();
                ostext.visible = true;
                if (swrelease == "N/A"){
                    coretext.visible = false;
                }
                else {
                    coretext.visible = core;
                }
                radiotext.visible = true;
                divider.visible = true;
                allclipboard.enabled = true;
                osclipboard.enabled = true;
                if (radiotext.text.length != 0){
                    radioclipboard.enabled = true;
                    radiopaste.enabled = true;
                }
                exportbutton.enabled = true;
                allpaste.enabled = true;
                ospaste.enabled = true;
            }
            ActionBar.placement: ActionBarPlacement.Signature
            imageSource: "asset:///images/menus/ic_edit.png"
        },
        ActionItem {
            title: qsTr("Clear") + Retranslate.onLanguageChanged
            enabled: (ostext.text != "")
            onTriggered: {
                ostext.text = "";
                coretext.text = "";
                radiotext.text = "";
                ostext.visible = false;
                coretext.visible = false;
                radiotext.visible = false;
                divider.visible = false;
                allclipboard.enabled = false;
                osclipboard.enabled = false;
                radioclipboard.enabled = false;
                exportbutton.enabled = false;
                allpaste.enabled = false;
                ospaste.enabled = false;
                radiopaste.enabled = false;
            }
            ActionBar.placement: ActionBarPlacement.OnBar
            imageSource: "asset:///images/menus/ic_clear.png"
        },
        ActionItem {
            id: allclipboard
            enabled: false
            title: qsTr("Copy Links") + Retranslate.onLanguageChanged
            onTriggered: {
                _manager.copyLinks()
                copytoast.body = qsTr("All URLs copied") + Retranslate.onLanguageChanged;
                copytoast.show();
            }
            ActionBar.placement: ActionBarPlacement.OnBar
            imageSource: "asset:///images/menus/ic_copy.png"
        },
        ActionItem {
            id: osclipboard
            enabled: false
            title: (ostext.text.indexOf("Normal URL") != -1 ? qsTr("Copy Autoloader Links") + Retranslate.onLanguageChanged : qsTr("Copy OS Links") + Retranslate.onLanguageChanged)
            onTriggered: {
                _manager.copyOsLinks()
                copytoast.body = (ostext.text.indexOf("Normal URL") != -1 ? qsTr("Autoloader URLs copied") + Retranslate.onLanguageChanged : qsTr("OS URLs copied") + Retranslate.onLanguageChanged);
                copytoast.show();
            }
            ActionBar.placement: ActionBarPlacement.InOverflow
            imageSource: "asset:///images/menus/ic_copy.png"
        },
        ActionItem {
            id: radioclipboard
            enabled: false
            title: (radiotext.text.indexOf("Variant URL") != -1 ? qsTr("Copy Variant Links") + Retranslate.onLanguageChanged : qsTr("Copy Radio Links") + Retranslate.onLanguageChanged)
            onTriggered: {
                _manager.copyRadioLinks()
                copytoast.body = (radiotext.text.indexOf("Variant URL") != -1 ? qsTr("Variant URLs copied") + Retranslate.onLanguageChanged : qsTr("Radio URLs copied") + Retranslate.onLanguageChanged);
                copytoast.show();
            }
            ActionBar.placement: ActionBarPlacement.InOverflow
            imageSource: "asset:///images/menus/ic_copy.png"
        },
        ActionItem {
            id: exportbutton
            enabled: false
            title: qsTr("Export Links") + Retranslate.onLanguageChanged
            onTriggered: {
                _manager.exportLinks(swrelease);
                linkexporttoast.show();
            }
            ActionBar.placement: ActionBarPlacement.InOverflow
            imageSource: "asset:///images/menus/ic_doctype_doc.png"
        },
        ActionItem {
            id: allpaste
            enabled: false
            title: qsTr("Upload Links") + Retranslate.onLanguageChanged
            onTriggered: {
                Paster.uploadPaste(_manager.returnLinks())
                Paster.uploadUrlChanged.connect(pastetoast.show())
            }
            imageSource: "asset:///images/menus/ic_browser.png"
            ActionBar.placement: ActionBarPlacement.OnBar
        },
        ActionItem {
            id: ospaste
            enabled: false
            title: (ostext.text.indexOf("Normal URL") != -1 ? qsTr("Upload Autoloader Links") + Retranslate.onLanguageChanged : qsTr("Upload OS Links") + Retranslate.onLanguageChanged)
            onTriggered: {
                var smeg = _manager.returnCoreLinks()
                if (smeg == ""){
                    Paster.uploadPaste(_manager.returnOsLinks())
                }
                else {
                    Paster.uploadPaste(_manager.returnOsLinks() + "\n\n" + _manager.returnCoreLinks())
                }
                Paster.uploadUrlChanged.connect(pastetoast.show())
            }
            imageSource: "asset:///images/menus/ic_browser.png"
            ActionBar.placement: ActionBarPlacement.OnBar
        },
        ActionItem {
            id: radiopaste
            enabled: false
            title: (radiotext.text.indexOf("Variant URL") != -1 ? qsTr("Upload Variant Links") + Retranslate.onLanguageChanged : qsTr("Upload Radio Links") + Retranslate.onLanguageChanged)
            onTriggered: {
                Paster.uploadPaste(_manager.returnRadioLinks())
                Paster.uploadUrlChanged.connect(pastetoast.show())
            }
            imageSource: "asset:///images/menus/ic_browser.png"
            ActionBar.placement: ActionBarPlacement.OnBar
        }
    ]
    ScrollView {
        scrollRole: ScrollRole.Main
        scrollViewProperties.pinchToZoomEnabled: false
        scrollViewProperties.scrollMode: ScrollMode.Vertical
        scrollViewProperties.overScrollEffectMode: OverScrollEffectMode.OnPinch
        Container {
            topPadding: ui.du(0.5)
            //Inputs
            Container {
                layout: StackLayout {
                    orientation: LayoutOrientation.TopToBottom
                }
                Container {
                    layout: StackLayout {
                        orientation: LayoutOrientation.LeftToRight
                    }
                    TextField {
                        id: osver_input
                        hintText: qsTr("OS Version") + Retranslate.onLanguageChanged
                        onTextChanging: {
                            osver_input.text = _swlookup.spaceTrimmer(osver_input.text)
                            osversion = osver_input.text
                            _swlookup.post(osversion, "https://cs.sl.blackberry.com/cse/srVersionLookup/2.0.0/");
                        }
                        onTextChanged: {
                            osver_input.text = _swlookup.spaceTrimmer(osver_input.text)
                            osversion = osver_input.text
                            _swlookup.post(osversion, "https://cs.sl.blackberry.com/cse/srVersionLookup/2.0.0/");
                        }
                        validator: Validator {
                            id: validator_osver
                            mode: ValidationMode.Immediate
                            onValidate: {
                                var regex = RegExp(/\b\d{1,4}\.\d{1,4}\.\d{1,4}\.\d{1,4}\b/);
                                if (regex.test(osver_input.text) == true) {
                                    validator_osver.setValid(true);
                                } else {
                                    validator_osver.setValid(false);
                                }
                            }
                        }
                        clearButtonVisible: true
                        maximumLength: 19
                    }
                    Button {
                        text: qsTr("Lookup") + Retranslate.onLanguageChanged
                        onClicked: {
                            var regex = RegExp(/\b\d{1,4}\.\d{1,4}\.\d{1,4}\.\d{1,4}\b/);
                            if (regex.test(osver_input.text) == true ) {
                                swver_input.text = _swlookup.softwareRelease();
                            }
                        }
                    }
                }
                Container {
                    topPadding: ui.du(0.5)
                    layout: StackLayout {
                        orientation: LayoutOrientation.LeftToRight
                    }
                    TextField {
                        id: radiover_input
                        hintText: qsTr("Radio Version") + Retranslate.onLanguageChanged
                        onTextChanging: {
                            radiover_input.text = _swlookup.spaceTrimmer(radiover_input.text)
                            radioversion = radiover_input.text
                        }
                        onTextChanged: {
                            radiover_input.text = _swlookup.spaceTrimmer(radiover_input.text)
                            radioversion = radiover_input.text
                        }
                        validator: Validator {
                            id: validator_radver
                            mode: ValidationMode.Immediate
                            onValidate: {
                                var regex = RegExp(/\b\d{1,4}\.\d{1,4}\.\d{1,4}\.\d{1,4}\b/);
                                if (regex.test(radiover_input.text) == true || swver_input.text == "N/A" || (osver_input.text.indexOf("10.") == -1 && radiover_input.text == "N/A")) {
                                    validator_radver.setValid(true);
                                } else {
                                    validator_radver.setValid(false);
                                }
                            }
                        }
                        clearButtonVisible: true
                        maximumLength: 19
                    }
                    Button {
                        text: qsTr("OS Version + 1") + Retranslate.onLanguageChanged
                        onClicked: {
                            var regex = RegExp(/\b\d{1,4}\.\d{1,4}\.\d{1,4}\.\d{1,4}\b/);
                            if (regex.test(osver_input.text) == true) {
                                radiover_input.text = _swlookup.lookupIncrement(osver_input.text, 1);
                            }
                        }
                    }
                }
                Container {
                    topPadding: ui.du(0.5)
                    layout: StackLayout {
                        orientation: LayoutOrientation.LeftToRight
                    }
                    TextField {
                        id: swver_input
                        hintText: qsTr("SW Version") + Retranslate.onLanguageChanged
                        onTextChanging: {
                            swver_input.text = _swlookup.spaceTrimmer(swver_input.text)
                            swrelease = swver_input.text
                            hashCalculateSha.calculateHash(swrelease)
                            hashedswversion = hashCalculateSha.getHash()
                        }
                        onTextChanged: {
                            swver_input.text = _swlookup.spaceTrimmer(swver_input.text)
                            swrelease = swver_input.text
                            hashCalculateSha.calculateHash(swrelease)
                            hashedswversion = hashCalculateSha.getHash()
                        }
                        validator: Validator {
                            id: validator_swver
                            mode: ValidationMode.Immediate
                            onValidate: {
                                var regex = RegExp(/\b\d{1,4}\.\d{1,4}\.\d{1,4}\.\d{1,4}\b/);
                                if (regex.test(swver_input.text) == true || swver_input.text == "N/A") {
                                    validator_swver.setValid(true);
                                } else {
                                    validator_swver.setValid(false);
                                }
                            }
                        }
                        clearButtonVisible: true
                        maximumLength: 19
                    }
                    Button {
                        id: repobutton
                        text: qsTr("Known Software") + Retranslate.onLanguageChanged
                        onClicked: {
                            var createdSheet = repoCompDef.createObject();
                            createdSheet.open();
                        }
                    }
                }
            }
            //Links
            Container {
                horizontalAlignment: HorizontalAlignment.Center
                topPadding: ui.du(0.5)
                Header {
                    title: qsTr("Links") + Retranslate.onLanguageChanged
                }
                TextArea {
                    id: ostext
                    text: ""
                    editable: false
                    visible: true
                    content.flags: TextContentFlag.ActiveText
                    scrollMode: TextAreaScrollMode.Stiff
                    maximumLength: 16384
                }
                TextArea {
                    id: coretext
                    text: ""
                    editable: false
                    visible: true
                    content.flags: TextContentFlag.ActiveText
                    scrollMode: TextAreaScrollMode.Stiff
                    maximumLength: 16384
                }
                Divider {
                    id: divider
                    visible: false
                }
                TextArea {
                    id: radiotext
                    text: ""
                    editable: false
                    visible: true
                    content.flags: TextContentFlag.ActiveText
                    scrollMode: TextAreaScrollMode.Stiff
                    maximumLength: 16384
                }
            }
        }
    }
    attachedObjects: [
        ComponentDefinition {
            id: repoCompDef
            OSRepo {
                id: osRepoAttached
                onReleaseSelected: {
                    osver_input.text = repoos;
                    radiover_input.text = reporadio;
                    swver_input.text = reposoftware;
                }
            }
        },
        SystemToast {
            id: copytoast
            body: "";
        },
        SystemToast {
            id: linkexporttoast
            body: qsTr("Links saved to default directory") + Retranslate.onLanguageChanged;
        },
        SystemToast {
            id: pastetoast
            body: qsTr("URL Copied") + Retranslate.onLanguageChanged
            button.enabled: false
            onFinished: {
                Clipboard.copyToClipboard(Paster.getUploadUrl())
            }
        }
    ]
}
