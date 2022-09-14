//
//  UIColor.swift
//  FeverPitcher
//
//  Created by Consultant on 26/08/2022.
//

import Foundation
import UIKit

extension UIColor {
  static var primary: UIColor {
    // swiftlint:disable:next force_unwrapping
    return UIColor(named: "rw-green")!
  }

  static var incomingMessage: UIColor {
    // swiftlint:disable:next force_unwrapping
    return UIColor(named: "incoming-message")!
  }
    
    static var themeColor: UIColor {
        return UIColor(red: (25/255), green: (53/255), blue: (111/255), alpha: 0.75)
    }
    
    static var heartColor: UIColor {
        return UIColor(red: (255/255), green: (110/255), blue: (87/255), alpha: 1.0)
    }
}
