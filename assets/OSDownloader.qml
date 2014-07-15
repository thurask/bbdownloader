/*OSDownloader.qml
 ------------------
 The meat of the application. Generates and downloads CSE Prod links.
 
 --Thurask*/

import bb.cascades 1.3
import bb.system 1.2

import "js/functions.js" as JScript

Page {
    id:mainpage
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
        id: mainscrollview
        scrollViewProperties.pinchToZoomEnabled: false
        scrollViewProperties.scrollMode: ScrollMode.Vertical
        scrollViewProperties.overScrollEffectMode: OverScrollEffectMode.None
        Container {
            id: global_download_container
            Header {
                title: qsTr("Inputs") + Retranslate.onLanguageChanged
            }                      
            Container {
                topPadding: 10.0
                layout: StackLayout {
                    orientation: LayoutOrientation.LeftToRight
                }
                horizontalAlignment: HorizontalAlignment.Center
                Label {
                    text: qsTr("Deltas") + Retranslate.onLanguageChanged
                    verticalAlignment: VerticalAlignment.Center
                }
                ToggleButton {
                    id: deltasetting
                    onCheckedChanged: {
                        JScript.clearButton();
                        _manager.messagesCleared();
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
            //Inputs
            Container {
                id: input_variable_container
                layout: StackLayout {
                    orientation: LayoutOrientation.TopToBottom 
                }
                Label {
                    id: osver_label
                    text: qsTr("Target OS Version") + Retranslate.onLanguageChanged
                }
                Container {
                    id: osinputcontainer
                    layout: StackLayout {
                        orientation: LayoutOrientation.LeftToRight
                    }
                    horizontalAlignment: HorizontalAlignment.Right
                    verticalAlignment: VerticalAlignment.Top
                    TextField {
                        id: osver_input
                        hintText: osver_label.text
                        inputMode: TextFieldInputMode.NumbersAndPunctuation
                        horizontalAlignment: HorizontalAlignment.Left
                        onTextChanging: {
                            osversion = osver_input.text
                            _swlookup.post(osversion);
                        }
                    }
                    Button {
                        id: lookupbutton
                        text: qsTr("Lookup") + Retranslate.onLanguageChanged
                        onClicked: {
                            swver_input.text = _swlookup.softwareRelease();                                                              
                        }
                        horizontalAlignment: HorizontalAlignment.Left
                        verticalAlignment: VerticalAlignment.Top
                    }
                }
                Container {
                    layout: StackLayout {
                        orientation: LayoutOrientation.LeftToRight
                    }
                    Container {
                        layout: StackLayout {
                            orientation: LayoutOrientation.TopToBottom
                        }
                        Label {
                            id: radiover_label
                            text: qsTr("Target Radio Version") + Retranslate.onLanguageChanged
                        }
                        TextField {
                            id: radiover_input
                            hintText: radiover_label.text
                            inputMode: TextFieldInputMode.NumbersAndPunctuation
                            onTextChanging: {
                                radioversion = radiover_input.text
                            }
                        }
                    }
                    Container {
                        layout: StackLayout {
                            orientation: LayoutOrientation.TopToBottom
                        }
                        Label {
                            id: swver_label
                            text: qsTr("Target SW Version") + Retranslate.onLanguageChanged
                        }
                        TextField {
                            id: swver_input
                            hintText: swver_label.text
                            onTextChanging: {
                                swrelease = swver_input.text
                                hashCalculateSha.calculateHash(swrelease)
                                hashedswversion = hashCalculateSha.getHash()
                            }
                            onTextChanged: {
                                hashCalculateSha.calculateHash(swrelease)
                                hashedswversion = hashCalculateSha.getHash()
                            }
                            inputMode: TextFieldInputMode.NumbersAndPunctuation
                        }
                    }
                }
                Container {
                    id: deltacontainer
                    layout: StackLayout {
                        orientation: LayoutOrientation.LeftToRight
                    }
                    visible: deltasetting.checked ? true : false
                    Container {
                        layout: StackLayout {
                            orientation: LayoutOrientation.TopToBottom
                        }
                        Label {
                            id: osinit_label
                            text: qsTr("Initial OS Version") + Retranslate.onLanguageChanged
                        }
                        TextField {
                            id: osinit_input
                            hintText: osinit_label.text
                            inputMode: TextFieldInputMode.NumbersAndPunctuation
                            onTextChanged: {
                                osinitversion = osinit_input.text
                                var osinit_temp = osinit_input.text;
                                osinit = osinit_temp.replace(/\./g, "");
                                var osinit2_temp = osinit_input.text;
                                osinit2 = osinit_temp.replace(/\./g, "_");
                            }
                        }
                    }
                    Container {
                        layout: StackLayout {
                            orientation: LayoutOrientation.TopToBottom
                        }
                        Label {
                            id: radioinit_label
                            text: qsTr("Initial Radio Version") + Retranslate.onLanguageChanged
                        }
                        TextField {
                            id: radioinit_input
                            hintText: radioinit_label.text
                            inputMode: TextFieldInputMode.NumbersAndPunctuation
                            onTextChanged: {
                                var radinit_temp = radioinit_input.text;
                                radinit = radinit_temp.replace(/\./g, "");
                                var radinit2_temp = radioinit_input.text;
                                radinit2 = radinit_temp.replace(/\./g, "_");
                            }
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
                        enabled: deltasetting.checked ? false : true
                    }
                    Option {
                        id: dropdown_core
                        text: deltasetting.checked ? "Delta OS" : "Core OS"
                        value: "core"
                    }
                    Option {
                        id: dropdown_debrick_verizon
                        text: "Verizon Debrick OS"
                        value: "debrick_vzw"
                        enabled: deltasetting.checked ? false : true
                    }
                    Option {
                        id: dropdown_core_verizon
                        text: deltasetting.checked ? "Verizon Delta OS" : "Verizon Core OS"
                        value: "core_vzw"
                    }
                    Option {
                        id: dropdown_debrick_china
                        text: "China Debrick OS"
                        value: "debrick_china"
                        enabled: deltasetting.checked ? false : true
                    }
                    Option {
                        id: dropdown_core_china
                        text: "China Core OS"
                        value: "core_china"
                        enabled: deltasetting.checked ? false : true
                    }
                    Option {
                        id: dropdown_sdkdebrick
                        text: "SDK Debrick OS"
                        value: "sdkdebrick"
                        enabled: deltasetting.checked ? false : true
                    }
                    Option {
                        id: dropdown_sdkcore
                        text: "SDK Core OS"
                        value: "sdkcore"
                        enabled: deltasetting.checked ? false : true
                    }
                    Option {
                        id: dropdown_sdkautoloader
                        text: "SDK Autoloader (BlackBerry Dev)"
                        value: "sdkautoloader"
                        enabled: deltasetting.checked ? false : true
                    }
                    onSelectedValueChanged: {
                        JScript.setOS();
                    }
                }
                DropDown {
                    id: devicedropdown
                    title: qsTr("Choose Device") + Retranslate.onLanguageChanged
                    Option {
                        id: dropdown_winchester
                        text: "Z10 STL100-1"
                        value: "winchester"
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
                        text: "Q10/Q5/P9983/Classic"
                        value: "8960wtr"
                    }
                    Option {
                        id: dropdown_z30
                        text: "Z30/Manitoba"
                        value: "8960wtr5"
                    }
                    Option {
                        id: dropdown_z30_future
                        text: "Z30/Manitoba (Future)"
                        value: "8960wtr6"
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
                    }
                    Option {
                        id: dropdown_winchester_daa
                        text: "Dev Alpha A"
                        value: "winchester_daa"
                    }
                    Option {
                        id: dropdown_winchester_dab
                        text: "Dev Alpha B"
                        value: "winchester_dab"
                    }
                    Option {
                        id: dropdown_winchester_daab
                        text: "Dev Alpha A/B"
                        value: "winchester_daab"
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
                        enabled: deltasetting.checked ? false : true
                    }
                    Option {
                        id: dropdown_pblte_old
                        text: "4G PlayBook (v1)"
                        value: "winchester_pblte_old"
                        enabled: deltasetting.checked ? false : true
                    }
                    Option {
                        id: dropdown_pblte_new
                        text: "4G PlayBook (v2)"
                        value: "winchester_pblte_new"
                        enabled: deltasetting.checked ? false : true
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
                        osclipboard.visible = true;
                        //Call Darcy
                        JScript.setEasterEgg(hashedswversion);
                        if (deltasetting.checked == false){
                            JScript.generateLinks();
                        }
                        if (deltasetting.checked == true){
                            JScript.generateDeltas();
                        }
                    }
                }
                Button {
                    id: clearbutton
                    text: qsTr("Clear") + Retranslate.onLanguageChanged
                    onClicked: {
                        JScript.clearButton();
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
                    multiline: true
                }
                TextArea {
                    id: radio_download_textarea
                    text: ""
                    editable: false
                    visible: true
                    content.flags: TextContentFlag.ActiveText
                }
                Container {
                    id: global_clipboardcontainer
                    layout: StackLayout {
                        orientation: LayoutOrientation.LeftToRight
                    }
                    horizontalAlignment: HorizontalAlignment.Center
                    topPadding: 20.0
                    Button {
                        id: osclipboard
                        text: qsTr("Copy OS") + Retranslate.onLanguageChanged
                        visible: false
                        onClicked: {
                            if (os_download_textarea.text.indexOf("http") != -1) {
                                Clipboard.copyToClipboard(os_download_textarea.text);
                                linkexporttoast.body = qsTr("OS URL copied") + Retranslate.onLanguageChanged;
                                linkexporttoast.button.enabled = false;
                                linkexporttoast.button.label = "";
                                linkexporttoast.show();
                            }
                        }
                    }
                    Button {
                        id: radioclipboard
                        text: qsTr("Copy Radio") + Retranslate.onLanguageChanged
                        visible: false
                        onClicked: {
                            if (radio_download_textarea.text.indexOf("http") != -1){
                                Clipboard.copyToClipboard(radio_download_textarea.text);
                                linkexporttoast.body = qsTr("Radio URL copied") + Retranslate.onLanguageChanged;
                                linkexporttoast.button.enabled = false;
                                linkexporttoast.button.label = "";
                                linkexporttoast.show();
                            }
                        }
                    }
                }
                Container {
                    topPadding: 10.0
                    visible: false
                    id: global_linkcontainer
                    layout: StackLayout {
                        orientation: LayoutOrientation.TopToBottom
                    }
                    horizontalAlignment: HorizontalAlignment.Center
                    //Clipboard buttons
                    Container {
                        layout: StackLayout {
                            orientation: LayoutOrientation.LeftToRight
                        }
                        horizontalAlignment: HorizontalAlignment.Center
                        Button {
                            id: downloadbutton_os
                            text: qsTr("Download OS") + Retranslate.onLanguageChanged
                            onClicked: {
                                global_urlcontainer.visible = true;
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
                                global_urlcontainer.visible = true;
                                var raddl = radio_download_textarea.text;
                                if (raddl.indexOf("http") != -1){
                                    _manager.downloadUrl(radio_download_textarea.text);
                                }
                            }
                        }
                        Button {
                            id: downloadbutton_export
                            text: qsTr("Export Links") + Retranslate.onLanguageChanged
                            onClicked: {
                                if (deltasetting.checked == false){
                                    _manager.exportLinks(swrelease, hashedswversion, osversion, radioversion);
                                }
                                if (deltasetting.checked == true){
                                    _manager.exportDeltaLinks(hashedswversion, osversion, radioversion, osinitversion, osinit, osinit2, radinit, radinit2);
                                }
                                linkexporttoast.body = qsTr("Links saved to /downloads/bbdownloader") + Retranslate.onLanguageChanged;
                                linkexporttoast.button.enabled = false;
                                linkexporttoast.button.label = "";
                                linkexporttoast.show();
                            }
                        }
                    }
                    Container{
                        id: global_urlcontainer
                        visible: false
                        Container {
                            Header {
                                title: qsTr("Progress") + Retranslate.onLanguageChanged
                            }
                            Label {
                                id: activedl_label
                                text: qsTr("Active Downloads: ") + Retranslate.onLanguageChanged + (_manager.activeDownloads == 0 ? qsTr("none") + Retranslate.onLanguageChanged : _manager.activeDownloads)
                            }
                            ProgressBar {
                                topMargin: 10
                                leftMargin: 10
                                rightMargin: 10
                                total: _manager.progressTotal
                                value: _manager.progressValue
                                message: _manager.progressMessage
                            }
                        }
                        Button {
                            id: stopbutton
                            text: qsTr("Stop Download") + Retranslate.onLanguageChanged
                            horizontalAlignment: HorizontalAlignment.Center
                            onClicked: {
                                var activedl = activedl_label.text;
                                if (activedl.indexOf("1") != -1) {
                                    _manager.downloadCancelled();
                                }
                            }
                        }
                        Header {
                            title: qsTr("Status") + Retranslate.onLanguageChanged
                        }
                        TextArea {
                            id: status_textarea
                            preferredWidth: 900
                            preferredHeight: 145
                            editable: false
                            text: _manager.statusMessage
                        }
                        Header {
                            title: qsTr("Errors") + Retranslate.onLanguageChanged
                        }
                        TextArea {
                            id: error_textarea
                            preferredWidth: 900
                            preferredHeight: 125
                            editable: false
                            text: _manager.errorMessage
                        }
                        Divider {
                        }
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
            button.label: "";
        }
    ]
}