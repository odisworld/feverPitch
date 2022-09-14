//
//  Location.swift
//  FeverPitcher
//
//  Created by Consultant on 27/08/2022.
//

import Foundation
import CoreData

struct LocationKey {
    static let location = "location"
    static let latitude = "lat"
    static let longitude = "lon"
}

public class Location: NSManagedObject, Parsable {
    
    public func parse(_ jsonData: [String : AnyObject]) {
        
        guard let latitude = jsonData[LocationKey.latitude] as? Double,
            let longitude = jsonData[LocationKey.longitude] as? Double
            else { return }
        
        self.latitude = latitude
        self.longitude = longitude
        
    }
}

extension Location {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Location> {
        return NSFetchRequest<Location>(entityName: "Location")
    }

    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var venue: Venue?

}
