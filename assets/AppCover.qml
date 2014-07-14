/*AppCover.qml
 --------------
 Active Frame
 
 --Thurask*/

import bb.cascades 1.3

Container {
    layout: StackLayout {}
    background: Color.Black
    ImageView {
        imageSource: "asset:///images/cover.png"
        scalingMethod: ScalingMethod.AspectFit
        verticalAlignment: VerticalAlignment.Center
        horizontalAlignment: HorizontalAlignment.Center
    }
}