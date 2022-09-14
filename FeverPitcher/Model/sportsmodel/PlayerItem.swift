//
//  PlayerItem.swift
//  LetsMeet
//
//  Created by Consultant on 25/08/2022.
//

import Foundation
import UIKit


struct PlayerItem: Codable{
    
    var array: [Player]
    
    init(){
        self.array = []
    }
   
}


struct Player: Codable{
    var FirstName: String
    var LastName: String
    var Position: String
    var Jersey: Int?
    var PhotoUrl: String?
    var PlayerID: Int?
    var BatHand: String?
    
}
