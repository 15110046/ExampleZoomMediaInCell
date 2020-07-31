
//  Created by NguyenHieu on 11/03/2020.
//  Copyright © 2020 Azibai. All rights reserved.
//

import UIKit

extension UIView {

    var globalFrame :CGRect? {
        return self.superview?.convert(self.frame, to: nil)
    }
    
}
