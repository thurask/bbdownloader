import bb.cascades 1.2

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
                text: "Open EScreens"
                horizontalAlignment: HorizontalAlignment.Center
                onClicked: {
                    myQuery.trigger(myQuery.query.invokeActionId);
                }
            }
        }
    }
}
