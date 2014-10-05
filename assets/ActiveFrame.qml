/*ActiveFrame.qml
 * --------------
 * 
 * Duh.
 * 
 * -Thurask
 */

import bb.cascades 1.3

MultiCover {
    SceneCover {
        MultiCover.level: CoverDetailLevel.High
        content: ImageView {
            imageSource: "asset:///images/cover.png"
            scalingMethod: ScalingMethod.AspectFit
            verticalAlignment: VerticalAlignment.Center
            horizontalAlignment: HorizontalAlignment.Center
        }
    }
    SceneCover {
        MultiCover.level: CoverDetailLevel.Medium
        content: ImageView {
            imageSource: "asset:///images/cover_small.png"
            scalingMethod: ScalingMethod.AspectFit
            verticalAlignment: VerticalAlignment.Center
            horizontalAlignment: HorizontalAlignment.Center
        }
    }
}
