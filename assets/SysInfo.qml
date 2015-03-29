/*SysInfo.qml
 * -------------
 * Reads device information.
 * 
 --Thurask*/

import bb.cascades 1.4
import bb.device 1.4
import bb 1.3

Page {
    id: sysinfopage
    property bool sanitized: false
    function bool2string(abool) {
        if (abool == true) {
            return qsTr("True") + Retranslate.onLanguageChanged
        } else {
            return qsTr("False") + Retranslate.onLanguageChanged
        }
    }
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
        WebView {
            id: dummywebview
        }
    ]
    actions: [
        ActionItem {
            id: sanitizer
            title: qsTr("Hide Personal Info") + Retranslate.onLanguageChanged
            onTriggered: {
                if (sanitized == false) {
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
                } else {
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
                    text: qsTr("Uptime: %1").arg(getUptime()) + Retranslate.onLanguageChanged
                    multiline: true
                    function getUptime() {
                        var now = new Date();
                        var dmy = new Date(_manager.readTextFile("/var/boottime.txt", "normal"));
                        var raw_ms = (now.getTime() - dmy.getTime());
                        //Days, hours, minutes
                        var days = Math.floor(raw_ms / (24 * 60 * 60 * 1000));
                        var daysms = raw_ms % (24 * 60 * 60 * 1000);
                        var hours = Math.floor((daysms) / (60 * 60 * 1000));
                        var hoursms = raw_ms % (60 * 60 * 1000);
                        var minutes = Math.floor((hoursms) / (60 * 1000));
                        return qsTr("%1 days, %2 hours, %3 minutes").arg(days).arg(hours).arg(minutes) + Retranslate.onLanguageChanged;
                    }
                }
                Label {
                    text: qsTr("HDMI: %1").arg(getHDMI(hardwareinfo.hdmiConnector)) + Retranslate.onLanguageChanged
                    multiline: true
                    function getHDMI(connector) {
                        switch (connector) {
                            case 0:
                                return qsTr("Bad or Unknown") + Retranslate.onLanguageChanged;
                                break;
                            case 1:
                                return qsTr("None") + Retranslate.onLanguageChanged;
                                break;
                            case 2:
                                return qsTr("Micro HDMI") + Retranslate.onLanguageChanged;
                                break;
                            default:
                                return qsTr("Bad or Unknown") + Retranslate.onLanguageChanged;
                        }
                    }
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
                    text: qsTr("Serial Number: %1").arg(hardwareinfo.serialNumber.slice(10, 14) + "-" + hardwareinfo.serialNumber.slice(14, 18) + "-" + hardwareinfo.serialNumber.slice(18, 22)) + Retranslate.onLanguageChanged
                    multiline: true
                }
                Label {
                    text: qsTr("Physical Keyboard: %1").arg(bool2string(hardwareinfo.isPhysicalKeyboardDevice)) + Retranslate.onLanguageChanged
                    multiline: true
                }
                Label {
                    text: qsTr("Physical Menu Button: %1").arg(bool2string(hardwareinfo.hasPhysicalMenuButton)) + Retranslate.onLanguageChanged
                    multiline: true
                }
                Label {
                    text: qsTr("Physical Back Button: %1").arg(bool2string(hardwareinfo.hasPhysicalBackButton)) + Retranslate.onLanguageChanged
                    multiline: true
                }
                Label {
                    text: qsTr("Physical Phone Keys: %1").arg(bool2string(hardwareinfo.hasPhysicalPhoneKeys)) + Retranslate.onLanguageChanged
                    multiline: true
                }
                Label {
                    text: qsTr("Physical Trackpad: %1").arg(bool2string(hardwareinfo.isTrackpadDevice)) + Retranslate.onLanguageChanged
                    multiline: true
                }
            }
            Container {
                topPadding: ui.du(1.5)
                Header {
                    title: qsTr("SIM Card") + Retranslate.onLanguageChanged
                }
                Label {
                    text: qsTr("State: %1").arg(getSimState(siminfo.state)) + Retranslate.onLanguageChanged
                    multiline: true
                    function getSimState(state) {
                        switch (state) {
                            case 0:
                                return qsTr("Not Detected") + Retranslate.onLanguageChanged;
                                break;
                            case 1:
                                return qsTr("Incompatible") + Retranslate.onLanguageChanged;
                                break;
                            case 2:
                                return qsTr("Not Provisioned") + Retranslate.onLanguageChanged;
                                break;
                            case 3:
                                return qsTr("Read Error") + Retranslate.onLanguageChanged;
                                break;
                            case 4:
                                return qsTr("PIN Required") + Retranslate.onLanguageChanged;
                                break;
                            case 5:
                                return qsTr("Ready") + Retranslate.onLanguageChanged;
                                break;
                            default:
                                return qsTr("Not Detected") + Retranslate.onLanguageChanged;
                        }
                    }
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
                    title: qsTr("Memory") + Retranslate.onLanguageChanged
                }
                Label {
                    text: qsTr("Total Device Memory: %1 MiB").arg((memoryinfo.totalDeviceMemory() / 1048576).toFixed(2).toLocaleString()) + Retranslate.onLanguageChanged
                    multiline: true
                }
                Label {
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
                    text: qsTr("Present: %1").arg(bool2string(battinfo.present)) + Retranslate.onLanguageChanged
                    multiline: true
                }
                Label {
                    text: qsTr("Charging State: %1").arg(getChargingState(battinfo.chargingState)) + Retranslate.onLanguageChanged
                    multiline: true
                    function getChargingState(state) {
                        switch (state) {
                            case 0:
                                return qsTr("Bad or Unknown") + Retranslate.onLanguageChanged;
                                break;
                            case 1:
                                return qsTr("Not Charging") + Retranslate.onLanguageChanged;
                                break;
                            case 2:
                                return qsTr("Charging") + Retranslate.onLanguageChanged;
                                break;
                            case 3:
                                return qsTr("Discharging") + Retranslate.onLanguageChanged;
                                break;
                            case 4:
                                return qsTr("Full") + Retranslate.onLanguageChanged;
                                break;
                            default:
                                return qsTr("Bad or Unknown") + Retranslate.onLanguageChanged;
                        }
                    }
                }
                Label {
                    text: qsTr("Condition: %1").arg(getCondition(battinfo.condition)) + Retranslate.onLanguageChanged
                    multiline: true
                    function getCondition(condition) {
                        switch (condition) {
                            case 0:
                                return qsTr("Bad or Unknown") + Retranslate.onLanguageChanged;
                                break;
                            case 1:
                                return qsTr("OK") + Retranslate.onLanguageChanged;
                                break;
                            default:
                                return qsTr("Bad or Unknown") + Retranslate.onLanguageChanged;
                        }
                    }
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
                    text: qsTr("Aspect: %1").arg(getAspect(dispinfo.aspectType)) + Retranslate.onLanguageChanged
                    multiline: true
                    function getAspect(aspect) {
                        switch (aspect) {
                            case 0:
                                return qsTr("Landscape") + Retranslate.onLanguageChanged;
                                break;
                            case 1:
                                return qsTr("Portrait") + Retranslate.onLanguageChanged;
                                break;
                            case 2:
                                return qsTr("Square") + Retranslate.onLanguageChanged;
                                break;
                            default:
                                return qsTr("Bad or Unknown") + Retranslate.onLanguageChanged;
                                
                        }
                    }
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
                    text: qsTr("Technology: %1").arg(getTechnology(dispinfo.displayTechnology)) + Retranslate.onLanguageChanged
                    multiline: true
                    function getTechnology(technology) {
                        switch (technology) {
                            case 0:
                                return qsTr("Bad or Unknown") + Retranslate.onLanguageChanged;
                                break;
                            case 1:
                                return qsTr("LCD") + Retranslate.onLanguageChanged;
                                break;
                            case 2:
                                return qsTr("OLED") + Retranslate.onLanguageChanged;
                                break;
                            case 3:
                                return qsTr("CRT") + Retranslate.onLanguageChanged;
                                break;
                            case 4:
                                return qsTr("Plasma") + Retranslate.onLanguageChanged;
                                break;
                            case 5:
                                return qsTr("LED") + Retranslate.onLanguageChanged;
                                break;
                            default:
                                return qsTr("Bad or Unknown") + Retranslate.onLanguageChanged;
                        }
                    }
                }
                Label {
                    id: dispname
                    text: qsTr("Display Name: %1").arg(dispinfo.displayName) + Retranslate.onLanguageChanged
                    multiline: true
                }
                Label {
                    text: qsTr("Attached: %1").arg(bool2string(dispinfo.attached)) + Retranslate.onLanguageChanged
                    multiline: true
                }
                Label {
                    text: qsTr("Detachable: %1").arg(bool2string(dispinfo.detachable)) + Retranslate.onLanguageChanged
                    multiline: true
                }
                Label {
                    text: qsTr("Wireless: %1").arg(bool2string(dispinfo.wireless)) + Retranslate.onLanguageChanged
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
