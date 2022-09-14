//
//  Standings.swift
//  LetsMeet
//
//  Created by Consultant on 24/08/2022.
//

import Foundation

struct StandingsItem: Codable{
    
    var array: [Standings]
    
    init(){
        self.array = []
    }
   
}


struct Standings: Codable{
    var Name: String
    var City: String
    //var WikipediaLogoUrl: String?
    var TeamID: Int
    var Key: String
    var Wins: Double
    var Losses: Double
    var Percentage: Double
    var Division: String
    var RunsScored: Double
    var RunsAgainst: Double
    var GamesBehind: Double
    var League: String
    var DivisionRank: Double
}


