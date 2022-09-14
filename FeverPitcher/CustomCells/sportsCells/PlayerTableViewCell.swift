//
//  PlayerTableViewCell.swift
//  FeverPitcher
//
//  Created by Consultant on 25/08/2022.
//

import Foundation
import UIKit

class PlayerTableViewcell: UITableViewCell{
    
    @IBOutlet var picture: UIImageView!
    @IBOutlet var positionNR: UILabel!
    @IBOutlet var name: UILabel!
    
    let identifier = "PlayerIdentifier"
}
