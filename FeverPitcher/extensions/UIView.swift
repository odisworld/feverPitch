//
//  UIView.swift
//  FeverPitcher
//
//  Created by Consultant on 26/08/2022.
//

import Foundation
import UIKit

extension UIView {
  func smoothRoundCorners(to radius: CGFloat) {
    let maskLayer = CAShapeLayer()
    maskLayer.path = UIBezierPath(
      roundedRect: bounds,
      cornerRadius: radius
    ).cgPath

    layer.mask = maskLayer
  }
}
