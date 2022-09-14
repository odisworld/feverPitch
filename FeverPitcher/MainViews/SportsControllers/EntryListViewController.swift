//
//  EventsListViewController.swift
//  FeverPitcher
//
//  Created by Consultant on 27/08/2022.
//

import UIKit
import Alamofire
import Kingfisher

class EntryListViewController: UIViewController {
    /*
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    */
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
   
    var eventsManager = EventsManager()
    var events = [Event]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 600
        
        eventsManager.fetchAllEvents(tableView: tableView)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if let index = self.tableView.indexPathForSelectedRow {
            self.tableView.deselectRow(at: index, animated: true)
        }
        navigationController?.isNavigationBarHidden = false
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    //passes over data to DetailView from chosen Event object
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! DetailViewController
        let indexpath = self.tableView.indexPathForSelectedRow
        let indexUrl = eventsManager.events[indexpath!.row].url
        let indexTitle = eventsManager.events[indexpath!.row].title
        
        vc.url = indexUrl
        vc.titletext = indexTitle
    }
}

//MARK: - Table View Methods

extension EntryListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventsManager.events.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as! EventTableViewCell
        
        cell.eventLocation.text = eventsManager.events[indexPath.row].venue.display_location
        cell.eventTitle.text = eventsManager.events[indexPath.row].title
        cell.eventDate.text = eventsManager.events[indexPath.row].getDate(datetime_local:eventsManager.events[indexPath.row].datetime_local)
        cell.eventImage.kf.setImage(with: URL(string: eventsManager.events[indexPath.row].performers[0].image))
      //  eventTitleLabel?.text = eventTitle
     //   eventImageView?.image = eventImage
       // eventDateLabel?.text = eventDate
       // eventTimeLabel?.text = eventTime
      //  eventLocationLabel?.text = eventLocation
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.reloadData()
    }
   
}

//MARK: - Search Bar Methods

extension EntryListViewController: UISearchBarDelegate {
    
    //kicks off query for user's search criteria; dismisses keyboard once search is submitted
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if let searchInput = searchBar.text {
            eventsManager.fetchEventsForSearchBar(searchInput: searchInput, tableView: tableView)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        searchBar.resignFirstResponder()
    }
    
    //searches every time text is changed within the search bar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let searchInput = searchBar.text {
            eventsManager.fetchEventsForSearchBar(searchInput: searchInput, tableView: tableView)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
}


