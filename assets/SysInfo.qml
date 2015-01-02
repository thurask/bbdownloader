/*SysInfo.qml
 -------------
 Reads device information.
 
 --Thurask*/

import bb.cascades 1.4
import bb.device 1.4
import bb 1.3

Page {
    property bool sanitized: false
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
        },
        DisplayInfo {
            id: dispinfo
        },
        FileSystemInfo {
            id: fsinfo
        }
    ]
    actions: [
        ActionItem {
            id: sanitizer
            title: qsTr("Hide Personal Info") + Retranslate.onLanguageChanged
            onTriggered: {
                if (sanitized == false){
                    sanitized = true
                    sanitizer.title = qsTr("Show Personal Info") + Retranslate.onLanguageChanged
                    pin.visible = false
                    imei.visible = false
                    meid.visible = false
                    serial.visible = false
                    mcc.visible = false
                    mnc.visible = false
                    simsn.visible = false
                    rxid.visible = false
                    dispname.visible = false
                    devmode.visible = false
                }
                else {
                    sanitized = false
                    sanitizer.title = qsTr("Hide Personal Info") + Retranslate.onLanguageChanged
                    pin.visible = true
                    imei.visible = true
                    meid.visible = true
                    serial.visible = true
                    mcc.visible = true
                    mnc.visible = true
                    simsn.visible = true
                    rxid.visible = true
                    dispname.visible = true
                    devmode.visible = true
                }
            }
            ActionBar.placement: ActionBarPlacement.Signature
            imageSource: "asset:///images/menus/ic_contact.png"
        }
    ]
    ScrollView {
        scrollViewProperties.scrollMode: ScrollMode.Vertical
        scrollViewProperties.overScrollEffectMode: OverScrollEffectMode.OnPinch
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
                    id: pin
                    text: qsTr("PIN: ") + Retranslate.onLanguageChanged + hardwareinfo.pin;
                }
                Label {
                    text: qsTr("Hardware ID: ") + Retranslate.onLanguageChanged + hardwareinfo.hardwareId;
                }
                Label {
                    text: qsTr("Boot Time: ") + Retranslate.onLanguageChanged + _manager.readTextFile("/var/boottime.txt", "normal");
                }
                Label {
                    text: qsTr("HDMI: ") + Retranslate.onLanguageChanged + (hardwareinfo.hdmiConnector == 2 ? qsTr("Micro HDMI") + Retranslate.onLanguageChanged : (hardwareinfo.hdmiConnector == 1 ? qsTr("None") + Retranslate.onLanguageChanged : qsTr("Bad or Unknown")))
                }
                Label {
                    id: imei
                    text: qsTr("IMEI: ") + Retranslate.onLanguageChanged + hardwareinfo.imei;
                }
                Label {
                    id: meid
                    text: qsTr("MEID: ") + Retranslate.onLanguageChanged + hardwareinfo.meid;
                }
                Label {
                    id: serial
                    text: qsTr("Serial Number: ") + Retranslate.onLanguageChanged + hardwareinfo.serialNumber;
                }
                Label {
                    text: qsTr("Physical Keyboard: ") + Retranslate.onLanguageChanged + (hardwareinfo.isPhysicalKeyboardDevice == true ? qsTr("True") + Retranslate.onLanguageChanged : qsTr("False") + Retranslate.onLanguageChanged)
                }
                Label {
                    text: qsTr("Physical Menu Button: ") + Retranslate.onLanguageChanged + (hardwareinfo.hasPhysicalMenuButton == true ? qsTr("True") + Retranslate.onLanguageChanged : qsTr("False") + Retranslate.onLanguageChanged)
                }
                Label {
                    text: qsTr("Physical Back Button: ") + Retranslate.onLanguageChanged + (hardwareinfo.hasPhysicalBackButton == true ? qsTr("True") + Retranslate.onLanguageChanged : qsTr("False") + Retranslate.onLanguageChanged)
                }
                Label {
                    text: qsTr("Physical Phone Keys: ") + Retranslate.onLanguageChanged + (hardwareinfo.hasPhysicalPhoneKeys == true ? qsTr("True") + Retranslate.onLanguageChanged : qsTr("False") + Retranslate.onLanguageChanged)
                }
                Label {
                    text: qsTr("Physical Trackpad: ") + Retranslate.onLanguageChanged + (hardwareinfo.isTrackpadDevice == true ? qsTr("True") + Retranslate.onLanguageChanged : qsTr("False") + Retranslate.onLanguageChanged)
                }
            }
            Container {
                topPadding: 20.0
                Header {
                    title: qsTr("SIM Card") + Retranslate.onLanguageChanged
                }
                Label {
                    text: qsTr("State: ") + Retranslate.onLanguageChanged + (siminfo.state == 5 ? qsTr("Ready") + Retranslate.onLanguageChanged : (siminfo.state == 4 ? qsTr("PIN Required") + Retranslate.onLanguageChanged : (siminfo.state == 3 ? qsTr("Read Error") + Retranslate.onLanguageChanged : (siminfo.state == 2 ? qsTr("Not Provisioned") + Retranslate.onLanguageChanged : (siminfo.state == 1 ? qsTr("Incompatible") + Retranslate.onLanguageChanged : qsTr("Not Detected") + Retranslate.onLanguageChanged)))))
                }
                Label {
                    id: mcc
                    text: qsTr("Mobile Country Code (MCC): ") + Retranslate.onLanguageChanged + siminfo.mobileCountryCode;
                }
                Label {
                    id: mnc
                    text: qsTr("Mobile Network Code (MNC): ") + Retranslate.onLanguageChanged + siminfo.mobileNetworkCode;
                }
                Label {
                    id: simsn
                    text: qsTr("Serial Number: ") + Retranslate.onLanguageChanged + siminfo.serialNumber;
                }
            }
            Container {
                topPadding: 20.0
                Header {
                    title: qsTr("Memory") + Retranslate.onLanguageChanged
                }
                Label {
                    text: qsTr("Total Device Memory: ") + Retranslate.onLanguageChanged + (memoryinfo.totalDeviceMemory()/1048576).toFixed(2).toLocaleString() + qsTr(" MiB") + Retranslate.onLanguageChanged
                }
                Label {
                    text: qsTr("Free Device Memory: ") + Retranslate.onLanguageChanged + (memoryinfo.availableDeviceMemory()/1048576).toFixed(2).toLocaleString() + qsTr(" MiB") + Retranslate.onLanguageChanged
                }
            }
            Container {
                topPadding: 20.0
                Header {
                    title: qsTr("Local Filesystem") + Retranslate.onLanguageChanged
                }
                Label {
                    text: qsTr("Physical Capacity: ") + Retranslate.onLanguageChanged + (fsinfo.physicalCapacity()/1000000000).toFixed(2).toLocaleString() + qsTr(" GB") + Retranslate.onLanguageChanged;
                }
                Label {
                    text: qsTr("Accessible Capacity: ") + Retranslate.onLanguageChanged + (fsinfo.fileSystemCapacity("/")/1000000000).toFixed(2).toLocaleString() + qsTr(" GB") + Retranslate.onLanguageChanged;
                }
                Label {
                    text: qsTr("Available Capacity: ") + Retranslate.onLanguageChanged + (fsinfo.availableFileSystemSpace("/")/1000000000).toFixed(2).toLocaleString() + qsTr(" GB") + Retranslate.onLanguageChanged;
                }
            }
            Container {
                topPadding: 20.0
                Header {
                    title: qsTr("SD Card") + Retranslate.onLanguageChanged
                }
                Label {
                    text: qsTr("Accessible Capacity: ") + Retranslate.onLanguageChanged + (fsinfo.fileSystemCapacity("/sdcard/external_sd/")/1000000000).toFixed(2).toLocaleString() + qsTr(" GB") + Retranslate.onLanguageChanged;
                }
                Label {
                    text: qsTr("Available Capacity: ") + Retranslate.onLanguageChanged + (fsinfo.availableFileSystemSpace("/sdcard/external_sd/")/1000000000).toFixed(2).toLocaleString() + qsTr(" GB") + Retranslate.onLanguageChanged;
                }
            }
            Container {
                topPadding: 20.0
                Header {
                    title: qsTr("Battery") + Retranslate.onLanguageChanged
                }
                Label {
                    text: qsTr("Present: ") + Retranslate.onLanguageChanged + (battinfo.present == true ? qsTr("True") + Retranslate.onLanguageChanged : qsTr("False") + Retranslate.onLanguageChanged)
                }
                Label {
                    text: qsTr("Charging State: ") + Retranslate.onLanguageChanged + (battinfo.chargingState == 4 ? qsTr("Full") + Retranslate.onLanguageChanged : (battinfo.chargingState == 3 ? qsTr("Discharging") + Retranslate.onLanguageChanged : (battinfo.chargingState == 2 ? qsTr("Charging") + Retranslate.onLanguageChanged : (battinfo.chargingState == 1 ? qsTr("Not Charging") + Retranslate.onLanguageChanged : qsTr("Bad or Unknown") + Retranslate.onLanguageChanged))))
                }
                Label {
                    text: qsTr("Condition: ") + Retranslate.onLanguageChanged + (battinfo.condition == 1 ? qsTr("OK") + Retranslate.onLanguageChanged : qsTr("Bad or Unknown") + Retranslate.onLanguageChanged)
                }
                Label {
                    text: qsTr("Full Charge Capacity: ") + Retranslate.onLanguageChanged + battinfo.fullChargeCapacity + qsTr(" mAh") + Retranslate.onLanguageChanged
                }
                Label {
                    text: qsTr("Remaining: ") + Retranslate.onLanguageChanged + battinfo.level + "%"
                }
                Label {
                    text: qsTr("Cycle Count: ") + Retranslate.onLanguageChanged + battinfo.cycleCount
                }
                Label {
                    text: qsTr("Temperature: ") + Retranslate.onLanguageChanged + battinfo.temperature.toFixed(2) + "°C (" + parseFloat(1.8 * (battinfo.temperature) + 32).toFixed(2) + "°F)"
                }
                Label {
                    id: rxid
                    text: qsTr("RxID: ") + Retranslate.onLanguageChanged + battinfo.rxid
                }
            }
            Container {
                topPadding: 20.0
                Header {
                    title: qsTr("Display") + Retranslate.onLanguageChanged
                }
                Label {
                    text: qsTr("Aspect: ") + Retranslate.onLanguageChanged + (dispinfo.aspectType == 2 ? qsTr("Square") + Retranslate.onLanguageChanged : (dispinfo.aspectType == 1 ? qsTr("Portrait") + Retranslate.onLanguageChanged : qsTr("Landscape") + Retranslate.onLanguageChanged))
                }
                Label {
                    text: qsTr("Physical Size: ") + Retranslate.onLanguageChanged + dispinfo.physicalSize.height.toFixed(2) + qsTr(" mm x ") + Retranslate.onLanguageChanged + dispinfo.physicalSize.width.toFixed(2) + qsTr(" mm") + Retranslate.onLanguageChanged
                }
                Label {
                    text: qsTr("Diagonal: ") + Retranslate.onLanguageChanged + Math.sqrt(Math.pow(dispinfo.physicalSize.height, 2) + Math.pow(dispinfo.physicalSize.width, 2)).toFixed(2) + qsTr(" mm") + Retranslate.onLanguageChanged //Yeah, Mr. Pythagoras! Yeah, math!
                }
                Label {
                    text: qsTr("Pixel Size: ") + Retranslate.onLanguageChanged + dispinfo.pixelSize.height.toFixed(2) + qsTr(" px x ") + Retranslate.onLanguageChanged + dispinfo.pixelSize.width.toFixed(2) + qsTr(" px") + Retranslate.onLanguageChanged
                }
                Label {
                    text: qsTr("Resolution: ") + Retranslate.onLanguageChanged + dispinfo.resolution.height.toFixed(2) + qsTr(" px/m x ") + Retranslate.onLanguageChanged + dispinfo.resolution.width.toFixed(2) + qsTr(" px/m") + Retranslate.onLanguageChanged
                }
                Label {
                    text: qsTr("Technology: ") + Retranslate.onLanguageChanged + (dispinfo.displayTechnology == 0 ? qsTr("Bad or Unknown") + Retranslate.onLanguageChanged : (dispinfo.displayTechnology == 1 ? qsTr("LCD") + Retranslate.onLanguageChanged : (dispinfo.displayTechnology == 2 ? qsTr("OLED") + Retranslate.onLanguageChanged : (dispinfo.displayTechnology == 3 ? qsTr("CRT") + Retranslate.onLanguageChanged : (dispinfo.displayTechnology == 4 ? qsTr("Plasma") + Retranslate.onLanguageChanged : qsTr("LED") + Retranslate.onLanguageChanged)))))
                }
                Label {
                    id: dispname
                    text: qsTr("Display Name: ") + Retranslate.onLanguageChanged + dispinfo.displayName
                }
                Label {
                    text: qsTr("Attached: ") + Retranslate.onLanguageChanged + (dispinfo.attached == true ? qsTr("True") + Retranslate.onLanguageChanged : qsTr("False") + Retranslate.onLanguageChanged)
                }
                Label {
                    text: qsTr("Detachable: ") + Retranslate.onLanguageChanged + (dispinfo.detachable == true ? qsTr("True") + Retranslate.onLanguageChanged  : qsTr("False") + Retranslate.onLanguageChanged)
                }
                Label {
                    text: qsTr("Wireless: ") + Retranslate.onLanguageChanged + (dispinfo.wireless == true ? qsTr("True") + Retranslate.onLanguageChanged  : qsTr("False") + Retranslate.onLanguageChanged)
                }
            }
            Container {
                topPadding: 20.0
                bottomPadding: 20.0
                Header {
                    title: qsTr("Versions") + Retranslate.onLanguageChanged
                }
                Label {
                    text: qsTr("Build ID: ") + Retranslate.onLanguageChanged + _manager.readTextFile("/base/svnrev", "firstline").slice(9)
                }
                Label {
                    text: qsTr("Build Branch: ") + Retranslate.onLanguageChanged + _manager.readTextFile("/base/svnrev", "branch").slice(13)
                }
                Label {
                    text: qsTr("OS Version: ") + Retranslate.onLanguageChanged + _manager.readTextFile("/base/etc/os.version", "normal")
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
                    visible: false
                }
                Label {
                    text: qsTr("WiFi: ") + Retranslate.onLanguageChanged + _manager.readTextFile("/base/etc/wifi.version", "normal")
                }
                Label {
                    text: qsTr("Webkit: ") + Retranslate.onLanguageChanged + _manager.readTextFile("/base/etc/webkit.version", "normal")
                }
            }
            Container {
                Header {
                    title: qsTr("Device Properties") + Retranslate.onLanguageChanged
                }
                Label {
                    text: _manager.readTextFile("/pps/services/deviceproperties", "normal")
                    multiline: true
                }
            }
            Container {
                Header {
                    title: qsTr("Hardware Info") + Retranslate.onLanguageChanged
                }
                Label {
                    text: _manager.readTextFile("/pps/services/hw_info/inventory", "normal")
                    multiline: true
                }
            }
            Container {
                id: devmode
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
}
