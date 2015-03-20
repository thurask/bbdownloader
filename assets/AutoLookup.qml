/*Autolookup.qml
 ---------------
 Get some SW/OS pairs. Export your findings to a text file, if you want.

 --Thurask*/

import bb.cascades 1.4
import bb.system 1.2
import bb.device 1.4
import qt.timer 1.0

Page {
    signal lookupStarted()
    signal lookupStopped()
    property bool scanning: false
    actions: [
        ActionItem {
            id: autolookupbutton
            title: qsTr("Start") + Retranslate.onLanguageChanged
            onTriggered: {
                if (validator.valid == false){
                    autolookup_input.text = qsTr("Input Valid OS") + Retranslate.onLanguageChanged;
                }
                else {
                    if (scanning == false) {
                        lookupStarted()
                        if (outputtext.text = ""){
                            _swlookup.setSoftwareRelease("");
                        }
                        scanning = true;
                        outputtext.storedtext = outputtext.text;
                        outputtext.text = "";
                        autolookupbutton.title = qsTr("Stop") + Retranslate.onLanguageChanged
                        autolookupbutton.imageSource = "asset:///images/menus/ic_stop.png"
                        _swlookup.softwareReleaseChanged.connect(timer.lookup())
                        _swlookup.post(autolookup_input.text, serverdropdown.selectedValue);
                    }
                    else {
                        lookupStopped()
                        scanning = false;
                        autolookupbutton.title = qsTr("Start") + Retranslate.onLanguageChanged
                        autolookupbutton.imageSource = "asset:///images/menus/ic_play.png"
                        timer.stop();
                    }
                }
            }
            ActionBar.placement: ActionBarPlacement.Signature
            imageSource: "asset:///images/menus/ic_play.png"
        },
        ActionItem {
            id: autoclearbutton
            title: qsTr("Clear") + Retranslate.onLanguageChanged
            enabled: (scanning == false && outputtext.text != "")
            onTriggered: {
                outputtext.storedtext = outputtext.text;
                outputtext.text = "";
                lookupexporttoast.body = qsTr("Cleared") + Retranslate.onLanguageChanged;
                lookupexporttoast.button.enabled = true;
                lookupexporttoast.button.label = qsTr("Undo") + Retranslate.onLanguageChanged;
                lookupexporttoast.show();
            }
            imageSource: "asset:///images/menus/ic_clear.png"
            ActionBar.placement: ActionBarPlacement.OnBar
        },
        ActionItem {
            id: autocopybutton
            title: qsTr("Copy") + Retranslate.onLanguageChanged
            enabled: (scanning == false && outputtext.text != "")
            onTriggered: {
                Clipboard.copyToClipboard(_swlookup.spaceTrimmer(outputtext.text));
                lookupexporttoast.body = qsTr("Copied") + Retranslate.onLanguageChanged;
                lookupexporttoast.button.enabled = false;
                lookupexporttoast.button.label = "";
                lookupexporttoast.show();
            }
            imageSource: "asset:///images/menus/ic_copy.png"
            ActionBar.placement: ActionBarPlacement.OnBar
        },
        ActionItem {
            id: autoexportbutton
            title: qsTr("Export") + Retranslate.onLanguageChanged
            enabled: (scanning == false && outputtext.text != "")
            onTriggered: {
                _manager.saveTextFile(outputtext.text, "Lookup-" + (serverdropdown.selectedOption.text));
                lookupexporttoast.body = qsTr("Lookups saved to default directory") + Retranslate.onLanguageChanged;
                lookupexporttoast.button.enabled = false;
                lookupexporttoast.button.label = "";
                lookupexporttoast.show();
            }
            imageSource: "asset:///images/menus/ic_doctype_doc.png"
            ActionBar.placement: ActionBarPlacement.OnBar
        },
        ActionItem {
            id: autosharebutton
            title: qsTr("Share") + Retranslate.onLanguageChanged
            enabled: (scanning == false && outputtext.text != "")
            onTriggered: {
                myQuery.trigger(myQuery.query.invokeActionId)
            }
            imageSource: "asset:///images/menus/ic_share.png"
            ActionBar.placement: ActionBarPlacement.OnBar
        },
        ActionItem {
            id: autopastebutton
            title: qsTr("Upload Lookups") + Retranslate.onLanguageChanged
            enabled: (scanning == false && outputtext.text != "")
            onTriggered: {
                Paster.uploadPaste(_swlookup.spaceTrimmer(outputtext.text))
                Paster.uploadUrlChanged.connect(pastetoast.show())
            }
            imageSource: "asset:///images/menus/ic_browser.png"
            ActionBar.placement: ActionBarPlacement.OnBar
        }
    ]
    attachedObjects: [
        QTimer{
            id: timer
            interval: 2000
            onTimeout: {
                _swlookup.softwareReleaseChanged.connect(timer.lookup());
                _swlookup.post(autolookup_input.text, serverdropdown.selectedValue);
            }
            function lookup() {
                if (_swlookup.softwareRelease().indexOf(".") != -1 && outputtext.text.indexOf(_swlookup.softwareRelease()) == -1){
                    if (serverdropdown.selectedValue.indexOf("cs.sl") != -1){
                        var smeg = _swlookup.getAvailability()
                        outputtext.text = outputtext.text + ("OS " + autolookup_input.text + " - SR " + _swlookup.softwareRelease() + " [" + serverdropdown.selectedOption.text + "] [" + smeg + "]\n");
                        if (smeg == "Valid") {
                            led.color = LedColor.Magenta
                        }
                        else {
                            led.color = LedColor.White
                        }
                    }
                    else {
                        outputtext.text = outputtext.text + ("OS " + autolookup_input.text + " - SR " + _swlookup.softwareRelease() + " [" + serverdropdown.selectedOption.text + "]\n");
                        led.color = LedColor.White
                    }
                    led.flash(1);
                }
                else {
                    led.cancel();
                }
                autolookup_input.text = _swlookup.lookupIncrement(autolookup_input.text, 3);
                timer.start();
            }
        },
        SystemToast {
            id: lookupexporttoast
            body: ""
            button.enabled: false
            button.label: ""
            onFinished: {
                if (lookupexporttoast.result == SystemUiResult.ButtonSelection){
                    outputtext.setText(outputtext.storedtext);
                }
            }
        },
        SystemToast {
            id: pastetoast
            body: qsTr("URL Copied") + Retranslate.onLanguageChanged
            button.enabled: false
            button.label: ""
            onFinished: {
                Clipboard.copyToClipboard(Paster.getUploadUrl())
            }
        },
        Invocation {
            id: myQuery
            query {
                mimeType: "text/plain"
                data: outputtext.text
                invokeActionId: "bb.action.SHARE"
                onQueryChanged: {
                    myQuery.query.updateQuery()
                }
            }
        },
        Led {
            color: LedColor.White
            id: led
        }
    ]
    Container {
        topPadding: ui.du(0.5)
        Container {
            layout: StackLayout {
                orientation: LayoutOrientation.LeftToRight
            }
            TextField {
                id: autolookup_input
                verticalAlignment: VerticalAlignment.Center
                enabled: (scanning == false)
                onTextChanging: {
                    autolookup_input.text = _swlookup.spaceTrimmer(autolookup_input.text);
                    _swlookup.post(autolookup_input.text, serverdropdown.selectedValue);
                }
                onTextChanged: {
                    autolookup_input.text = _swlookup.spaceTrimmer(autolookup_input.text);
                    _swlookup.post(autolookup_input.text, serverdropdown.selectedValue);
                }
                hintText: qsTr("Enter OS version") + Retranslate.onLanguageChanged
                validator: Validator {
                    id: validator
                    mode: ValidationMode.Immediate
                    onValidate: {
                        var regex = RegExp(/\b\d{1,4}\.\d{1,4}\.\d{1,4}\.\d{1,4}\b/)
                        if (regex.test(autolookup_input.text) == true) {
                            validator.setValid(true);
                        }
                        else {
                            validator.setValid(false);
                        }
                    }
                }
                clearButtonVisible: true
                maximumLength: 19
            }
        }
        Container {
            topPadding: ui.du(0.5)
            DropDown {
                id: serverdropdown
                title: qsTr("Server") + Retranslate.onLanguageChanged
                enabled: (scanning == false)
                Option {
                    id: main
                    text: qsTr("Production") + Retranslate.onLanguageChanged
                    value: "https://cs.sl.blackberry.com/cse/srVersionLookup/2.0.0/"
                    selected: true
                }
                Option {
                    id: beta
                    text: qsTr("Beta") + Retranslate.onLanguageChanged
                    value: "https://beta.sl.eval.blackberry.com/slscse/srVersionLookup/2.0.0/"
                }
                Option {
                    id: beta2
                    text: qsTr("Beta 2") + Retranslate.onLanguageChanged
                    value: "https://beta2.sl.eval.blackberry.com/slscse/srVersionLookup/2.0.0/"
                }
                Option {
                    id: alpha
                    text: qsTr("Alpha") + Retranslate.onLanguageChanged
                    value: "https://alpha.sl.eval.blackberry.com/slscse/srVersionLookup/2.0.0/"
                }
                Option {
                    id: alpha2
                    text: qsTr("Alpha 2") + Retranslate.onLanguageChanged
                    value: "https://alpha2.sl.eval.blackberry.com/slscse/srVersionLookup/2.0.0/"
                }
                onSelectedValueChanged: {
                    _swlookup.post(autolookup_input.text, serverdropdown.selectedValue);
                }
            }
        }
        Header {
            title: qsTr("Results") + Retranslate.onLanguageChanged
        }
        Container {
            ScrollView {
                scrollViewProperties.scrollMode: ScrollMode.Vertical
                scrollViewProperties.pinchToZoomEnabled: false
                scrollViewProperties.overScrollEffectMode: OverScrollEffectMode.None
                TextArea {
                    property string storedtext
                    text: ""
                    editable: false
                    id: outputtext
                    textFormat: TextFormat.Plain
                    content.flags: TextContentFlag.ActiveTextOff
                }
            }
        }
    }
}