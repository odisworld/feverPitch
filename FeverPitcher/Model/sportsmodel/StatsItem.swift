//
//  StatsItem.swift
// LetsMeet
//
//  Created by Consultant on 25/08/2022.
//

import Foundation


struct StatsItem{
    var player: Stats?
    
    init(){
        player = nil
    }
}

struct Stats: Codable{
    var Position: String?
    var Hits: Double?
    var HomeRuns: Double?
    var Games: Double?
    var AtBats: Double?
    var BattingAverage: Double?
    var RunsBattedIn: Double?
    var StolenBases: Double?
    var Walks: Double?
    var Strikeouts: Double?
    
    // Goalie
    var EarnedRunAverage: Double?
    var Saves: Double?
    var PitchingStrikeouts: Double?
    var Wins: Double?
    var Losses: Double?
    var PitchingWalks: Double?
    var InningsPitchedFull: Double?
    var PitchingEarnedRuns: Double?
}
