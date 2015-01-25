/*EScreens.qml
 -------------
 Generates a code for the escreens app (take that, Javascript!). Invoke the escreens app.
 
 --Thurask*/

import bb.cascades 1.3
import bb.device 1.3
import "js/escreens.js" as Escreens

Page {
    actions: [
        ActionItem {
            title: qsTr("Get Key") + Retranslate.onLanguageChanged
            onTriggered: {
                var regex_pin = RegExp(/\b[0-9a-f]{8}\b/)
                var regex_appv = RegExp(/\b\d{1,4}\.\d{1,4}\.\d{1,4}\.\d{1,4}\b/)
                var regex_uptime = RegExp(/\b\d{1,}\b/)
                if (regex_pin.test(pin.text) == true && regex_appv.test(appv.text) == true && regex_uptime.test(uptime.text) == true){
                    Escreens.newHMAC();
                }
            }
            ActionBar.placement: ActionBarPlacement.Signature
            imageSource: "asset:///images/menus/ic_pgp_key.png"
        },
        ActionItem {
            title: qsTr("Load Values") + Retranslate.onLanguageChanged
            onTriggered: {
                pin.text = hwinfo.pin.slice(2)
                appv.text = _manager.readTextFile("/base/etc/os.version", "normal")
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
        HardwareInfo {
            id: hwinfo
        }
    ]
    Container {
        topPadding: 5.0
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
                        }
                        else {
                            validator_pin.setValid(false);
                        }
                    }
                }
                clearButtonVisible: true
            }
        }
        Container {
            topPadding: 5.0
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
                        }
                        else {
                            validator_appver.setValid(false);
                        }
                    }
                }
                clearButtonVisible: true
                maximumLength: 19
            }
        }
        Container {
            topPadding: 5.0
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
                        }
                        else {
                            validator_uptime.setValid(false);
                        }
                    }
                }
                clearButtonVisible: true
                function returnUptime() {
                    var now = new Date();
                    var dmy = new Date(_manager.readTextFile("/var/boottime.txt", "normal"));
                    uptime.text = (now.getTime() - dmy.getTime());
                }
            }//Load uptime button isn't the same as the actual escreens uptime, but I'm too proud of it to let it go:
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
            topPadding: 5.0
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
                        value: "%55%72%79%79%62%20%7A%6C%20%6F%6E%6F%6C%2C%20%75%72%79%79%62%20%7A%6C%20%75%62%61%72%6C%2C%20%75%72%79%79%62%20%7A%6C%20%65%6E%74%20%67%76%7A%72%20%74%6E%79"
                    },
                    Option {
                        text: qsTr("7 days") + Retranslate.onLanguageChanged
                        value: "%55%72%20%6A%6E%66%20%6E%20%6F%62%6C%2C%20%6E%61%71%20%66%75%72%20%6A%6E%66%20%6E%20%74%76%65%79%2C%20%70%6E%61%20%56%20%7A%6E%78%72%20%76%67%20%6E%61%6C%20%7A%62%65%72%20%62%6F%69%76%62%68%66%3F"
                    },
                    Option {
                        text: qsTr("15 days") + Retranslate.onLanguageChanged
                        value: "%46%62%20%6E%7A%20%56%2C%20%66%67%76%79%79%20%6A%6E%76%67%76%61%74%2C%20%73%62%65%20%67%75%76%66%20%6A%62%65%79%71%20%67%62%20%66%67%62%63%20%75%6E%67%76%61%74%3F"
                    },
                    Option {
                        text: qsTr("30 days") + Retranslate.onLanguageChanged
                        value: "%56%20%79%62%69%72%20%7A%6C%66%72%79%73%20%67%62%71%6E%6C%2C%20%61%62%67%20%79%76%78%72%20%6C%72%66%67%72%65%71%6E%6C%2E%20%56%27%7A%20%70%62%62%79%2C%20%56%27%7A%20%70%6E%79%7A%2C%20%56%27%7A%20%74%62%61%61%6E%20%6F%72%20%62%78%6E%6C"
                        selected: true
                    }]
            }
        }
        Label {
            id: ykey
            text: qsTr("Your Key") + Retranslate.onLanguageChanged
            horizontalAlignment: HorizontalAlignment.Center
            textStyle.fontSize: FontSize.XXLarge
        }
    }
}