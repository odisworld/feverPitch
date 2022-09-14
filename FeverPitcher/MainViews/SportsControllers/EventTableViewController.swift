//
//  TicketTableViewController.swift
//  FeverPitcher
//
//  Created by Consultant on 26/08/2022.
//

import UIKit

class EventTableViewController: UITableViewController {

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
    let cellIdentifier = "EventIdentifier"
    private let urlSession = URLSession.shared
    private var eventsItems: EventItem = EventItem()
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
        
        getEvents(completion: { [weak self] eventItem, error in
           print(error)
            guard let item = eventItem else{ return}
            print(item)
            
            self?.eventsItems.array = item
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                self?.activityIndicatorView.stopAnimating()

            }
        })
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventsItems.array.count
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? EventTableViewCell else {
            fatalError("Could not find a team")        }
        
       
     //   let teamItem = standingItems.array[indexPath.row]
        let standingItem = eventsItems.array[indexPath.row]
      //  var id = standingItem.TeamID
        cell.title.text = standingItem.title
        cell.url.text = standingItem.url
        
        
        
        
        
        
            return cell
        }
        
       private func getEvents(completion: @escaping ([Event]?, Error?) -> Void) {
           guard let url = URL(string: "https://api.seatgeek.com/2/events?client_id=Nzc3NDQwMnwxNDk2ODcwMjI0LjUx&type=mlb&page=1") else {
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
                   let responseData = try decoder.decode([Event].self, from: responseData)
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
           let cell = sender as? StandingTableViewCell,
           let indexPath = tableView.indexPath(for: cell){
            
            let teamCode = standingItems.array[indexPath.row].Key
            newController.prevKey = teamCode
         //   newController.teamImageUrl = standingItems.array[indexPath.row].WikipediaLogoUrl
            newController.teamName = "\(standingItems.array[indexPath.row].City) \(standingItems.array[indexPath.row].Name)"
            
          
            
        }
        
        
    }
}


