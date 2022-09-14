//
//  Ticket.swift
//  FeverPitcher
//
//  Created by Consultant on 26/08/2022.
//

import Foundation

// MARK: - Welcome
struct Welcome: Codable {
    let events: [Event]
    let meta: Meta
}

struct EventItem: Codable{
    
    var array: [Event]
    
    init(){
        self.array = []
    }
   
}

// MARK: - Event
struct Event: Codable {
    let type: TypeEnum
    let id: Int
    let datetimeUTC: String
    let venue: Venue
    let datetimeTbd: Bool
    let performers: [Performer]
    let isOpen: Bool
    let datetimeLocal: String
    let timeTbd: Bool
    let shortTitle, visibleUntilUTC: String
    let stats: EventStats
    let taxonomies: [Taxonomy]
    let url: String
    let score: Double
    let announceDate: AnnounceDate
    let createdAt: String
    let dateTbd: Bool
    let title: String
    let popularity: Double
    let eventDescription: String
    let status: Status
    let accessMethod: AccessMethod?
    let eventPromotion: EventPromotion?
    let announcements: Announcements
    let conditional: Bool


    enum CodingKeys: String, CodingKey {
        case type, id
        case datetimeUTC = "datetime_utc"
        case venue
        case datetimeTbd = "datetime_tbd"
        case performers
        case isOpen = "is_open"
        case datetimeLocal = "datetime_local"
        case timeTbd = "time_tbd"
        case shortTitle = "short_title"
        case visibleUntilUTC = "visible_until_utc"
        case stats, taxonomies, url, score
        case announceDate = "announce_date"
        case createdAt = "created_at"
        case dateTbd = "date_tbd"
        case title, popularity
        case eventDescription = "description"
        case status
        case accessMethod = "access_method"
        case eventPromotion = "event_promotion"
        case announcements, conditional
    }
}

// MARK: - AccessMethod
struct AccessMethod: Codable {
    let method: Method
    let createdAt: Date
    let employeeOnly: Bool

    enum CodingKeys: String, CodingKey {
        case method
        case createdAt = "created_at"
        case employeeOnly = "employee_only"
    }
}

enum Method: String, Codable {
    case none = "NONE"
    case pdf417 = "PDF417"
    case qrcodeTm = "QRCODE_TM"
}

enum AnnounceDate: String, Codable {
    case the20210804T000000 = "2021-08-04T00:00:00"
    case the20211027T000000 = "2021-10-27T00:00:00"
}

// MARK: - Announcements
struct Announcements: Codable {
}

// MARK: - EventPromotion
struct EventPromotion: Codable {
    let headline, additionalInfo: String
    let images: EventPromotionImages

    enum CodingKeys: String, CodingKey {
        case headline
        case additionalInfo = "additional_info"
        case images
    }
}

// MARK: - EventPromotionImages
struct EventPromotionImages: Codable {
    let icon: String
    let png2X, png3X: String

    enum CodingKeys: String, CodingKey {
        case icon
        case png2X = "png@2x"
        case png3X = "png@3x"
    }
}

// MARK: - Performer
struct Performer: Codable {
    let type: TypeEnum
    let name: String
    let image: String
    let id: Int
    let images: PerformerImages
    let divisions: [Division]
    let hasUpcomingEvents: Bool
    let primary: Bool?
    let stats: PerformerStats
    let taxonomies: [Taxonomy]
    let imageAttribution, url: String
    let score: Double
    let slug: String
    let homeVenueID: Int
    let shortName: String
    let numUpcomingEvents: Int
    let colors: Colors
    let imageLicense: String
    let popularity: Int
    let homeTeam: Bool?
    let location: Location
    let imageRightsMessage: String
    let awayTeam: Bool?

    enum CodingKeys: String, CodingKey {
        case type, name, image, id, images, divisions
        case hasUpcomingEvents = "has_upcoming_events"
        case primary, stats, taxonomies
        case imageAttribution = "image_attribution"
        case url, score, slug
        case homeVenueID = "home_venue_id"
        case shortName = "short_name"
        case numUpcomingEvents = "num_upcoming_events"
        case colors
        case imageLicense = "image_license"
        case popularity
        case homeTeam = "home_team"
        case location
        case imageRightsMessage = "image_rights_message"
        case awayTeam = "away_team"
    }
}

// MARK: - Colors
struct Colors: Codable {
    let all: [String]
    let iconic: String
    let primary: [String]
}

// MARK: - Division
struct Division: Codable {
    let taxonomyID: Int
    let shortName: String?
    let displayName: String
    let displayType: DisplayType
    let divisionLevel: Int
    let slug: String?

    enum CodingKeys: String, CodingKey {
        case taxonomyID = "taxonomy_id"
        case shortName = "short_name"
        case displayName = "display_name"
        case displayType = "display_type"
        case divisionLevel = "division_level"
        case slug
    }
}

enum DisplayType: String, Codable {
    case division = "Division"
    case league = "League"
}

// MARK: - PerformerImages
struct PerformerImages: Codable {
    let huge: String
}

// MARK: - Location
struct Location: Codable {
    let lat, lon: Double
}

// MARK: - PerformerStats
struct PerformerStats: Codable {
    let eventCount: Int

    enum CodingKeys: String, CodingKey {
        case eventCount = "event_count"
    }
}

// MARK: - Taxonomy
struct Taxonomy: Codable {
    let id: Int
    let name: TypeEnum
    let parentID: Int?
    let documentSource: DocumentSource?
    let rank: Int

    enum CodingKeys: String, CodingKey {
        case id, name
        case parentID = "parent_id"
        case documentSource = "document_source"
        case rank
    }
}

// MARK: - DocumentSource
struct DocumentSource: Codable {
    let sourceType: SourceType
    let generationType: GenerationType

    enum CodingKeys: String, CodingKey {
        case sourceType = "source_type"
        case generationType = "generation_type"
    }
}

enum GenerationType: String, Codable {
    case full = "FULL"
}

enum SourceType: String, Codable {
    case elastic = "ELASTIC"
}

enum TypeEnum: String, Codable {
    case baseball = "baseball"
    case mlb = "mlb"
    case sports = "sports"
}

// MARK: - EventStats
struct EventStats: Codable {
    let listingCount, averagePrice, lowestPriceGoodDeals, lowestPrice: Int
    let highestPrice, visibleListingCount: Int
    let dqBucketCounts: [Int]
    let medianPrice, lowestSgBasePrice, lowestSgBasePriceGoodDeals: Int

    enum CodingKeys: String, CodingKey {
        case listingCount = "listing_count"
        case averagePrice = "average_price"
        case lowestPriceGoodDeals = "lowest_price_good_deals"
        case lowestPrice = "lowest_price"
        case highestPrice = "highest_price"
        case visibleListingCount = "visible_listing_count"
        case dqBucketCounts = "dq_bucket_counts"
        case medianPrice = "median_price"
        case lowestSgBasePrice = "lowest_sg_base_price"
        case lowestSgBasePriceGoodDeals = "lowest_sg_base_price_good_deals"
    }
}

enum Status: String, Codable {
    case normal = "normal"
}

// MARK: - Venue
struct Venue: Codable {
    let state, nameV2, postalCode, name: String
  //  let links: [JSONAny]
    let timezone: Timezone
    let url: String
    let score: Double
    let location: Location
    let address: String
    let country: Country
    let hasUpcomingEvents: Bool
    let numUpcomingEvents: Int
    let city, slug, extendedAddress: String
    let id, popularity: Int
    let accessMethod: AccessMethod?
    let metroCode, capacity: Int
    let displayLocation: String

    enum CodingKeys: String, CodingKey {
        case state
        case nameV2 = "name_v2"
        case postalCode = "postal_code"
        case name, timezone, url, score, location, address, country
        case hasUpcomingEvents = "has_upcoming_events"
        case numUpcomingEvents = "num_upcoming_events"
        case city, slug
        case extendedAddress = "extended_address"
        case id, popularity
        case accessMethod = "access_method"
        case metroCode = "metro_code"
        case capacity
        case displayLocation = "display_location"
    }
}

enum Country: String, Codable {
    case canada = "Canada"
    case us = "US"
}

enum Timezone: String, Codable {
    case americaChicago = "America/Chicago"
    case americaNewYork = "America/New_York"
    case americaToronto = "America/Toronto"
}

// MARK: - Meta
struct Meta: Codable {
    let total, took, page, perPage: Int
 //   let geolocation: JSONNull?

    enum CodingKeys: String, CodingKey {
        case total, took, page
        case perPage = "per_page"
    }
}
