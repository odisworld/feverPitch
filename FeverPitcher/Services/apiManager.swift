//
//  apiManager.swift
//  FeverPitcher
//
//  Created by Consultant on 27/08/2022.
//

import Foundation

enum Endpoint: String {
    case events = "/2/events" //URLComponent requires that `.path` start with a `/` or it returns `nil` for `.url`
}

struct APIManager {
    
    static let sharedInstance = APIManager()
    
    private static let baseURL = URL(string: "https://api.seatgeek.com/")
    private static let clientId = "Nzc3NDQwMnwxNDk2ODcwMjI0LjUx"
    
    static var page: Int = 1
    static var query: String?
    
    private static func apiURL(to endpoint: Endpoint, parameters: [String: Any?]?) -> URL? {
        
        guard let baseUrl = baseURL else {
            return nil
        }
        
        var components = URLComponents(url: baseUrl, resolvingAgainstBaseURL: false)
        
        // Add the path to URL
        components?.path = endpoint.rawValue
                
        // Build the parameter list
        var queryItems = [URLQueryItem]()
        
        let baseParameters = [
            "client_id": clientId
        ]
        
        queryItems.addParameters(dictionary: baseParameters)
                
        if let additionalParameters = parameters {
            queryItems.addParameters(dictionary: additionalParameters)
        }
        
        components?.queryItems = queryItems
        print(components ?? "Components is nil")
        return components?.url
    }
    
    static var eventsURL: URL? {
        get {
            return APIManager.apiURL(to: .events, parameters: [
                "type": "mlb",
                "page": page,
                "q": query ?? NSNull()]
            )
        }
        set {
            self.eventsURL = newValue
            
        }
    }
    
}
