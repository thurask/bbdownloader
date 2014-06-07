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
        title: "BB10 OS Downloader"
    }
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
                onTextChanged: {
                    osver_input.text = osver_input.text
                }
                inputMode: TextFieldInputMode.NumbersAndPunctuation
            }
            Label {
                id: radiover_label
                text: "Radio Version"
            }
            TextField {
                id: radiover_input
                hintText: "Enter target radio version"
                onTextChanged: {
                    radiover_input.text = radiover_input.text
                }
                inputMode: TextFieldInputMode.NumbersAndPunctuation
            }
            Label {
                id: swver_label
                text: "Software Version"
            }
            TextField {
                id: swver_input
                hintText: "Enter target software version"
                onTextChanged: {
                    hashCalculateSha.calculateHash(swver_input.text)
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
                    id: dropdown_sdkdebrick
                    text: "SDK Debrick OS"
                    value: "sdkdebrick"
                }
                Option {
                    id: dropdown_sdkcore
                    text: "SDK Core OS"
                    value: "sdkcore"
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
                    if (osdropdown.selectedValue == "sdkdebrick") {
                        os_download_label.text = "Debrick SDK OS:";
                    }
                    if (osdropdown.selectedValue == "sdkcore") {
                        os_download_label.text = "Debrick SDK OS:";
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
                    onSelectedChanged: {
                        if(selected){
                            radio_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.qcfm.radio.m5730/" + radiover_input.text + "/m5730-" + radiover_input.text + "-nto+armle-v7+signed.bar";
                            if (osdropdown.selectedValue == "debrick") {
                                os_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.factory.desktop/" + osver_input.text + "/winchester.factory_sfi.desktop-" + osver_input.text + "-nto+armle+v7+signed.bar";
                            }
                            if (osdropdown.selectedValue == "core") {
                                os_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.factory/" + osver_input.text + "/winchester.factory_sfi-" + osver_input.text + "-nto+armle+v7+signed.bar";
                            }
                            if (osdropdown.selectedValue == "sdkdebrick") {
                                os_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.winchester.sdk.desktop/" + osver_input.text + "/winchester.sdk.desktop-" + osver_input.text + "-nto+armle+v7+signed.bar";
                            }
                            if (osdropdown.selectedValue == "sdkcore") {
                                os_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.winchester.sdk/" + osver_input.text + "/winchester.sdk-" + osver_input.text + "-nto+armle+v7+signed.bar";
                            }
                        }
                    }
                     }
                Option {
                    id: dropdown_stl
                    text: "Z10 STL100-2/3"
                    value: "8960"
                    onSelectedChanged: {
                        if(selected){
                            radio_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.qcfm.radio.qc8960/" + radiover_input.text + "/qc8960-" + radiover_input.text + "-nto+armle-v7+signed.bar";
                            if (osdropdown.selectedValue == "debrick") {
                                os_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8960.factory_sfi.desktop/" + osver_input.text + "/qc8960.factory_sfi.desktop-" + osver_input.text + "-nto+armle+v7+signed.bar";
                                }
                            if (osdropdown.selectedValue == "core") {
                                os_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8960.factory_sfi/" + osver_input.text + "/qc8960.factory_sfi-" + osver_input.text + "-nto+armle+v7+signed.bar";
                                }
                            if (osdropdown.selectedValue == "debrick_vzw"){
                                os_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8960.verizon_sfi.desktop/" + osver_input.text + "/qc8960.verizon_sfi.desktop-" + osver_input.text + "-nto+armle+v7+signed.bar";
                            }
                            if (osdropdown.selectedValue == "core_vzw"){
                                os_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8960.verizon_sfi/" + osver_input.text + "/qc8960.verizon_sfi-" + osver_input.text + "-nto+armle+v7+signed.bar";
                            }
                            if (osdropdown.selectedValue == "sdkdebrick") {
                                os_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8960.sdk.desktop/" + osver_input.text + "/qc8960.sdk.desktop-" + osver_input.text + "-nto+armle+v7+signed.bar";
                            }
                            if (osdropdown.selectedValue == "sdkcore") {
                                os_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8960.sdk/" + osver_input.text + "/qc8960.sdk-" + osver_input.text + "-nto+armle+v7+signed.bar";
                            }
                        }
                    }
                }
                Option {
                    id: dropdown_stl_omadm
                    text: "Z10 STL100-4"
                    value: "8960omadm"
                    onSelectedChanged: {
                        if(selected){
                            radio_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.qcfm.radio.qc8960.omadm/" + radiover_input.text + "/qc8960.omadm-" + radiover_input.text + "-nto+armle-v7+signed.bar"
                            if (osdropdown.selectedValue == "debrick") {
                                os_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8960.factory_sfi.desktop/" + osver_input.text + "/qc8960.factory_sfi.desktop-" + osver_input.text + "-nto+armle+v7+signed.bar";
                            }
                            if (osdropdown.selectedValue == "core") {
                                os_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8960.factory_sfi/" + osver_input.text + "/qc8960.factory_sfi-" + osver_input.text + "-nto+armle+v7+signed.bar";
                            }
                            if (osdropdown.selectedValue == "debrick_vzw"){
                                os_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8960.verizon_sfi.desktop/" + osver_input.text + "/qc8960.verizon_sfi.desktop-" + osver_input.text + "-nto+armle+v7+signed.bar";
                            }
                            if (osdropdown.selectedValue == "core_vzw"){
                                os_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8960.verizon_sfi/" + osver_input.text + "/qc8960.verizon_sfi-" + osver_input.text + "-nto+armle+v7+signed.bar";
                            }
                            if (osdropdown.selectedValue == "sdkdebrick") {
                                os_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8960.sdk.desktop/" + osver_input.text + "/qc8960.sdk.desktop-" + osver_input.text + "-nto+armle+v7+signed.bar";
                            }
                            if (osdropdown.selectedValue == "sdkcore") {
                                os_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8960.sdk/" + osver_input.text + "/qc8960.sdk-" + osver_input.text + "-nto+armle+v7+signed.bar";
                            }
                        }
                    }
                }
                Option {
                    id: dropdown_q10
                    text: "Q10/Q5"
                    value: "8960wtr"
                    onSelectedChanged: {
                        if(selected){
                            radio_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.qcfm.radio.qc8960.wtr/" + radiover_input.text + "/qc8960.wtr-" + radiover_input.text + "-nto+armle-v7+signed.bar"
                            if (osdropdown.selectedValue == "debrick") {
                                os_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8960.factory_sfi.desktop/" + osver_input.text + "/qc8960.factory_sfi.desktop-" + osver_input.text + "-nto+armle+v7+signed.bar";
                            }
                            if (osdropdown.selectedValue == "core") {
                                os_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8960.factory_sfi/" + osver_input.text + "/qc8960.factory_sfi-" + osver_input.text + "-nto+armle+v7+signed.bar";
                            }
                            if (osdropdown.selectedValue == "debrick_vzw"){
                                os_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8960.verizon_sfi.desktop/" + osver_input.text + "/qc8960.verizon_sfi.desktop-" + osver_input.text + "-nto+armle+v7+signed.bar";
                            }
                            if (osdropdown.selectedValue == "core_vzw"){
                                os_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8960.verizon_sfi/" + osver_input.text + "/qc8960.verizon_sfi-" + osver_input.text + "-nto+armle+v7+signed.bar";
                            }
                            if (osdropdown.selectedValue == "sdkdebrick") {
                                os_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8960.sdk.desktop/" + osver_input.text + "/qc8960.sdk.desktop-" + osver_input.text + "-nto+armle+v7+signed.bar";
                            }
                            if (osdropdown.selectedValue == "sdkcore") {
                                os_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8960.sdk/" + osver_input.text + "/qc8960.sdk-" + osver_input.text + "-nto+armle+v7+signed.bar";
                            }
                        }
                    }
                }
                Option {
                    id: dropdown_z30
                    text: "Z30"
                    value: "8960wtr5"
                    onSelectedChanged: {
                        if(selected){
                            radio_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.qcfm.radio.qc8960.wtr5/" + radiover_input.text + "/qc8960.wtr5-" + radiover_input.text + "-nto+armle-v7+signed.bar"
                            if (osdropdown.selectedValue == "debrick") {
                                os_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8960.factory_sfi.desktop/" + osver_input.text + "/qc8960.factory_sfi.desktop-" + osver_input.text + "-nto+armle+v7+signed.bar";
                            }
                            if (osdropdown.selectedValue == "core") {
                                os_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8960.factory_sfi/" + osver_input.text + "/qc8960.factory_sfi-" + osver_input.text + "-nto+armle+v7+signed.bar";
                            }
                            if (osdropdown.selectedValue == "debrick_vzw"){
                                os_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8960.verizon_sfi.desktop/" + osver_input.text + "/qc8960.verizon_sfi.desktop-" + osver_input.text + "-nto+armle+v7+signed.bar";
                            }
                            if (osdropdown.selectedValue == "core_vzw"){
                                os_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8960.verizon_sfi/" + osver_input.text + "/qc8960.verizon_sfi-" + osver_input.text + "-nto+armle+v7+signed.bar";
                            }
                            if (osdropdown.selectedValue == "sdkdebrick") {
                                os_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8960.sdk.desktop/" + osver_input.text + "/qc8960.sdk.desktop-" + osver_input.text + "-nto+armle+v7+signed.bar";
                            }
                            if (osdropdown.selectedValue == "sdkcore") {
                                os_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8960.sdk/" + osver_input.text + "/qc8960.sdk-" + osver_input.text + "-nto+armle+v7+signed.bar";
                            }
                        }
                    }
                }
                Option {
                    id: dropdown_jakarta
                    text: "Z3"
                    value: "8930wtr5"
                    onSelectedChanged: {
                        if(selected) {
                            radio_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.qcfm.radio.qc8930.wtr5/" + radiover_input.text + "/qc8930.wtr5-" + radiover_input.text + "-nto+armle-v7+signed.bar"
                            if (osdropdown.selectedValue == "debrick") {
                                os_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8960.factory_sfi.desktop/" + osver_input.text + "/qc8960.factory_sfi.desktop-" + osver_input.text + "-nto+armle+v7+signed.bar";
                            }
                            if (osdropdown.selectedValue == "core") {
                                os_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8960.factory_sfi/" + osver_input.text + "/qc8960.factory_sfi-" + osver_input.text + "-nto+armle+v7+signed.bar";
                            }
                            if (osdropdown.selectedValue == "debrick_vzw"){
                                os_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8960.verizon_sfi.desktop/" + osver_input.text + "/qc8960.verizon_sfi.desktop-" + osver_input.text + "-nto+armle+v7+signed.bar";
                            }
                            if (osdropdown.selectedValue == "core_vzw"){
                                os_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8960.verizon_sfi/" + osver_input.text + "/qc8960.verizon_sfi-" + osver_input.text + "-nto+armle+v7+signed.bar";
                            }
                            if (osdropdown.selectedValue == "sdkdebrick") {
                                os_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8960.sdk.desktop/" + osver_input.text + "/qc8960.sdk.desktop-" + osver_input.text + "-nto+armle+v7+signed.bar";
                            }
                            if (osdropdown.selectedValue == "sdkcore") {
                                os_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8960.sdk/" + osver_input.text + "/qc8960.sdk-" + osver_input.text + "-nto+armle+v7+signed.bar";
                            }
                        }
                    }
                }
            }
            Divider {
                accessibility.name: ""
            
            }
            Label {
                id: os_download_label
                text: "OS Link"
            }
            TextArea {
                id: os_download_textarea
                text: ""
                editable: false
                visible: true
                content.flags: TextContentFlag.ActiveText
            }
            Divider {
                accessibility.name: ""
            }
            Label {
                id: radio_download_label
                text: "Radio Link"
            }
            TextArea {
                id: radio_download_textarea
                text: ""
                editable: false
                visible: true
                content.flags: TextContentFlag.ActiveText
            }
            Button {
                id: resetbutton
                accessibility.name: ""
                text: "Reset Dropdowns"
                onClicked: {
                    radio_download_textarea.resetText()
                    os_download_label.text = "OS Link"
                    os_download_textarea.resetText()
                    osdropdown.resetSelectedOption()
                    devicedropdown.resetSelectedOption()
                }
                
            }
        }
    }

}
