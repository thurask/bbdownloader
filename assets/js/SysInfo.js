function bool2string(abool) {
	if (abool == true) {
		return qsTr("True") + Retranslate.onLanguageChanged;
	} else {
		return qsTr("False") + Retranslate.onLanguageChanged;
	}
}

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

function celltechSwitch(flag) {
	switch (flag) {
	case (0x0):
		return qsTr("None, ") + Retranslate.onLanguageChanged;
	break;
	case (0x1):
		return qsTr("GSM, ") + Retranslate.onLanguageChanged;
	break;
	case (0x2):
		return qsTr("UMTS, ") + Retranslate.onLanguageChanged;
	break;
	case (0x4):
		return qsTr("CDMA1X, ") + Retranslate.onLanguageChanged;
	break;
	case (0x8):
		return qsTr("EVDO, ") + Retranslate.onLanguageChanged;
	break;
	case (0x10):
		return qsTr("LTE") + Retranslate.onLanguageChanged;
	break;
	}
}

function celltechBitcomp(type, flag) {
	switch (type) {
	case 0:
		if ((crinfo.technologies & flag) != 0) {
			return celltechSwitch(flag);
		}
		else {
			return "";
		}
		break;
	case 1:
		if ((crinfo.enabledTechnologies & flag) != 0) {
			return celltechSwitch(flag);
		}
		else {
			return "";
		}
		break;
	case 2:
		if ((crinfo.activeTechnologies & flag) != 0) {
			return celltechSwitch(flag);
		}
		else {
			return "";
		}
		break;
	case 3:
		if ((cninfo.technology & flag) != 0) {
			return celltechSwitch(flag);
		}
		else {
			return "";
		}
		break;
	}
}

function cellservicesSwitch(flag)
{
	switch (flag) {
	case (0x0):
		return qsTr("None, ") + Retranslate.onLanguageChanged;
	break;
	case (0x1):
		return qsTr("Emergency, ") + Retranslate.onLanguageChanged;
	break;
	case (0x2):
		return qsTr("Voice, ") + Retranslate.onLanguageChanged;
	break;
	case (0x4):
		return qsTr("E911 Callback, ") + Retranslate.onLanguageChanged;
	break;
	case (0x100):
		return qsTr("Data, ") + Retranslate.onLanguageChanged;
	break;
	case (0x200):
		return qsTr("GAN") + Retranslate.onLanguageChanged;
	break;
	case (0x400):
		return qsTr("Concurrent Voice+Data, ") + Retranslate.onLanguageChanged;
	break;
	case (0x1000):
		return qsTr("GPRS Data, ") + Retranslate.onLanguageChanged;
	break;
	case (0x2000):
		return qsTr("EDGE Data, ") + Retranslate.onLanguageChanged;
	break;
	case (0x4000):
		return qsTr("HSPA Data, ") + Retranslate.onLanguageChanged;
	break;
	case (0x8000):
		return qsTr("UMTS Data, ") + Retranslate.onLanguageChanged;
	break;
	case (0x10000):
		return qsTr("HSPA+ Data, ") + Retranslate.onLanguageChanged;
	break;
	case (0x20000):
		return qsTr("CDMA Data, ") + Retranslate.onLanguageChanged;
	break;
	case (0x40000):
		return qsTr("EVDO 0 Data, ") + Retranslate.onLanguageChanged;
	break;
	case (0x80000):
		return qsTr("EVDO A Data, ") + Retranslate.onLanguageChanged;
	break;
	case (0x100000):
		return qsTr("eHRPD Data, ") + Retranslate.onLanguageChanged;
	break;
	case (0x200000):
		return qsTr("LTE Data") + Retranslate.onLanguageChanged;
	break;
	}
}

function cellservicesBitcomp(type, flag) {
	switch (type) {
	case 0:
		if ((crinfo.services & flag) != 0) {
			return cellservicesSwitch(flag);
		}
		else {
			return "";
		}
		break;
	case 1:
		if ((cninfo.services & flag) != 0) {
			return cellservicesSwitch(flag);
		}
		else {
			return "";
		}
		break;
	}
}

function cellbandsSwitch(flag)
{
	switch (flag) {
	case (0x0):
		return qsTr("None, ") + Retranslate.onLanguageChanged;
	break;
	case (0x1):
		return qsTr("CDMA 0 (800), ") + Retranslate.onLanguageChanged;
	break;
	case (0x2):
		return qsTr("CDMA 1 (1900), ") + Retranslate.onLanguageChanged;
	break;
	case (0x4):
		return qsTr("CDMA 15 (1700/2100), ") + Retranslate.onLanguageChanged;
	break;
	case (0x8):
		return qsTr("GSM 850, ") + Retranslate.onLanguageChanged;
	break;
	case (0x10):
		return qsTr("GSM 900, ") + Retranslate.onLanguageChanged;
	break;
	case (0x20):
		return qsTr("GSM 1800, ") + Retranslate.onLanguageChanged;
	break;
	case (0x40):
		return qsTr("GSM 1900, ") + Retranslate.onLanguageChanged;
	break;
	case (0x80):
		return qsTr("UMTS 1 (2100), ") + Retranslate.onLanguageChanged;
	break;
	case (0x100):
		return qsTr("UMTS 2 (1900), ") + Retranslate.onLanguageChanged;
	break;
	case (0x200):
		return qsTr("UMTS 3 (1800), ") + Retranslate.onLanguageChanged;
	break;
	case (0x400):
		return qsTr("UMTS 4 (1700), ") + Retranslate.onLanguageChanged;
	break;
	case (0x800):
		return qsTr("UMTS 5 (850), ") + Retranslate.onLanguageChanged;
	break;
	case (0x1000):
		return qsTr("UMTS 6 (800), ") + Retranslate.onLanguageChanged;
	break;
	case (0x2000):
		return qsTr("UMTS 7 (2600), ") + Retranslate.onLanguageChanged;
	break;
	case (0x4000):
		return qsTr("UMTS 8 (900), ") + Retranslate.onLanguageChanged;
	break;
	case (0x8000):
		return qsTr("UMTS 9 (1700), ") + Retranslate.onLanguageChanged;
	break;
	case (0x10000):
		return qsTr("UMTS 10 (1700), ") + Retranslate.onLanguageChanged;
	break;
	case (0x20000):
		return qsTr("LTE 2 (1900), ") + Retranslate.onLanguageChanged;
	break;
	case (0x40000):
		return qsTr("LTE 3 (1800), ") + Retranslate.onLanguageChanged;
	break;
	case (0x80000):
		return qsTr("LTE 4 (1700/2100), ") + Retranslate.onLanguageChanged;
	break;
	case (0x100000):
		return qsTr("LTE 5 (850), ") + Retranslate.onLanguageChanged;
	break;
	case (0x200000):
		return qsTr("LTE 7 (2600), ") + Retranslate.onLanguageChanged;
	break;
	case (0x400000):
		return qsTr("LTE 8 (900), ") + Retranslate.onLanguageChanged;
	break;
	case (0x800000):
		return qsTr("LTE 13 (700), ") + Retranslate.onLanguageChanged;
	break;
	case (0x1000000):
		return qsTr("LTE 17 (700), ") + Retranslate.onLanguageChanged;
	break;
	case (0x2000000):
		return qsTr("LTE 20 (800)") + Retranslate.onLanguageChanged;
	break;
	}
}

function cellbandsBitcomp(flag)
{
	if ((crinfo.bands & flag) != 0) {
		return cellbandsSwitch(flag);
	}
	else {
		return "";
	}
}

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