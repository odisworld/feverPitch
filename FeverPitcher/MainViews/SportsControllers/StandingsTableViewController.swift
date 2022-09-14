//
//  StandingsTableViewController.swift
//  FeverPitcher
//
//  Created by Consultant on 25/08/2022.//

import UIKit

class StandingsTableViewController: UITableViewController {

    
    enum Result<T> {
       case success(T)
       case failure(Error)
    }
    
    enum NetworkError: Error{
        case couldNotParseUrl
        case noResponseData
    }
    private var teamData: Data = Data.init()
    let activityIndicatorView = UIActivityIndicatorView()
    let cellIdentifier = "StandingIdentifier"
    private let urlSession = URLSession.shared
    private var teamsItems: TeamItem = TeamItem()
    private var standingItems: StandingsItem = StandingsItem()
    private var logoData: Data = Data.init()
    var logoUrl: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(activityIndicatorView)
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        activityIndicatorView.startAnimating()
        
        getStandings(completion: { [weak self] standingItem, error in
           print(error)
            guard let item = standingItem else{ return}
            print(item)
            
            self?.standingItems.array = item
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                self?.activityIndicatorView.stopAnimating()

            }
        })
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return standingItems.array.count
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? StandingTableViewCell else {
            fatalError("Could not find a team")        }
        
       
     //   let teamItem = standingItems.array[indexPath.row]
        let standingItem = standingItems.array[indexPath.row]
      //  var id = standingItem.TeamID
        cell.NameOfTeam.text = "\(standingItem.City) \(standingItem.Name)"
        cell.Division.text = standingItem.Division
        
    //    cell.GamesBack
      //      .text = "\(Int(standingItem.DivisionRank))"
        
        cell.wins.text = "\(Int(standingItem.Wins))"
        
        cell.loss.text = "\(Int(standingItem.Losses))"
        
        cell.percentage.text = "\(Double(standingItem.Percentage))"
        
     //   cell.RS.text = "\(Int(standingItem.RunsScored))"
        
        cell.league.text = standingItem.League
        
    //    cell.runsAllowed.text = "\(Int(standingItem.RunsAgainst))"
        
        
        
        
            return cell
        }
        
       private func getStandings(completion: @escaping ([Standings]?, Error?) -> Void) {
                let fullURL = "https://api.sportsdata.io/v3/mlb/scores/json/Standings/2022?key=bb4d7ff390ab44d78d7cd4bfafdf1233"
                guard let url = URL(string: fullURL) else {return}
                let request = URLRequest(url: url)
                
            let task = urlSession.dataTask(with: url){ data, response, error in
                if error != nil{
                    completion(nil, error)
                }
                    
                    guard let data = data else {
                        completion(nil, NetworkError.noResponseData)
                        return}
                    
                    do {
                        let allStandings = try JSONDecoder().decode([Standings].self, from: data)
                        
                        DispatchQueue.main.sync {
                            var foobar: [String: [Standings]] = [
                                "AL": [Standings](),
                                "NL": [Standings]()
                            ]
                            
                            for standing in allStandings {
                                if standing.League == "AL" {
                                    foobar["AL"]!.append(standing)
                                } else {
                                    foobar["NL"]!.append(standing)
                                }
                            }
                            
                            completion(allStandings, nil)
                            print(Result.success(foobar))
                        }
                        
                    } catch {
                        print(error)
                        completion(nil, error)
                    }
                }.resume()
            }
    
    
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    

    
    // send code variable of selceted currency
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowPlayers",
           let newController = segue.destination as? PlayerTableViewController,
           let cell = sender as? StandingTableViewCell,
           let indexPath = tableView.indexPath(for: cell){
            
            let teamCode = standingItems.array[indexPath.row].Key
            newController.prevKey = teamCode
         //   newController.teamImageUrl = standingItems.array[indexPath.row].WikipediaLogoUrl
            newController.teamName = "\(standingItems.array[indexPath.row].City) \(standingItems.array[indexPath.row].Name)"
            
          
            
        }
        
        
    }
}


