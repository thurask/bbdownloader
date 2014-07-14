/*EScreens.qml
 -------------
Load the generator in a HTML file as a WebView, since the generate function was being irritating. Invoke the escreens app.

 --Thurask*/

import bb.cascades 1.3

Page {
    id: escreens
    attachedObjects: [
        Invocation {
            id: myQuery
            query {
                uri: ("escreen://")
                invokeActionId: "bb.action.OPEN"
                onQueryChanged: {
                    myQuery.query.updateQuery()
                }
            }
        }
    ]
    ScrollView {
        scrollViewProperties.scrollMode: ScrollMode.Vertical
        scrollViewProperties.pinchToZoomEnabled: false
        scrollViewProperties.overScrollEffectMode: OverScrollEffectMode.None
        Container {
            Container {
                id: webViewContainer
                WebView {
                    id: becauseJavaWasGettingAnnoying
                    url: "local:///assets/html/escreens.html"
                    settings.background: Color.Transparent
                    settings.textAutosizingEnabled: true
                }
            }
            Divider {
                
            }
            Button {
                id: openescreens
                text: qsTr("Open EScreens") + Retranslate.onLanguageChanged
                horizontalAlignment: HorizontalAlignment.Center
                onClicked: {
                    myQuery.trigger(myQuery.query.invokeActionId);
                }
            }
        }
    }
}
