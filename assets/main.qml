/*
 * Copyright (c) 2011-2014 BlackBerry Limited.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import bb.cascades 1.2

TabbedPane {
    property string hashedswversion
    property string swrelease
    property string osversion
    property string osinitversion
    property string osinit
    property string osinit2
    property string radinit
    property string radinit2
    attachedObjects: [
        ComponentDefinition {
            id: helpSheetDefinition
            HelpSheet {
            }
        },
        ComponentDefinition {
            id: settingsSheetDefinition
            SettingsSheet {
            }
        }
    ]
    Menu.definition: MenuDefinition {
        helpAction: HelpActionItem {
            onTriggered: {
                var help = helpSheetDefinition.createObject()
                help.open();
            }
        }
        settingsAction: SettingsActionItem {
            onTriggered: {
                var settings = settingsSheetDefinition.createObject()
                settings.open();
            }
        }
    }
    Tab {
        title: "OS Downloader"
        Page {
            titleBar: TitleBar {
                title: qsTr("BB10 OS Downloader %1").arg(AppInfo.version)
            }
            ScrollView {
                id: mainscrollview
                scrollViewProperties.pinchToZoomEnabled: false
                scrollViewProperties.scrollMode: ScrollMode.Vertical
                
                Container {
                    id: global_download_container
                    Header {
                        title: "Inputs"
                    }
                    Container {
                        topPadding: 10.0
                        layout: StackLayout {
                            orientation: LayoutOrientation.LeftToRight
                        }
                        horizontalAlignment: HorizontalAlignment.Center
                        Label {
                            text: "Delta Mode"
                            verticalAlignment: VerticalAlignment.Center
                        }
                        ToggleButton {
                            id: deltasetting
                            onCheckedChanged: {
                                os_download_textarea.text = "";
                                radio_download_textarea.text = "";
                                global_linkcontainer.visible = false;
                                osdropdown.resetSelectedOption();
                                devicedropdown.resetSelectedOption();
                                os_download_label.text = "OS Link:";
                                radio_download_label.text = "Radio Link:";
                                _manager.messagesCleared();
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
                            text: "Target OS Version"
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
                                hintText: "Target OS version"
                                inputMode: TextFieldInputMode.NumbersAndPunctuation
                                horizontalAlignment: HorizontalAlignment.Left
                                onTextChanging: {
                                    osversion = osver_input.text
                                    _swlookup.post(osver_input.text);
                                }
                            }
                            Button {
                                id: lookupbutton
                                text: "Lookup"
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
                                    text: "Target Radio Version"
                                }
                                TextField {
                                    id: radiover_input
                                    hintText: "Target radio version"
                                    inputMode: TextFieldInputMode.NumbersAndPunctuation
                                }
                            }
                            Container {
                                layout: StackLayout {
                                    orientation: LayoutOrientation.TopToBottom
                                }
                                Label {
                                    id: swver_label
                                    text: "Target SW Version"
                                }
                                TextField {
                                    id: swver_input
                                    hintText: "Target SW version"
                                    onTextChanging: {
                                        hashCalculateSha.calculateHash(swver_input.text)
                                        hashedswversion = hashCalculateSha.getHash()
                                    }
                                    onTextChanged: {
                                        hashCalculateSha.calculateHash(swver_input.text)
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
                                    text: "Initial OS Version"
                                }
                                TextField {
                                    id: osinit_input
                                    hintText: "Initial OS version"
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
                                    text: "Initial Radio Version"
                                }
                                TextField {
                                    id: radioinit_input
                                    hintText: "Initial radio version"
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
                            title: "Choose OS Type"
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
                                if (devicedropdown.selectedIndex == -1){
                                    radio_download_label.text = "Radio Link:";
                                }
                                if (osdropdown.selectedIndex == -1){
                                    os_download_label.text = "OS Link:";
                                }
                                if (deltasetting.checked == true){
                                    if (osdropdown.selectedValue == "core"){
                                        dropdown_winchester.enabled = true;
                                        os_download_label.text = "Delta from " + osinit_input.text + " to " + osver_input.text + ":";
                                    }
                                    if (osdropdown.selectedValue == "core_vzw"){
                                        os_download_label.text = "Verizon delta from " + osinit_input.text + " to " + osver_input.text + ":";
                                        dropdown_winchester.enabled = false;
                                    }
                                    dropdown_pb.enabled = false;
                                    dropdown_pblte_old.enabled = false;
                                    dropdown_pblte_new.enabled = false;
                                }
                                if (deltasetting.checked == false){
                                    if (osdropdown.selectedValue == "debrick") {
                                        os_download_label.text = "Debrick OS:";
                                        dropdown_winchester.enabled = true;
                                        dropdown_pb.enabled = true;
                                        dropdown_pblte_old.enabled = true;
                                        dropdown_pblte_new.enabled = true;
                                    }
                                    if (osdropdown.selectedValue == "core") {
                                        os_download_label.text = "Core OS:";
                                        dropdown_winchester.enabled = true;
                                        dropdown_pb.enabled = false;
                                        dropdown_pblte_old.enabled = false;
                                        dropdown_pblte_new.enabled = false;
                                    }
                                    if (osdropdown.selectedValue == "debrick_vzw") {
                                        os_download_label.text = "Verizon Debrick OS:";
                                        dropdown_winchester.enabled = false;
                                        dropdown_pb.enabled = false;
                                        dropdown_pblte_old.enabled = false;
                                        dropdown_pblte_new.enabled = false;
                                    }
                                    if (osdropdown.selectedValue == "core_vzw") {
                                        os_download_label.text = "Verizon Core OS:";
                                        dropdown_winchester.enabled = false;
                                        dropdown_pb.enabled = false;
                                        dropdown_pblte_old.enabled = false;
                                        dropdown_pblte_new.enabled = false;
                                    }
                                    if (osdropdown.selectedValue == "debrick_china") {
                                        os_download_label.text = "China Debrick OS:";
                                        dropdown_winchester.enabled = false;
                                        dropdown_pb.enabled = false;
                                        dropdown_pblte_old.enabled = false;
                                        dropdown_pblte_new.enabled = false;
                                    }
                                    if (osdropdown.selectedValue == "core_china") {
                                        os_download_label.text = "China Core OS:";
                                        dropdown_winchester.enabled = false;
                                        dropdown_pb.enabled = false;
                                        dropdown_pblte_old.enabled = false;
                                        dropdown_pblte_new.enabled = false;
                                    }
                                    if (osdropdown.selectedValue == "sdkdebrick") {
                                        os_download_label.text = "SDK Debrick OS:";
                                        dropdown_winchester.enabled = true;
                                        dropdown_pb.enabled = false;
                                        dropdown_pblte_old.enabled = false;
                                        dropdown_pblte_new.enabled = false;
                                    }
                                    if (osdropdown.selectedValue == "sdkcore") {
                                        os_download_label.text = "SDK Core OS:";
                                        dropdown_winchester.enabled = true;
                                        dropdown_pb.enabled = false;
                                        dropdown_pblte_old.enabled = false;
                                        dropdown_pblte_new.enabled = false;
                                    }
                                    if (osdropdown.selectedValue == "sdkautoloader") {
                                        os_download_label.text = "Autoloader:";
                                        radio_download_label.text = "SDK downloads wonky. \nWorkaround: tap link to download in Browser.";
                                        dropdown_parana.enabled = false;
                                        dropdown_pb.enabled = false;
                                        dropdown_pblte_old.enabled = false;
                                        dropdown_pblte_new.enabled = false;
                                    }
                                    if (osdropdown.selectedValue != "sdkautoloader"){
                                        dropdown_parana.enabled = true;
                                        if (devicedropdown.selectedValue == "winchester") {
                                            radio_download_label.text = "OMAP Z10 Radio:";
                                        }
                                        if (devicedropdown.selectedValue == "8960") {
                                            radio_download_label.text = "Qualcomm Z10/P9982 Radio:";
                                        }
                                        if (devicedropdown.selectedValue == "8960omadm") {
                                            radio_download_label.text = "Verizon Z10 Radio:";
                                        }
                                        if (devicedropdown.selectedValue == "8960wtr") {
                                            radio_download_label.text = "Q10/Q5/P9983/Classic Radio:";
                                        }
                                        if (devicedropdown.selectedValue == "8960wtr5") {
                                            radio_download_label.text = "Z30/Manitoba Radio:";
                                        }
                                        if (devicedropdown.selectedValue == "8960wtr6") {
                                            radio_download_label.text = "Z30/Manitoba (Future) Radio:";
                                        }
                                        if (devicedropdown.selectedValue == "8930wtr5") {
                                            radio_download_label.text = "Z3/Kopi/Cafe Radio:";
                                        }
                                        if (devicedropdown.selectedValue == "winchester_pblte_old"){
                                            radio_download_label.text = "4G PlayBook Radio (mod-qcmdm): ";
                                        }
                                        if (devicedropdown.selectedValue == "winchester_pblte_new"){
                                            radio_download_label.text = "4G PlayBook Radio (mod.qcmdm): ";
                                        }
                                        if (devicedropdown.selectedValue == "winchester_pb"){
                                            radio_download_label.text = "";
                                        }
                                        if (devicedropdown.selectedValue == "8974"){
                                            radio_download_label.text = "Aquila/Aquarius Radio:";
                                        }
                                        if (devicedropdown.selectedValue == "8974_sqw"){
                                            radio_download_label.text = "Passport Radio:";
                                        }
                                    }
                                }
                            }
                        }
                        DropDown {
                            id: devicedropdown
                            title: "Choose Device"
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
                                if (devicedropdown.selectedIndex == -1){
                                    radio_download_label.text = "Radio Link:";
                                }
                                if (osdropdown.selectedIndex == -1){
                                    os_download_label.text = "OS Link:";
                                }
                                if (osdropdown.selectedValue != "sdkautoloader"){
                                    if (devicedropdown.selectedValue == "winchester") {
                                        radio_download_label.text = "OMAP Z10 Radio:";
                                    }
                                    if (devicedropdown.selectedValue == "8960") {
                                        radio_download_label.text = "Qualcomm Z10/P9982 Radio:";
                                    }
                                    if (devicedropdown.selectedValue == "8960omadm") {
                                        radio_download_label.text = "Verizon Z10 Radio:";
                                    }
                                    if (devicedropdown.selectedValue == "8960wtr") {
                                        radio_download_label.text = "Q10/Q5/P9983/Classic Radio:";
                                    }
                                    if (devicedropdown.selectedValue == "8960wtr5") {
                                        radio_download_label.text = "Z30/Manitoba Radio:";
                                    }
                                    if (devicedropdown.selectedValue == "8960wtr6") {
                                        radio_download_label.text = "Z30/Manitoba (Future) Radio:";
                                    }
                                    if (devicedropdown.selectedValue == "8930wtr5") {
                                        radio_download_label.text = "Z3/Kopi/Cafe Radio:";
                                    }
                                    if (devicedropdown.selectedValue == "winchester_pblte_old"){
                                        radio_download_label.text = "4G PlayBook Radio (mod-qcmdm): ";
                                    }
                                    if (devicedropdown.selectedValue == "winchester_pblte_new"){
                                        radio_download_label.text = "4G PlayBook Radio (mod.qcmdm): ";
                                    }
                                    if (devicedropdown.selectedValue == "winchester_pb"){
                                        radio_download_label.text = "";
                                    }
                                    if (devicedropdown.selectedValue == "8974"){
                                        radio_download_label.text = "Aquila/Aquarius Radio:";
                                    }
                                    if (devicedropdown.selectedValue == "8974_sqw"){
                                        radio_download_label.text = "Passport Radio:";
                                    }
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
                            text: "Generate"
                            horizontalAlignment: HorizontalAlignment.Center
                            onClicked: {
                                //Call Darcy
                                if (hashedswversion == "da5ebb46fd2330dd29ab9d27245803fca2fd7c54"){
                                    os_download_label.text = "You're winner!";
                                    os_download_textarea.text = "";
                                    radio_download_label.text = "Have a beer, you've earned it.";
                                    radio_download_textarea.text = "";
                                }
                                if (deltasetting.checked == false){
                                    // First, hide the visibility of the link downloader if one wants an autoloader (probably BlackBerry's problem)
                                    if (osdropdown.selectedValue == "sdkautoloader"){
                                        global_linkcontainer.visible = false;
                                    }
                                    if (osdropdown.selectedValue != "sdkautoloader"){
                                        global_linkcontainer.visible = true;
                                    }
                                    // Then set the OS values for Qualcomm 8960+derivatives
                                    if (devicedropdown.selectedValue == "8930wtr5" || devicedropdown.selectedValue == "8960wtr5" || devicedropdown.selectedValue == "8960wtr6" || devicedropdown.selectedValue == "8960wtr" || devicedropdown.selectedValue == "8960omadm" || devicedropdown.selectedValue == "8960"){
                                        if (osdropdown.selectedValue == "debrick") {
                                            os_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8960.factory_sfi.desktop/" + osversion + "/qc8960.factory_sfi.desktop-" + osversion + "-nto+armle-v7+signed.bar";
                                        }
                                        if (osdropdown.selectedValue == "core") {
                                            os_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8960.factory_sfi/" + osversion + "/qc8960.factory_sfi-" + osversion + "-nto+armle-v7+signed.bar";
                                        }
                                        if (osdropdown.selectedValue == "debrick_vzw"){
                                            os_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8960.verizon_sfi.desktop/" + osversion + "/qc8960.verizon_sfi.desktop-" + osversion + "-nto+armle-v7+signed.bar";
                                        }
                                        if (osdropdown.selectedValue == "core_vzw"){
                                            os_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8960.verizon_sfi/" + osversion + "/qc8960.verizon_sfi-" + osversion + "-nto+armle-v7+signed.bar";
                                        }
                                        if (osdropdown.selectedValue == "debrick_china"){
                                            os_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8960.china_sfi.desktop/" + osversion + "/qc8960.china_sfi.desktop-" + osversion + "-nto+armle-v7+signed.bar";
                                        }
                                        if (osdropdown.selectedValue == "core_china"){
                                            os_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8960.china_sfi/" + osversion + "/qc8960.china_sfi-" + osversion + "-nto+armle-v7+signed.bar";
                                        }
                                        if (osdropdown.selectedValue == "sdkdebrick") {
                                            os_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8960.sdk.desktop/" + osversion + "/qc8960.sdk.desktop-" + osversion + "-nto+armle-v7+signed.bar";
                                        }
                                        if (osdropdown.selectedValue == "sdkcore") {
                                            os_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8960.sdk/" + osversion + "/qc8960.sdk-" + osversion + "-nto+armle-v7+signed.bar";
                                        }
                                    }
                                    // Then QC8974
                                    if (devicedropdown.selectedValue == "8974" || devicedropdown.selectedValue == "8974_sqw"){
                                        if (osdropdown.selectedValue == "debrick") {
                                            os_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8974.factory_sfi.desktop/" + osversion + "/qc8974.factory_sfi.desktop-" + osversion + "-nto+armle-v7+signed.bar";
                                        }
                                        if (osdropdown.selectedValue == "core") {
                                            os_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8974.factory_sfi/" + osversion + "/qc8974.factory_sfi-" + osversion + "-nto+armle-v7+signed.bar";
                                        }
                                        if (osdropdown.selectedValue == "debrick_vzw"){
                                            os_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8974.verizon_sfi.desktop/" + osversion + "/qc8974.verizon_sfi.desktop-" + osversion + "-nto+armle-v7+signed.bar";
                                        }
                                        if (osdropdown.selectedValue == "core_vzw"){
                                            os_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8974.verizon_sfi/" + osversion + "/qc8974.verizon_sfi-" + osversion + "-nto+armle-v7+signed.bar";
                                        }
                                        if (osdropdown.selectedValue == "debrick_china"){
                                            os_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8974.china_sfi.desktop/" + osversion + "/qc8974.china_sfi.desktop-" + osversion + "-nto+armle-v7+signed.bar";
                                        }
                                        if (osdropdown.selectedValue == "core_china"){
                                            os_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8974.china_sfi/" + osversion + "/qc8974.china_sfi-" + osversion + "-nto+armle-v7+signed.bar";
                                        }
                                        if (osdropdown.selectedValue == "sdkdebrick") {
                                            os_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8974.sdk.desktop/" + osversion + "/qc8974.sdk.desktop-" + osversion + "-nto+armle-v7+signed.bar";
                                        }
                                        if (osdropdown.selectedValue == "sdkcore") {
                                            os_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8974.sdk/" + osversion + "/qc8974.sdk-" + osversion + "-nto+armle-v7+signed.bar";
                                        }
                                    }
                                    // Then the PlayBooks
                                    if (devicedropdown.selectedValue == "winchester_pb" || devicedropdown.selectedValue == "winchester_pblte_old" || devicedropdown.selectedValue == "winchester_pblte_new" ){
                                        if (osdropdown.selectedValue == "debrick"){
                                            os_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.factory.desktop/" + osversion + "/winchester.factory_sfi.desktop-" + osversion + "-nto+armle-v7+signed.bar";
                                        }
                                        if (osdropdown.selectedValue != "debrick"){
                                            os_download_textarea.text = "Please set OS Type to Debrick OS";
                                        }
                                    }
                                    // Now the radios
                                    if (devicedropdown.selectedValue == "winchester_pb"){
                                        radio_download_textarea.text = "";
                                    }
                                    if (devicedropdown.selectedValue == "winchester_pblte_old"){
                                        radio_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/mod-qcmdm9k-" + radiover_input.text + "-nto+armle-v7+signed.bar";
                                    }
                                    if (devicedropdown.selectedValue == "winchester_pblte_new"){
                                        radio_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/mod.qcmdm9k-" + radiover_input.text + "-nto+armle-v7+signed.bar";
                                    }
                                    if (devicedropdown.selectedValue == "8930wtr5") {
                                        if (osdropdown.selectedValue != "sdkautoloader"){
                                            radio_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.qcfm.radio.qc8930.wtr5/" + radiover_input.text + "/qc8930.wtr5-" + radiover_input.text + "-nto+armle-v7+signed.bar";
                                        }
                                        if (osdropdown.selectedValue == "sdkautoloader") {
                                            radio_download_textarea.text = "";
                                            os_download_textarea.text = "http://developer.blackberry.com/native/downloads/fetch/Autoload-STJ100-1-" + osversion +".exe";
                                        }
                                    }
                                    if (devicedropdown.selectedValue == "8960wtr5"){
                                        if (osdropdown.selectedValue != "sdkautoloader"){
                                            radio_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.qcfm.radio.qc8960.wtr5/" + radiover_input.text + "/qc8960.wtr5-" + radiover_input.text + "-nto+armle-v7+signed.bar";
                                        }
                                        if (osdropdown.selectedValue == "sdkautoloader") {
                                            radio_download_textarea.text = "";
                                            os_download_textarea.text = "http://developer.blackberry.com/native/downloads/fetch/Autoload-STA100-5-" + osversion +".exe";
                                        }
                                    }
                                    if (devicedropdown.selectedValue == "8960wtr6"){
                                        if (osdropdown.selectedValue != "sdkautoloader"){
                                            radio_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.qcfm.radio.qc8960.wtr6/" + radiover_input.text + "/qc8960.wtr6-" + radiover_input.text + "-nto+armle-v7+signed.bar";
                                        }
                                        if (osdropdown.selectedValue == "sdkautoloader") {
                                            radio_download_textarea.text = "";
                                            os_download_textarea.text = "http://developer.blackberry.com/native/downloads/fetch/Autoload-STA100-5-" + osversion +".exe";
                                        }
                                    }
                                    if (devicedropdown.selectedValue == "8960wtr"){
                                        if (osdropdown.selectedValue != "sdkautoloader"){
                                            radio_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.qcfm.radio.qc8960.wtr/" + radiover_input.text + "/qc8960.wtr-" + radiover_input.text + "-nto+armle-v7+signed.bar";
                                        }
                                        if (osdropdown.selectedValue == "sdkautoloader") {
                                            radio_download_textarea.text = "";
                                            os_download_textarea.text = "http://developer.blackberry.com/native/downloads/fetch/Autoload-SQN100-5-" + osversion +".exe";
                                        }
                                    }
                                    if (devicedropdown.selectedValue == "8960omadm"){
                                        if (osdropdown.selectedValue != "sdkautoloader"){
                                            radio_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.qcfm.radio.qc8960.omadm/" + radiover_input.text + "/qc8960.omadm-" + radiover_input.text + "-nto+armle-v7+signed.bar";
                                        }
                                        if (osdropdown.selectedValue == "sdkautoloader") {
                                            radio_download_textarea.text = "";
                                            os_download_textarea.text = "http://developer.blackberry.com/native/downloads/fetch/Autoload-STL100-4-" + osversion +".exe";
                                        }
                                    }
                                    if (devicedropdown.selectedValue == "8960"){
                                        if (osdropdown.selectedValue != "sdkautoloader"){
                                            radio_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.qcfm.radio.qc8960/" + radiover_input.text + "/qc8960-" + radiover_input.text + "-nto+armle-v7+signed.bar";
                                        }
                                        if (osdropdown.selectedValue == "sdkautoloader") {
                                            radio_download_textarea.text = "";
                                            os_download_textarea.text = "http://developer.blackberry.com/native/downloads/fetch/Autoload-STL100-3-" + osversion +".exe";
                                        }
                                    }
                                    // And lastly the STL100-1
                                    if (devicedropdown.selectedValue == "winchester"){
                                        if (osdropdown.selectedValue != "sdkautoloader"){
                                            radio_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.qcfm.radio.m5730/" + radiover_input.text + "/m5730-" + radiover_input.text + "-nto+armle-v7+signed.bar";
                                        }
                                        if (osdropdown.selectedValue == "debrick") {
                                            os_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.factory.desktop/" + osversion + "/winchester.factory_sfi.desktop-" + osversion + "-nto+armle-v7+signed.bar";
                                        }
                                        if (osdropdown.selectedValue == "core") {
                                            os_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.factory/" + osversion + "/winchester.factory_sfi-" + osversion + "-nto+armle-v7+signed.bar";
                                        }
                                        if (osdropdown.selectedValue == "sdkdebrick") {
                                            os_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.winchester.sdk.desktop/" + osversion + "/winchester.sdk.desktop-" + osversion + "-nto+armle-v7+signed.bar";
                                        }
                                        if (osdropdown.selectedValue == "sdkcore") {
                                            os_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.winchester.sdk/" + osversion + "/winchester.sdk-" + osversion + "-nto+armle-v7+signed.bar";
                                        }
                                        if (osdropdown.selectedValue == "debrick_vzw" || osdropdown.selectedValue == "debrick_china" || osdropdown.selectedValue == "core_vzw" || osdropdown.selectedValue == "core_china") {
                                            os_download_textarea.text = "Please set OS Type to Debrick/Core OS/SDK OS";
                                        }
                                        if (osdropdown.selectedValue == "sdkautoloader") {
                                            radio_download_textarea.text = "";
                                            os_download_textarea.text = "http://developer.blackberry.com/native/downloads/fetch/Autoload-STL100-1-" + osversion +".exe";
                                        }
                                    }
                                    // Miscellany
                                    if (devicedropdown.selectedValue == "8974"){
                                        if (osdropdown.selectedValue != "sdkautoloader"){
                                            radio_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.qcfm.radio.qc8974/" + radiover_input.text + "/qc8974-" + radiover_input.text + "-nto+armle-v7+signed.bar";
                                        }
                                        if (osdropdown.selectedValue == "sdkautoloader") {
                                            radio_download_textarea.text = "";
                                            os_download_textarea.text = "If nobody can find a regular OS for this hardware, what makes you think there's a SDK OS?";
                                        }
                                    }
                                    if (devicedropdown.selectedValue == "8974_sqw"){
                                        if (osdropdown.selectedValue != "sdkautoloader"){
                                            radio_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.qcfm.radio.qc8974.wtr?/" + radiover_input.text + "/qc8974.wtr?-" + radiover_input.text + "-nto+armle-v7+signed.bar";
                                        }
                                        if (osdropdown.selectedValue == "sdkautoloader") {
                                            radio_download_textarea.text = "";
                                            os_download_textarea.text = os_download_textarea.text = "http://developer.blackberry.com/native/downloads/fetch/Autoload-SQW100-1-" + osversion +".exe";
                                        }
                                    }
                                }
                                if (deltasetting.checked == true){
                                    //PB doesn't have deltas (I think)
                                    if (devicedropdown.selectedValue == "winchester_pb" || devicedropdown.selectedValue == "winchester_pblte_old" || devicedropdown.selectedValue == "winchester_pblte_new" ){
                                        os_download_textarea.text = "Please pick a BB10 device.";
                                    }
                                    //STL100-1
                                    if (devicedropdown.selectedValue == "winchester"){
                                        global_linkcontainer.visible = true;
                                        if (osdropdown.selectedValue != "core"){
                                            os_download_textarea.text = "Please set OS Type to Delta OS";
                                        }
                                        if (osdropdown.selectedValue == "core"){
                                            os_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.factory.d" + osinit + "/" + osversion + "/winchester.factory_sfi-" + osversion + "-nto+armle-v7+signed+patch+"+ osinit2 + ".bar";
                                            radio_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.qcfm.radio.m5730.d" + radinit + "/" + radiover_input.text + "/m5730-" + radiover_input.text + "-nto+armle-v7+signed+patch+"+ radinit2 + ".bar";
                                        }
                                    }
                                    //QC8960
                                    if (devicedropdown.selectedValue == devicedropdown.selectedValue == "8930wtr5" || devicedropdown.selectedValue == "8960wtr5" || devicedropdown.selectedValue == "8960wtr6" || devicedropdown.selectedValue == "8960wtr" || devicedropdown.selectedValue == "8960omadm" || devicedropdown.selectedValue == "8960"){
                                        global_linkcontainer.visible = true;
                                        if (osdropdown.selectedValue != "core" || osdropdown.selectedValue != "core_vzw"){
                                            os_download_textarea.text = "Please set OS Type to Delta OS/Verizon Delta OS";
                                        }
                                        if (osdropdown.selectedValue == "core"){
                                            os_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8960.factory.d" + osinit + "/" + osversion + "/qc8960.factory_sfi-" + osversion + "-nto+armle-v7+signed+patch+"+ osinit2 + ".bar";
                                        }
                                        if (osdropdown.selectedValue == "core_vzw"){
                                            os_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8960.verizon.d" + osinit + "/" + osversion + "/qc8960.verizon_sfi-" + osversion + "-nto+armle-v7+signed+patch+"+ osinit2 + ".bar";
                                        }
                                        if (devicedropdown.selectedValue == "8930wtr5"){
                                            radio_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.qcfm.radio.qc8930.wtr5.d" + radinit + "/" + radiover_input.text + "/qc8930.wtr5-" + radiover_input.text + "-nto+armle-v7+signed+patch+"+ radinit2 + ".bar";
                                        }
                                        if (devicedropdown.selectedValue == "8960wtr6"){
                                            radio_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.qcfm.radio.qc8960.wtr6.d" + radinit + "/" + radiover_input.text + "/qc8960.wtr6-" + radiover_input.text + "-nto+armle-v7+signed+patch+"+ radinit2 + ".bar";
                                        }
                                        if (devicedropdown.selectedValue == "8960wtr5"){
                                            radio_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.qcfm.radio.qc8960.wtr5.d" + radinit + "/" + radiover_input.text + "/qc8960.wtr5-" + radiover_input.text + "-nto+armle-v7+signed+patch+"+ radinit2 + ".bar";
                                        }
                                        if (devicedropdown.selectedValue == "8960wtr"){
                                            radio_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.qcfm.radio.qc8960.wtr.d" + radinit + "/" + radiover_input.text + "/qc8960.wtr-" + radiover_input.text + "-nto+armle-v7+signed+patch+"+ radinit2 + ".bar";
                                        }
                                        if (devicedropdown.selectedValue == "8960omadm"){
                                            radio_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.qcfm.radio.qc8960.omadm.d" + radinit + "/" + radiover_input.text + "/qc8960.omadm-" + radiover_input.text + "-nto+armle-v7+signed+patch+"+ radinit2 + ".bar";
                                        }
                                        if (devicedropdown.selectedValue == "8960"){
                                            radio_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.qcfm.radio.qc8960.d" + radinit + "/" + radiover_input.text + "/qc8960-" + radiover_input.text + "-nto+armle-v7+signed+patch+"+ radinit2 + ".bar";
                                        }
                                    }
                                    //QC8974
                                    if (devicedropdown.selectedValue == "8974" || devicedropdown.selectedValue == "8974_sqw"){
                                        global_linkcontainer.visible = true;
                                        if (osdropdown.selectedValue != "core" || osdropdown.selectedValue != "core_vzw"){
                                            os_download_textarea.text = "Please set OS Type to Delta OS/Verizon Delta OS";
                                        }
                                        if (osdropdown.selectedValue == "core"){
                                            os_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8974.factory.d" + osinit + "/" + osversion + "/qc8974.factory_sfi-" + osversion + "-nto+armle-v7+signed+patch+"+ osinit2 + ".bar";
                                        }
                                        if (osdropdown.selectedValue == "core_vzw"){
                                            os_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8974.verizon.d" + osinit + "/" + osversion + "/qc8974.verizon_sfi-" + osversion + "-nto+armle-v7+signed+patch+"+ osinit2 + ".bar";
                                        }
                                        if (devicedropdown.selectedValue == "8974"){
                                            radio_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.qcfm.radio.qc8974.d" + radinit + "/" + radiover_input.text + "/qc8974-" + radiover_input.text + "-nto+armle-v7+signed+patch+"+ radinit2 + ".bar";
                                        }
                                        if (devicedropdown.selectedValue == "8974_sqw"){
                                            radio_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.qcfm.radio.qc8974.wtr?.d" + radinit + "/" + radiover_input.text + "/qc8974.wtr?-" + radiover_input.text + "-nto+armle-v7+signed+patch+"+ radinit2 + ".bar";
                                        }
                                    }
                                }
                            }
                        }
                        Button {
                            id: clearbutton
                            text: "Clear"
                            onClicked: {
                                os_download_textarea.text = "";
                                radio_download_textarea.text = "";
                                global_linkcontainer.visible = false;
                                osdropdown.resetSelectedOption();
                                devicedropdown.resetSelectedOption();
                                os_download_label.text = "OS Link:";
                                radio_download_label.text = "Radio Link:";
                                _manager.messagesCleared();
                            }
                        }
                    }
                    //Links
                    Container {
                        horizontalAlignment: HorizontalAlignment.Center
                        topPadding: 10.0
                        Header {
                            title: "Links"
                        }
                        Label {
                            id: os_download_label
                            text: "OS Link:"
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
                            text: "Radio Link:"
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
                            visible:false
                            id: global_linkcontainer
                            horizontalAlignment: HorizontalAlignment.Center
                            Container {
                                layout: StackLayout {
                                    orientation: LayoutOrientation.LeftToRight
                                }
                                horizontalAlignment: HorizontalAlignment.Center
                                Button {
                                    id: downloadbutton_os
                                    text: "Download OS"
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
                                    text: "Download Radio"
                                    onClicked: {
                                        global_urlcontainer.visible = true;
                                        var raddl =radio_download_textarea.text;
                                        if (raddl.indexOf("http") != -1){
                                            _manager.downloadUrl(radio_download_textarea.text);
                                        }
                                    }
                                }
                            }
                            Container{
                                id: global_urlcontainer
                                visible: false
                                Container {
                                    Header {
                                        title: "Progress"
                                    }
                                    Label {
                                        id: activedl_label
                                        text: "Active Downloads: " + (_manager.activeDownloads == 0 ? "none" : _manager.activeDownloads)
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
                                    text: "Stop Download"
                                    horizontalAlignment: HorizontalAlignment.Center
                                    onClicked: {
                                        var activedl = activedl_label.text;
                                        if (activedl.indexOf("1") != -1) {
                                            _manager.downloadCancelled();
                                        }
                                    }
                                }
                                Header {
                                    title: "Status"
                                }
                                TextArea {
                                    id: status_textarea
                                    preferredWidth: 900
                                    preferredHeight: 145
                                    editable: false
                                    text: _manager.statusMessage
                                }
                                Header {
                                    title: "Errors"
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
        }
    }
    Tab {
        title: "OS Lookup Tool"
        Page {
            titleBar: TitleBar {
                title: qsTr("BB10 OS Downloader %1").arg(AppInfo.version)
            }
            ScrollView {
                scrollViewProperties.pinchToZoomEnabled: false
                scrollViewProperties.scrollMode: ScrollMode.Vertical
                Container {
                    Header {
                        title: "Input"
                    }
                    Container {
                        topPadding: 20.0
                        layout: StackLayout {
                            orientation: LayoutOrientation.LeftToRight
                        }
                        Label {
                            text: "OS Version:"
                            verticalAlignment: VerticalAlignment.Center
                        }
                        TextField {
                            id: autolookup_input
                            verticalAlignment: VerticalAlignment.Center
                            inputMode: TextFieldInputMode.NumbersAndPunctuation
                            onTextChanging: {
                                _swlookup.post(autolookup_input.text);
                            }
                            input.submitKey: SubmitKey.Submit
                            hintText: "Enter OS version"
                        }
                    }
                    Label {
                        horizontalAlignment: HorizontalAlignment.Center
                        text: "Don't tap too fast.\nIf things go sour, hit Clear and try again."
                        multiline: true
                        verticalAlignment: VerticalAlignment.Center
                        textStyle.textAlign: TextAlign.Center
                    }
                    Container {
                        topPadding: 20.0
                        layout: StackLayout {
                            orientation: LayoutOrientation.LeftToRight
                        }
                        horizontalAlignment: HorizontalAlignment.Center
                        Button {
                            id: autolookupbutton
                            text: "Keep tapping"
                            onClicked: {
                                outputtext.text = outputtext.text + (autolookup_input.text + " - " + _swlookup.softwareRelease() + "\n");
                                var splitarray = autolookup_input.text.split(".");
                                var newnum = parseInt(splitarray[3], 10);
                                splitarray[3] = newnum +3;
                                autolookup_input.text = splitarray.join(".");
                            }
                        }
                        Button {
                            id: autoclearbutton
                            text: "Clear"
                            onClicked: {
                                outputtext.text = "";
                                autolookup_input.text = "";
                                swrelease_auto = "";
                            }
                        }
                    }
                    Header {
                        title: "Results"
                    }
                    Container {
                        TextArea {
                            text: ""
                            editable: false
                            id:outputtext
                            textFormat: TextFormat.Plain
                            content.flags: TextContentFlag.ActiveTextOff
                        }
                    }
                }
            }  
        }
    }
}