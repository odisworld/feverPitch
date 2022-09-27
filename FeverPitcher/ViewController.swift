//
//  ViewController.swift
//  FeverPitcher
//
//  Created by Consultant on 15/08/2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    var eventsManager = EventsManager()

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
        let indexLocation = eventsManager.events[indexpath!.row].venue.display_location
        let indexDate = eventsManager.events[indexpath!.row].datetime_local
        vc.titletext = indexTitle
        vc.url = indexUrl
        vc.locationtext = indexLocation
        vc.datetext = indexDate
            }
    }
//randome datetext


//MARK: - Table View Methods

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventsManager.events.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as! EventTableViewCell
        
        cell.update(indexPath: indexPath, eventsManager: eventsManager)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.reloadData()
    }
   
}

//MARK: - Search Bar Methods

extension ViewController: UISearchBarDelegate {
    
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


