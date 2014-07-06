/*Autolookup.qml
 ---------------
Get some SW/OS pairs. Export your findings to a text file, if you want.
 
 --Thurask*/

import bb.cascades 1.2
import bb.system 1.2
import qt.timer 1.0

import "js/functions.js" as JScript

Page {
    attachedObjects: [
        QTimer{
            id: timer
            //set interval
            interval: 500
            onTimeout:{
                JScript.autoLookup();
                timer.restart();
            }
        },
        SystemToast {
            id: lookupexporttoast
            body: ""
            button.enabled: false
            button.label: ""
            onFinished: {
                if (lookupexporttoast.result == SystemUiResult.ButtonSelection){
                    outputtext.setText(outputtext.storedtext);
                }
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
        DropDown {
            id: timeoutdropdown
            title: "Lookup Interval"
            Option {
                id: quartersecond
                text: "250 ms"
                value: 250
            }
            Option {
                id: halfsecond
                text: "500 ms"
                value: 500
                selected: true
            }
            Option {
                id: threequartersecond
                text: "750 ms"
                value: 750
            }
            Option {
                id: fullsecond
                text: "1000 ms"
                value: 1000
            }
            onSelectedOptionChanged: {
                timer.interval = timeoutdropdown.selectedValue;
            }
        }
        Container {
            layout: StackLayout {
                orientation: LayoutOrientation.LeftToRight
            }
            horizontalAlignment: HorizontalAlignment.Center
            Button {
                id: autolookupbutton
                text: "Start"
                onClicked: {
                    JScript.autoLookup();
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
                    timer.stop();
                    outputtext.storedtext = outputtext.text;
                    outputtext.text = "";
                    lookupexporttoast.body = "Cleared";
                    lookupexporttoast.button.enabled = true;
                    lookupexporttoast.button.label = "Undo";
                    lookupexporttoast.show();
                }
            }
            Button {
                id: autoexportbutton
                text: "Export"
                onClicked: {
                    _manager.saveTextFile(outputtext.text, "Lookup");
                    lookupexporttoast.body = "Lookups saved to /downloads/bbdownloader";
                    lookupexporttoast.button.enabled = false;
                    lookupexporttoast.button.label = "";
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
                    property string storedtext
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