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
        },
        SimCardInfo {
            id: siminfo
        }
    ]
    ScrollView {
        scrollViewProperties.scrollMode: ScrollMode.Vertical
        scrollViewProperties.overScrollEffectMode: OverScrollEffectMode.None
        scrollViewProperties.pinchToZoomEnabled: false
        Container {
            Container {
                topPadding: 20.0
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
                    text: qsTr("PIN: ") + Retranslate.onLanguageChanged + hardwareinfo.pin;
                }
                Label {
                    text: qsTr("Hardware ID: ") + Retranslate.onLanguageChanged + hardwareinfo.hardwareId;
                }
                Label {
                    text: qsTr("HDMI: ") + Retranslate.onLanguageChanged + (hardwareinfo.hdmiConnector == 2 ? qsTr("Micro HDMI") + Retranslate.onLanguageChanged : (hardwareinfo.hdmiConnector == 1 ? qsTr("None") + Retranslate.onLanguageChanged : qsTr("Bad or Unknown")))
                }
                Label {
                    text: qsTr("IMEI: ") + Retranslate.onLanguageChanged + hardwareinfo.imei;
                }
                Label {
                    text: qsTr("MEID: ") + Retranslate.onLanguageChanged + hardwareinfo.meid;
                }
                Label {
                    text: qsTr("Serial Number: ") + Retranslate.onLanguageChanged + hardwareinfo.serialNumber;
                }
            }          
            Container {
                topPadding: 20.0
                Header {
                    title: qsTr("SIM Card") + Retranslate.onLanguageChanged
                }
                Label {
                    text: qsTr("Mobile Country Code (MCC): ") + Retranslate.onLanguageChanged + siminfo.mobileCountryCode;
                }
                Label {
                    text: qsTr("Mobile Network Code (MNC): ") + Retranslate.onLanguageChanged + siminfo.mobileNetworkCode;
                }
                Label {
                    text: qsTr("Serial Number: ") + Retranslate.onLanguageChanged + siminfo.serialNumber;
                }
            }
            Container {
                topPadding: 20.0
                Header {
                    title: qsTr("Memory") + Retranslate.onLanguageChanged
                }
                Label {
                    text: qsTr("Free Device Memory: ") + Retranslate.onLanguageChanged + memoryinfo.availableDeviceMemory().toLocaleString() + qsTr(" bytes") + Retranslate.onLanguageChanged
                }
                Label {
                    text: qsTr("Total Device Memory: ") + Retranslate.onLanguageChanged + memoryinfo.totalDeviceMemory().toLocaleString() + qsTr(" bytes") + Retranslate.onLanguageChanged
                }
            }
            Container {
                topPadding: 20.0
                Header {
                    title: qsTr("Battery") + Retranslate.onLanguageChanged
                }
                Label {
                    text: qsTr("Condition: ") + Retranslate.onLanguageChanged + (battinfo.condition == 1 ? qsTr("OK") + Retranslate.onLanguageChanged : qsTr("Bad or Unknown") + Retranslate.onLanguageChanged)
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
            }
            Container {
                topPadding: 20.0
                bottomPadding: 20.0
                Header {
                    title: qsTr("Versions") + Retranslate.onLanguageChanged
                }
                Label {
                    text: _manager.readTextFile("/base/svnrev", "firstline")
                }
                Label {
                    text: qsTr ("OS Version: ") + Retranslate.onLanguageChanged + _manager.readTextFile("/base/etc/os.version", "normal")
                }
                Label {
                    text: qsTr("Radio Version: ") + Retranslate.onLanguageChanged + _manager.readTextFile("/radio/etc/radio.version", "normal")
                }
                Label {
                    text: qsTr("NFC Firmware: ") + Retranslate.onLanguageChanged + _manager.readTextFile("/var/etc/nfc/nfcFirmware.version", "normal")
                }
                Label {
                    text: qsTr("NFC Stack: ") + Retranslate.onLanguageChanged + _manager.readTextFile("/var/etc/nfc/nfcStack.version", "normal")
                }
                Label {
                    text: qsTr("Adobe Flash: ") + Retranslate.onLanguageChanged + _manager.readTextFile("/base/etc/flash.version", "normal")
                }
                Label {
                    text: qsTr("Adobe AIR: ") + Retranslate.onLanguageChanged + _manager.readTextFile("/base/etc/air.version", "normal")
                }
                Label {
                    text: qsTr("WiFi: ") + Retranslate.onLanguageChanged + _manager.readTextFile("/base/etc/wifi.version", "normal")
                }
                Label {
                    text: qsTr("Webkit: ") + Retranslate.onLanguageChanged + _manager.readTextFile("/base/etc/webkit.version", "normal")
                }
            }
            Header {
                title: qsTr("Device Properties") + Retranslate.onLanguageChanged
            }
            Label {
                text: _manager.readTextFile("/pps/services/deviceproperties", "normal")
                multiline: true
            }
            Header {
                title: qsTr("Hardware Info") + Retranslate.onLanguageChanged
            }
            Label {
                text: _manager.readTextFile("/pps/services/hw_info/inventory", "normal")
                multiline: true
            }
            Header {
                title: qsTr("Development Mode") + Retranslate.onLanguageChanged
            }
            Label {
                text: _manager.readTextFile("/pps/system/development/devmode", "normal")
                multiline: true
            }
        }
    }
}
