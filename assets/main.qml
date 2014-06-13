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
    property string hashedswversion
    property string swrelease
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
    titleBar: TitleBar {
        title: qsTr("BB10 OS Downloader %1").arg(AppInfo.version)
    }
    ScrollView {
        id: mainscrollview
        accessibility.name: ""
        scrollViewProperties.pinchToZoomEnabled: false
        scrollViewProperties.scrollMode: ScrollMode.Vertical
        Container {
            id: global_download_container
            //Inputs
            Container {
                id: input_variable_container
                layout: StackLayout {
                    orientation: LayoutOrientation.TopToBottom 
                }
                Label {
                    id: osver_label
                    text: "OS Version"
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
                        hintText: "OS version"
                        inputMode: TextFieldInputMode.NumbersAndPunctuation
                        horizontalAlignment: HorizontalAlignment.Left
                    }
                    Button {
                        id: lookupbutton
                        text: "Lookup"
                        onClicked: {
                            _swlookup.post(osver_input.text);
                            var swrelease = _swlookup.softwareRelease();
                            if (swrelease.indexOf(".") != -1) {
                                swver_input.text = swrelease;
                            } else {
                                swver_input.text = "SW Release not found.";
                            }
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
                            text: "Radio Version"
                        }
                        TextField {
                            id: radiover_input
                            hintText: "Radio version"
                            inputMode: TextFieldInputMode.NumbersAndPunctuation
                        }
                    }
                    Container {
                        layout: StackLayout {
                            orientation: LayoutOrientation.TopToBottom

                        }
                        Label {
                            id: swver_label
                            text: "Software Version"
                        }
                        TextField {
                            id: swver_input
                            hintText: "Software version"
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
                            os_download_label.text = "SDK Debrick OS:";
                        }
                        if (osdropdown.selectedValue == "sdkcore") {
                            os_download_label.text = "SDK Core OS:";
                        }
                        if (osdropdown.selectedValue == "sdkautoloader") {
                            os_download_label.text = "Autoloader:";
                            radio_download_label.text = "SDK downloads wonky. \nWorkaround: tap on link to download in Browser.";
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
                        text: "Z30"
                        value: "8960wtr5"
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
                        id: dropdown_parana
                        text: "Aquila/Aquarius"
                        value: "8974"
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
                                radio_download_label.text = "Q10/Q5/P9983/Classic Radio:";
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
                            if (devicedropdown.selectedValue == "8974"){
                                radio_download_label.text = "Aquila/Aquarius Radio:";
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
                        if (osdropdown.selectedValue == "sdkautoloader"){
                            global_linkcontainer.visible = false;
                        }
                        if (osdropdown.selectedValue != "sdkautoloader"){
                            global_linkcontainer.visible = true;
                        }
                        if (devicedropdown.selectedValue == "winchester_pb"){
                            radio_download_label.text = "WiFi PlayBook ain't got no radio";
                            radio_download_textarea.text = "";
                            if (osdropdown.selectedValue == "debrick") {
                                os_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.factory.desktop/" + osver_input.text + "/winchester.factory_sfi.desktop-" + osver_input.text + "-nto+armle-v7+signed.bar";
                            }
                            if (osdropdown.selectedValue != "debrick") {
                                os_download_textarea.text = "Please set OS Type to Debrick OS";
                            }
                        }
                        if (devicedropdown.selectedValue == "winchester_pblte_old"){
                            if (osdropdown.selectedValue == "debrick") {
                                os_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.factory.desktop/" + osver_input.text + "/winchester.factory_sfi.desktop-" + osver_input.text + "-nto+armle-v7+signed.bar";
                                radio_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/mod-qcmdm9k-" + radiover_input.text + "-nto+armle-v7+signed.bar";
                            }
                            if (osdropdown.selectedValue != "debrick") {
                                os_download_textarea.text = "Please set OS Type to Debrick OS";
                            }
                        }
                        if (devicedropdown.selectedValue == "winchester_pblte_new"){
                            if (osdropdown.selectedValue == "debrick") {
                                radio_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/mod.qcmdm9k-" + radiover_input.text + "-nto+armle-v7+signed.bar";
                                os_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.factory.desktop/" + osver_input.text + "/winchester.factory_sfi.desktop-" + osver_input.text + "-nto+armle-v7+signed.bar";
                            }
                            if (osdropdown.selectedValue != "debrick") {
                                os_download_textarea.text = "Please set OS Type to Debrick OS";
                            }
                        }
                        if (devicedropdown.selectedValue == "8930wtr5") {
                            if (osdropdown.selectedValue != "sdkautoloader"){
                                radio_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.qcfm.radio.qc8930.wtr5/" + radiover_input.text + "/qc8930.wtr5-" + radiover_input.text + "-nto+armle-v7+signed.bar"
                            }
                            if (osdropdown.selectedValue == "debrick") {
                                os_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8960.factory_sfi.desktop/" + osver_input.text + "/qc8960.factory_sfi.desktop-" + osver_input.text + "-nto+armle-v7+signed.bar";
                            }
                            if (osdropdown.selectedValue == "core") {
                                os_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8960.factory_sfi/" + osver_input.text + "/qc8960.factory_sfi-" + osver_input.text + "-nto+armle-v7+signed.bar";
                            }
                            if (osdropdown.selectedValue == "debrick_vzw"){
                                os_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8960.verizon_sfi.desktop/" + osver_input.text + "/qc8960.verizon_sfi.desktop-" + osver_input.text + "-nto+armle-v7+signed.bar";
                            }
                            if (osdropdown.selectedValue == "core_vzw"){
                                os_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8960.verizon_sfi/" + osver_input.text + "/qc8960.verizon_sfi-" + osver_input.text + "-nto+armle-v7+signed.bar";
                            }
                            if (osdropdown.selectedValue == "debrick_china"){
                                os_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8960.china_sfi.desktop/" + osver_input.text + "/qc8960.china_sfi.desktop-" + osver_input.text + "-nto+armle-v7+signed.bar";
                            }
                            if (osdropdown.selectedValue == "core_china"){
                                os_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8960.china_sfi/" + osver_input.text + "/qc8960.china_sfi-" + osver_input.text + "-nto+armle-v7+signed.bar";
                            }
                            if (osdropdown.selectedValue == "sdkdebrick") {
                                os_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8960.sdk.desktop/" + osver_input.text + "/qc8960.sdk.desktop-" + osver_input.text + "-nto+armle-v7+signed.bar";
                            }
                            if (osdropdown.selectedValue == "sdkcore") {
                                os_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8960.sdk/" + osver_input.text + "/qc8960.sdk-" + osver_input.text + "-nto+armle-v7+signed.bar";
                            }
                            if (osdropdown.selectedValue == "sdkautoloader") {
                                radio_download_textarea.text = "";
                                os_download_textarea.text = "http://developer.blackberry.com/native/downloads/fetch/Autoload-STJ100-1-" + osver_input.text +".exe";
                            }
                        }
                        if (devicedropdown.selectedValue == "8960wtr5"){
                            if (osdropdown.selectedValue != "sdkautoloader"){
                                radio_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.qcfm.radio.qc8960.wtr5/" + radiover_input.text + "/qc8960.wtr5-" + radiover_input.text + "-nto+armle-v7+signed.bar";
                            }
                            if (osdropdown.selectedValue == "debrick") {
                                os_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8960.factory_sfi.desktop/" + osver_input.text + "/qc8960.factory_sfi.desktop-" + osver_input.text + "-nto+armle-v7+signed.bar";
                            }
                            if (osdropdown.selectedValue == "core") {
                                os_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8960.factory_sfi/" + osver_input.text + "/qc8960.factory_sfi-" + osver_input.text + "-nto+armle-v7+signed.bar";
                            }
                            if (osdropdown.selectedValue == "debrick_vzw"){
                                os_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8960.verizon_sfi.desktop/" + osver_input.text + "/qc8960.verizon_sfi.desktop-" + osver_input.text + "-nto+armle-v7+signed.bar";
                            }
                            if (osdropdown.selectedValue == "core_vzw"){
                                os_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8960.verizon_sfi/" + osver_input.text + "/qc8960.verizon_sfi-" + osver_input.text + "-nto+armle-v7+signed.bar";
                            }
                            if (osdropdown.selectedValue == "debrick_china"){
                                os_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8960.china_sfi.desktop/" + osver_input.text + "/qc8960.china_sfi.desktop-" + osver_input.text + "-nto+armle-v7+signed.bar";
                            }
                            if (osdropdown.selectedValue == "core_china"){
                                os_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8960.china_sfi/" + osver_input.text + "/qc8960.china_sfi-" + osver_input.text + "-nto+armle-v7+signed.bar";
                            }
                            if (osdropdown.selectedValue == "sdkdebrick") {
                                os_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8960.sdk.desktop/" + osver_input.text + "/qc8960.sdk.desktop-" + osver_input.text + "-nto+armle-v7+signed.bar";
                            }
                            if (osdropdown.selectedValue == "sdkcore") {
                                os_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8960.sdk/" + osver_input.text + "/qc8960.sdk-" + osver_input.text + "-nto+armle-v7+signed.bar";
                            }
                            if (osdropdown.selectedValue == "sdkautoloader") {
                                radio_download_textarea.text = "";
                                os_download_textarea.text = "http://developer.blackberry.com/native/downloads/fetch/Autoload-STA100-5-" + osver_input.text +".exe";
                            }
                        }
                        if (devicedropdown.selectedValue == "8960wtr6"){
                            if (osdropdown.selectedValue != "sdkautoloader"){
                                radio_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.qcfm.radio.qc8960.wtr6/" + radiover_input.text + "/qc8960.wtr6-" + radiover_input.text + "-nto+armle-v7+signed.bar";
                            }
                            if (osdropdown.selectedValue == "debrick") {
                                os_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8960.factory_sfi.desktop/" + osver_input.text + "/qc8960.factory_sfi.desktop-" + osver_input.text + "-nto+armle-v7+signed.bar";
                            }
                            if (osdropdown.selectedValue == "core") {
                                os_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8960.factory_sfi/" + osver_input.text + "/qc8960.factory_sfi-" + osver_input.text + "-nto+armle-v7+signed.bar";
                            }
                            if (osdropdown.selectedValue == "debrick_vzw"){
                                os_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8960.verizon_sfi.desktop/" + osver_input.text + "/qc8960.verizon_sfi.desktop-" + osver_input.text + "-nto+armle-v7+signed.bar";
                            }
                            if (osdropdown.selectedValue == "core_vzw"){
                                os_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8960.verizon_sfi/" + osver_input.text + "/qc8960.verizon_sfi-" + osver_input.text + "-nto+armle-v7+signed.bar";
                            }
                            if (osdropdown.selectedValue == "debrick_china"){
                                os_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8960.china_sfi.desktop/" + osver_input.text + "/qc8960.china_sfi.desktop-" + osver_input.text + "-nto+armle-v7+signed.bar";
                            }
                            if (osdropdown.selectedValue == "core_china"){
                                os_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8960.china_sfi/" + osver_input.text + "/qc8960.china_sfi-" + osver_input.text + "-nto+armle-v7+signed.bar";
                            }
                            if (osdropdown.selectedValue == "sdkdebrick") {
                                os_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8960.sdk.desktop/" + osver_input.text + "/qc8960.sdk.desktop-" + osver_input.text + "-nto+armle-v7+signed.bar";
                            }
                            if (osdropdown.selectedValue == "sdkcore") {
                                os_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8960.sdk/" + osver_input.text + "/qc8960.sdk-" + osver_input.text + "-nto+armle-v7+signed.bar";
                            }
                            if (osdropdown.selectedValue == "sdkautoloader") {
                                radio_download_textarea.text = "";
                                os_download_textarea.text = "http://developer.blackberry.com/native/downloads/fetch/Autoload-STA100-5-" + osver_input.text +".exe";
                            }
                        }
                        if (devicedropdown.selectedValue == "8960wtr"){
                            if (osdropdown.selectedValue != "sdkautoloader"){
                                radio_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.qcfm.radio.qc8960.wtr/" + radiover_input.text + "/qc8960.wtr-" + radiover_input.text + "-nto+armle-v7+signed.bar";
                            }
                            if (osdropdown.selectedValue == "debrick") {
                                os_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8960.factory_sfi.desktop/" + osver_input.text + "/qc8960.factory_sfi.desktop-" + osver_input.text + "-nto+armle-v7+signed.bar";
                            }
                            if (osdropdown.selectedValue == "core") {
                                os_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8960.factory_sfi/" + osver_input.text + "/qc8960.factory_sfi-" + osver_input.text + "-nto+armle-v7+signed.bar";
                            }
                            if (osdropdown.selectedValue == "debrick_vzw"){
                                os_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8960.verizon_sfi.desktop/" + osver_input.text + "/qc8960.verizon_sfi.desktop-" + osver_input.text + "-nto+armle-v7+signed.bar";
                            }
                            if (osdropdown.selectedValue == "core_vzw"){
                                os_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8960.verizon_sfi/" + osver_input.text + "/qc8960.verizon_sfi-" + osver_input.text + "-nto+armle-v7+signed.bar";
                            }
                            if (osdropdown.selectedValue == "debrick_china"){
                                os_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8960.china_sfi.desktop/" + osver_input.text + "/qc8960.china_sfi.desktop-" + osver_input.text + "-nto+armle-v7+signed.bar";
                            }
                            if (osdropdown.selectedValue == "core_china"){
                                os_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8960.china_sfi/" + osver_input.text + "/qc8960.china_sfi-" + osver_input.text + "-nto+armle-v7+signed.bar";
                            }
                            if (osdropdown.selectedValue == "sdkdebrick") {
                                os_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8960.sdk.desktop/" + osver_input.text + "/qc8960.sdk.desktop-" + osver_input.text + "-nto+armle-v7+signed.bar";
                            }
                            if (osdropdown.selectedValue == "sdkcore") {
                                os_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8960.sdk/" + osver_input.text + "/qc8960.sdk-" + osver_input.text + "-nto+armle-v7+signed.bar";
                            }
                            if (osdropdown.selectedValue == "sdkautoloader") {
                                radio_download_textarea.text = "";
                                os_download_textarea.text = "http://developer.blackberry.com/native/downloads/fetch/Autoload-SQN100-5-" + osver_input.text +".exe";
                            }
                        }
                        if (devicedropdown.selectedValue == "8960omadm"){
                            if (osdropdown.selectedValue != "sdkautoloader"){
                                radio_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.qcfm.radio.qc8960.omadm/" + radiover_input.text + "/qc8960.omadm-" + radiover_input.text + "-nto+armle-v7+signed.bar";
                            }
                            if (osdropdown.selectedValue == "debrick") {
                                os_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8960.factory_sfi.desktop/" + osver_input.text + "/qc8960.factory_sfi.desktop-" + osver_input.text + "-nto+armle-v7+signed.bar";
                            }
                            if (osdropdown.selectedValue == "core") {
                                os_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8960.factory_sfi/" + osver_input.text + "/qc8960.factory_sfi-" + osver_input.text + "-nto+armle-v7+signed.bar";
                            }
                            if (osdropdown.selectedValue == "debrick_vzw"){
                                os_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8960.verizon_sfi.desktop/" + osver_input.text + "/qc8960.verizon_sfi.desktop-" + osver_input.text + "-nto+armle-v7+signed.bar";
                            }
                            if (osdropdown.selectedValue == "core_vzw"){
                                os_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8960.verizon_sfi/" + osver_input.text + "/qc8960.verizon_sfi-" + osver_input.text + "-nto+armle-v7+signed.bar";
                            }
                            if (osdropdown.selectedValue == "debrick_china"){
                                os_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8960.china_sfi.desktop/" + osver_input.text + "/qc8960.china_sfi.desktop-" + osver_input.text + "-nto+armle-v7+signed.bar";
                            }
                            if (osdropdown.selectedValue == "core_china"){
                                os_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8960.china_sfi/" + osver_input.text + "/qc8960.china_sfi-" + osver_input.text + "-nto+armle-v7+signed.bar";
                            }
                            if (osdropdown.selectedValue == "sdkdebrick") {
                                os_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8960.sdk.desktop/" + osver_input.text + "/qc8960.sdk.desktop-" + osver_input.text + "-nto+armle-v7+signed.bar";
                            }
                            if (osdropdown.selectedValue == "sdkcore") {
                                os_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8960.sdk/" + osver_input.text + "/qc8960.sdk-" + osver_input.text + "-nto+armle-v7+signed.bar";
                            }
                            if (osdropdown.selectedValue == "sdkautoloader") {
                                radio_download_textarea.text = "";
                                os_download_textarea.text = "http://developer.blackberry.com/native/downloads/fetch/Autoload-STL100-4-" + osver_input.text +".exe";
                            }
                        }
                        if (devicedropdown.selectedValue == "8960"){
                            if (osdropdown.selectedValue != "sdkautoloader"){
                                radio_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.qcfm.radio.qc8960/" + radiover_input.text + "/qc8960-" + radiover_input.text + "-nto+armle-v7+signed.bar";
                            }
                            if (osdropdown.selectedValue == "debrick") {
                                os_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8960.factory_sfi.desktop/" + osver_input.text + "/qc8960.factory_sfi.desktop-" + osver_input.text + "-nto+armle-v7+signed.bar";
                            }
                            if (osdropdown.selectedValue == "core") {
                                os_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8960.factory_sfi/" + osver_input.text + "/qc8960.factory_sfi-" + osver_input.text + "-nto+armle-v7+signed.bar";
                            }
                            if (osdropdown.selectedValue == "debrick_vzw"){
                                os_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8960.verizon_sfi.desktop/" + osver_input.text + "/qc8960.verizon_sfi.desktop-" + osver_input.text + "-nto+armle-v7+signed.bar";
                            }
                            if (osdropdown.selectedValue == "core_vzw"){
                                os_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8960.verizon_sfi/" + osver_input.text + "/qc8960.verizon_sfi-" + osver_input.text + "-nto+armle-v7+signed.bar";
                            }
                            if (osdropdown.selectedValue == "debrick_china"){
                                os_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8960.china_sfi.desktop/" + osver_input.text + "/qc8960.china_sfi.desktop-" + osver_input.text + "-nto+armle-v7+signed.bar";
                            }
                            if (osdropdown.selectedValue == "core_china"){
                                os_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8960.china_sfi/" + osver_input.text + "/qc8960.china_sfi-" + osver_input.text + "-nto+armle-v7+signed.bar";
                            }
                            if (osdropdown.selectedValue == "sdkdebrick") {
                                os_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8960.sdk.desktop/" + osver_input.text + "/qc8960.sdk.desktop-" + osver_input.text + "-nto+armle-v7+signed.bar";
                            }
                            if (osdropdown.selectedValue == "sdkcore") {
                                os_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8960.sdk/" + osver_input.text + "/qc8960.sdk-" + osver_input.text + "-nto+armle-v7+signed.bar";
                            }
                            if (osdropdown.selectedValue == "sdkautoloader") {
                                radio_download_textarea.text = "";
                                os_download_textarea.text = "http://developer.blackberry.com/native/downloads/fetch/Autoload-STL100-3-" + osver_input.text +".exe";
                            }
                        }
                        if (devicedropdown.selectedValue == "winchester"){
                            if (osdropdown.selectedValue != "sdkautoloader"){
                                radio_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.qcfm.radio.m5730/" + radiover_input.text + "/m5730-" + radiover_input.text + "-nto+armle-v7+signed.bar";
                            }
                            if (osdropdown.selectedValue == "debrick") {
                                os_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.factory.desktop/" + osver_input.text + "/winchester.factory_sfi.desktop-" + osver_input.text + "-nto+armle-v7+signed.bar";
                            }
                            if (osdropdown.selectedValue == "core") {
                                os_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.factory/" + osver_input.text + "/winchester.factory_sfi-" + osver_input.text + "-nto+armle-v7+signed.bar";
                            }
                            if (osdropdown.selectedValue == "sdkdebrick") {
                                os_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.winchester.sdk.desktop/" + osver_input.text + "/winchester.sdk.desktop-" + osver_input.text + "-nto+armle-v7+signed.bar";
                            }
                            if (osdropdown.selectedValue == "sdkcore") {
                                os_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.winchester.sdk/" + osver_input.text + "/winchester.sdk-" + osver_input.text + "-nto+armle-v7+signed.bar";
                            }
                            if (osdropdown.selectedValue == "debrick_vzw" || osdropdown.selectedValue == "debrick_china" || osdropdown.selectedValue == "core_vzw" || osdropdown.selectedValue == "core_china") {
                                os_download_textarea.text = "Please set OS Type to Debrick/Core OS"
                            }
                            if (osdropdown.selectedValue == "sdkautoloader") {
                                radio_download_textarea.text = "";
                                os_download_textarea.text = "http://developer.blackberry.com/native/downloads/fetch/Autoload-STL100-1-" + osver_input.text +".exe";
                            }
                        }
                        if (devicedropdown.selectedValue == "8974"){
                            if (osdropdown.selectedValue != "sdkautoloader"){
                                radio_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.qcfm.radio.qc8974/" + radiover_input.text + "/qc8974-" + radiover_input.text + "-nto+armle-v7+signed.bar";
                                os_download_textarea.text = "If you actually know what the URL for a 8974 OS is, please tell me.";
                            }
                            if (osdropdown.selectedValue == "sdkautoloader") {
                                radio_download_textarea.text = "";
                                os_download_textarea.text = "If nobody can find a regular OS for this hardware, what makes you think there's a SDK OS?";
                            }
                        }
                    }
                }
                Button {
                    id: clearbutton
                    text: "Clear"
                    onClicked: {
                        /*osver_input.text = "";
                        radiover_input.text = "";
                        swver_input.text = "";*/
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
                                accessibility.name: ""
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
                            accessibility.name: ""
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
                            accessibility.name: ""
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
                            accessibility.name: ""
                        }
                    }
                }
            }
        }
    }
}