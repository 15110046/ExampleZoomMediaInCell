
//  Created by NguyenHieu on 11/03/2020.
//  Copyright © 2020 Azibai. All rights reserved.
//

import UIKit

extension HImageView: UIGestureRecognizerDelegate {
    
    public func gestureRecognizer(
        _ gestureRecognizer: UIGestureRecognizer,
        shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
}
