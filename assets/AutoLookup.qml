/*Autolookup.qml
 ---------------
Get some SW/OS pairs. Export your findings to a text file, if you want.
 
 --Thurask*/

import bb.cascades 1.3
import bb.system 1.2
import qt.timer 1.0

import "js/functions.js" as JScript

Page {
    property bool scanning: false
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
        },
        Invocation {
            id: myQuery
            query {
                mimeType: "text/plain"
                data: outputtext.text
                invokeActionId: "bb.action.SHARE"
                onQueryChanged: {
                    myQuery.query.updateQuery()
                }
            }
        }
    ]
    Container {
        Header {
            title: qsTr("Input") + Retranslate.onLanguageChanged
        }
        Container {
            topPadding: 20.0
            layout: StackLayout {
                orientation: LayoutOrientation.LeftToRight
            }
            Label {
                text: qsTr("OS Version:") + Retranslate.onLanguageChanged
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
                hintText: qsTr("Enter OS version") + Retranslate.onLanguageChanged
            }
        }
        DropDown {
            id: timeoutdropdown
            title: qsTr("Lookup Interval") + Retranslate.onLanguageChanged
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
                text: qsTr("Start/Stop") + Retranslate.onLanguageChanged
                onClicked: {
                    if (scanning == false) {
                        timer.start();
                        scanning = true;
                    }
                    else {
                        timer.stop();
                        scanning = false;
                    }
                }
            }
            Button {
                id: autoclearbutton
                text: qsTr("Clear") + Retranslate.onLanguageChanged
                onClicked: {
                    timer.stop();
                    outputtext.storedtext = outputtext.text;
                    outputtext.text = "";
                    lookupexporttoast.body = qsTr("Cleared") + Retranslate.onLanguageChanged;
                    lookupexporttoast.button.enabled = true;
                    lookupexporttoast.button.label = qsTr("Undo") + Retranslate.onLanguageChanged;
                    lookupexporttoast.show();
                }
            }
            Button {
                id: autosharebutton
                text: qsTr("Share") + Retranslate.onLanguageChanged
                onClicked: {
                    myQuery.trigger(myQuery.query.invokeActionId)
                }
            }
            Button {
                id: autoexportbutton
                text: qsTr("Export") + Retranslate.onLanguageChanged
                onClicked: {
                    _manager.saveTextFile(outputtext.text, "Lookup");
                    lookupexporttoast.body = qsTr("Lookups saved to /downloads/bbdownloader") + Retranslate.onLanguageChanged;
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
                scrollViewProperties.overScrollEffectMode: OverScrollEffectMode.None
                TextArea {
                    property string storedtext
                    text: ""
                    editable: false
                    id: outputtext
                    textFormat: TextFormat.Plain
                    content.flags: TextContentFlag.ActiveTextOff
                }
            }
        }
    }  
}