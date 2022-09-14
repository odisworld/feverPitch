//
//  TeamTableViewCell.swift
//  FeverPitcher
//
//  Created by Consultant on 25/08/2022.
//

import UIKit

class TeamTableViewCell: UITableViewCell {
let identifier = "TeamIdentifier"
    
    @IBOutlet var teamName: UILabel!
    @IBOutlet var teamLogo: UIImageView!
   
  
    
    private var standingItems: StandingsItem = StandingsItem()
  //  var team = standingItems.array[indexPathRow]
}


