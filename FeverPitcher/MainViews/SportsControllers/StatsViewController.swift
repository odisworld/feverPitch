//
//  StatsViewController.swift
//  Fever Pitch
//
//  Created by Consultant on 30.11.21.
//

import Foundation
import UIKit
import Kingfisher

class StatsViewController: UIViewController{
    
    
    enum NetworkError: Error{
        case couldNotParseUrl
        case noResponseData
    }
    private let urlSession = URLSession.shared

    
    
    @IBOutlet var gamesPlayed: UILabel!
    @IBOutlet var teamLogo: UIImageView!
    @IBOutlet var teamName: UILabel!
    @IBOutlet var lastName: UILabel!
    @IBOutlet var positionNR: UILabel!
    @IBOutlet var firstName: UILabel!
    @IBOutlet var image: UIImageView!
    @IBOutlet var hits: UILabel!
    @IBOutlet var atBats: UILabel!
    @IBOutlet var Avg: UILabel!
    @IBOutlet var stolenbase: UILabel!
    
    @IBOutlet weak var strikeOutsLabel: UILabel!
    @IBOutlet weak var walkLabel: UILabel!
    
    @IBOutlet weak var strikeout: UILabel!
    @IBOutlet weak var walks: UILabel!
    @IBOutlet var HomeRuns: UILabel!
    @IBOutlet var Rbis: UILabel!
    @IBOutlet var shoots: UILabel!
    @IBOutlet var gamesLabel: UILabel!
    @IBOutlet var hitsLabel: UILabel!
    @IBOutlet var atbatslabel: UILabel!
    @IBOutlet var avgLabel: UILabel!
    
    @IBOutlet var handsLabel: UILabel!
    @IBOutlet var RBILabel: UILabel!
    @IBOutlet var homerunLabel: UILabel!
    @IBOutlet var stolenBaseLabel: UILabel!
    
    
    
    let identifier = "StatsIdentifier"
    
// data from tableview cell
    var playerID: Int?
    var jersey: Int?
    var shootsString: String?
    var teamNameString: String?
    var firstNameString: String?
    var lastNameString: String?
    var positionNRString: String?
    var porträtImageUrl: String?
    var clubImageUrl: String?
    var id: Int = 0
    
    var statItems: Stats = Stats()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let prevID = playerID{
            id = prevID
        }
        
        requestStats(completion: { statsItem, error in
            print(error as Any)
            guard let item = statsItem else{
                return
            }
            print(item)
            self.statItems = item
            self.addData()
            
           
            
            })
        
        addData()
        self.reloadInputViews()

        
        
    }
    
    // adds all content into view
    private func addData(){
        
        DispatchQueue.main.async { [self] in
            self.RBILabel.layer.masksToBounds = true
            self.RBILabel.layer.cornerRadius = 8
            self.Rbis.layer.masksToBounds = true
            self.Rbis.layer.cornerRadius = 8
            
            self.stolenBaseLabel.layer.masksToBounds = true
            self.stolenBaseLabel.layer.cornerRadius = 8
            self.stolenbase.layer.masksToBounds = true
            self.stolenbase.layer.cornerRadius = 8
            
            self.homerunLabel.layer.masksToBounds = true
            self.homerunLabel.layer.cornerRadius = 8
            self.HomeRuns.layer.masksToBounds = true
            self.HomeRuns.layer.cornerRadius = 8
            
            self.shoots.layer.masksToBounds = true
            self.shoots.layer.cornerRadius = 8
            self.handsLabel.layer.masksToBounds = true
            self.handsLabel.layer.cornerRadius = 8
            
            
            self.strikeOutsLabel.layer.masksToBounds = true
            self.strikeOutsLabel.layer.cornerRadius = 8
            self.walkLabel.layer.masksToBounds = true
            self.walkLabel.layer.cornerRadius = 8
            self.gamesLabel.layer.masksToBounds = true
            self.gamesLabel.layer.cornerRadius = 8
            self.hitsLabel.layer.masksToBounds = true
            self.hitsLabel.layer.cornerRadius = 8
            self.atbatslabel.layer.masksToBounds = true
            self.atbatslabel.layer.cornerRadius = 8
            self.avgLabel.layer.masksToBounds = true
            self.avgLabel.layer.cornerRadius = 8

            
            self.hits.layer.masksToBounds  = true
            self.hits.layer.cornerRadius = 5
            self.gamesPlayed.layer.masksToBounds  = true
            self.gamesPlayed.layer.cornerRadius = 5
            self.atBats.layer.masksToBounds  = true
            self.atBats.layer.cornerRadius = 5
            self.Avg.layer.masksToBounds  = true
            self.Avg.layer.cornerRadius = 5
            self.strikeout.layer.masksToBounds  = true
            self.strikeout.layer.cornerRadius = 5
            self.walks.layer.masksToBounds  = true
            self.walks.layer.cornerRadius = 5
                
            // add api data into view
            
            if let lns = self.lastNameString{
                self.lastName.text = lns
            }
            if let fns = self.firstNameString{
                self.firstName.text = fns
            }
            if let pns = self.positionNRString{
                self.positionNR.text = pns
            }
            if let hand = self.shootsString{
                shoots.text = hand
            }
            
            if let teamLogoUrl = self.clubImageUrl{
                let picUrl = URL(string: teamLogoUrl)
                self.teamLogo.kf.setImage(with: picUrl)
            }
            if let tns = self.teamNameString{
                self.teamName.text = tns
            }
            
            if let img = self.porträtImageUrl{
                let url = URL(string: img)
                self.image.kf.setImage(with: url)
                
            }
            
            if let gapd = self.statItems.Games{
                self.gamesPlayed.text = "\(Int(gapd))"
                
                if let asts = self.statItems.AtBats{
                    self.atBats.text = "\(Int(asts))"
                    
                    if let gls = self.statItems.Hits{
                        self.hits.text = "\(Int(gls))"
                        
                        self.Avg.text = "\(Double(gls / asts))"
                       
                    }
                    
                }
                
            }else{
                self.hits.text = "0"
                self.atBats.text = "0"
                self.gamesPlayed.text = "0"
                self.Avg.text = "0"

            }
            
            // bottom four values
            
            
            if let hts = self.statItems.StolenBases{
                self.stolenbase.text = "\(Int(hts))"
            }else{
                self.stolenbase.text = "0"
            }
            
            
            if let pen = self.statItems.HomeRuns{
                self.HomeRuns.text = "\(Int(pen))"
            }else{
                self.HomeRuns.text = "0"
            }
            
            if let plmi = self.statItems.RunsBattedIn{
                self.Rbis.text = "\(Int(plmi))"
            }else{
                self.Rbis.text = "0"
            }
            
            if let so = self.statItems.Strikeouts{
                self.strikeout.text = "\(Int(so))"
            }else{
                self.strikeout.text = "0"
            }
            
            if let bb = self.statItems.Walks{
                self.walks.text = "\(Int(bb))"
            }else{
                self.walks.text = "0"
            }
            
            
            
            // for goalies
            if let x = statItems.Position{
                if x == "SP"{
                    hitsLabel.text = "Saves"
                    atbatslabel.text = "Wins"
                    avgLabel.text = "Losses"
                
                    RBILabel.text = "walks"
                    stolenBaseLabel.text = "ERA"
                    homerunLabel.text = "Strikeouts"
                    walkLabel.text = "Innings"
                    strikeout.text = "ER"
   
                    if let svs = self.statItems.Saves{
                        self.hits.text = "\(Int(svs))"
                    }
                    if let wins = self.statItems.Wins{
                        self.atBats.text = "\(Int(wins))"
                    }
                    if let lost = self.statItems.Losses{
                        self.Avg.text = "\(Int(lost))"
                    }
                    
                    if let so = statItems.PitchingStrikeouts{
                        self.HomeRuns.text = "\(Int(so))"
                    }
                    if let sa = statItems.PitchingWalks{
                        self.Rbis.text = "\(Int(sa))"
                    }
              /*      if let ga = statItems.EarnedRunAverage{
                        self.stolenbase.text = "\(Int(ga))"
                    } */
                    
                    if let gapd = self.statItems.Games{
                        self.gamesPlayed.text = "\(Int(gapd))"
                        
                        if let Ips = self.statItems.InningsPitchedFull{
                            self.walks.text = "\(Int(Ips))"
                            
                            if let ers = self.statItems.PitchingEarnedRuns{
                                self.strikeout.text = "\(Int(ers))"
                                
                                self.stolenbase.text = "\(Double(ers)*9 / Double(Ips))"
                               
                            }
                            
                        }
                        
                    }else{
                        self.hits.text = "0"
                        self.atBats.text = "0"
                        self.gamesPlayed.text = "0"
                        self.Avg.text = "0"
                        self.strikeout.text = "0"
                        self.walks.text = "0"

                    }

    
                }
                
            }
            if let x = statItems.Position{
                if x == "RP"{
                    hitsLabel.text = "Saves"
                    atbatslabel.text = "Wins"
                    avgLabel.text = "Losses"
                
                    RBILabel.text = "walks"
                    stolenBaseLabel.text = "ERA"
                    homerunLabel.text = "Strikeouts"
                    walkLabel.text = "IP"
                    strikeOutsLabel.text = "Runs"
   
                    if let svs = self.statItems.Saves{
                        self.hits.text = "\(Int(svs))"
                    }
                    if let wins = self.statItems.Wins{
                        self.atBats.text = "\(Int(wins))"
                    }
                    if let lost = self.statItems.Losses{
                        self.Avg.text = "\(Int(lost))"
                    }
                    
                    if let so = statItems.PitchingStrikeouts{
                        self.HomeRuns.text = "\(Int(so))"
                    }
                    if let sa = statItems.PitchingWalks{
                        self.Rbis.text = "\(Int(sa))"
                    }
                    if let ga = statItems.EarnedRunAverage{
                        self.stolenbase.text = "\(Int(ga))"
                    }
                    if let gapd = self.statItems.Games{
                        self.gamesPlayed.text = "\(Int(gapd))"
                        
                        if let Ips = self.statItems.InningsPitchedFull{
                            self.walks.text = "\(Int(Ips))"
                            
                            if let ers = self.statItems.PitchingEarnedRuns{
                                self.strikeout.text = "\(Int(ers))"
                                
                                self.stolenbase.text = "\(Double(ers)*9 / Double(Ips))"
                               
                            }
                            
                        }
                        
                    }else{
                        self.hits.text = "0"
                        self.atBats.text = "0"
                        self.gamesPlayed.text = "0"
                        self.Avg.text = "0"
                        self.walks.text = "0"
                        self.strikeout.text = "0"

                    }
    
                }
                
            }
            
            
        }

    }
    
    //request stats from player
 func requestStats(completion: @escaping (Stats?, Error?) -> Void){
        
        guard let url = URL(string: "https://api.sportsdata.io/v3/mlb/stats/json/PlayerSeasonStatsByPlayer/2022/\(id)?key=bb4d7ff390ab44d78d7cd4bfafdf1233") else{
            completion(nil, NetworkError.couldNotParseUrl)
            return
        }
        let task = urlSession.dataTask(with: url){ data, response, error in
            if error != nil{
                completion(nil, error)
            }
            
            guard let responseData = data else{
                completion(nil, NetworkError.noResponseData)
            return}
            
            let decoder = JSONDecoder()
            
            do{
                let responseData = try decoder.decode(Stats.self, from: responseData)
                completion(responseData, nil)
            }catch{
                print(error)
                completion(nil, error)
            }
        }
        task.resume()
    }
    
}
