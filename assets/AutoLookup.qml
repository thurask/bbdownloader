/*Autolookup.qml
 ---------------
 Keep tapping that button to get some SW/OS pairs. Export your findings to a text file, if you want.
 
 --Thurask*/

import bb.cascades 1.2
import bb.system 1.2
import qt.timer 1.0

import "js/functions.js" as Functions

Page {
    attachedObjects: [
        QTimer{
            id: timer
            //set interval
            interval: 500
            onTimeout:{
                Functions.autoLookup();
                timer.restart();
            }
        }
    ]
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
        Container {
            topPadding: 20.0
            layout: StackLayout {
                orientation: LayoutOrientation.LeftToRight
            }
            horizontalAlignment: HorizontalAlignment.Center
            Button {
                id: autolookupbutton
                text: "Start"
                onClicked: {
                    timer.start();
                }
            }
            Button {
                id: autostopbutton
                text: "Stop"
                onClicked: {
                    timer.stop();
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
                    _manager.saveTextFile(outputtext.text, "Lookup");
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