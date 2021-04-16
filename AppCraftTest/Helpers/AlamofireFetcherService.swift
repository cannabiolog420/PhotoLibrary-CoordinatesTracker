//
//  AlamofireFetcherService.swift
//  AppCraftTest
//
//  Created by cannabiolog420 on 15.04.2021.
//

import Foundation
import Alamofire



protocol DataFetcher {
    static func fetchGenericJSONData<T: Decodable>(urlString: String, completion: @escaping (T) -> Void)
}

class AlamofireFetcherService:DataFetcher{
    
    
    static func fetchAlbums(urlString:String,completion:@escaping(Albums) -> Void){
        
        fetchGenericJSONData(urlString: urlString, completion: completion)
    }
    
    
    static func fetchPhotos(albumId:Int,completion:@escaping(Photos)->()){
        
        let urlString = "https://jsonplaceholder.typicode.com/photos?albumId=\(albumId)"
        fetchGenericJSONData(urlString: urlString, completion: completion)
    }
    
    
    
    static func fetchImage(from urlString:String,completion:@escaping(UIImage)->()){
        
        guard let url = URL(string: urlString) else { return }
        AF.request(url).validate().responseData { (response) in
            
            switch response.result{
            case .success(let imageData):
                guard let image = UIImage(data: imageData) else { return }
                completion(image)
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    
    static func fetchGenericJSONData<T: Decodable>(urlString:String,completion:@escaping (T) -> Void){
        
        guard let url = URL(string: urlString) else { return }
        
        AF.request(url).validate().responseJSON { (response) in
            
            switch response.result{
            case .success:
                let decodedJSON = AlamofireFetcherService.decodeJSON(type: T.self, from: response.data )
                guard let decoded = decodedJSON else { return }
                completion(decoded)
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    
    static func decodeJSON<T: Decodable>(type: T.Type, from: Data?) -> T? {
        let decoder = JSONDecoder()
        guard let data = from else { return nil }
        do {
            let objects = try decoder.decode(type.self, from: data)
            return objects
        } catch let jsonError {
            print("Failed to decode JSON", jsonError)
            return nil
        }
    }
    
    
}
