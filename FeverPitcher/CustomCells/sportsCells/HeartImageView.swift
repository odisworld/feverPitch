//
//  HeartImageView.swift
//  FeverPitcher
//
//  Created by Consultant on 27/08/2022.
//

import UIKit

@IBDesignable class HeartImageView: UIImageView, HeartDesignable {
    
    @IBInspectable open var strokeColor: UIColor = UIColor.clear
    @IBInspectable open var strokeWidth: CGFloat = 0
    @IBInspectable open var scaling: Double = 1.0
    @IBInspectable open var fillColor: UIColor = UIColor.clear
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setup()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    open func setup() {
        drawHeart()
    }
}
