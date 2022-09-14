//
//  StandingTableViewCell.swift
//  LetsMeet
//
//  Created by Consultant on 25/08/2022.
//

import UIKit

class StandingTableViewCell: UITableViewCell {
    
    let identifier = "StandingIdentifier"
    
  //  @IBOutlet weak var Division: UILabel!
    
   // @IBOutlet weak var runsAllowed: UILabel!
  //  @IBOutlet weak var percentage: UILabel!
  //  @IBOutlet weak var loss: UILabel!
 //   @IBOutlet weak var wins: UILabel!
    
    @IBOutlet weak var wins: UILabel!
    @IBOutlet weak var loss: UILabel!
  //  @IBOutlet weak var wins: UILabel!
    @IBOutlet weak var percentage: UILabel!
    @IBOutlet weak var RS: UILabel!
    @IBOutlet weak var GamesBack: UILabel!
 //   @IBOutlet weak var NameOfTeam: UILabel!
   
    @IBOutlet weak var league: UILabel!
    @IBOutlet weak var Division: UILabel!
    @IBOutlet weak var NameOfTeam: UILabel!
   // @IBOutlet weak var league: UILabel!
}
