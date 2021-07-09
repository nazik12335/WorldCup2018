//
//  Sequence+NSLayoutConstraint.swift
//  WorldCup2018
//
//  Created by Nazik on 09.07.2021.
//

import Foundation
import UIKit

extension Sequence where Iterator.Element == NSLayoutConstraint {
  func activate() {
    self.forEach({$0.isActive = true})
  }
}
