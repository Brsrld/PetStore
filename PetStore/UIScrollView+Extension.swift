//
//  UIScrollView+Extension.swift
//  PetStore
//
//  Created by Brsrld on 23.08.2023.
//

import Foundation
import UIKit

extension UIScrollView {
    func resetScrollPositionToTop() {
        self.contentOffset = CGPoint(x: -contentInset.left, y: -contentInset.top)
    }
}
