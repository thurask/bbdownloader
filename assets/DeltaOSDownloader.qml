/*DeltaOSDownloader.qml
 -----------------------
 Generates delta links from CSE Prod.
 
 --Thurask*/

import bb.cascades 1.3
import bb.system 1.2

import "js/functions.js" as JScript

Page {
    property string hashedswversion
    property string swrelease
    property string osversion
    property string osinitversion
    property string osinit
    property string osinit2
    property string radioversion
    property string radinit
    property string radinit2
    ScrollView {
        scrollViewProperties.pinchToZoomEnabled: false
        scrollViewProperties.scrollMode: ScrollMode.Vertical
        scrollViewProperties.overScrollEffectMode: OverScrollEffectMode.None
        Container {
            Header {
                title: qsTr("Inputs") + Retranslate.onLanguageChanged
            }
            //Inputs
            Container {
                layout: StackLayout {
                    orientation: LayoutOrientation.TopToBottom 
                }
                Label {
                    text: qsTr("Target OS Version") + Retranslate.onLanguageChanged
                }
                Container {
                    layout: StackLayout {
                        orientation: LayoutOrientation.LeftToRight
                    }
                    TextField {
                        id: osver_input
                        hintText: qsTr("Target OS Version") + Retranslate.onLanguageChanged
                        inputMode: TextFieldInputMode.NumbersAndPunctuation
                        onTextChanged: {
                            osversion = osver_input.text
                            _swlookup.post(osversion, "https://cs.sl.blackberry.com/cse/srVersionLookup/2.0.0/");
                        }
                    }
                    Button {
                        text: qsTr("Lookup") + Retranslate.onLanguageChanged
                        onClicked: {
                            swver_input.text = _swlookup.softwareRelease();                                                              
                        }
                    }
                }
                Label {
                    text: qsTr("Target Radio Version") + Retranslate.onLanguageChanged
                }
                Container {
                    layout: StackLayout {
                        orientation: LayoutOrientation.LeftToRight
                    }
                    TextField {
                        id: radiover_input
                        hintText: qsTr("Target Radio Version") + Retranslate.onLanguageChanged
                        inputMode: TextFieldInputMode.NumbersAndPunctuation
                        onTextChanged: {
                            radioversion = radiover_input.text
                        }
                    }
                    Button {
                        text: qsTr("OS Version + 1") + Retranslate.onLanguageChanged
                        onClicked: {
                            radiover_input.text = _linkgen.incrementRadio(osversion);
                        }
                    }
                }
                Label {
                    text: qsTr("Target SW Version") + Retranslate.onLanguageChanged
                }
                Container {
                    layout: StackLayout {
                        orientation: LayoutOrientation.LeftToRight
                    }
                    TextField {
                        id: swver_input
                        hintText: qsTr("Target SW Version") + Retranslate.onLanguageChanged
                        onTextChanged: {
                            swrelease = swver_input.text
                            hashCalculateSha.calculateHash(swrelease)
                            hashedswversion = hashCalculateSha.getHash()
                        }
                        inputMode: TextFieldInputMode.NumbersAndPunctuation
                    }
                    Button {
                        text: qsTr("Known Software") + Retranslate.onLanguageChanged
                        onClicked: {
                            var createdSheet = repoCompDef.createObject();
                            createdSheet.open();
                        }
                    }
                }
                Label {
                    text: qsTr("Initial OS Version") + Retranslate.onLanguageChanged
                }
                Container {
                    layout: StackLayout {
                        orientation: LayoutOrientation.LeftToRight
                    }
                    TextField {
                        id: osinit_input
                        hintText: qsTr("Initial OS Version") + Retranslate.onLanguageChanged
                        inputMode: TextFieldInputMode.NumbersAndPunctuation
                        onTextChanged: {
                            osinitversion = osinit_input.text;
                            osinit = osinit_input.text.replace(/\./g, "");
                            osinit2 = osinit_input.text.replace(/\./g, "_");
                        }
                    }
                    Button {
                        text: qsTr("Use Current") + Retranslate.onLanguageChanged
                        onClicked: {
                            osinit_input.text = _manager.readTextFile("/base/etc/os.version", "normal");
                            radioinit_input.text = _manager.readTextFile("/radio/etc/radio.version", "normal");
                        }
                    }
                }
                Label {
                    text: qsTr("Initial Radio Version") + Retranslate.onLanguageChanged
                }
                Container {
                    layout: StackLayout {
                        orientation: LayoutOrientation.LeftToRight
                    }
                    TextField {
                        id: radioinit_input
                        hintText: qsTr("Initial Radio Version") + Retranslate.onLanguageChanged
                        inputMode: TextFieldInputMode.NumbersAndPunctuation
                        onTextChanged: {
                            radinit = radioinit_input.text.replace(/\./g, "");
                            radinit2 = radioinit_input.text.replace(/\./g, "_");
                        }
                    }
                    Button {
                        text: qsTr("OS Version + 1") + Retranslate.onLanguageChanged
                        onClicked: {
                            radioinit_input.text = _linkgen.incrementRadio(osinitversion);
                        }
                    }
                }
            }
            //Dropdowns
            Container {
                topPadding: 20.0
                DropDown {
                    id: osdropdown
                    title: qsTr("Choose OS Type") + Retranslate.onLanguageChanged
                    Option {
                        id: dropdown_core
                        text: "Delta OS"
                        value: "core"
                        onSelectedChanged: {
                            if (selected){
                                os_download_label.text = qsTr("Delta from ") + Retranslate.onLanguageChanged + osinit_input.text + qsTr(" to ") + Retranslate.onLanguageChanged + osver_input.text + ":";
                                dropdown_winchester.setEnabled(true);
                            }
                        }
                    }
                    Option {
                        id: dropdown_core_verizon
                        text: "Verizon Delta OS"
                        value: "core_vzw"
                        onSelectedChanged: {
                            if (selected){
                                os_download_label.text = qsTr("Verizon delta from ") + Retranslate.onLanguageChanged + osinit_input.text + qsTr(" to ") + Retranslate.onLanguageChanged + osver_input.text + ":";
                                dropdown_winchester.setEnabled(false);
                            }
                        }
                    }
                }
                DropDown {
                    id: devicedropdown
                    title: qsTr("Choose Device") + Retranslate.onLanguageChanged
                    Option {
                        id: dropdown_winchester
                        text: "Z10 STL100-1/Dev Alpha A/Dev Alpha B"
                        value: "winchester"
                        enabled: (osdropdown.selectedValue == "core_vzw") ? false : true
                    }
                    Option {
                        id: dropdown_stl
                        text: "Z10 STL100-2/3/P9982"
                        value: "8960"
                    }
                    Option {
                        id: dropdown_stl_omadm
                        text: "Z10 STL100-4"
                        value: "8960omadm"
                    }
                    Option {
                        id: dropdown_q10
                        text: "Q10/Q5/P9983/Dev Alpha C"
                        value: "8960wtr"
                    }
                    Option {
                        id: dropdown_z30
                        text: "Z30/Manitoba/Classic"
                        value: "8960wtr5"
                    }
                    Option {
                        id: dropdown_jakarta
                        text: "Z3/Kopi/Cafe"
                        value: "8930wtr5"
                    }
                    Option {
                        id: dropdown_windermere
                        text: "Passport"
                        value: "8974_sqw"
                    }
                    onSelectedValueChanged: {
                        JScript.setRadios();
                    }
                }
            }
            //Generator buttons
            Container {
                layout: StackLayout {
                    orientation: LayoutOrientation.LeftToRight
                }
                horizontalAlignment: HorizontalAlignment.Center
                topPadding: 20.0
                Button {
                    id:generatebutton
                    text: qsTr("Generate") + Retranslate.onLanguageChanged
                    horizontalAlignment: HorizontalAlignment.Center
                    onClicked: {
                        global_exportcontainer.visible = true;
                        global_clipboardcontainer.visible = true;
                        global_linkcontainer.visible = true;
                        JScript.generateDeltas();
                    }
                }
                Button {
                    id: clearbutton
                    text: qsTr("Clear") + Retranslate.onLanguageChanged
                    onClicked: {
                        os_download_textarea.text = "";
                        radio_download_textarea.text = "";
                        global_linkcontainer.visible = false;
                        global_exportcontainer.visible = false;
                        global_clipboardcontainer.visible = false;
                        downloadComponent.visible = false;
                        osdropdown.resetSelectedOption();
                        devicedropdown.resetSelectedOption();
                        os_download_label.text = qsTr("OS Link:") + Retranslate.onLanguageChanged;
                        radio_download_label.text = qsTr("Radio Link:") + Retranslate.onLanguageChanged;
                        _manager.messagesCleared();
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
                Label {
                    id: os_download_label
                    text: qsTr("OS Link:") + Retranslate.onLanguageChanged
                }
                TextArea {
                    id: os_download_textarea
                    text: ""
                    editable: false
                    content.flags: TextContentFlag.ActiveText
                }
                Label {
                    id: radio_download_label
                    text: qsTr("Radio Link:") + Retranslate.onLanguageChanged
                }
                TextArea {
                    id: radio_download_textarea
                    text: ""
                    editable: false
                    content.flags: TextContentFlag.ActiveText
                }
                Container {
                    id: global_exportcontainer
                    layout: StackLayout {
                        orientation: LayoutOrientation.TopToBottom
                    }
                    horizontalAlignment: HorizontalAlignment.Center
                    topPadding: 10.0
                    visible:false
                    Header {
                        title: qsTr("Export") + Retranslate.onLanguageChanged
                    }
                    Container {
                        layout: StackLayout {
                            orientation: LayoutOrientation.LeftToRight
                        }
                        topPadding: 10.0
                        horizontalAlignment: HorizontalAlignment.Center
                        Button {
                            text: qsTr("Export Links") + Retranslate.onLanguageChanged
                            onClicked: {
                                _manager.exportDeltaLinks(hashedswversion, osversion, radioversion, osinitversion, osinit, osinit2, radinit, radinit2);
                                linkexporttoast.body = qsTr("Links saved to default directory") + Retranslate.onLanguageChanged;
                                linkexporttoast.button.enabled = true;
                                myQuery.query.uri = _manager.returnFilename();
                                myQuery.query.data = "";
                                myQuery.query.mimeType = "";
                                linkexporttoast.show();
                            }
                        }
                        Button {
                            text: qsTr("Share Links") + Retranslate.onLanguageChanged
                            onClicked: {
                                myQuery.query.data = _manager.returnDeltaLinks(hashedswversion, osversion, radioversion, osinit, osinit2, radinit, radinit2);
                                myQuery.query.uri = "";
                                myQuery.query.mimeType = "text/plain"
                                myQuery.trigger(myQuery.query.invokeActionId);
                            }
                        }
                    }
                }
                Container {
                    id: global_clipboardcontainer
                    layout: StackLayout {
                        orientation: LayoutOrientation.TopToBottom
                    }
                    horizontalAlignment: HorizontalAlignment.Center
                    topPadding: 10.0
                    Header {
                        title: qsTr("Clipboard") + Retranslate.onLanguageChanged
                    }
                    Container {
                        layout: StackLayout {
                            orientation: LayoutOrientation.LeftToRight
                        }
                        topPadding: 10.0
                        Button {
                            text: qsTr("Copy OS") + Retranslate.onLanguageChanged
                            onClicked: {
                                if (os_download_textarea.text.indexOf("http") != -1) {
                                    Clipboard.copyToClipboard(os_download_textarea.text);
                                    linkexporttoast.body = qsTr("OS URL copied") + Retranslate.onLanguageChanged;
                                    linkexporttoast.button.enabled = true;
                                    myQuery.query.data = os_download_textarea.text;
                                    myQuery.query.uri = "";
                                    myQuery.query.mimeType = "text/plain"
                                    linkexporttoast.show();
                                }
                            }
                        }
                        Button {
                            text: qsTr("Copy Radio") + Retranslate.onLanguageChanged
                            onClicked: {
                                if (radio_download_textarea.text.indexOf("http") != -1){
                                    Clipboard.copyToClipboard(radio_download_textarea.text);
                                    linkexporttoast.body = qsTr("Radio URL copied") + Retranslate.onLanguageChanged;
                                    linkexporttoast.button.enabled = true;
                                    myQuery.query.data = radio_download_textarea.text;
                                    myQuery.query.uri = "";
                                    myQuery.query.mimeType = "text/plain"
                                    linkexporttoast.show();
                                }
                            }
                        }
                        Button {
                            text: qsTr("Copy All") + Retranslate.onLanguageChanged
                            onClicked: {
                                if (os_download_textarea.text.indexOf("http") != -1 && radio_download_textarea.text.indexOf("http") != -1) {
                                    _manager.copyDeltaLinks(hashedswversion, osversion, radioversion, osinit, osinit2, radinit, radinit2)
                                    linkexporttoast.body = qsTr("All URLs copied") + Retranslate.onLanguageChanged;
                                    linkexporttoast.button.enabled = true;
                                    myQuery.query.data = _manager.returnLinks(hashedswversion, osversion, radioversion);
                                    myQuery.query.uri = "";
                                    myQuery.query.mimeType = "text/plain"
                                    linkexporttoast.show();
                                }
                            }
                        }
                    }
                }
                Container {
                    topPadding: 10.0
                    id: global_linkcontainer
                    layout: StackLayout {
                        orientation: LayoutOrientation.TopToBottom
                    }
                    horizontalAlignment: HorizontalAlignment.Center
                    Header {
                        title: qsTr("Downloads") + Retranslate.onLanguageChanged
                    }
                    Container {
                        layout: StackLayout {
                            orientation: LayoutOrientation.LeftToRight
                        }
                        topPadding: 10.0
                        horizontalAlignment: HorizontalAlignment.Center
                        Button {
                            text: qsTr("Download OS") + Retranslate.onLanguageChanged
                            onClicked: {
                                downloadComponent.visible = true;
                                var osdl = os_download_textarea.text;
                                if (osdl.indexOf("http") != -1) {
                                    _manager.downloadUrl(os_download_textarea.text);
                                }
                            }
                        }
                        Button {
                            text: qsTr("Download Radio") + Retranslate.onLanguageChanged
                            onClicked: {
                                downloadComponent.visible = true;
                                var raddl = radio_download_textarea.text;
                                if (raddl.indexOf("http") != -1){
                                    _manager.downloadUrl(radio_download_textarea.text);
                                }
                            }
                        }
                    }
                    DownloadComponent{
                        id: downloadComponent
                    }
                }
            }
        }
    }
    attachedObjects: [
        ComponentDefinition {
            id: repoCompDef
            OSRepo{
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
            body: "";
            button.enabled: false;
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
                data: _manager.returnLinks(hashedswversion, osversion, radioversion)
                onQueryChanged: {
                    myQuery.query.updateQuery()
                }
            }
        }
    ]
}