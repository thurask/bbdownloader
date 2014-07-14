/*PullToRefresh.qml
 -------------------
 Exactly what it says on the tin.
 
 --Thurask*/

import bb.cascades 1.3

Container {
    signal refreshTriggered
    property bool touchActive: false  
    ImageView {
        id: imgRefreshIcon      
        imageSource: "asset:///images/ic_refresh.png"
        horizontalAlignment: HorizontalAlignment.Center
        scalingMethod: ScalingMethod.AspectFit
        verticalAlignment: VerticalAlignment.Center
    }
    Label {
        id: lblRefresh
        text: qsTr("Pull down to refresh entries...") + Retranslate.onLanguageChanged
        horizontalAlignment: HorizontalAlignment.Center
        verticalAlignment: VerticalAlignment.Center
        textStyle.textAlign: TextAlign.Center
    }
    attachedObjects: [
        LayoutUpdateHandler {
            id: refreshHandler
            onLayoutFrameChanged: {
                imgRefreshIcon.rotationZ = layoutFrame.y;
                if (layoutFrame.y >= 0.0) {
                lblRefresh.text = qsTr("Release to refresh") + Retranslate.onLanguageChanged                  
                    if (layoutFrame.y == 0 && touchActive != true) {
                        refreshTriggered();
                        lblRefresh.text = qsTr("Refreshing...") + Retranslate.onLanguageChanged
                    }
                } else {
                    lblRefresh.text = qsTr("Pull down to refresh") + Retranslate.onLanguageChanged
                }
            }
        }
    ]
}