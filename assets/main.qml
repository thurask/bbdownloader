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

Page {
    property string swversion: swver_input.text
    property string hashedswversion
    property string osversion: osver_input.text
    property string radioversion: radiover_input.text
    property string osurl
    property string radiourl
    property alias osurl_alias: os_download_textarea.text
    property alias radiourl_alias: radio_download_textarea.text
    attachedObjects: [
        ComponentDefinition {
            id: helpSheetDefinition
            HelpSheet {
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
    }
    titleBar: TitleBar {
        title: "BB10 OS Downloader v2.1.1"
    }
    ScrollView {
        id: mainscrollview
        accessibility.name: ""
        scrollViewProperties.pinchToZoomEnabled: false
        scrollViewProperties.scrollMode: ScrollMode.Vertical
        Container {
            id: global_download_container
            Container {
                id: input_variable_container
                layout: StackLayout {
                    orientation: LayoutOrientation.TopToBottom
                
                }
                Label {
                    id: osver_label
                    text: "OS Version"
                
                }
                TextField {
                    id: osver_input
                    hintText: "Enter target OS version"
                    text: "10.2.1.3175"
                    inputMode: TextFieldInputMode.NumbersAndPunctuation
                }
                Label {
                    id: radiover_label
                    text: "Radio Version"
                }
                TextField {
                    id: radiover_input
                    hintText: "Enter target radio version"
                    text: "10.2.1.3140"
                    inputMode: TextFieldInputMode.NumbersAndPunctuation
                }
                Label {
                    id: swver_label
                    text: "Software Version"
                }
                TextField {
                    id: swver_input
                    hintText: "Enter target software version"
                    text: "10.2.1.2941"
                    onCreationCompleted: {
                        hashCalculateSha.calculateHash(swversion)
                        hashedswversion = hashCalculateSha.getHash()
                    }
                    onTextChanged: {
                        hashCalculateSha.calculateHash(swversion)
                        hashedswversion = hashCalculateSha.getHash()
                    }
                    inputMode: TextFieldInputMode.NumbersAndPunctuation
                }
                DropDown {
                    id: osdropdown
                    title: "Choose OS Type"
                    Option {
                        id: dropdown_debrick
                        text: "Debrick OS"
                        value: "debrick"
                        selected: true
                    }
                    Option {
                        id: dropdown_core
                        text: "Core OS"
                        value: "core"
                    }
                    Option {
                        id: dropdown_debrick_verizon
                        text: "Verizon Debrick OS"
                        value: "debrick_vzw"
                    }
                    Option {
                        id: dropdown_core_verizon
                        text: "Verizon Core OS"
                        value: "core_vzw"
                    }
                    Option {
                        id: dropdown_debrick_china
                        text: "China Debrick OS"
                        value: "debrick_china"
                    }
                    Option {
                        id: dropdown_core_china
                        text: "China Core OS"
                        value: "core_china"
                    }
                    Option {
                        id: dropdown_sdkdebrick
                        text: "SDK Debrick OS"
                        value: "sdkdebrick"
                    }
                    Option {
                        id: dropdown_sdkcore
                        text: "SDK Core OS"
                        value: "sdkcore"
                    }
                    Option {
                        id: dropdown_sdkautoloader
                        text: "SDK Autoloader (BlackBerry Dev)"
                        value: "sdkautoloader"
                    }
                    onCreationCompleted: {
                        if (osdropdown.selectedValue == "debrick") {
                            os_download_label.text = "Debrick OS:";
                        } 
                    }
                    onSelectedValueChanged: {
                        if (osdropdown.selectedValue == "debrick") {
                            os_download_label.text = "Debrick OS:";
                        }
                        if (osdropdown.selectedValue == "core") {
                            os_download_label.text = "Core OS:";
                        }
                        if (osdropdown.selectedValue == "debrick_vzw") {
                            os_download_label.text = "Verizon Debrick OS:";
                        }
                        if (osdropdown.selectedValue == "core_vzw") {
                            os_download_label.text = "Verizon Core OS:";
                        }
                        if (osdropdown.selectedValue == "debrick_china") {
                            os_download_label.text = "China Debrick OS:";
                        }
                        if (osdropdown.selectedValue == "core_china") {
                            os_download_label.text = "China Core OS:";
                        }
                        if (osdropdown.selectedValue == "sdkdebrick") {
                            os_download_label.text = "Debrick SDK OS:";
                        }
                        if (osdropdown.selectedValue == "sdkcore") {
                            os_download_label.text = "Debrick SDK OS:";
                        }
                        if (osdropdown.selectedValue == "sdkautoloader") {
                            os_download_label.text = "Autoloader:";
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
                        text: "Q10/Q5/Classic/Khan"
                        value: "8960wtr"
                    }
                    Option {
                        id: dropdown_z30
                        text: "Z30"
                        value: "8960wtr5"
                        selected: true
                    }
                    Option {
                        id: dropdown_z30_future
                        text: "Z30 (Future)"
                        value: "8960wtr6"
                    }
                    Option {
                        id: dropdown_jakarta
                        text: "Z3/Kopi/Cafe"
                        value: "8930wtr5"
                    }
                    Option {
                        id: dropdown_pb
                        text: "PlayBook"
                        value: "winchester_pb"
                    }
                    Option {
                        id: dropdown_pblte_old
                        text: "4G PlayBook (v1)"
                        value: "winchester_pblte_old"
                    }
                    Option {
                        id: dropdown_pblte_new
                        text: "4G PlayBook (v2)"
                        value: "winchester_pblte_new"
                    }
                    onCreationCompleted: {
                        if (devicedropdown.selectedValue == "8960wtr5") {
                            radio_download_label.text = "Z30 Radio:";
                        }
                    }
                    onSelectedValueChanged: {
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
                                radio_download_label.text = "Q10/Q5/Khan/Classic Radio:";
                            }
                            if (devicedropdown.selectedValue == "8960wtr5") {
                                radio_download_label.text = "Z30 Radio:";
                            }
                            if (devicedropdown.selectedValue == "8960wtr6") {
                                radio_download_label.text = "Z30 (Future) Radio:";
                            }
                            if (devicedropdown.selectedValue == "8930wtr5") {
                                radio_download_label.text = "Z3/Kopi/Cafe Radio:";
                            }
                            if (devicedropdown.selectedValue == "winchester_pblte_old"){
                                radio_download_label.text = "4G PlayBook Radio: ";
                            }
                            if (devicedropdown.selectedValue == "winchester_pblte_new"){
                                radio_download_label.text = "4G PlayBook Radio: ";
                            }
                        }
                    }
                }
            }
            Button {
                id:generatebutton
                text: "Generate"
                horizontalAlignment: HorizontalAlignment.Center
                onClicked: {
                    global_linkcontainer.visible = true;
                    if (devicedropdown.selectedValue == "winchester_pb"){
                        radio_download_label.text = "WiFi PlayBook ain't got no radio";
                        radio_download_textarea.text = "";
                        if (osdropdown.selectedValue == "debrick") {
                            os_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.factory.desktop/" + osversion + "/winchester.factory_sfi.desktop-" + osversion + "-nto+armle-v7+signed.bar";
                        }
                        if (osdropdown.selectedValue != "debrick") {
                            os_download_textarea.text = "Please set OS Type to Debrick OS";
                        }
                    }
                    if (devicedropdown.selectedValue == "winchester_pblte_old"){
                        if (osdropdown.selectedValue == "debrick") {
                            os_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.factory.desktop/" + osversion + "/winchester.factory_sfi.desktop-" + osversion + "-nto+armle-v7+signed.bar";
                            radio_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/mod-qcmdm9k-" + radioversion + "-nto+armle-v7+signed.bar";
                        }
                        if (osdropdown.selectedValue != "debrick") {
                            os_download_textarea.text = "Please set OS Type to Debrick OS";
                        }
                    }
                    if (devicedropdown.selectedValue == "winchester_pblte_new"){
                        if (osdropdown.selectedValue == "debrick") {
                            radio_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/mod.qcmdm9k-" + radioversion + "-nto+armle-v7+signed.bar";
                            os_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.factory.desktop/" + osversion + "/winchester.factory_sfi.desktop-" + osversion + "-nto+armle-v7+signed.bar";
                        }
                        if (osdropdown.selectedValue != "debrick") {
                            os_download_textarea.text = "Please set OS Type to Debrick OS";
                        }
                    }
                    if (devicedropdown.selectedValue == "8930wtr5") {
                        if (osdropdown.selectedValue != "sdkautoloader"){
                            radio_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.qcfm.radio.qc8930.wtr5/" + radioversion + "/qc8930.wtr5-" + radioversion + "-nto+armle-v7+signed.bar"
                        }
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
                        if (osdropdown.selectedValue == "sdkautoloader") {
                            radio_download_textarea.text = "";
                            os_download_textarea.text = "http://developer.blackberry.com/native/downloads/fetch/Autoload-STJ100-1-" + osversion +".exe"
                        }
                    }
                    if (devicedropdown.selectedValue == "8960wtr5"){
                        if (osdropdown.selectedValue != "sdkautoloader"){
                            radio_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.qcfm.radio.qc8960.wtr5/" + radioversion + "/qc8960.wtr5-" + radioversion + "-nto+armle-v7+signed.bar";
                        }
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
                        if (osdropdown.selectedValue == "sdkautoloader") {
                            radio_download_textarea.text = "";
                            os_download_textarea.text = "http://developer.blackberry.com/native/downloads/fetch/Autoload-STA100-5-" + osversion +".exe"
                        }
                    }
                    if (devicedropdown.selectedValue == "8960wtr6"){
                        if (osdropdown.selectedValue != "sdkautoloader"){
                            radio_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.qcfm.radio.qc8960.wtr6/" + radioversion + "/qc8960.wtr6-" + radioversion + "-nto+armle-v7+signed.bar";
                        }
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
                        if (osdropdown.selectedValue == "sdkautoloader") {
                            radio_download_textarea.text = "";
                            os_download_textarea.text = "http://developer.blackberry.com/native/downloads/fetch/Autoload-STA100-5-" + osversion +".exe"
                        }
                    }
                    if (devicedropdown.selectedValue == "8960wtr"){
                        if (osdropdown.selectedValue != "sdkautoloader"){
                            radio_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.qcfm.radio.qc8960.wtr/" + radioversion + "/qc8960.wtr-" + radioversion + "-nto+armle-v7+signed.bar";
                        }
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
                        if (osdropdown.selectedValue == "sdkautoloader") {
                            radio_download_textarea.text = "";
                            os_download_textarea.text = "http://developer.blackberry.com/native/downloads/fetch/Autoload-SQN100-5-" + osversion +".exe"
                        }
                    }
                    if (devicedropdown.selectedValue == "8960omadm"){
                        if (osdropdown.selectedValue != "sdkautoloader"){
                            radio_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.qcfm.radio.qc8960.omadm/" + radioversion + "/qc8960.omadm-" + radioversion + "-nto+armle-v7+signed.bar";
                        }
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
                        if (osdropdown.selectedValue == "sdkautoloader") {
                            radio_download_textarea.text = "";
                            os_download_textarea.text = "http://developer.blackberry.com/native/downloads/fetch/Autoload-STL100-4-" + osversion +".exe"
                        }
                    }
                    if (devicedropdown.selectedValue == "8960"){
                        if (osdropdown.selectedValue != "sdkautoloader"){
                            radio_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.qcfm.radio.qc8960/" + radioversion + "/qc8960-" + radioversion + "-nto+armle-v7+signed.bar";
                        }
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
                        if (osdropdown.selectedValue == "sdkautoloader") {
                            radio_download_textarea.text = "";
                            os_download_textarea.text = "http://developer.blackberry.com/native/downloads/fetch/Autoload-STL100-3-" + osversion +".exe"
                        }
                    }
                    if (devicedropdown.selectedValue == "winchester"){
                        if (osdropdown.selectedValue != "sdkautoloader"){
                            radio_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.qcfm.radio.m5730/" + radioversion + "/m5730-" + radioversion + "-nto+armle-v7+signed.bar";
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
                        if (osdropdown.selectedValue == "sdkautoloader") {
                            radio_download_textarea.text = "";
                            os_download_textarea.text = "http://developer.blackberry.com/native/downloads/fetch/Autoload-STL100-1-" + osversion +".exe"
                        }
                    }
                }
            }
            Header {
                accessibility.name: ""
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
                            osurl = os_download_textarea.text
                            _manager.downloadUrl (osurl)
                        }
                    }
                    Button {
                        id: downloadbutton_radio
                        text: "Download Radio"
                        onClicked: {
                            global_urlcontainer.visible = true;
                            radiourl = radio_download_textarea.text
                            _manager.downloadUrl (radiourl)
                        }
                    }
                }
                Container{
                    id: global_urlcontainer
                    visible: false
                    Container {
                        Header {
                            accessibility.name: ""
                            title: "Progress"
                        }
                        Label {
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
                        Button {
                            id: stopbutton
                            text: "Stop Download"
                            horizontalAlignment: HorizontalAlignment.Center
                            onClicked: {
                                _manager.downloadCancelled();
                            }
                        }
                        Header {
                            accessibility.name: ""
                            title: "Status"
                        }
                        TextArea {
                            preferredWidth: 900
                            preferredHeight: 145
                            editable: false
                            text: _manager.statusMessage
                        }
                        Header {
                            accessibility.name: ""
                            title: "Errors"
                        }
                        TextArea {
                            preferredWidth: 900
                            preferredHeight: 125
                            editable: false
                            text: _manager.errorMessage
                        }
                        Divider {
                            accessibility.name: ""
                    }
                }
                }
            }
        }
    }
}