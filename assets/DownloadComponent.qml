import bb.cascades 1.3

Container{
    id: global_urlcontainer
    visible: false
    Container {
        Header {
            title: qsTr("Progress") + Retranslate.onLanguageChanged
        }
        Label {
            id: activedl_label
            text: qsTr("Active Downloads: ") + Retranslate.onLanguageChanged + (_manager.activeDownloads == 0 ? qsTr(" none") + Retranslate.onLanguageChanged : _manager.activeDownloads)
        }
        ProgressBar {
            topMargin: 10
            leftMargin: 10
            rightMargin: 10
            total: _manager.progressTotal
            value: _manager.progressValue
            message: _manager.progressMessage
        }
    }
    Button {
        id: stopbutton
        text: qsTr("Stop Download") + Retranslate.onLanguageChanged
        horizontalAlignment: HorizontalAlignment.Center
        onClicked: {
            var activedl = activedl_label.text;
            if (activedl.indexOf("1") != -1) {
                _manager.downloadCancelled();
            }
        }
    }
    Header {
        title: qsTr("Status") + Retranslate.onLanguageChanged
    }
    TextArea {
        id: status_textarea
        preferredWidth: 900
        preferredHeight: 145
        editable: false
        text: _manager.statusMessage
    }
    Header {
        title: qsTr("Errors") + Retranslate.onLanguageChanged
    }
    TextArea {
        id: error_textarea
        preferredWidth: 900
        preferredHeight: 125
        editable: false
        text: _manager.errorMessage
    }
    Divider {
    }
}