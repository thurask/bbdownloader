/*SysInfo.qml
 -------------
Reads device information.
 
 --Thurask*/

import bb.cascades 1.3
import bb.device 1.2
import bb 1.0

Page {
    attachedObjects: [
        HardwareInfo {
            id: hardwareinfo
        },
        MemoryInfo {
            id: memoryinfo
        },
        BatteryInfo {
            id: battinfo
        }
    ]
    ScrollView {
        scrollViewProperties.scrollMode: ScrollMode.Vertical
        scrollViewProperties.overScrollEffectMode: OverScrollEffectMode.None
        scrollViewProperties.pinchToZoomEnabled: false
        Container {
            id: maincontainer
            Header {
                title: qsTr("Hardware") + Retranslate.onLanguageChanged
            }
            Label {
                text: qsTr("Device Name: ") + Retranslate.onLanguageChanged + hardwareinfo.deviceName;
            }
            Label {
                text: qsTr("Model Name: ") + Retranslate.onLanguageChanged + hardwareinfo.modelName;
            }
            Label {
                text: qsTr("Model Number: ") + Retranslate.onLanguageChanged + hardwareinfo.modelNumber;
            }
            Label {
                text: "PIN: " + hardwareinfo.pin;
            }
            Label {
                text: qsTr("Hardware ID: ") + hardwareinfo.hardwareId;
            }
            Label {
                text: "IMEI: " + hardwareinfo.imei;
            }
            Label {
                text: "MEID: " + hardwareinfo.meid;
            }
            Label {
                text: qsTr("Serial Number: ") + Retranslate.onLanguageChanged + hardwareinfo.serialNumber;
            }
            Header {
                title: qsTr("Memory") + Retranslate.onLanguageChanged
            }
            Label {
                text: qsTr("Free Device Memory: ") + Retranslate.onLanguageChanged + memoryinfo.availableDeviceMemory().toLocaleString() + qsTr(" bytes") + Retranslate.onLanguageChanged
            }
            Label {
                text: qsTr("Total Device Memory: ") + Retranslate.onLanguageChanged + memoryinfo.totalDeviceMemory().toLocaleString() + qsTr(" bytes") + Retranslate.onLanguageChanged
            }
            Header {
                title: qsTr("Battery") + Retranslate.onLanguageChanged
            }
            Label {
                text: qsTr("Condition: ") + Retranslate.onLanguageChanged + (battinfo.condition == 1 ? "OK" : "Bad or Unknown")
            }
            Label {
                text: qsTr("Remaining: ") + Retranslate.onLanguageChanged + battinfo.level + "%"
            }
            Label {
                text: qsTr("Cycle Count: ") + Retranslate.onLanguageChanged + battinfo.cycleCount
            }
            Label {
                text: qsTr("Temperature: ") + Retranslate.onLanguageChanged + battinfo.temperature + "°C (" + (1.8 * (battinfo.temperature) + 32) + "°F)"
            }
            Header {
                title: qsTr("Device Properties") + Retranslate.onLanguageChanged
            }
            WebView {
                url: "file:///pps/services/deviceproperties"
            }
            Header {
                title: qsTr("Hardware Info") + Retranslate.onLanguageChanged
            }
            WebView {
                url: "file:///pps/services/hw_info/inventory"
            }
            Header {
                title: qsTr("Versions") + Retranslate.onLanguageChanged
            }
            Container {
                background: Color.White
                Label {
                    text: "Adobe Flash"
                    textStyle.color: Color.Black
                }
                WebView {
                    url: "file:///base/etc/flash.version"
                }
                Label {
                    text: "Adobe AIR"
                    textStyle.color: Color.Black
                }
                WebView {
                    url: "file:///base/etc/air.version"
                }
                Label {
                    text: "WiFi"
                    textStyle.color: Color.Black
                }
                WebView {
                    url: "file:///base/etc/wifi.version"
                }
                Label {
                    text: "Webkit"
                    textStyle.color: Color.Black
                }
                WebView {
                    url: "file:///base/etc/webkit.version"
                }
            }
            Header {
                title: qsTr("Development Mode") + Retranslate.onLanguageChanged
            }
            WebView {
                url: "file:///pps/system/development/devmode"
            }
        }
    }
}
