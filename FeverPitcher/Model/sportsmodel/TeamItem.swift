//
//  TeamItem.swift
//  LetsMeet
//
//  Created by Consultant on 25/08/2022.
//

import Foundation
import UIKit

struct TeamItem: Codable{
    
    var array: [Team]
    
    init(){
        self.array = []
    }
   
}


struct Team: Codable{
    var Name: String
    var City: String
    var WikipediaLogoUrl: String?
    var TeamID: Int
    var Key: String
}
