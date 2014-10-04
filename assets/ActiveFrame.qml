/*ActiveFrame.qml
 ------------------
 Duh.
 
 --Thurask*/

import bb.cascades 1.4

MultiCover {
    SceneCover {
        MultiCover.level: CoverDetailLevel.High
        content: ImageView {
            imageSource: "asset:///images/covers/cover.png"
            scalingMethod: ScalingMethod.AspectFit
            verticalAlignment: VerticalAlignment.Center
            horizontalAlignment: HorizontalAlignment.Center
        }
    }
    SceneCover {
        MultiCover.level: CoverDetailLevel.Medium
        content: ImageView {
            imageSource: "asset:///images/covers/cover_small.png"
            scalingMethod: ScalingMethod.AspectFit
            verticalAlignment: VerticalAlignment.Center
            horizontalAlignment: HorizontalAlignment.Center
        }
    }
}
