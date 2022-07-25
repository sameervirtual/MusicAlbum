//
//  Webservices.swift
//  MusicAlbum
//
//  Created by Sameer on 25/07/22.
//

import Foundation


enum StaticEndpoints {
    case developmentURL
    case stagingURL
    case productionURL
    
    var strEndPoint: String {
        switch self {
        
        case .developmentURL:
            return  "https://rss.applemarketingtools.com/api/v2/"
        case .stagingURL:
            return "https://rss.applemarketingtools.com/api/v2/"
        case .productionURL:
            return "https://rss.applemarketingtools.com/api/v2/"
        }
    }
}



enum EnumImageSize: String {
    
    case medinum = "/500x300bb.jpg"

    static func getVal(val: EnumImageSize) -> String {
        return val.rawValue
    }
}

class Webservices: NSObject {
    
    
    
    enum EnumWebApi: String {
        
        case musicAlbum = "music/most-played/"
        
        static func getVal(val: EnumWebApi) -> String {
            return val.rawValue
        }
    }
    
    enum EnumApiExtension: String {
        
        case albumsJson = "albums.json"
        
        static func getVal(val: EnumApiExtension) -> String {
            return val.rawValue
        }
    }
    
    
    enum EnumWebParameter: String {
        
        case feed
        
        static func getText(value: EnumWebParameter) -> String {
           return value.rawValue
        }
    }
    
    // MARK: - Private functions
    private static func getData(url: URL,
                                completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    // MARK: - Public function
    
    /// downloadImage function will download the thumbnail images
    /// returns Result<Data> as completion handler
    ///
    public static func downloadImage(url: URL,
                                     completion: @escaping (Result<Data>) -> Void) {
        Webservices.getData(url: url) { data, response, error in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data, error == nil else {
                return
            }
            
            DispatchQueue.main.async() {
                completion(.success(data))
            }
        }
    }
    
    
    static func getMusicAlbum(count: Int, onCompletion completion:@escaping (FeedModel?) -> ()) {
        
        if !Reachability.isConnectedToNetwork() {
            Alert.showAlert(strMessage: EnumErrorMsg.getText(value: .noInternet))
            return
        }
        
        print("Internet Connection Available!")

        if let url = URL(string: "\(baseURL)\(String.deviceCountry)/\(EnumWebApi.getVal(val: .musicAlbum))\(count)/\(EnumApiExtension.getVal(val: .albumsJson))") {
            
            Webservices.getData(url: url) { (data, response, error) in
                
                if error == nil, let data = data {
                    
                    if let result = Webservices.dataToJSON(data: data) as? Parameters {
                        
                        if let dictFeed = Webservices.checkInsideDict(value: result, key: EnumWebParameter.getText(value: .feed)) {
                            
                            if let arrTemp =  Webservices.decordResponse(type: FeedModel.self, arrValues: [dictFeed]) as? [FeedModel], arrTemp.count > 0 {
                                completion(arrTemp.first)
                                return
                            }
                        }
                        
                    }
                }
                else if let error = error {
                    Alert.showAlert(strMessage: error.localizedDescription)
                }
                completion(nil)
            }
        }
    }
    
    //MARK: - convert methods
    
    static func dataToJSON(data: Data) -> Any? {
        
        do {
            return try JSONSerialization.jsonObject(with: data, options: []) as Any
        } catch _ as NSError {
        }
        return nil
    }
    
    class func stringifyJson(_ value: Any, prettyPrinted: Bool = false) -> NSString {
        let options = prettyPrinted ? JSONSerialization.WritingOptions.prettyPrinted : .prettyPrinted
        if JSONSerialization.isValidJSONObject(value) {
            if let data = try? JSONSerialization.data(withJSONObject: value, options: options) {
                if let string = NSString(data: data, encoding: String.Encoding.utf8.rawValue) {
                    return string
                }
            }
        }
        return ""
    }
    
    static func checkInsideDict(value: Parameters, key: String) -> [String : Any]? {
        
        if value[key] != nil && value[key] is NSDictionary {
            return value[key] as? [String : Any]
        }
        return nil
    }
    
    static func checkInsideArray(value: Parameters, key: String) -> NSArray? {
        
        if value[key] != nil && value[key] is NSArray {
            return value[key] as? NSArray
        }
        return nil
    }
    
    
    static func decordResponse<T: Decodable>(type: T.Type, arrValues: [Any]) -> [Any]?  {
        
        var arrTemp = [Any]()
        let decoder = JSONDecoder()
        
        for obj in arrValues {
            let dictObj = obj as! Parameters
            let strJson = Webservices.stringifyJson(dictObj) as String
            if let jsonData = strJson.data(using: .utf8) {
                
                do {
                    let response = try decoder.decode(type, from: jsonData)
                    arrTemp.append(response)
                } catch {
                    print("Decode error", error.localizedDescription, error)
                }
            }
        }
        return arrTemp.count > 0 ? arrTemp : nil
    }
}


/// Result enum is a generic for any type of value
/// with success and failure case
public enum Result<T> {
    case success(T)
    case failure(Error)
}


