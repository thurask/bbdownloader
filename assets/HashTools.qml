/*HashTools.qml
 --------------
 This page looks familiar.
 
 --Thurask*/

import bb.cascades 1.2
import bb.cascades.pickers 1.0
import bb.system 1.2

Page {
    property bool pickermode
    property string hashmode
    attachedObjects: [
        FilePicker {
            id: picker
            property string selectedFile
            title: "File Picker"
            mode: FilePickerMode.Picker
            type: FileType.Other
            viewMode: FilePickerViewMode.Default
            sortBy: FilePickerSortFlag.Default
            sortOrder: FilePickerSortOrder.Default
            onFileSelected: {
                selectedFile = selectedFiles[0]
            }
        },
        SystemToast {
            id: hashToast
            body: ""
        }
    ]
    Container {
        layout: StackLayout {
            orientation: LayoutOrientation.TopToBottom
        }
        Container {
            layout: StackLayout {
                orientation: LayoutOrientation.LeftToRight
            }
            horizontalAlignment: HorizontalAlignment.Center
            Label {
                text: "File mode:"
                verticalAlignment: VerticalAlignment.Center
            }
            ToggleButton {
                id: togglebutton
                verticalAlignment: VerticalAlignment.Center
                onCheckedChanged: {
                    if (checked == true){
                        pickermode = true;
                    }
                    else {
                        pickermode = false;
                    }
                }
            }
        }
        Divider {        
        }
        Container {
            topPadding: 20.0
            id: textmodecontainer
            visible: (pickermode == false)
            Label {
                text: "Enter text:"
            }
            TextField {
                id: hashinput
                hintText: "Text to be hashed"
            }
        }
        Container {
            topPadding: 20.0
            id: pickermodecontainer
            visible: (pickermode == true)
            layout: StackLayout {
                orientation: LayoutOrientation.TopToBottom
            }
            horizontalAlignment: HorizontalAlignment.Center
            Container {
                layout: StackLayout {
                    orientation: LayoutOrientation.LeftToRight
                }
                horizontalAlignment: HorizontalAlignment.Center
                Button {
                    text: "Choose a file"
                    onClicked: {
                        resultLabel.visible = true;
                        picker.open();
                    }
                }
            }
            Label {
                id: resultLabel
                horizontalAlignment: HorizontalAlignment.Center
                text: qsTr("Selected file: %1").arg(picker.selectedFile)
                multiline: true
            }         
        }
        Container {
            topPadding: 50.0
            layout: StackLayout {
                orientation: LayoutOrientation.TopToBottom
            }
            Label {
                horizontalAlignment: HorizontalAlignment.Center
                verticalAlignment: VerticalAlignment.Center
                text: "Be patient with large files"
                visible: (pickermode == true)
            }
            Divider {
            }
            Container {
                topPadding: 10.0
                layout: StackLayout {
                    orientation: LayoutOrientation.LeftToRight
                }
                Button {
                    text: "MD4"
                    horizontalAlignment: HorizontalAlignment.Left
                    onClicked: {
                        hashmode = "MD4";
                        hashoutput_label.text = "Hashed output (MD4):";
                        if (pickermode == false){
                            hashCalculateMd4.calculateHash(hashinput.text);
                            hashoutput.text = hashCalculateMd4.getHash();
                        }
                        else {
                            hashCalculateMd4.calculateFileHash(picker.selectedFile);
                            hashoutput.text = hashCalculateMd4.getHash();
                        }
                    }
                }
                Button {
                    text: "SHA-1"
                    horizontalAlignment: HorizontalAlignment.Center
                    onClicked: {
                        hashmode = "SHA1"
                        hashoutput_label.text = "Hashed output (SHA-1):";
                        if (pickermode == false){
                            hashCalculateSha.calculateHash(hashinput.text);
                            hashoutput.text = hashCalculateSha.getHash();
                        }
                        else {
                            hashCalculateSha.calculateFileHash(picker.selectedFile);
                            hashoutput.text = hashCalculateSha.getHash();
                        }
                    }  
                }
                Button {
                    text: "MD5"
                    horizontalAlignment: HorizontalAlignment.Right
                    onClicked: {
                        hashmode = "MD5"
                        hashoutput_label.text = "Hashed output (MD5):";
                        if (pickermode == false ){
                            hashCalculateMd5.calculateHash(hashinput.text);
                            hashoutput.text = hashCalculateMd5.getHash();
                        }
                        else {
                            hashCalculateMd5.calculateFileHash(picker.selectedFile);
                            hashoutput.text = hashCalculateMd5.getHash();
                        }
                    }  
                }
            }
        }
        Container {
            topPadding: 50.0
            layout: StackLayout {
                orientation: LayoutOrientation.TopToBottom
            }
            Label {
                id: hashoutput_label
                text: "Hashed output:"
            }
            TextArea {
                id: hashoutput
                editable: false
            }
            Container {
                horizontalAlignment: HorizontalAlignment.Center
                layout: StackLayout {
                    orientation: LayoutOrientation.LeftToRight
                }
                Button {                   
                    id: exportbutton
                    text: "Export to file"
                    onClicked: {
                        hashToast.body = "Hash saved to /downloads/bbdownloader";            
                        hashToast.show();
                        if (togglebutton.checked == false){
                            var exporthash = (hashinput.text + " -- " + hashoutput.text);
                            _manager.saveTextFile(exporthash, hashmode);
                        }
                        if (togglebutton.checked == true){
                            var exporthash_file = (picker.selectedFile + " -- " + hashoutput.text);
                            _manager.saveTextFile(exporthash_file, hashmode);
                        }
                    }
                }
                Button {
                    id: clipboardbutton
                    text: "Copy to clipboard"
                    onClicked: {
                        hashToast.body = "Hash copied to clipboard";
                        hashToast.show();
                        Clipboard.copyToClipboard(hashoutput.text);
                    }
                }
            }
        }
    }
}