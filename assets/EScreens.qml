/*EScreens.qml
 * -------------
 * Generates a code for the escreens app (take that, Javascript!). Invoke the escreens app.
 *
 --Thurask*/

import bb.cascades 1.4
import bb.system 1.2

Page {
    actions: [
        ActionItem {
            title: qsTr("Get Key") + Retranslate.onLanguageChanged
            onTriggered: {
                var regex_pin = RegExp(/\b[0-9a-f]{8}\b/)
                var regex_appv = RegExp(/\b\d{1,4}\.\d{1,4}\.\d{1,4}\.\d{1,4}\b/)
                var regex_uptime = RegExp(/\b\d{1,}\b/)
                if (regex_pin.test(pin.text) == true && regex_appv.test(appv.text) == true && regex_uptime.test(uptime.text) == true) {
                    _hashgen.calculateEscreen(pin.text, appv.text, uptime.text, validity.selectedOption.value);
                    ykey.text = _hashgen.returnEscreen();
                }
                else {
                    ykey.text = qsTr("Error") + Retranslate.onLanguageChanged
                }
            }
            ActionBar.placement: ActionBarPlacement.Signature
            imageSource: "asset:///images/menus/ic_pgp_key.png"
        },
        ActionItem {
            title: qsTr("Load Values") + Retranslate.onLanguageChanged
            onTriggered: {
                pin.text = Settings.getValueFor("uuid", "0x00000000").slice(2)
                appv.text = _fsmanager.readTextFile("/base/etc/os.version", "normal")
            }
            ActionBar.placement: ActionBarPlacement.OnBar
            imageSource: "asset:///images/menus/ic_edit.png"
        },
        ActionItem {
            title: qsTr("EScreens") + Retranslate.onLanguageChanged
            onTriggered: {
                myQuery.trigger(myQuery.query.invokeActionId);
            }
            ActionBar.placement: ActionBarPlacement.OnBar
            imageSource: "asset:///images/menus/ic_browser.png"
        },
        ActionItem {
            title: qsTr("Copy") + Retranslate.onLanguageChanged
            enabled: (ykey.text.length == 8) //8 character string
            onTriggered: {
                Clipboard.copyToClipboard(ykey.text)
                toast.show()
            }
            ActionBar.placement: ActionBarPlacement.OnBar
            imageSource: "asset:///images/menus/ic_copy.png"
        }
    ]
    attachedObjects: [
        Invocation {
            id: myQuery
            query {
                uri: ("escreen://")
                invokeActionId: "bb.action.OPEN"
                onQueryChanged: {
                    myQuery.query.updateQuery()
                }
            }
        },
        SystemToast {
            id: toast
            body: qsTr("Copied") + Retranslate.onLanguageChanged
        }
    ]
    Container {
        topPadding: ui.du(0.5)
        Container {
            TextField {
                id: pin
                hintText: qsTr("PIN") + Retranslate.onLanguageChanged
                onTextChanging: {
                    pin.text = pin.text.toLowerCase()
                }
                onTextChanged: {
                    pin.text = pin.text.toLowerCase()
                }
                maximumLength: 8
                validator: Validator {
                    id: validator_pin
                    mode: ValidationMode.Immediate
                    onValidate: {
                        var regex_pin = RegExp(/\b[0-9a-f]{8}\b/)
                        if (regex_pin.test(pin.text) == true) {
                            validator_pin.setValid(true);
                        } else {
                            validator_pin.setValid(false);
                        }
                    }
                }
                clearButtonVisible: true
            }
        }
        Container {
            topPadding: ui.du(0.5)
            TextField {
                id: appv
                hintText: qsTr("App Version") + Retranslate.onLanguageChanged
                onTextChanging: {
                    appv.text = _swlookup.spaceTrimmer(appv.text)
                }
                onTextChanged: {
                    appv.text = _swlookup.spaceTrimmer(appv.text)
                }
                validator: Validator {
                    id: validator_appver
                    mode: ValidationMode.Immediate
                    onValidate: {
                        var regex_appv = RegExp(/\b\d{1,4}\.\d{1,4}\.\d{1,4}\.\d{1,4}\b/)
                        if (regex_appv.test(appv.text) == true) {
                            validator_appver.setValid(true);
                        } else {
                            validator_appver.setValid(false);
                        }
                    }
                }
                clearButtonVisible: true
                maximumLength: 19
            }
        }
        Container {
            topPadding: ui.du(0.5)
            TextField {
                id: uptime
                hintText: qsTr("Uptime") + Retranslate.onLanguageChanged
                validator: Validator {
                    id: validator_uptime
                    mode: ValidationMode.Immediate
                    onValidate: {
                        var regex_uptime = RegExp(/\b\d{1,}\b/)
                        if (regex_uptime.test(uptime.text) == true) {
                            validator_uptime.setValid(true);
                        } else {
                            validator_uptime.setValid(false);
                        }
                    }
                }
                clearButtonVisible: true
                function returnUptime() {
                    var now = new Date();
                    var dmy = new Date(_fsmanager.readTextFile("/var/boottime.txt", "normal"));
                    uptime.text = (now.getTime() - dmy.getTime());
                }
            } //Load uptime button isn't the same as the actual escreens uptime, but I'm too proud of it to let it go:
            //escreens uptime is current ms since 01/01/1970 - ms since 01/01/1970 at boot time (/var/boottime.txt), but it's impossible
            //to exactly match them since the escreens value is generated during app launch. Alas.
            Button {
                visible: false
                text: qsTr("Load Uptime") + Retranslate.onLanguageChanged
                onClicked: {
                    uptime.returnUptime();
                }
            }
        }
        Container {
            topPadding: ui.du(0.5)
            DropDown {
                id: validity
                title: qsTr("Validity") + Retranslate.onLanguageChanged
                options: [
                    Option {
                        text: qsTr("1 day") + Retranslate.onLanguageChanged
                        value: ""
                    },
                    Option {
                        text: qsTr("3 days") + Retranslate.onLanguageChanged
                        value: "Hello my baby, hello my honey, hello my rag time gal"
                    },
                    Option {
                        text: qsTr("7 days") + Retranslate.onLanguageChanged
                        value: "He was a boy, and she was a girl, can I make it any more obvious?"
                    },
                    Option {
                        text: qsTr("15 days") + Retranslate.onLanguageChanged
                        value: "So am I, still waiting, for this world to stop hating?"
                    },
                    Option {
                        text: qsTr("30 days") + Retranslate.onLanguageChanged
                        value: "I love myself today, not like yesterday. I'm cool, I'm calm, I'm gonna be okay"
                        selected: true
                    }
                ]
            }
        }
        Label {
            id: ykey
            text: qsTr("Key") + Retranslate.onLanguageChanged
            horizontalAlignment: HorizontalAlignment.Center
            textStyle.fontSize: FontSize.XXLarge
        }
    }
}