//
//  Venue.swift
//  FeverPitcher
//
//  Created by Consultant on 27/08/2022.
//

import Foundation

import Foundation
import CoreData

struct VenueKey {
    static let city = "city"
    static let country = "country"
    static let displayLocation = "display_location"
    static let identifier = "id"
    static let name = "name"
    static let postalCode = "postal_code"
    static let state = "state"
    static let street = "address"
    static let url = "url"
    static let location = "location"
}


public class Venue: NSManagedObject, Parsable {
    
    public func parse(_ jsonData: [String : AnyObject]) {
        
        guard let identifier = jsonData[VenueKey.identifier] as? Int,
            let name = jsonData[VenueKey.name] as? String,
            let street = jsonData[VenueKey.street] as? String,
            let city = jsonData[VenueKey.city] as? String,
            let state = jsonData[VenueKey.state] as? String,
            let country = jsonData[VenueKey.country] as? String,
            let postalCode = jsonData[VenueKey.postalCode] as? String,
            let displayLocation = jsonData[VenueKey.displayLocation] as? String,
            let urlString = jsonData[VenueKey.url] as? String
            else { return }
        
        self.identifier = identifier
        self.name = name
        self.street = street
        self.city = city
        self.state = state
        self.country = country
        self.postal = postalCode
        self.displayLocation = displayLocation
        self.url = NSURL(string: urlString)
        
        if let locationDict = jsonData[VenueKey.location] as? JSON,
            let context = self.managedObjectContext {
            
            let location = NSEntityDescription.insertNewObject(forEntityName: "Location", into: context) as? Location
            location?.parse(locationDict)
            
            self.location = location
            location?.venue = self
        }
    }
    
}

extension Venue {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Venue> {
        return NSFetchRequest<Venue>(entityName: "Venue")
    }

    @NSManaged public var displayLocation: String?
    @NSManaged public var identifier: Int
    @NSManaged public var name: String?
    @NSManaged public var url: NSURL?
    @NSManaged public var city: String?
    @NSManaged public var state: String?
    @NSManaged public var postal: String?
    @NSManaged public var country: String?
    @NSManaged public var street: String?
    @NSManaged public var event: Event?
    @NSManaged public var location: Location?

}
