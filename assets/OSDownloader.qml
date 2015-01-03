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
    actions: [
        ActionItem {
            title: qsTr("Generate") + Retranslate.onLanguageChanged
            onTriggered: {
                ostext.text = _manager.returnOsLinks(hashedswversion, osversion, true);
                radiotext.text = _manager.returnRadioLinks(hashedswversion, osversion, radioversion);
                divider.visible = true;
                allclipboard.enabled = true;
                osclipboard.enabled = true;
                if (radiotext.text.length != 0){
                    radioclipboard.enabled = true;
                }
                exportbutton.enabled = true;
            }
            ActionBar.placement: ActionBarPlacement.Signature
            imageSource: "asset:///images/menus/ic_edit.png"
        },
        ActionItem {
            title: qsTr("Clear") + Retranslate.onLanguageChanged
            onTriggered: {
                ostext.text = "";
                radiotext.text = "";
                divider.visible = false;
                allclipboard.enabled = false;
                osclipboard.enabled = false;
                radioclipboard.enabled = false;
                exportbutton.enabled = false;
            }
            ActionBar.placement: ActionBarPlacement.OnBar
            imageSource: "asset:///images/menus/ic_clear.png"
        },
        ActionItem {
            id: allclipboard
            enabled: false
            title: qsTr("Copy Links") + Retranslate.onLanguageChanged
            onTriggered: {
                _manager.copyLinks(hashedswversion, osversion, radioversion, true)
                linkexporttoast.body = qsTr("All URLs copied") + Retranslate.onLanguageChanged;
                linkexporttoast.show();
            }
            ActionBar.placement: ActionBarPlacement.OnBar
            imageSource: "asset:///images/menus/ic_copy.png"
        },
        ActionItem {
            id: osclipboard
            enabled: false
            title: qsTr("Copy OS Links") + Retranslate.onLanguageChanged
            onTriggered: {
                _manager.copyOsLinks(hashedswversion, osversion, true)
                linkexporttoast.body = qsTr("All URLs copied") + Retranslate.onLanguageChanged;
                linkexporttoast.show();
            }
            ActionBar.placement: ActionBarPlacement.InOverflow
            imageSource: "asset:///images/menus/ic_copy.png"
        },
        ActionItem {
            id: radioclipboard
            enabled: false
            title: (radiotext.text.indexOf("Variant URL") != -1 ? qsTr("Copy Variant Links") + Retranslate.onLanguageChanged : qsTr("Copy Radio Links") + Retranslate.onLanguageChanged)
            onTriggered: {
                _manager.copyRadioLinks(hashedswversion, osversion, radioversion)
                linkexporttoast.body = qsTr("Radio URLs copied") + Retranslate.onLanguageChanged;
                linkexporttoast.show();
            }
            ActionBar.placement: ActionBarPlacement.InOverflow
            imageSource: "asset:///images/menus/ic_copy.png"
        },
        ActionItem {
            id: exportbutton
            enabled: false
            title: qsTr("Export Links") + Retranslate.onLanguageChanged
            onTriggered: {
                _manager.exportLinks(swrelease, hashedswversion, osversion, radioversion, true);
                linkexporttoast.body = qsTr("Links saved to default directory") + Retranslate.onLanguageChanged;
                linkexporttoast.button.enabled = true;
                myQuery.query.uri = _manager.returnFilename();
                myQuery.query.data = "";
                myQuery.query.mimeType = "";
                linkexporttoast.show();
            }
            ActionBar.placement: ActionBarPlacement.InOverflow
            imageSource: "asset:///images/menus/ic_doctype_doc.png"
        }
    ]
    ScrollView {
        scrollViewProperties.pinchToZoomEnabled: false
        scrollViewProperties.scrollMode: ScrollMode.Vertical
        scrollViewProperties.overScrollEffectMode: OverScrollEffectMode.OnPinch
        Container {
            topPadding: 10.0
            //Inputs
            Container {
                layout: StackLayout {
                    orientation: LayoutOrientation.TopToBottom
                }
                Container {
                    topPadding: 5.0
                    layout: StackLayout {
                        orientation: LayoutOrientation.LeftToRight
                    }
                    TextField {
                        id: osver_input
                        hintText: qsTr("Target OS Version") + Retranslate.onLanguageChanged
                        onTextChanging: {
                            osversion = osver_input.text
                            _swlookup.post(osversion, "https://cs.sl.blackberry.com/cse/srVersionLookup/2.0.0/");
                        }
                        onTextChanged: {
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
                    }
                    Button {
                        text: qsTr("Lookup") + Retranslate.onLanguageChanged
                        onClicked: {
                            var regex = RegExp(/\b\d{1,4}\.\d{1,4}\.\d{1,4}\.\d{1,4}\b/);
                            if (regex.test(osver_input.text) == true) {
                                swver_input.text = _swlookup.softwareRelease();
                            }
                        }
                    }
                }
                Container {
                    topPadding: 5.0
                    layout: StackLayout {
                        orientation: LayoutOrientation.LeftToRight
                    }
                    TextField {
                        id: radiover_input
                        hintText: qsTr("Target Radio Version") + Retranslate.onLanguageChanged
                        onTextChanging: {
                            radioversion = radiover_input.text
                        }
                        validator: Validator {
                            id: validator_radver
                            mode: ValidationMode.Immediate
                            onValidate: {
                                var regex = RegExp(/\b\d{1,4}\.\d{1,4}\.\d{1,4}\.\d{1,4}\b/);
                                if (regex.test(radiover_input.text) == true || swver_input.text == "N/A") {
                                    validator_radver.setValid(true);
                                } else {
                                    validator_radver.setValid(false);
                                }
                            }
                        }
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
                    topPadding: 5.0
                    layout: StackLayout {
                        orientation: LayoutOrientation.LeftToRight
                    }
                    TextField {
                        id: swver_input
                        hintText: qsTr("Target SW Version") + Retranslate.onLanguageChanged
                        onTextChanging: {
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
                topPadding: 10.0
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
            id: linkexporttoast
            body: ""
            button.enabled: false
            button.label: qsTr("Share") + Retranslate.onLanguageChanged;
            onFinished: {
                if (linkexporttoast.result == SystemUiResult.ButtonSelection){
                    myQuery.trigger(myQuery.query.invokeActionId)
                }
            }
        },
        Invocation {
            id: myQuery
            query {
                uri: _manager.returnFilename()
                mimeType: ""
                invokeActionId: "bb.action.SHARE"
                data: _manager.returnLinks(hashedswversion, osversion, radioversion, true)
                onQueryChanged: {
                    myQuery.query.updateQuery()
                }
            }
        }
    ]
}
