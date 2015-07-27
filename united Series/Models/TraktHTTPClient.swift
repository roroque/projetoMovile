//
//  TraktHTTPClient.swift
//  united Series
//
//  Created by iOS on 7/22/15.
//  Copyright (c) 2015 gabriel. All rights reserved.
//

import UIKit
import Alamofire
import Result
import TraktModels


class TraktHTTPClient {
    
    
    private lazy var manager: Alamofire.Manager = {
        let configuration: NSURLSessionConfiguration = {
            var configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
            var headers = Alamofire.Manager.defaultHTTPHeaders
            headers["Accept-Encoding"] = "gzip"
            headers["Content-Type"] = "application/json"
            headers["trakt-api-version"] = "2"
            headers["trakt-api-key"] = "94c634619a67cdb3c5b979261e66c88782d5ed7e19312923a92564c840f820b0"
            configuration.HTTPAdditionalHeaders = headers
            return configuration
        }()
        
        return Manager(configuration: configuration)
    }()
    
    func getShow(id: String, completion: ((Result<Show, NSError?>) -> Void)?) {
        
        getJSONElement(Router.Show(id), completion: completion)
                
    }
    
    func getEpisode(showId: String, season: String, episodeNumber: String,    completion: ((Result<Episode, NSError?>) -> Void)?) {
    
        let router = Router.Episode(showId, season, episodeNumber)
        
        getJSONElement(router, completion: completion)

        
    }
    
    
    func getPopularShows(completion: ((Result<[Show], NSError?>) -> Void)?) {
        getJSONElements(Router.PopularShows, completion: completion)
    }
    
    func getSeasons(showId: String,completion: ((Result<[Season], NSError?>) -> Void)?) {
        let router = Router.Seasons(showId)
        getJSONElements(router, completion: completion)
    }
    
    
    func getEpisodes(showId: String, season: Int,completion: ((Result<[Episode], NSError?>) -> Void)?) {
        getJSONElements(Router.Episodes(showId, season.description), completion: completion)
    }
    
    
    private func getJSONElements<T: JSONDecodable>(router: Router,completion: ((Result<[T], NSError?>) -> Void)?) {
        manager.request(router).validate().responseJSON { (_, _, responseObject, error)  in
            if let jsonArray = responseObject as? [NSDictionary] {
                let values =  jsonArray.map { T.decode($0) }.filter { $0 != nil }.map { $0! }
                completion?(Result.success(values))
               
            } else {
                completion?(Result.failure(error))
            }
        }
    }
    
    
    
  
    
    
   private func getJSONElement<T: JSONDecodable>(router: Router,completion: ((Result<T, NSError?>) -> Void)?) {
        manager.request(router).validate().responseJSON { (_, _, responseObject, error)  in
            if let json = responseObject as? NSDictionary {
                if let value = T.decode(json) {
                    completion?(Result.success(value))
                } else {
                    completion?(Result.failure(nil))
                }
            } else {
                completion?(Result.failure(error))
            }
        }
    }
    

    
    
    private enum Router: URLRequestConvertible {
                
                static let baseURLString = "https://api-v2launch.trakt.tv/"
                case Show(String)
                case PopularShows
                case Episode(String,String,String)
                case Seasons(String)
                case Episodes(String,String)
        

                // MARK: URLRequestConvertible
                var URLRequest: NSURLRequest {
                    let (path: String, parameters: [String: AnyObject]?, method: Alamofire.Method) = {
                    switch self {
                        case .Show(let id):
                        return ("shows/\(id)", ["extended": "images,full"], .GET)
                        case .PopularShows:
                        return ("shows/popular", ["limit": 50, "extended": "images"], .GET)
                        case .Episode(let id, let season, let epNum):
                            return("shows/\(id)/seasons/\(season)/episodes\(epNum)",["extended" : "full"] , .GET)
                    case .Seasons(let id):
                        return ("shows/\(id)/seasons",["extended": "images,full"], .GET)
                    case .Episodes(let id, let season):
                        return ("shows/\(id)/seasons/\(season)",["extended" : "images,full"], .GET)

                    }
                }()
                
                let URL = NSURL(string: Router.baseURLString)!
                let URLRequest = NSMutableURLRequest(URL: URL.URLByAppendingPathComponent(path))
                URLRequest.HTTPMethod = method.rawValue
                let encoding = Alamofire.ParameterEncoding.URL
                return encoding.encode(URLRequest, parameters: parameters).0
            
                }
                
                
            

    }
    
    
    
    
    
    
    
    
    
}