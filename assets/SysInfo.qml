/*SysInfo.qml
 * -------------
 * Reads device information.
 * 
 --Thurask*/

import bb.cascades 1.4
import bb.device 1.4
import bb 1.3
import "js/SysInfo.js" as JScript

Page {
    id: sysinfopage
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
        },
        CellularRadioInfo {
            id: crinfo
        },
        CellularNetworkInfo {
            id: cninfo
        },
        WebView {
            id: dummywebview
        }
    ]
    actions: [
        ActionItem {
            id: sanitizer
            title: qsTr("Hide Personal") + Retranslate.onLanguageChanged
            onTriggered: {
                if (sanitized == false) {
                    sanitized = true
                    sanitizer.title = qsTr("Show Personal") + Retranslate.onLanguageChanged
                    pin.visible = false
                    imei.visible = false
                    meid.visible = false
                    serial.visible = false
                    mcc.visible = false
                    mnc.visible = false
                    celldispname.visible = false
                    cellname.visible = false
                    cellmcc.visible = false
                    cellmnc.visible = false
                    simsn.visible = false
                    rxid.visible = false
                    dispname.visible = false
                    devmode.visible = false
                } else {
                    sanitized = false
                    sanitizer.title = qsTr("Hide Personal") + Retranslate.onLanguageChanged
                    pin.visible = true
                    imei.visible = true
                    meid.visible = true
                    serial.visible = true
                    mcc.visible = true
                    mnc.visible = true
                    celldispname.visible = true
                    cellname.visible = true
                    cellmcc.visible = true
                    cellmnc.visible = true
                    simsn.visible = true
                    rxid.visible = true
                    dispname.visible = true
                    devmode.visible = true
                }
            }
            ActionBar.placement: ActionBarPlacement.Signature
            imageSource: "asset:///images/menus/ic_contact.png"
        },
        ActionItem {
            title: qsTr("Refresh") + Retranslate.onLanguageChanged
            onTriggered: {
                cellstrength.text = qsTr("Signal Strength: %1 dBm").arg(cninfo.signalStrength) + Retranslate.onLanguageChanged
                uptime.text = qsTr("Uptime: %1").arg(JScript.getUptime()) + Retranslate.onLanguageChanged
                freemem.text = qsTr("Free Device Memory: %1 MiB").arg((memoryinfo.availableDeviceMemory() / 1048576).toFixed(2).toLocaleString()) + Retranslate.onLanguageChanged
                sdavcap.text = qsTr("Available Capacity: %1 GB").arg((fsinfo.availableFileSystemSpace("/sdcard/external_sd/") / 1000000000).toFixed(2).toLocaleString()) + Retranslate.onLanguageChanged
                temp.text = qsTr("Temperature: %1 °C (%2 °F)").arg(battinfo.temperature.toFixed(1)).arg(parseFloat(1.8 * (battinfo.temperature) + 32).toFixed(1)) + Retranslate.onLanguageChanged
            }
            imageSource: "asset:///images/menus/ic_reload.png"
            ActionBar.placement: ActionBarPlacement.OnBar
        }
    ]
    ScrollView {
        scrollRole: ScrollRole.Main
        scrollViewProperties.scrollMode: ScrollMode.Vertical
        scrollViewProperties.overScrollEffectMode: OverScrollEffectMode.OnPinch
        scrollViewProperties.pinchToZoomEnabled: false
        Container {
            Container {
                topPadding: ui.du(0.5)
                Header {
                    title: qsTr("Hardware") + Retranslate.onLanguageChanged
                }
                Label {
                    text: qsTr("Device Name: %1").arg(hardwareinfo.deviceName) + Retranslate.onLanguageChanged
                    multiline: true
                }
                Label {
                    text: qsTr("Model Name: %1").arg(hardwareinfo.modelName) + Retranslate.onLanguageChanged
                    multiline: true
                }
                Label {
                    text: qsTr("Model Number: %1").arg(hardwareinfo.modelNumber) + Retranslate.onLanguageChanged
                    multiline: true
                }
                Label {
                    id: pin
                    text: qsTr("PIN: %1").arg(hardwareinfo.pin) + Retranslate.onLanguageChanged
                    multiline: true
                }
                Label {
                    text: qsTr("Hardware ID: %1").arg(hardwareinfo.hardwareId) + Retranslate.onLanguageChanged
                    multiline: true
                }
                Label {
                    text: qsTr("Boot Time: %1").arg(_manager.readTextFile("/var/boottime.txt", "normsimp")) + Retranslate.onLanguageChanged
                    multiline: true
                }
                Label {
                    id: uptime
                    text: qsTr("Uptime: %1").arg(JScript.getUptime()) + Retranslate.onLanguageChanged
                    multiline: true
                }
                Label {
                    text: qsTr("HDMI: %1").arg(JScript.getHDMI(hardwareinfo.hdmiConnector)) + Retranslate.onLanguageChanged
                    multiline: true
                }
                Label {
                    id: imei
                    text: qsTr("IMEI: %1").arg(hardwareinfo.imei) + Retranslate.onLanguageChanged
                    multiline: true
                }
                Container {
                    id: meidc
                    visible: (! ! hardwareinfo.meid) //if not blank
                    Label {
                        id: meid
                        text: qsTr("MEID: %1").arg(hardwareinfo.meid) + Retranslate.onLanguageChanged
                        multiline: true
                    }
                }
                Label {
                    id: serial
                    text: qsTr("Serial Number: %1").arg(hardwareinfo.serialNumber.slice(13, 14) + "-" + hardwareinfo.serialNumber.slice(14, 18) + "-" + hardwareinfo.serialNumber.slice(18, 22)) + Retranslate.onLanguageChanged
                    multiline: true
                }
                Label {
                    text: qsTr("Physical Keyboard: %1").arg(JScript.bool2string(hardwareinfo.isPhysicalKeyboardDevice)) + Retranslate.onLanguageChanged
                    multiline: true
                }
                Label {
                    text: qsTr("Physical Menu Button: %1").arg(JScript.bool2string(hardwareinfo.hasPhysicalMenuButton)) + Retranslate.onLanguageChanged
                    multiline: true
                }
                Label {
                    text: qsTr("Physical Back Button: %1").arg(JScript.bool2string(hardwareinfo.hasPhysicalBackButton)) + Retranslate.onLanguageChanged
                    multiline: true
                }
                Label {
                    text: qsTr("Physical Phone Keys: %1").arg(JScript.bool2string(hardwareinfo.hasPhysicalPhoneKeys)) + Retranslate.onLanguageChanged
                    multiline: true
                }
                Label {
                    text: qsTr("Physical Trackpad: %1").arg(JScript.bool2string(hardwareinfo.isTrackpadDevice)) + Retranslate.onLanguageChanged
                    multiline: true
                }
            }
            Container {
                topPadding: ui.du(1.5)
                Header {
                    title: qsTr("SIM Card") + Retranslate.onLanguageChanged
                }
                Label {
                    text: qsTr("State: %1").arg(JScript.getSimState(siminfo.state)) + Retranslate.onLanguageChanged
                    multiline: true
                }
                Label {
                    id: mcc
                    text: qsTr("Mobile Country Code (MCC): %1").arg(siminfo.mobileCountryCode) + Retranslate.onLanguageChanged
                    multiline: true
                }
                Label {
                    id: mnc
                    text: qsTr("Mobile Network Code (MNC): %1").arg(siminfo.mobileNetworkCode) + Retranslate.onLanguageChanged
                    multiline: true
                }
                Label {
                    id: simsn
                    text: qsTr("Serial Number: %1").arg(siminfo.serialNumber) + Retranslate.onLanguageChanged
                    multiline: true
                }
            }
            Container {
                topPadding: ui.du(1.5)
                Header {
                    title: qsTr("Cellular Network") + Retranslate.onLanguageChanged
                }
                Label {
                    id: cellname
                    text: qsTr("Name: %1").arg(cninfo.name) + Retranslate.onLanguageChanged
                    multiline: true
                }
                Label {
                    id: celldispname
                    text: qsTr("Display Name: %1").arg(cninfo.displayName) + Retranslate.onLanguageChanged
                    multiline: true
                }
                Label {
                    id: cellmcc
                    text: qsTr("Mobile Country Code (MCC): %1").arg(cninfo.mobileCountryCode) + Retranslate.onLanguageChanged
                    multiline: true
                }
                Label {
                    id: cellmnc
                    text: qsTr("Mobile Network Code (MNC): %1").arg(cninfo.mobileNetworkCode) + Retranslate.onLanguageChanged
                    multiline: true
                }
                Label {
                    text: qsTr("Roaming: %1").arg(JScript.bool2string(cninfo.roaming)) + Retranslate.onLanguageChanged
                }
                Label {
                    id: cellstrength
                    text: qsTr("Signal Strength: %1 dBm").arg(cninfo.signalStrength) + Retranslate.onLanguageChanged
                }
                Label {
                    id: cni_supptech
                    text: qsTr("Supported Technologies: %1%2%3%4%5%6")
                    .arg(JScript.celltechBitcomp(3, 0x0))
                    .arg(JScript.celltechBitcomp(3, 0x1))
                    .arg(JScript.celltechBitcomp(3, 0x2))
                    .arg(JScript.celltechBitcomp(3, 0x4))
                    .arg(JScript.celltechBitcomp(3, 0x8))
                    .arg(JScript.celltechBitcomp(3, 0x10)) + Retranslate.onLanguageChanged
                    onCreationCompleted: {
                        cni_supptech.text = cni_supptech.text.trim()
                        while (cni_supptech.text.charAt(-1) == "," || cni_supptech.text.charAt(-1) == " ") {
                            cni_supptech.text = cni_supptech.text.slice(0, -1)
                        }
                    }
                }
                Label {
                    id: cni_suppserv
                    text: qsTr("Supported Services: %1%2%3%4%5%6%7%8%9%10%11%12%13%14%15%16%17")
                    .arg(JScript.celltechBitcomp(0, 0x0))
                    .arg(JScript.celltechBitcomp(0, 0x1))
                    .arg(JScript.celltechBitcomp(0, 0x2))
                    .arg(JScript.celltechBitcomp(0, 0x4))
                    .arg(JScript.celltechBitcomp(0, 0x100))
                    .arg(JScript.celltechBitcomp(0, 0x200))
                    .arg(JScript.celltechBitcomp(0, 0x400))
                    .arg(JScript.celltechBitcomp(0, 0x1000))
                    .arg(JScript.celltechBitcomp(0, 0x2000))
                    .arg(JScript.celltechBitcomp(0, 0x4000))
                    .arg(JScript.celltechBitcomp(0, 0x8000))
                    .arg(JScript.celltechBitcomp(0, 0x10000))
                    .arg(JScript.celltechBitcomp(0, 0x20000))
                    .arg(JScript.celltechBitcomp(0, 0x40000))
                    .arg(JScript.celltechBitcomp(0, 0x80000))
                    .arg(JScript.celltechBitcomp(0, 0x100000))
                    .arg(JScript.celltechBitcomp(0, 0x200000))+ Retranslate.onLanguageChanged
                    multiline: true
                    onCreationCompleted: {
                        cni_suppserv.text = cni_suppserv.text.trim()
                        while (cni_suppserv.text.charAt(-1) == "," || cni_suppserv.text.charAt(-1) == " ") {
                            cni_suppserv.text = cni_suppserv.text.slice(0, -1)
                        }
                    }
                }
            }
            Container {
                topPadding: ui.du(1.5)
                Header {
                    title: qsTr("Cellular Radio") + Retranslate.onLanguageChanged
                }
                Label {
                    text: qsTr("Powered On: %1").arg(JScript.bool2string(crinfo.poweredOn)) + Retranslate.onLanguageChanged
                }
                Label {
                    text: qsTr("Network Count: %1").arg(crinfo.networkCount) + Retranslate.onLanguageChanged
                }
                Label {
                    text: qsTr("Data Enabled: %1").arg(JScript.bool2string(crinfo.dataEnabled)) + Retranslate.onLanguageChanged
                }
                Label {
                    text: qsTr("Data Roaming: %1").arg(JScript.bool2string(crinfo.dataRoaming)) + Retranslate.onLanguageChanged
                }
                Label {
                    id: cri_supptech
                    text: qsTr("Supported Technologies: %1%2%3%4%5%6")
                    .arg(JScript.celltechBitcomp(0, 0x0))
                    .arg(JScript.celltechBitcomp(0, 0x1))
                    .arg(JScript.celltechBitcomp(0, 0x2))
                    .arg(JScript.celltechBitcomp(0, 0x4))
                    .arg(JScript.celltechBitcomp(0, 0x8))
                    .arg(JScript.celltechBitcomp(0, 0x10)) + Retranslate.onLanguageChanged
                    multiline: true
                    onCreationCompleted: {
                        cri_supptech.text = cri_supptech.text.trim()
                        while (cri_supptech.text.charAt(-1) == "," || cri_supptech.text.charAt(-1) == " ") {
                            cri_supptech.text = cri_supptech.text.slice(0, -1)
                        }
                    }
                }
                Label {
                    id: cri_entech
                    text: qsTr("Enabled Technologies: %1%2%3%4%5%6")
                    .arg(JScript.celltechBitcomp(1, 0x0))
                    .arg(JScript.celltechBitcomp(1, 0x1))
                    .arg(JScript.celltechBitcomp(1, 0x2))
                    .arg(JScript.celltechBitcomp(1, 0x4))
                    .arg(JScript.celltechBitcomp(1, 0x8))
                    .arg(JScript.celltechBitcomp(1, 0x10)) + Retranslate.onLanguageChanged
                    multiline: true
                    onCreationCompleted: {
                        cri_entech.text = cri_entech.text.trim()
                        while (cri_entech.text.charAt(-1) == "," || cri_entech.text.charAt(-1) == " ") {
                            cri_entech.text = cri_entech.text.slice(0, -1)
                        }
                    }
                }
                Label {
                    id: cri_acttech
                    text: qsTr("Active Technologies: %1%2%3%4%5%6")
                    .arg(JScript.celltechBitcomp(2, 0x0))
                    .arg(JScript.celltechBitcomp(2, 0x1))
                    .arg(JScript.celltechBitcomp(2, 0x2))
                    .arg(JScript.celltechBitcomp(2, 0x4))
                    .arg(JScript.celltechBitcomp(2, 0x8))
                    .arg(JScript.celltechBitcomp(2, 0x10)) + Retranslate.onLanguageChanged
                    multiline: true
                    onCreationCompleted: {
                        cri_acttech.text = cri_acttech.text.trim()
                        while (cri_acttech.text.charAt(-1) == "," || cri_acttech.text.charAt(-1) == " ") {
                            cri_acttech.text = cri_acttech.text.slice(0, -1)
                        }
                    }
                }
                Label {
                    id: cri_suppserv
                    text: qsTr("Supported Services: %1%2%3%4%5%6%7%8%9%10%11%12%13%14%15%16%17")
                    .arg(JScript.celltechBitcomp(0, 0x0))
                    .arg(JScript.celltechBitcomp(0, 0x1))
                    .arg(JScript.celltechBitcomp(0, 0x2))
                    .arg(JScript.celltechBitcomp(0, 0x4))
                    .arg(JScript.celltechBitcomp(0, 0x100))
                    .arg(JScript.celltechBitcomp(0, 0x200))
                    .arg(JScript.celltechBitcomp(0, 0x400))
                    .arg(JScript.celltechBitcomp(0, 0x1000))
                    .arg(JScript.celltechBitcomp(0, 0x2000))
                    .arg(JScript.celltechBitcomp(0, 0x4000))
                    .arg(JScript.celltechBitcomp(0, 0x8000))
                    .arg(JScript.celltechBitcomp(0, 0x10000))
                    .arg(JScript.celltechBitcomp(0, 0x20000))
                    .arg(JScript.celltechBitcomp(0, 0x40000))
                    .arg(JScript.celltechBitcomp(0, 0x80000))
                    .arg(JScript.celltechBitcomp(0, 0x100000))
                    .arg(JScript.celltechBitcomp(0, 0x200000))+ Retranslate.onLanguageChanged
                    multiline: true
                    onCreationCompleted: {
                        cri_suppserv.text = cri_suppserv.text.trim()
                        while (cri_suppserv.text.charAt(-1) == "," || cri_suppserv.text.charAt(-1) == " ") {
                            cri_suppserv.text = cri_suppserv.text.slice(0, -1)
                        }
                    }
                }
                Label {
                    id: cri_suppbands
                    text: qsTr("Supported Bands: %1%2%3%4%5%6%7%8%9%10%11%12%13%14%15%16%17%18%19%20%21%22%23%24%25%26%27")
                    .arg(JScript.cellbandsBitcomp(0x0))
                    .arg(JScript.cellbandsBitcomp(0x1))
                    .arg(JScript.cellbandsBitcomp(0x2))
                    .arg(JScript.cellbandsBitcomp(0x4))
                    .arg(JScript.cellbandsBitcomp(0x8))
                    .arg(JScript.cellbandsBitcomp(0x10))
                    .arg(JScript.cellbandsBitcomp(0x20))
                    .arg(JScript.cellbandsBitcomp(0x40))
                    .arg(JScript.cellbandsBitcomp(0x80))
                    .arg(JScript.cellbandsBitcomp(0x100))
                    .arg(JScript.cellbandsBitcomp(0x200))
                    .arg(JScript.cellbandsBitcomp(0x400))
                    .arg(JScript.cellbandsBitcomp(0x800))
                    .arg(JScript.cellbandsBitcomp(0x1000))
                    .arg(JScript.cellbandsBitcomp(0x2000))
                    .arg(JScript.cellbandsBitcomp(0x4000))
                    .arg(JScript.cellbandsBitcomp(0x8000))
                    .arg(JScript.cellbandsBitcomp(0x10000))
                    .arg(JScript.cellbandsBitcomp(0x20000))
                    .arg(JScript.cellbandsBitcomp(0x40000))
                    .arg(JScript.cellbandsBitcomp(0x80000))
                    .arg(JScript.cellbandsBitcomp(0x100000))
                    .arg(JScript.cellbandsBitcomp(0x200000))
                    .arg(JScript.cellbandsBitcomp(0x400000))
                    .arg(JScript.cellbandsBitcomp(0x800000))
                    .arg(JScript.cellbandsBitcomp(0x1000000))
                    .arg(JScript.cellbandsBitcomp(0x2000000)) + Retranslate.onLanguageChanged
                    multiline: true
                    onCreationCompleted: {
                        cri_suppbands.text = cri_suppbands.text.trim()
                        while (cri_suppbands.text.charAt(-1) == "," || cri_suppbands.text.charAt(-1) == " ") {
                            cri_suppbands.text = cri_suppbands.text.slice(0, -1)
                        }
                    }
                }
            }
            Container {
                topPadding: ui.du(1.5)
                Header {
                    title: qsTr("Memory") + Retranslate.onLanguageChanged
                }
                Label {
                    text: qsTr("Total Device Memory: %1 MiB").arg((memoryinfo.totalDeviceMemory() / 1048576).toFixed(2).toLocaleString()) + Retranslate.onLanguageChanged
                    multiline: true
                }
                Label {
                    id: freemem
                    text: qsTr("Free Device Memory: %1 MiB").arg((memoryinfo.availableDeviceMemory() / 1048576).toFixed(2).toLocaleString()) + Retranslate.onLanguageChanged
                    multiline: true
                }
            }
            Container {
                topPadding: ui.du(1.5)
                Header {
                    title: qsTr("Local Filesystem") + Retranslate.onLanguageChanged
                }
                Label {
                    text: qsTr("Physical Capacity: %1 GB").arg((fsinfo.physicalCapacity() / 1000000000).toFixed(2).toLocaleString()) + Retranslate.onLanguageChanged
                    multiline: true
                }
                Label {
                    text: qsTr("Accessible Capacity: %1 GB").arg((fsinfo.fileSystemCapacity("/") / 1000000000).toFixed(2).toLocaleString()) + Retranslate.onLanguageChanged
                    multiline: true
                }
                Label {
                    text: qsTr("Available Capacity: %1 GB").arg((fsinfo.availableFileSystemSpace("/") / 1000000000).toFixed(2).toLocaleString()) + Retranslate.onLanguageChanged
                    multiline: true
                }
            }
            Container {
                topPadding: ui.du(1.5)
                visible: (fsinfo.fileSystemCapacity("/sdcard/external_sd/") > 0)
                Header {
                    title: qsTr("SD Card") + Retranslate.onLanguageChanged
                }
                Label {
                    text: qsTr("Accessible Capacity: %1 GB").arg((fsinfo.fileSystemCapacity("/sdcard/external_sd/") / 1000000000).toFixed(2).toLocaleString()) + Retranslate.onLanguageChanged
                    multiline: true
                }
                Label {
                    id: sdavcap
                    text: qsTr("Available Capacity: %1 GB").arg((fsinfo.availableFileSystemSpace("/sdcard/external_sd/") / 1000000000).toFixed(2).toLocaleString()) + Retranslate.onLanguageChanged
                    multiline: true
                }
            }
            Container {
                topPadding: ui.du(1.5)
                Header {
                    title: qsTr("Battery") + Retranslate.onLanguageChanged
                }
                Label {
                    text: qsTr("Present: %1").arg(JScript.bool2string(battinfo.present)) + Retranslate.onLanguageChanged
                    multiline: true
                }
                Label {
                    text: qsTr("Charging State: %1").arg(JScript.getChargingState(battinfo.chargingState)) + Retranslate.onLanguageChanged
                    multiline: true
                }
                Label {
                    text: qsTr("Condition: %1").arg(JScript.getCondition(battinfo.condition)) + Retranslate.onLanguageChanged
                    multiline: true
                }
                Label {
                    text: qsTr("Full Charge Capacity: %1 mAh").arg(battinfo.fullChargeCapacity.toString()) + Retranslate.onLanguageChanged
                    multiline: true
                }
                Label {
                    text: qsTr("Remaining: %1%").arg(battinfo.level) + Retranslate.onLanguageChanged
                    multiline: true
                }
                Label {
                    text: qsTr("Cycle Count: %1").arg(battinfo.cycleCount) + Retranslate.onLanguageChanged
                    multiline: true
                }
                Label {
                    id: temp
                    text: qsTr("Temperature: %1 °C (%2 °F)").arg(battinfo.temperature.toFixed(1)).arg(parseFloat(1.8 * (battinfo.temperature) + 32).toFixed(1)) + Retranslate.onLanguageChanged
                    multiline: true
                }
                Container {
                    id: rxidc
                    visible: (battinfo.rxid == "" ? false : true)
                    Label {
                        id: rxid
                        text: qsTr("RxID: %1").arg(battinfo.rxid) + Retranslate.onLanguageChanged
                        multiline: true
                    }
                }
            }
            Container {
                topPadding: ui.du(1.5)
                Header {
                    title: qsTr("Display") + Retranslate.onLanguageChanged
                }
                Label {
                    text: qsTr("Aspect: %1").arg(JScript.getAspect(dispinfo.aspectType)) + Retranslate.onLanguageChanged
                    multiline: true
                }
                Label {
                    text: qsTr("Physical Size: %1 mm x %2 mm").arg(dispinfo.physicalSize.height.toFixed(2)).arg(dispinfo.physicalSize.width.toFixed(2)) + Retranslate.onLanguageChanged
                    multiline: true
                }
                Label {
                    text: qsTr("Diagonal: %1 mm").arg(Math.sqrt(Math.pow(dispinfo.physicalSize.height, 2) + Math.pow(dispinfo.physicalSize.width, 2)).toFixed(2)) + Retranslate.onLanguageChanged; //Yeah, Mr. Pythagoras! Yeah, math!
                    multiline: true
                }
                Label {
                    text: qsTr("Pixel Size: %1 px x %2 px").arg(dispinfo.pixelSize.height.toFixed(2)).arg(dispinfo.pixelSize.width.toFixed(2)) + Retranslate.onLanguageChanged
                    multiline: true
                }
                Label {
                    text: qsTr("Resolution: %1 px/m x %2 px/m").arg(dispinfo.resolution.height.toFixed(2)).arg(dispinfo.resolution.width.toFixed(2)) + Retranslate.onLanguageChanged
                    multiline: true
                }
                Label {
                    text: qsTr("Technology: %1").arg(JScript.getTechnology(dispinfo.displayTechnology)) + Retranslate.onLanguageChanged
                    multiline: true
                }
                Label {
                    id: dispname
                    text: qsTr("Display Name: %1").arg(dispinfo.displayName) + Retranslate.onLanguageChanged
                    multiline: true
                }
                Label {
                    text: qsTr("Attached: %1").arg(JScript.bool2string(dispinfo.attached)) + Retranslate.onLanguageChanged
                    multiline: true
                }
                Label {
                    text: qsTr("Detachable: %1").arg(JScript.bool2string(dispinfo.detachable)) + Retranslate.onLanguageChanged
                    multiline: true
                }
                Label {
                    text: qsTr("Wireless: %1").arg(JScript.bool2string(dispinfo.wireless)) + Retranslate.onLanguageChanged
                    multiline: true
                }
            }
            Container {
                topPadding: ui.du(1.5)
                bottomPadding: ui.du(1.5)
                Header {
                    title: qsTr("Versions") + Retranslate.onLanguageChanged
                }
                Label {
                    text: qsTr("OS Version: %1").arg(_manager.readTextFile("/base/etc/os.version", "normsimp")) + Retranslate.onLanguageChanged
                    multiline: true
                }
                Label {
                    text: qsTr("Build ID: %1").arg(_manager.readTextFile("/base/svnrev", "firstline").slice(9)) + Retranslate.onLanguageChanged
                    multiline: true
                }
                Label {
                    text: qsTr("Build Branch: %1").arg(_manager.readTextFile("/base/svnrev", "branch").slice(13)) + Retranslate.onLanguageChanged
                    multiline: true
                }
                Label {
                    text: qsTr("Radio Version: %1").arg(_manager.readTextFile("/radio/etc/radio.version", "normsimp")) + Retranslate.onLanguageChanged
                    multiline: true
                }
                Label {
                    text: qsTr("Build ID: %1").arg(_manager.readTextFile("/radio/svnrev", "firstline").slice(9)) + Retranslate.onLanguageChanged
                    multiline: true
                }
                Label {
                    text: qsTr("Build Branch: %1").arg(_manager.readTextFile("/radio/svnrev", "branch").slice(13)) + Retranslate.onLanguageChanged
                    multiline: true
                }
                Label {
                    text: qsTr("NFC Firmware: %1").arg(_manager.readTextFile("/var/etc/nfc/nfcFirmware.version", "normsimp")) + Retranslate.onLanguageChanged
                    multiline: true
                }
                Label {
                    text: qsTr("NFC Stack: %1").arg(_manager.readTextFile("/var/etc/nfc/nfcStack.version", "normsimp")) + Retranslate.onLanguageChanged
                    multiline: true
                }
                Label {
                    text: qsTr("User Agent: %1").arg(dummywebview.settings.userAgent) + Retranslate.onLanguageChanged
                    multiline: true
                }
                Label {
                    text: qsTr("WiFi: %1").arg(_manager.readTextFile("/base/etc/wifi.version", "normsimp")) + Retranslate.onLanguageChanged
                    multiline: true
                }
                Label {
                    text: qsTr("Webkit: %1").arg(_manager.readTextFile("/base/etc/webkit.version", "normsimp")) + Retranslate.onLanguageChanged
                    multiline: true
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
