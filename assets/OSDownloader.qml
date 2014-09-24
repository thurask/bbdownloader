/*OSDownloader.qml
 ------------------
 The meat of the application. Generates and downloads CSE Prod links.
 
 --Thurask*/

import bb.cascades 1.3
import bb.system 1.2

Page {
    property string hashedswversion
    property string swrelease
    property string osversion
    property string radioversion
    ScrollView {
        scrollViewProperties.pinchToZoomEnabled: false
        scrollViewProperties.scrollMode: ScrollMode.Vertical
        scrollViewProperties.overScrollEffectMode: OverScrollEffectMode.None
        Container {
            topPadding: 20.0
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
                        onTextChanging: {
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
                        onTextChanging: {
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
                        onTextChanging: {
                            swrelease = swver_input.text
                            hashCalculateSha.calculateHash(swrelease)
                            hashedswversion = hashCalculateSha.getHash()
                        }
                        inputMode: TextFieldInputMode.NumbersAndPunctuation
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
            //Dropdowns
            Container {
                horizontalAlignment: HorizontalAlignment.Center
                topPadding: 20.0
                DropDown {
                    id: osdropdown
                    objectName: "osdropdown"
                    title: qsTr("Choose OS Type") + Retranslate.onLanguageChanged
                    Option {
                        id: dropdown_debrick
                        text: "Debrick OS"
                        value: "debrick"
                        onSelectedChanged: {
                            if (selected){
                                dropdown_winchester.setEnabled(true);
                                dropdown_winchester_daa.setEnabled(true);
                                dropdown_winchester_dab.setEnabled(true);
                                dropdown_winchester_daab.setEnabled(true);
                                dropdown_pb.setEnabled(true);
                                dropdown_pblte_old.setEnabled(true);
                                dropdown_pblte_new.setEnabled(true);
                            }
                        }
                    }
                    Option {
                        id: dropdown_core
                        text: "Core OS"
                        value: "core"
                        onSelectedChanged: {
                            if (selected){
                                dropdown_winchester.setEnabled(true);
                                dropdown_winchester_daa.setEnabled(true);
                                dropdown_winchester_dab.setEnabled(true);
                                dropdown_winchester_daab.setEnabled(true);
                                dropdown_pb.setEnabled(false);
                                dropdown_pblte_old.setEnabled(false);
                                dropdown_pblte_new.setEnabled(false);
                            }
                        }
                    }
                    Option {
                        id: dropdown_debrick_verizon
                        text: "Verizon Debrick OS"
                        value: "debrick_vzw"
                        onSelectedChanged: {
                            if (selected){
                                dropdown_winchester.setEnabled(false);
                                dropdown_winchester_daa.setEnabled(false);
                                dropdown_winchester_dab.setEnabled(false);
                                dropdown_winchester_daab.setEnabled(false);
                                dropdown_pb.setEnabled(false);
                                dropdown_pblte_old.setEnabled(false);
                                dropdown_pblte_new.setEnabled(false);
                            }
                        }
                    }
                    Option {
                        id: dropdown_core_verizon
                        text: "Verizon Core OS"
                        value: "core_vzw"
                        onSelectedChanged: {
                            if (selected){
                                dropdown_winchester.setEnabled(false);
                                dropdown_winchester_daa.setEnabled(false);
                                dropdown_winchester_dab.setEnabled(false);
                                dropdown_winchester_daab.setEnabled(false);
                                dropdown_pb.setEnabled(false);
                                dropdown_pblte_old.setEnabled(false);
                                dropdown_pblte_new.setEnabled(false);
                            }
                        }
                    }
                    Option {
                        id: dropdown_debrick_china
                        text: "China Debrick OS"
                        value: "debrick_china"
                        onSelectedChanged: {
                            if (selected){
                                dropdown_winchester.setEnabled(false);
                                dropdown_winchester_daa.setEnabled(false);
                                dropdown_winchester_dab.setEnabled(false);
                                dropdown_winchester_daab.setEnabled(false);
                                dropdown_pb.setEnabled(false);
                                dropdown_pblte_old.setEnabled(false);
                                dropdown_pblte_new.setEnabled(false);
                            }
                        }
                    }
                    Option {
                        id: dropdown_core_china
                        text: "China Core OS"
                        value: "core_china"
                        onSelectedChanged: {
                            if (selected){
                                dropdown_winchester.setEnabled(false);
                                dropdown_winchester_daa.setEnabled(false);
                                dropdown_winchester_dab.setEnabled(false);
                                dropdown_winchester_daab.setEnabled(false);
                                dropdown_pb.setEnabled(false);
                                dropdown_pblte_old.setEnabled(false);
                                dropdown_pblte_new.setEnabled(false);
                            }
                        }
                    }
                    Option {
                        id: dropdown_sdkdebrick
                        text: "SDK Debrick OS"
                        value: "sdkdebrick"
                        onSelectedChanged: {
                            if (selected){
                                dropdown_winchester.setEnabled(true);
                                dropdown_winchester_daa.setEnabled(true);
                                dropdown_winchester_dab.setEnabled(true);
                                dropdown_winchester_daab.setEnabled(true);
                                dropdown_pb.setEnabled(false);
                                dropdown_pblte_old.setEnabled(false);
                                dropdown_pblte_new.setEnabled(false);
                            }
                        }
                    }
                    Option {
                        id: dropdown_sdkcore
                        text: "SDK Core OS"
                        value: "sdkcore"
                        onSelectedChanged: {
                            if (selected){
                                dropdown_winchester.setEnabled(true);
                                dropdown_winchester_daa.setEnabled(true);
                                dropdown_winchester_dab.setEnabled(true);
                                dropdown_winchester_daab.setEnabled(true);
                                dropdown_pb.setEnabled(false);
                                dropdown_pblte_old.setEnabled(false);
                                dropdown_pblte_new.setEnabled(false);
                            }
                        }
                    }
                    Option {
                        id: dropdown_sdkautoloader
                        text: "SDK Autoloader (BlackBerry Dev)"
                        value: "sdkautoloader"
                        onSelectedChanged: {
                            if (selected){
                                dropdown_winchester.setEnabled(true);
                                dropdown_winchester_daa.setEnabled(true);
                                dropdown_winchester_dab.setEnabled(true);
                                dropdown_winchester_daab.setEnabled(true);
                                dropdown_pb.setEnabled(false);
                                dropdown_pblte_old.setEnabled(false);
                                dropdown_pblte_new.setEnabled(false);
                            }
                        }
                    }
                    onSelectedValueChanged: {
                        _linkgen.setOsLabel(osdropdown.selectedValue);
                        os_download_label.text = _linkgen.getOsLabel();
                    }
                }
                DropDown {
                    id: devicedropdown
                    title: qsTr("Choose Device") + Retranslate.onLanguageChanged
                    Option {
                        id: dropdown_winchester
                        text: "Z10 STL100-1"
                        value: "winchester"
                        enabled: (osdropdown.selectedValue == "debrick" || osdropdown.selectedValue == "core" || osdropdown.selectedValue == "sdkdebrick" || osdropdown.selectedValue == "sdkcore" || osdropdown.selectedValue == "sdkautoloader" ? true : false)
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
                        text: "Q10/Q5/P9983"
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
                    Option {
                        id: dropdown_parana
                        text: "Aquila/Aquarius"
                        value: "8974"
                        enabled: (osdropdown.selectedValue != "sdkautoloader" ? true : false)
                    }
                    Option {
                        id: dropdown_winchester_daa
                        text: "Dev Alpha A"
                        value: "winchester_daa"
                        enabled: (osdropdown.selectedValue == "debrick" || osdropdown.selectedValue == "core" || osdropdown.selectedValue == "sdkdebrick" || osdropdown.selectedValue == "sdkcore" || osdropdown.selectedValue == "sdkautoloader" ? true : false)
                    }
                    Option {
                        id: dropdown_winchester_dab
                        text: "Dev Alpha B"
                        value: "winchester_dab"
                        enabled: (osdropdown.selectedValue == "debrick" || osdropdown.selectedValue == "core" || osdropdown.selectedValue == "sdkdebrick" || osdropdown.selectedValue == "sdkcore" || osdropdown.selectedValue == "sdkautoloader" ? true : false)
                    }
                    Option {
                        id: dropdown_winchester_daab
                        text: "Dev Alpha A/B"
                        value: "winchester_daab"
                        enabled: (osdropdown.selectedValue == "debrick" || osdropdown.selectedValue == "core" || osdropdown.selectedValue == "sdkdebrick" || osdropdown.selectedValue == "sdkcore" || osdropdown.selectedValue == "sdkautoloader" ? true : false)
                    }
                    Option {
                        id: dropdown_devalphac
                        text: "Dev Alpha C"
                        value: "8960wtr_dac"
                    }
                    Option {
                        id: dropdown_pb
                        text: "PlayBook"
                        value: "winchester_pb"
                        enabled: (osdropdown.selectedValue == "debrick" ? true : false)
                    }
                    Option {
                        id: dropdown_pblte_old
                        text: "4G PlayBook (v1)"
                        value: "winchester_pblte_old"
                        enabled: (osdropdown.selectedValue == "debrick" ? true : false)
                    }
                    Option {
                        id: dropdown_pblte_new
                        text: "4G PlayBook (v2)"
                        value: "winchester_pblte_new"
                        enabled: (osdropdown.selectedValue == "debrick" ? true : false)
                    }
                    onSelectedValueChanged: {
                        if (devicedropdown.selectedValue != "sdkautoloader"){
                            _linkgen.setRadioLabel(devicedropdown.selectedValue);
                            radio_download_label.text = _linkgen.getRadioLabel();
                        }
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
                        if (osdropdown.selectedValue == "sdkautoloader") {
                            radioclipboard.visible = false;
                            allclipboard.visible = false;
                            _linkgen.setAutoloader(osversion, devicedropdown.selectedValue);
                            radio_download_label.text = "";
                            radio_download_textarea.text = "";
                        }
                        else {
                            radioclipboard.visible = true;
                            allclipboard.visible = true;
                            global_exportcontainer.visible = true;
                            global_linkcontainer.visible = true;
                            _linkgen.setOS(osversion, hashedswversion, osdropdown.selectedValue, devicedropdown.selectedValue);
                            _linkgen.setRadio(radioversion, hashedswversion, devicedropdown.selectedValue);
                            radio_download_textarea.text = _linkgen.getRadio();
                        }
                        global_clipboardcontainer.visible = true;
                        os_download_textarea.text = _linkgen.getOS();
                    }
                }
                Button {
                    id: clearbutton
                    text: qsTr("Clear") + Retranslate.onLanguageChanged
                    onClicked: {
                        os_download_textarea.text = "";
                        radio_download_textarea.text = "";
                        _linkgen.forceOS("");
                        _linkgen.forceRadio("");
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
                    visible: true
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
                    visible: true
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
                            id: exportbutton
                            text: qsTr("Export Links") + Retranslate.onLanguageChanged
                            onClicked: {
                                _manager.exportLinks(swrelease, hashedswversion, osversion, radioversion);
                                linkexporttoast.body = qsTr("Links saved to default directory") + Retranslate.onLanguageChanged;
                                linkexporttoast.button.enabled = true;
                                myQuery.query.uri = _manager.returnFilename();
                                myQuery.query.data = "";
                                myQuery.query.mimeType = "";
                                linkexporttoast.show();
                            }
                        }
                        Button {
                            id: sharebutton
                            text: qsTr("Share Links") + Retranslate.onLanguageChanged
                            onClicked: {
                                myQuery.query.data = _manager.returnLinks(hashedswversion, osversion, radioversion);
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
                    visible: false
                    Header {
                        title: qsTr("Clipboard") + Retranslate.onLanguageChanged
                    }
                    Container {
                        layout: StackLayout {
                            orientation: LayoutOrientation.LeftToRight
                        }
                        topPadding: 10.0
                        horizontalAlignment: HorizontalAlignment.Center
                        Button {
                            id: osclipboard
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
                            id: radioclipboard
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
                            id: allclipboard
                            text: qsTr("Copy All") + Retranslate.onLanguageChanged
                            onClicked: {
                                if (os_download_textarea.text.indexOf("http") != -1 && radio_download_textarea.text.indexOf("http") != -1) {
                                _manager.copyLinks(hashedswversion, osversion, radioversion)
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
                    visible: false
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
                            id: downloadbutton_os
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
                            id: downloadbutton_radio
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