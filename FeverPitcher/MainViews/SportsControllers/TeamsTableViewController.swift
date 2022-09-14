//
//  TeamsTableViewController.swift
//  Fever Pitch
//
//  Created by Consultant on 29.11.21.
//

import UIKit
import Kingfisher

class TeamsTableViewController: UITableViewController {
    
    enum NetworkError: Error{
        case couldNotParseUrl
        case noResponseData
    }
    private var teamData: Data = Data.init()
    let activityIndicatorView = UIActivityIndicatorView()
    let cellIdentifier = "TeamIdentifier"
    private let urlSession = URLSession.shared
    private var teamsItems: TeamItem = TeamItem()
    private var logoData: Data = Data.init()
    var logoUrl: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(activityIndicatorView)
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        activityIndicatorView.startAnimating()
        
        requestTeams(completion: { [weak self] teamItem, error in
           print(error)
            guard let item = teamItem else{ return}
//            print(item)
            
            self?.teamsItems.array = item
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                self?.activityIndicatorView.stopAnimating()

            }
        })
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teamsItems.array.count
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? TeamTableViewCell else {
            fatalError("Could not find a team")        }
        
        let teamItem = teamsItems.array[indexPath.row]
        cell.teamName.text = "\(teamItem.City) \(teamItem.Name)"
        
        let finalUrl = getPicture(indexPathRow: indexPath.row, itemUrl: teamItem.WikipediaLogoUrl)
        
        if let picUrl = URL(string: finalUrl){
            cell.teamLogo.kf.setImage(with: picUrl)
            teamsItems.array[indexPath.row].WikipediaLogoUrl = finalUrl
        }
        
 
        return cell
    }
    
    // loads team logo
    func loadImage(picUrl: String){
        
        guard let url  = URL(string: picUrl) else{
            return
        }
        guard let data = try? Data(contentsOf: url) else{
            return
        }
        logoData = data
        return
    }
    
    
    // url needs to be changed because api delivers only partly correct urls
    func getPicture(indexPathRow: Int, itemUrl: String?)->String{
        guard let url = itemUrl else{
            logoUrl = "https://1000logos.net/wp-content/uploads/2017/04/MLB-Logo.png"
            return "https://1000logos.net/wp-content/uploads/2017/04/MLB-Logo.png"
        }
        
        var team = teamsItems.array[indexPathRow]
        let city = team.City
        let name = team.Name
        
        
        
        // the api url for the picture is different to the other urls -> external link is necessary
        if team.TeamID == 26{
            logoUrl = "https://1000logos.net/wp-content/uploads/2017/08/Atlanta-Braves-logo.png"
            team.WikipediaLogoUrl = logoUrl
            return "https://1000logos.net/wp-content/uploads/2017/08/Atlanta-Braves-logo.png"
        }
        if team.TeamID == 14{
            logoUrl = "https://1000logos.net/wp-content/uploads/2021/05/Arizona-Diamondbacks-logo.png"
            team.WikipediaLogoUrl = logoUrl

            return "https://1000logos.net/wp-content/uploads/2021/05/Arizona-Diamondbacks-logo.png"
        }
        if team.TeamID == 3{
            logoUrl = "https://1000logos.net/wp-content/uploads/2018/02/Toronto-Blue-Jays-Logo.png"
            team.WikipediaLogoUrl = logoUrl
            return "https://1000logos.net/wp-content/uploads/2018/02/Toronto-Blue-Jays-Logo.png"
        }
        if team.TeamID == 4{
            logoUrl = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSQrU-MN5cYPFPQlehGLd12NTkW0lp1UC78XKU9ukKOYA&s"
            team.WikipediaLogoUrl = logoUrl
            return "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSQrU-MN5cYPFPQlehGLd12NTkW0lp1UC78XKU9ukKOYA&s"
        }
        if team.TeamID == 5{
            logoUrl = "https://1000logos.net/wp-content/uploads/2017/12/Kansas-City-Royals-Logo.png"
            team.WikipediaLogoUrl = logoUrl
            return "https://1000logos.net/wp-content/uploads/2017/12/Kansas-City-Royals-Logo.png"
        }
        if team.TeamID == 9{
            logoUrl = "https://1000logos.net/wp-content/uploads/2017/07/Emblem-Cubs.jpg"
            team.WikipediaLogoUrl = logoUrl
            return "https://1000logos.net/wp-content/uploads/2017/07/Emblem-Cubs.jpg"
        }
        if team.TeamID == 10{
            logoUrl = "https://1000logos.net/wp-content/uploads/2021/04/Cleveland-Indians-logo.png"
            team.WikipediaLogoUrl = logoUrl
            return "https://1000logos.net/wp-content/uploads/2021/04/Cleveland-Indians-logo.png"
        }
        if team.TeamID == 11{
            logoUrl = "https://1000logos.net/wp-content/uploads/2018/05/Tampa_Bay_Rays-Logo.png"
            team.WikipediaLogoUrl = logoUrl
            return "https://1000logos.net/wp-content/uploads/2018/05/Tampa_Bay_Rays-Logo.png"
        }
        if team.TeamID == 12{
            logoUrl = "https://1000logos.net/wp-content/uploads/2017/05/Philadelphia-Phillies-Logo.png"
            team.WikipediaLogoUrl = logoUrl
            return "https://1000logos.net/wp-content/uploads/2017/05/Philadelphia-Phillies-Logo.png"
        }
        if team.TeamID == 13{
            logoUrl = "https://1000logos.net/wp-content/uploads/2018/05/Seattle-Mariners-Logo-Cap.png"
            team.WikipediaLogoUrl = logoUrl
            return "https://1000logos.net/wp-content/uploads/2018/05/Seattle-Mariners-Logo-Cap.png"
        }
        if team.TeamID == 15{
            logoUrl = "https://1000logos.net/wp-content/uploads/2018/06/San-Francisco-Giants-Logo-1994.jpg"
            team.WikipediaLogoUrl = logoUrl
            return "https://1000logos.net/wp-content/uploads/2018/06/San-Francisco-Giants-Logo-1994.jpg"
        }
        if team.TeamID == 16{
            logoUrl = "https://1000logos.net/wp-content/uploads/2018/03/White-Sox-logo.jpg"
            team.WikipediaLogoUrl = logoUrl
            return "https://1000logos.net/wp-content/uploads/2018/03/White-Sox-logo.jpg"
        }
        if team.TeamID == 17{
            logoUrl = "https://1000logos.net/wp-content/uploads/2017/08/Detroit-Tigers-logo.jpg"
            team.WikipediaLogoUrl = logoUrl
            return "https://1000logos.net/wp-content/uploads/2017/08/Detroit-Tigers-logo.jpg"
        }
        if team.TeamID == 18{
            logoUrl = "https://1000logos.net/wp-content/uploads/2017/07/New-York-Mets-Logo.png"
            team.WikipediaLogoUrl = logoUrl
            return "https://1000logos.net/wp-content/uploads/2017/07/New-York-Mets-Logo.png"
        }
        if team.TeamID == 19{
            logoUrl = "https://1000logos.net/wp-content/uploads/2017/12/Logo-Baltimore-Orioles.png"
            team.WikipediaLogoUrl = logoUrl
            return "https://1000logos.net/wp-content/uploads/2017/12/Logo-Baltimore-Orioles.png"
        }
        if team.TeamID == 20{
            logoUrl = "https://1000logos.net/wp-content/uploads/2017/11/Minnesota-Twins-Logo.png"
            team.WikipediaLogoUrl = logoUrl
            return "https://1000logos.net/wp-content/uploads/2017/11/Minnesota-Twins-Logo.png"
        }
        if team.TeamID == 21{
            logoUrl = "https://1000logos.net/wp-content/uploads/2018/05/Los-Angeles-Angels-of-Anaheim-Logo.png"
            team.WikipediaLogoUrl = logoUrl
            return "https://1000logos.net/wp-content/uploads/2018/05/Los-Angeles-Angels-of-Anaheim-Logo.png"
        }
        if team.TeamID == 22{
            logoUrl = "https://1000logos.net/wp-content/uploads/2017/04/Miami-Marlins-Logo.png"
            team.WikipediaLogoUrl = logoUrl
            return "https://1000logos.net/wp-content/uploads/2017/04/Miami-Marlins-Logo.png"
        }
        if team.TeamID == 23{
            logoUrl = "https://1000logos.net/wp-content/uploads/2018/06/Oakland-Athletics-Logo.png"
            team.WikipediaLogoUrl = logoUrl
            return "https://1000logos.net/wp-content/uploads/2018/06/Oakland-Athletics-Logo.png"
        }
        if team.TeamID == 24{
            logoUrl = "https://1000logos.net/wp-content/uploads/2017/12/Kansas-City-Royals-Logo.png"
            team.WikipediaLogoUrl = logoUrl
            return "https://1000logos.net/wp-content/uploads/2017/12/Kansas-City-Royals-Logo.png"
        }
        if team.TeamID == 25{
            logoUrl = "https://1000logos.net/wp-content/uploads/2016/10/Boston-Red-Sox-Logo-1-1024x640.png"
            team.WikipediaLogoUrl = logoUrl
            return "https://1000logos.net/wp-content/uploads/2016/10/Boston-Red-Sox-Logo-1-1024x640.png"
        }
        
        if team.TeamID == 27{
            logoUrl = "https://1000logos.net/wp-content/uploads/2017/12/Kansas-City-Royals-Logo.png"
            team.WikipediaLogoUrl = logoUrl
            return "https://1000logos.net/wp-content/uploads/2017/12/Kansas-City-Royals-Logo.png"
        }
        if team.TeamID == 28{
            logoUrl = "https://1000logos.net/wp-content/uploads/2017/06/Texas-Rangers-Logo.png"
            team.WikipediaLogoUrl = logoUrl
            return "https://1000logos.net/wp-content/uploads/2017/06/Texas-Rangers-Logo.png"
            
        }
        if team.TeamID == 29{
            logoUrl = "https://1000logos.net/wp-content/uploads/2017/05/New-York-Yankees-Logo-1024x640.png"
            team.WikipediaLogoUrl = logoUrl
            return "https://1000logos.net/wp-content/uploads/2017/05/New-York-Yankees-Logo-1024x640.png"
            
    }
        if team.TeamID == 30{
            logoUrl = "https://1000logos.net/wp-content/uploads/2017/08/Astros-Logo-768x591.png"
            team.WikipediaLogoUrl = logoUrl
            return "https://1000logos.net/wp-content/uploads/2017/08/Astros-Logo-768x591.png"
            
}
        
//        // all star teams
//        if team.TeamID == 31 || team.TeamID == 32 || team.TeamID == 33 || team.TeamID == 34{
//            return "https://www.pngall.com/wp-content/uploads/2/NHL-PNG-File.png"
//        }
    
        
        let cityParts = city.components(separatedBy: " ")
      
        // if name contains of 2 words, e.g "New York"
        var cityString: String = city
        if cityParts.count == 2{
            cityString = "\(cityParts[0])_\(cityParts[1])"
        }
        let nameParts = name.components(separatedBy: " ")

        var nameString: String = name
        
        if nameParts.count == 2{
            nameString = "\(nameParts[0])_\(nameParts[1])"
        }
        
        let id = team.TeamID
        
//        api delivers already correct image for those 2 images
        if id == 26 || id == 28{
            return url
        }
  
        if let url: String = team.WikipediaLogoUrl{

            let addOn: String = "/800px-\(cityString)_\(nameString)_logo.svg.png"
            let urlParts = url.components(separatedBy: "/en")
//            print(urlParts)

            let string: String = urlParts[0] + "/en/thumb" + addOn
        //    print(urlParts[1])
           // print(string)
            return string
        }
        logoUrl = "https://1000logos.net/wp-content/uploads/2017/04/MLB-Logo.png"
        team.WikipediaLogoUrl = logoUrl

        return "https://1000logos.net/wp-content/uploads/2017/04/MLB-Logo.png"
        

        
    }
    
    
    // get team
    private func requestTeams(completion: @escaping ([Team]?, Error?) -> Void) {
        
        guard let url = URL(string: "https://api.sportsdata.io/v3/mlb/scores/json/AllTeams?key=bb4d7ff390ab44d78d7cd4bfafdf1233") else {
            completion(nil, NetworkError.couldNotParseUrl)
            return
        }
//        print(url)
        let task = urlSession.dataTask(with: url){ data, response, error in
            if error != nil{
                completion(nil, error)
            }
            
            guard let responseData = data else{
                completion(nil, NetworkError.noResponseData)
                return}
            
            let decoder = JSONDecoder()
            
            do{
                let responseData = try decoder.decode([Team].self, from: responseData)
                completion(responseData, nil)
                
            } catch{
                print(error)
                completion(nil, error)
            }
            
            
            
        }
        task.resume()
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
 
    // send code variable of selceted currency
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowPlayers",
           let newController = segue.destination as? PlayerTableViewController,
           let cell = sender as? TeamTableViewCell,
           let indexPath = tableView.indexPath(for: cell){
            
            let teamCode = teamsItems.array[indexPath.row].Key
            newController.prevKey = teamCode
            newController.teamImageUrl = teamsItems.array[indexPath.row].WikipediaLogoUrl
            newController.teamName = "\(teamsItems.array[indexPath.row].City) \(teamsItems.array[indexPath.row].Name)"
            
          
            
        }
        
        
    }
}

