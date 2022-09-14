//
//  apiService.swift
//  FeverPitcher
//
//  Created by Consultant on 27/08/2022.
//

import Foundation

public typealias JSON = [String: AnyObject]

enum Result {
    case success(Any)
    case failure(Error)
}

class APIService {
    
    private static let errorDomain = "com.dubdub.apiservice.error"
    
    private var ignoredErrors = Array<Int>()
    
    private let session: URLSession = {
        return URLSession(configuration: .default)
    }()
    
    private func cancelAllPreviousTasks() {
        session.getAllTasks { (tasks) in
            _ = tasks.map{$0.cancel()}
        }
    }
    
    private func getEventsFor(query: String?, onPage page: Int, completion: @escaping (Result) -> Void) {
        
        guard let queryString = query else {
            let error = NSError(domain: APIService.errorDomain, code: 400, userInfo: [NSLocalizedDescriptionKey: "Invalid Query"])
            completion(.failure(error))
            return
        }
        
        APIManager.query = queryString
        APIManager.page = page
        let url = APIManager.eventsURL
        print(url)
        
        guard let uri = url else {
            let error = NSError(domain: APIService.errorDomain, code: 404, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])
            completion(.failure(error))
            return
        }
        
        let request = URLRequest(url: uri)
        
        cancelAllPreviousTasks()
        
        let task = session.dataTask(with: request) { (data, response, error) in
            
            guard let httpResponse = response as? HTTPURLResponse else {
                if let err = error as NSError? {
                    print(err.localizedDescription)
                    if err.code != (-999) {
                        completion(.failure(err))
                    }
                }
                return
            }
            
            if httpResponse.statusCode == 200 {
                if let data = data {
                    do {
                        if let jsonData = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? JSON {
                            DispatchQueue.global(qos: .background).async {
                                let dataManager = DataManager()
                                dataManager.processJSON(jsonData)
                            }
                            
                            completion(.success(httpResponse))
                            print(httpResponse)
                        }
                    } catch {
                        completion(.failure(error))
                    }
                } else {
                    let error = NSError(domain: APIService.errorDomain, code: 400, userInfo: [NSLocalizedDescriptionKey: "Invalid data received"])
                    completion(.failure(error))
                }
            }
        }
        
        task.resume()
    }
    
    func getEventsFor(query: String?, completion: @escaping (Result) -> Void) {
        getEventsFor(query: query, onPage: 1, completion: completion)
    }
    
    func getEventsOnNextPage(completion: @escaping (Result) -> Void){
        getEventsFor(query: APIManager.query, onPage: APIManager.page + 1, completion: completion)
    }
    
    func ignoreErrorWithCode(_ errorCode: Int?) {
        if let code = errorCode {
            ignoredErrors.append(code)
        }
    }
    
    func acceptAllErrors() {
        ignoredErrors.removeAll()
    }
}
