/*Autolookup.qml
 ---------------
 Keep tapping that button to get some SW/OS pairs. Export your findings to a text file, if you want.
 
 --Thurask*/

import bb.cascades 1.2
import bb.system 1.2

import "js/functions.js" as Functions

Page {
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
                    Functions.autoLookup();
                }
            }
            Button {
                id: autoclearbutton
                text: "Clear"
                onClicked: {
                    outputtext.text = "";
                    autolookup_input.text = "";
                }
            }
            Button {
                id: autoexportbutton
                text: "Export"
                attachedObjects: [
                    SystemToast {
                        id: lookupexporttoast
                        body: "Lookups saved to /downloads/bbdownloader"
                    }   
                ]
                onClicked: {
                    _swlookup.saveTextFile(outputtext.text);
                    lookupexporttoast.show();
                }
            }
        }
        Header {
            title: "Results"
        }
        Container {
            ScrollView {
                scrollViewProperties.scrollMode: ScrollMode.Vertical
                scrollViewProperties.pinchToZoomEnabled: false
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