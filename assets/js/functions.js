function clearButton(){
    os_download_textarea.text = "";
    radio_download_textarea.text = "";
    global_linkcontainer.visible = false;
    osclipboard.visible = false;
    radioclipboard.visible = false;
    osdropdown.resetSelectedOption();
    devicedropdown.resetSelectedOption();
    os_download_label.text = "OS Link:";
    radio_download_label.text = "Radio Link:";
};

function setEasterEgg(backdoor){
	if (backdoor == "da5ebb46fd2330dd29ab9d27245803fca2fd7c54"){
	    os_download_label.text = "You're winner!";
	    os_download_textarea.text = "";
	    radio_download_label.text = "Have a beer, you've earned it.";
	    radio_download_textarea.text = "";
	}
	if (backdoor == "edc75c4cb80a8f3b3505c7df7cfbdfea2d694f5d"){
	    os_download_label.text = "I used to be an adventurer like you...";
	    os_download_textarea.text = "";
	    radio_download_label.text = "until I stabbed someone for making too many arrow to the knee jokes.";
	    radio_download_textarea.text = "";
	}
	else{
		return;
	}
};

function omapEnable(includeWinchester, status){
	if (includeWinchester == true){
		if (status == true){
            dropdown_winchester.enabled = true;
            dropdown_pb.enabled = true;
            dropdown_pblte_old.enabled = true;
            dropdown_pblte_new.enabled = true;
		}
		if (status == false){
            dropdown_winchester.enabled = false;
            dropdown_pb.enabled = false;
            dropdown_pblte_old.enabled = false;
            dropdown_pblte_new.enabled = false;
		}
	}
	if (includeWinchester == false){
		if (status == true){
            dropdown_pb.enabled = true;
            dropdown_pblte_old.enabled = true;
            dropdown_pblte_new.enabled = true;
		}
		if (status == false){
			dropdown_winchester.enabled = true;
            dropdown_pb.enabled = false;
            dropdown_pblte_old.enabled = false;
            dropdown_pblte_new.enabled = false;
		}
	}
};

function setRadios(){
	if (devicedropdown.selectedIndex == -1){
        radio_download_label.text = "Radio Link:";
    }
    if (osdropdown.selectedIndex == -1){
        os_download_label.text = "OS Link:";
    }
    if (osdropdown.selectedValue != "sdkautoloader"){
    	if (devicedropdown.selectedValue == "winchester") {
            radio_download_label.text = "OMAP Z10 Radio:";
        }
        if (devicedropdown.selectedValue == "8960") {
            radio_download_label.text = "Qualcomm Z10/P9982 Radio:";
        }
        if (devicedropdown.selectedValue == "8960omadm") {
            radio_download_label.text = "Verizon Z10 Radio:";
        }
        if (devicedropdown.selectedValue == "8960wtr") {
            radio_download_label.text = "Q10/Q5/P9983/Classic Radio:";
        }
        if (devicedropdown.selectedValue == "8960wtr5") {
            radio_download_label.text = "Z30/Manitoba Radio:";
        }
        if (devicedropdown.selectedValue == "8960wtr6") {
            radio_download_label.text = "Z30/Manitoba (Future) Radio:";
        }
        if (devicedropdown.selectedValue == "8930wtr5") {
            radio_download_label.text = "Z3/Kopi/Cafe Radio:";
        }
        if (devicedropdown.selectedValue == "winchester_pblte_old"){
            radio_download_label.text = "4G PlayBook Radio (mod-qcmdm): ";
        }
        if (devicedropdown.selectedValue == "winchester_pblte_new"){
            radio_download_label.text = "4G PlayBook Radio (mod.qcmdm): ";
        }
        if (devicedropdown.selectedValue == "winchester_pb"){
            radio_download_label.text = "";
        }
        if (devicedropdown.selectedValue == "8974"){
            radio_download_label.text = "Aquila/Aquarius Radio:";
        }
        if (devicedropdown.selectedValue == "8974_sqw"){
            radio_download_label.text = "Passport Radio:";
        } 
    } 
};

function setOS(){
	if (devicedropdown.selectedIndex == -1){
        radio_download_label.text = "Radio Link:";
    }
    if (osdropdown.selectedIndex == -1){
        os_download_label.text = "OS Link:";
    }
    if (deltasetting.checked == true){
        if (osdropdown.selectedValue == "core"){
            dropdown_winchester.enabled = true;
            os_download_label.text = "Delta from " + osinit_input.text + " to " + osver_input.text + ":";
        }
        if (osdropdown.selectedValue == "core_vzw"){
            dropdown_winchester.enabled = false;
            os_download_label.text = "Verizon delta from " + osinit_input.text + " to " + osver_input.text + ":";                                
        }
    }
    if (deltasetting.checked == false){
        if (osdropdown.selectedValue == "debrick") {
            os_download_label.text = "Debrick OS:";
            omapEnable(true, true);
        }
        if (osdropdown.selectedValue == "core") {
            os_download_label.text = "Core OS:";
            omapEnable(false, false);
        }
        if (osdropdown.selectedValue == "debrick_vzw") {
            os_download_label.text = "Verizon Debrick OS:";
            omapEnable(true, false);
        }
        if (osdropdown.selectedValue == "core_vzw") {
            os_download_label.text = "Verizon Core OS:";
            omapEnable(true, false);
        }
        if (osdropdown.selectedValue == "debrick_china") {
            os_download_label.text = "China Debrick OS:";
            omapEnable(true, false);
        }
        if (osdropdown.selectedValue == "core_china") {
            os_download_label.text = "China Core OS:";
            omapEnable(true, false);
        }
        if (osdropdown.selectedValue == "sdkdebrick") {
            os_download_label.text = "SDK Debrick OS:";
            omapEnable(false, false);
        }
        if (osdropdown.selectedValue == "sdkcore") {
            os_download_label.text = "SDK Core OS:";
            omapEnable(false, false);
        }
        if (osdropdown.selectedValue == "sdkautoloader") {
            os_download_label.text = "Autoloader:";
            radio_download_label.text = "SDK downloads wonky. \nWorkaround: tap link to download in Browser.";
            dropdown_parana.enabled = false;
            omapEnable(false, false);
        }
        if (osdropdown.selectedValue != "sdkautoloader"){
            dropdown_parana.enabled = true;
            Functions.setRadios();
        }
    }
};

function generateLinks(){
	// First, hide the visibility of the link downloader if one wants an autoloader (probably BlackBerry's problem)
    if (osdropdown.selectedValue == "sdkautoloader"){
        global_linkcontainer.visible = false;
    }
    // Make the downloader and the other copiers visible
    if (osdropdown.selectedValue != "sdkautoloader"){
    	radioclipboard.visible = true;
        global_linkcontainer.visible = true;
    }
    // Then set the OS values for Qualcomm 8960+derivatives
    if (devicedropdown.selectedValue == "8930wtr5" || devicedropdown.selectedValue == "8960wtr5" || devicedropdown.selectedValue == "8960wtr6" || devicedropdown.selectedValue == "8960wtr" || devicedropdown.selectedValue == "8960omadm" || devicedropdown.selectedValue == "8960"){
        if (osdropdown.selectedValue == "debrick") {
            os_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8960.factory_sfi.desktop/" + osversion + "/qc8960.factory_sfi.desktop-" + osversion + "-nto+armle-v7+signed.bar";
        }
        if (osdropdown.selectedValue == "core") {
            os_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8960.factory_sfi/" + osversion + "/qc8960.factory_sfi-" + osversion + "-nto+armle-v7+signed.bar";
        }
        if (osdropdown.selectedValue == "debrick_vzw"){
            os_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8960.verizon_sfi.desktop/" + osversion + "/qc8960.verizon_sfi.desktop-" + osversion + "-nto+armle-v7+signed.bar";
        }
        if (osdropdown.selectedValue == "core_vzw"){
            os_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8960.verizon_sfi/" + osversion + "/qc8960.verizon_sfi-" + osversion + "-nto+armle-v7+signed.bar";
        }
        if (osdropdown.selectedValue == "debrick_china"){
            os_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8960.china_sfi.desktop/" + osversion + "/qc8960.china_sfi.desktop-" + osversion + "-nto+armle-v7+signed.bar";
        }
        if (osdropdown.selectedValue == "core_china"){
            os_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8960.china_sfi/" + osversion + "/qc8960.china_sfi-" + osversion + "-nto+armle-v7+signed.bar";
        }
        if (osdropdown.selectedValue == "sdkdebrick") {
            os_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8960.sdk.desktop/" + osversion + "/qc8960.sdk.desktop-" + osversion + "-nto+armle-v7+signed.bar";
        }
        if (osdropdown.selectedValue == "sdkcore") {
            os_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8960.sdk/" + osversion + "/qc8960.sdk-" + osversion + "-nto+armle-v7+signed.bar";
        }
    }
    // Then QC8974
    if (devicedropdown.selectedValue == "8974" || devicedropdown.selectedValue == "8974_sqw"){
        if (osdropdown.selectedValue == "debrick") {
            os_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8974.factory_sfi.desktop/" + osversion + "/qc8974.factory_sfi.desktop-" + osversion + "-nto+armle-v7+signed.bar";
        }
        if (osdropdown.selectedValue == "core") {
            os_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8974.factory_sfi/" + osversion + "/qc8974.factory_sfi-" + osversion + "-nto+armle-v7+signed.bar";
        }
        if (osdropdown.selectedValue == "debrick_vzw"){
            os_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8974.verizon_sfi.desktop/" + osversion + "/qc8974.verizon_sfi.desktop-" + osversion + "-nto+armle-v7+signed.bar";
        }
        if (osdropdown.selectedValue == "core_vzw"){
            os_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8974.verizon_sfi/" + osversion + "/qc8974.verizon_sfi-" + osversion + "-nto+armle-v7+signed.bar";
        }
        if (osdropdown.selectedValue == "debrick_china"){
            os_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8974.china_sfi.desktop/" + osversion + "/qc8974.china_sfi.desktop-" + osversion + "-nto+armle-v7+signed.bar";
        }
        if (osdropdown.selectedValue == "core_china"){
            os_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8974.china_sfi/" + osversion + "/qc8974.china_sfi-" + osversion + "-nto+armle-v7+signed.bar";
        }
        if (osdropdown.selectedValue == "sdkdebrick") {
            os_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8974.sdk.desktop/" + osversion + "/qc8974.sdk.desktop-" + osversion + "-nto+armle-v7+signed.bar";
        }
        if (osdropdown.selectedValue == "sdkcore") {
            os_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8974.sdk/" + osversion + "/qc8974.sdk-" + osversion + "-nto+armle-v7+signed.bar";
        }
    }
    // Then the PlayBooks
    if (devicedropdown.selectedValue == "winchester_pb" || devicedropdown.selectedValue == "winchester_pblte_old" || devicedropdown.selectedValue == "winchester_pblte_new" ){
        if (osdropdown.selectedValue == "debrick"){
            os_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.factory.desktop/" + osversion + "/winchester.factory_sfi.desktop-" + osversion + "-nto+armle-v7+signed.bar";
        }
        if (osdropdown.selectedValue != "debrick"){
            os_download_textarea.text = "Please set OS Type to Debrick OS";
        }
    }
    // Now the radios
    if (devicedropdown.selectedValue == "winchester_pb"){
        radio_download_textarea.text = "";
    }
    if (devicedropdown.selectedValue == "winchester_pblte_old"){
        radio_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/mod-qcmdm9k-" + radioversion + "-nto+armle-v7+signed.bar";
    }
    if (devicedropdown.selectedValue == "winchester_pblte_new"){
        radio_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/mod.qcmdm9k-" + radioversion + "-nto+armle-v7+signed.bar";
    }
    if (devicedropdown.selectedValue == "8930wtr5") {
        if (osdropdown.selectedValue != "sdkautoloader"){
            radio_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.qcfm.radio.qc8930.wtr5/" + radioversion + "/qc8930.wtr5-" + radioversion + "-nto+armle-v7+signed.bar";
        }
        if (osdropdown.selectedValue == "sdkautoloader") {
            radio_download_textarea.text = "";
            os_download_textarea.text = "http://developer.blackberry.com/native/downloads/fetch/Autoload-STJ100-1-" + osversion +".exe";
        }
    }
    if (devicedropdown.selectedValue == "8960wtr5"){
        if (osdropdown.selectedValue != "sdkautoloader"){
            radio_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.qcfm.radio.qc8960.wtr5/" + radioversion + "/qc8960.wtr5-" + radioversion + "-nto+armle-v7+signed.bar";
        }
        if (osdropdown.selectedValue == "sdkautoloader") {
            radio_download_textarea.text = "";
            os_download_textarea.text = "http://developer.blackberry.com/native/downloads/fetch/Autoload-STA100-5-" + osversion +".exe";
        }
    }
    if (devicedropdown.selectedValue == "8960wtr6"){
        if (osdropdown.selectedValue != "sdkautoloader"){
            radio_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.qcfm.radio.qc8960.wtr6/" + radioversion + "/qc8960.wtr6-" + radioversion + "-nto+armle-v7+signed.bar";
        }
        if (osdropdown.selectedValue == "sdkautoloader") {
            radio_download_textarea.text = "";
            os_download_textarea.text = "http://developer.blackberry.com/native/downloads/fetch/Autoload-STA100-5-" + osversion +".exe";
        }
    }
    if (devicedropdown.selectedValue == "8960wtr"){
        if (osdropdown.selectedValue != "sdkautoloader"){
            radio_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.qcfm.radio.qc8960.wtr/" + radioversion + "/qc8960.wtr-" + radioversion + "-nto+armle-v7+signed.bar";
        }
        if (osdropdown.selectedValue == "sdkautoloader") {
            radio_download_textarea.text = "";
            os_download_textarea.text = "http://developer.blackberry.com/native/downloads/fetch/Autoload-SQN100-5-" + osversion +".exe";
        }
    }
    if (devicedropdown.selectedValue == "8960omadm"){
        if (osdropdown.selectedValue != "sdkautoloader"){
            radio_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.qcfm.radio.qc8960.omadm/" + radioversion + "/qc8960.omadm-" + radioversion + "-nto+armle-v7+signed.bar";
        }
        if (osdropdown.selectedValue == "sdkautoloader") {
            radio_download_textarea.text = "";
            os_download_textarea.text = "http://developer.blackberry.com/native/downloads/fetch/Autoload-STL100-4-" + osversion +".exe";
        }
    }
    if (devicedropdown.selectedValue == "8960"){
        if (osdropdown.selectedValue != "sdkautoloader"){
            radio_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.qcfm.radio.qc8960/" + radioversion + "/qc8960-" + radioversion + "-nto+armle-v7+signed.bar";
        }
        if (osdropdown.selectedValue == "sdkautoloader") {
            radio_download_textarea.text = "";
            os_download_textarea.text = "http://developer.blackberry.com/native/downloads/fetch/Autoload-STL100-3-" + osversion +".exe";
        }
    }
    // And lastly the STL100-1
    if (devicedropdown.selectedValue == "winchester"){
        if (osdropdown.selectedValue != "sdkautoloader"){
            radio_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.qcfm.radio.m5730/" + radioversion + "/m5730-" + radioversion + "-nto+armle-v7+signed.bar";
        }
        if (osdropdown.selectedValue == "debrick") {
            os_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.factory.desktop/" + osversion + "/winchester.factory_sfi.desktop-" + osversion + "-nto+armle-v7+signed.bar";
        }
        if (osdropdown.selectedValue == "core") {
            os_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.factory/" + osversion + "/winchester.factory_sfi-" + osversion + "-nto+armle-v7+signed.bar";
        }
        if (osdropdown.selectedValue == "sdkdebrick") {
            os_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.winchester.sdk.desktop/" + osversion + "/winchester.sdk.desktop-" + osversion + "-nto+armle-v7+signed.bar";
        }
        if (osdropdown.selectedValue == "sdkcore") {
            os_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.winchester.sdk/" + osversion + "/winchester.sdk-" + osversion + "-nto+armle-v7+signed.bar";
        }
        if (osdropdown.selectedValue == "debrick_vzw" || osdropdown.selectedValue == "debrick_china" || osdropdown.selectedValue == "core_vzw" || osdropdown.selectedValue == "core_china") {
            os_download_textarea.text = "Please set OS Type to Debrick/Core OS/SDK OS";
        }
        if (osdropdown.selectedValue == "sdkautoloader") {
            radio_download_textarea.text = "";
            os_download_textarea.text = "http://developer.blackberry.com/native/downloads/fetch/Autoload-STL100-1-" + osversion +".exe";
        }
    }
    // Miscellany
    if (devicedropdown.selectedValue == "8974"){
        if (osdropdown.selectedValue != "sdkautoloader"){
            radio_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.qcfm.radio.qc8974/" + radioversion + "/qc8974-" + radioversion + "-nto+armle-v7+signed.bar";
        }
        if (osdropdown.selectedValue == "sdkautoloader") {
            radio_download_textarea.text = "";
            os_download_textarea.text = "If nobody can find a regular OS for this hardware, what makes you think there's a SDK OS?";
        }
    }
    if (devicedropdown.selectedValue == "8974_sqw"){
        if (osdropdown.selectedValue != "sdkautoloader"){
            radio_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.qcfm.radio.qc8974.wtr?/" + radioversion + "/qc8974.wtr?-" + radioversion + "-nto+armle-v7+signed.bar";
        }
        if (osdropdown.selectedValue == "sdkautoloader") {
            radio_download_textarea.text = "";
            os_download_textarea.text = os_download_textarea.text = "http://developer.blackberry.com/native/downloads/fetch/Autoload-SQW100-1-" + osversion +".exe";
        }
    }
};

function generateDeltas(){
	//PB doesn't have deltas (I think)
    if (devicedropdown.selectedValue == "winchester_pb" || devicedropdown.selectedValue == "winchester_pblte_old" || devicedropdown.selectedValue == "winchester_pblte_new" ){
        os_download_textarea.text = "Please pick a BB10 device.";
    }
    if (osdropdown.selectedValue == "core"){
        os_download_label.text = "Delta from " + osinit_input.text + " to " + osver_input.text + ":";
    }
    if (osdropdown.selectedValue == "core_vzw"){
        os_download_label.text = "Verizon delta from " + osinit_input.text + " to " + osver_input.text + ":";                                
    }
    //STL100-1
    if (devicedropdown.selectedValue == "winchester"){
        global_linkcontainer.visible = true;
        if (osdropdown.selectedValue != "core"){
            os_download_textarea.text = "Please set OS Type to Delta OS";
        }
        if (osdropdown.selectedValue == "core"){
            os_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.factory.d" + osinit + "/" + osversion + "/winchester.factory_sfi-" + osversion + "-nto+armle-v7+signed+patch+"+ osinit2 + ".bar";
            radio_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.qcfm.radio.m5730.d" + radinit + "/" + radioversion + "/m5730-" + radioversion + "-nto+armle-v7+signed+patch+"+ radinit2 + ".bar";
        }
    }
    //QC8960
    if (devicedropdown.selectedValue == devicedropdown.selectedValue == "8930wtr5" || devicedropdown.selectedValue == "8960wtr5" || devicedropdown.selectedValue == "8960wtr6" || devicedropdown.selectedValue == "8960wtr" || devicedropdown.selectedValue == "8960omadm" || devicedropdown.selectedValue == "8960"){
        global_linkcontainer.visible = true;
        if (osdropdown.selectedValue != "core" || osdropdown.selectedValue != "core_vzw"){
            os_download_textarea.text = "Please set OS Type to Delta OS/Verizon Delta OS";
        }
        if (osdropdown.selectedValue == "core"){
            os_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8960.factory.d" + osinit + "/" + osversion + "/qc8960.factory_sfi-" + osversion + "-nto+armle-v7+signed+patch+"+ osinit2 + ".bar";
        }
        if (osdropdown.selectedValue == "core_vzw"){
            os_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8960.verizon.d" + osinit + "/" + osversion + "/qc8960.verizon_sfi-" + osversion + "-nto+armle-v7+signed+patch+"+ osinit2 + ".bar";
        }
        if (devicedropdown.selectedValue == "8930wtr5"){
            radio_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.qcfm.radio.qc8930.wtr5.d" + radinit + "/" + radioversion + "/qc8930.wtr5-" + radioversion + "-nto+armle-v7+signed+patch+"+ radinit2 + ".bar";
        }
        if (devicedropdown.selectedValue == "8960wtr6"){
            radio_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.qcfm.radio.qc8960.wtr6.d" + radinit + "/" + radioversion + "/qc8960.wtr6-" + radioversion + "-nto+armle-v7+signed+patch+"+ radinit2 + ".bar";
        }
        if (devicedropdown.selectedValue == "8960wtr5"){
            radio_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.qcfm.radio.qc8960.wtr5.d" + radinit + "/" + radioversion + "/qc8960.wtr5-" + radioversion + "-nto+armle-v7+signed+patch+"+ radinit2 + ".bar";
        }
        if (devicedropdown.selectedValue == "8960wtr"){
            radio_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.qcfm.radio.qc8960.wtr.d" + radinit + "/" + radioversion + "/qc8960.wtr-" + radioversion + "-nto+armle-v7+signed+patch+"+ radinit2 + ".bar";
        }
        if (devicedropdown.selectedValue == "8960omadm"){
            radio_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.qcfm.radio.qc8960.omadm.d" + radinit + "/" + radioversion + "/qc8960.omadm-" + radioversion + "-nto+armle-v7+signed+patch+"+ radinit2 + ".bar";
        }
        if (devicedropdown.selectedValue == "8960"){
            radio_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.qcfm.radio.qc8960.d" + radinit + "/" + radioversion + "/qc8960-" + radioversion + "-nto+armle-v7+signed+patch+"+ radinit2 + ".bar";
        }
    }
    //QC8974
    if (devicedropdown.selectedValue == "8974" || devicedropdown.selectedValue == "8974_sqw"){
        global_linkcontainer.visible = true;
        if (osdropdown.selectedValue != "core" || osdropdown.selectedValue != "core_vzw"){
            os_download_textarea.text = "Please set OS Type to Delta OS/Verizon Delta OS";
        }
        if (osdropdown.selectedValue == "core"){
            os_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8974.factory.d" + osinit + "/" + osversion + "/qc8974.factory_sfi-" + osversion + "-nto+armle-v7+signed+patch+"+ osinit2 + ".bar";
        }
        if (osdropdown.selectedValue == "core_vzw"){
            os_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8974.verizon.d" + osinit + "/" + osversion + "/qc8974.verizon_sfi-" + osversion + "-nto+armle-v7+signed+patch+"+ osinit2 + ".bar";
        }
        if (devicedropdown.selectedValue == "8974"){
            radio_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.qcfm.radio.qc8974.d" + radinit + "/" + radioversion + "/qc8974-" + radioversion + "-nto+armle-v7+signed+patch+"+ radinit2 + ".bar";
        }
        if (devicedropdown.selectedValue == "8974_sqw"){
            radio_download_textarea.text = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.qcfm.radio.qc8974.wtr?.d" + radinit + "/" + radioversion + "/qc8974.wtr?-" + radioversion + "-nto+armle-v7+signed+patch+"+ radinit2 + ".bar";
        }
    }
};

function autoLookup(){
	outputtext.text = outputtext.text + (autolookup_input.text + " - " + _swlookup.softwareRelease() + "\n");
    var splitarray = autolookup_input.text.split(".");
    var newnum = parseInt(splitarray[3], 10);
    if (newnum < 9998){
        splitarray[3] = newnum +3;
        autolookup_input.text = splitarray.join(".");
    }
    else {
        splitarray[3] = 0;
        autolookup_input.text = splitarray.join(".");
    }
};

function saveDeltaLinks(){
	var exporturls_delta = ("---OPERATING SYSTEMS---\n" +
            "STL100-1\n" +
            "Delta OS: http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.factory.d" + osinit + "/" + osversion + "/winchester.factory_sfi-" + osversion + "-nto+armle-v7+signed+patch+"+ osinit2 + ".bar\n" +
            "Qualcomm\n" +
            "Delta OS: http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8960.factory.d" + osinit + "/" + osversion + "/qc8960.factory_sfi-" + osversion + "-nto+armle-v7+signed+patch+"+ osinit2 + ".bar\n" +
            "Verizon\n" +
            "Delta OS: http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8960.verizon.d" + osinit + "/" + osversion + "/qc8960.verizon_sfi-" + osversion + "-nto+armle-v7+signed+patch+"+ osinit2 + ".bar\n\n" +
            "---RADIOS---\n" +
            "OMAP Z10: http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.qcfm.radio.m5730.d" + radinit + "/" + radioversion + "/m5730-" + radioversion + "-nto+armle-v7+signed+patch+"+ radinit2 + ".bar\n" +
            "Qualcomm Z10/P9982: http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.qcfm.radio.qc8960.d" + radinit + "/" + radioversion + "/qc8960-" + radioversion + "-nto+armle-v7+signed+patch+"+ radinit2 + ".bar\n" +
            "Verizon Z10: http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.qcfm.radio.qc8960.omadm.d" + radinit + "/" + radioversion + "/qc8960.omadm-" + radioversion + "-nto+armle-v7+signed+patch+"+ radinit2 + ".bar\n" +                                
            "Q10/Q5/P9983/Classic: http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.qcfm.radio.qc8960.wtr.d" + radinit + "/" + radioversion + "/qc8960.wtr-" + radioversion + "-nto+armle-v7+signed+patch+"+ radinit2 + ".bar\n" +
            "Z30/Manitoba: http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.qcfm.radio.qc8960.wtr5.d" + radinit + "/" + radioversion + "/qc8960.wtr5-" + radioversion + "-nto+armle-v7+signed+patch+"+ radinit2 + ".bar\n" +
            //"Z30/Manitoba: http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.qcfm.radio.qc8960.wtr6.d" + radinit + "/" + radioversion + "/qc8960.wtr6-" + radioversion + "-nto+armle-v7+signed+patch+"+ radinit2 + ".bar\n" +                                   
            "Z3/Kopi/Cafe: http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.qcfm.radio.qc8930.wtr5.d" + radinit + "/" + radioversion + "/qc8930.wtr5-" + radioversion + "-nto+armle-v7+signed+patch+"+ radinit2 + ".bar\n" +
            "");
            var deltasw = osinit_input.text + "-to-" + osver_input.text;
            returnDeltaLinks(exporturls_delta, deltasw);
};

function returnDeltaLinks(links, software){
	return [links, software];
};

function saveLinks(){
	var exporturls = ("---OPERATING SYSTEMS---\n" +
            "STL100-1\n" +
            "Debrick OS: http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.factory.desktop/" + osversion + "/winchester.factory_sfi.desktop-" + osversion + "-nto+armle-v7+signed.bar\n" +
            "Core OS: http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.factory/" + osversion + "/winchester.factory_sfi-" + osversion + "-nto+armle-v7+signed.bar\n" +
            "\n" +
            "Qualcomm 8960/8930 (Most others)\n" +
            "Debrick OS: http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8960.factory_sfi.desktop/" + osversion + "/qc8960.factory_sfi.desktop-" + osversion + "-nto+armle-v7+signed.bar\n" +
            "Core OS: http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8960.factory_sfi/" + osversion + "/qc8960.factory_sfi-" + osversion + "-nto+armle-v7+signed.bar\n" +
            "\n" +
            "Verizon Devices\n" +
            "Debrick OS: http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8960.verizon_sfi.desktop/" + osversion + "/qc8960.verizon_sfi.desktop-" + osversion + "-nto+armle-v7+signed.bar\n" +
            "Core OS: http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8960.verizon_sfi/" + osversion + "/qc8960.verizon_sfi-" + osversion + "-nto+armle-v7+signed.bar\n" +
            "\n\n" +
            //"Qualcomm 8974 (Passport)\n" +
            //"Debrick OS: http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8974.factory_sfi.desktop/" + osversion + "/qc8974.factory_sfi.desktop-" + osversion + "-nto+armle-v7+signed.bar\n" +
            //"Core OS: http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8974.factory_sfi/" + osversion + "/qc8974.factory_sfi-" + osversion + "-nto+armle-v7+signed.bar\n" +
            //"\n\n" +
            "---RADIOS---\n" +
            "OMAP Z10: http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.qcfm.radio.m5730/" + radioversion + "/m5730-" + radioversion + "-nto+armle-v7+signed.bar\n" +
            "Qualcomm Z10/P9982: http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.qcfm.radio.qc8960/" + radioversion + "/qc8960-" + radioversion + "-nto+armle-v7+signed.bar\n" +
            "Verizon Z10: http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.qcfm.radio.qc8960.omadm/" + radioversion + "/qc8960.omadm-" + radioversion + "-nto+armle-v7+signed.bar\n" +                                
            "Q10/Q5/P9983/Classic: http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.qcfm.radio.qc8960.wtr/" + radioversion + "/qc8960.wtr-" + radioversion + "-nto+armle-v7+signed.bar\n" +
            "Z30/Manitoba: http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.qcfm.radio.qc8960.wtr5/" + radioversion + "/qc8960.wtr5-" + radioversion + "-nto+armle-v7+signed.bar\n" +
            //"Z30/Manitoba: http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.qcfm.radio.qc8960.wtr6/" + radioversion + "/qc8960.wtr6-" + radioversion + "-nto+armle-v7+signed.bar\n" +
            "Z3/Kopi/Cafe: http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.qcfm.radio.qc8930.wtr5/" + radioversion + "/qc8930.wtr5-" + radioversion + "-nto+armle-v7+signed.bar\n" +
            //"Passport: http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.qcfm.radio.qc8974.wtr?/" + radioversion + "/qc8974.wtr?-" + radioversion + "-nto+armle-v7+signed.bar\n" +
            "");
	returnLinks(exporturls, swrelease);
};

function returnLinks(links, software){
	return [links, software];
};