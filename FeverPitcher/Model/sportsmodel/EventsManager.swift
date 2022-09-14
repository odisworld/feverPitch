//
//  EventManager.swift
//  FeverPitcher
//
//  Created by Consultant on 27/08/2022.
//
//

import Foundation
import UIKit
//https://api.seatgeek.com/2/events?client_id=Nzc3NDQwMnwxNDk2ODcwMjI0LjUx&type=mlb&page=1&q=Arizona
class EventsManager {
    var endPoint = "type=mlb"
    var events = [Event]()
    let eventsURL = "https://api.seatgeek.com/2/events"
    let clientID = "client_id=Nzc3NDQwMnwxNDk2ODcwMjI0LjUx&type=mlb&per_page=25"
    let fullEventsURL = "https://api.seatgeek.com/2/events?client_id=Nzc3NDQwMnwxNDk2ODcwMjI0LjUx&type=mlb&per_page=50&page=1"
    
    //queries the SeatGeek API for the user's search criteria
    func fetchEventsForSearchBar(searchInput: String, tableView: UITableView) {
        let urlString = "\(eventsURL)?q=\(searchInput)&\(clientID)"
        performRequest(urlString: urlString, tableView: tableView)
    }
    
    //queries the SeatGeek API only using the assigned clientID
    func fetchAllEvents(tableView: UITableView) {
        let urlString = fullEventsURL
        print(urlString)
        performRequest(urlString: urlString, tableView: tableView)
    }
    
    //starts networking session
    func performRequest(urlString: String, tableView: UITableView) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                if let safeData = data  {
                    self.parse(json: safeData, tableView: tableView)
                    print(safeData)
                }
            }
            task.resume()
        }
    }
    
    //parse data from the JSON
    func parse(json: Data, tableView: UITableView) {
        let decoder = JSONDecoder()
        
        if let decodedData = try? decoder.decode(Events.self, from: json) {
            events = decodedData.events
            DispatchQueue.main.async {
                tableView.reloadData()
            }
        }
    }
}
