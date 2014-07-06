/*SysInfo.qml
 -------------
Reads device information.
 
 --Thurask*/

import bb.cascades 1.2
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
            function numberWithCommas(x) {
                var parts = x.toString().split(".");
                parts[0] = parts[0].replace(/\B(?=(\d{3})+(?!\d))/g, ",");
                return parts.join(".");
            }
            Header {
                title: "Hardware"
            }
            Label {
                text: "Device Name: " + hardwareinfo.deviceName;
            }
            Label {
                text: "Model Name: " + hardwareinfo.modelName;
            }
            Label {
                text: "Model Number: " + hardwareinfo.modelNumber;
            }
            Label {
                text: "PIN: " + hardwareinfo.pin;
            }
            Label {
                text: "HWID: " + hardwareinfo.hardwareId;
            }
            Label {
                text: "IMEI: " + hardwareinfo.imei;
            }
            Label {
                text: "MEID: " + hardwareinfo.meid;
            }
            Label {
                text: "Serial Number: " + hardwareinfo.serialNumber;
            }
            Header {
                title: "Memory"
            }
            Label {
                text: "Free Device Memory: " + maincontainer.numberWithCommas(memoryinfo.availableDeviceMemory()) + " bytes"
            }
            Label {
                text: "Total Device Memory: " + maincontainer.numberWithCommas(memoryinfo.totalDeviceMemory()) + " bytes"
            }
            Header {
                title: "Battery"
            }
            Label {
                text: "Condition: " + (battinfo.condition == 1 ? "OK" : "Bad or Unknown")
            }
            Label {
                text: "Remaining: " + battinfo.level + "%"
            }
            Label {
                text: "Cycle Count: " + battinfo.cycleCount
            }
            Label {
                text: "Temperature: " + battinfo.temperature + "°C (" + (1.8 * (battinfo.temperature) + 32) + "°F)"
            }
        }
    }
}
