//
//  AlamofireDataFetcher.swift
//  AppCraftTest
//
//  Created by cannabiolog420 on 15.04.2021.
//

import Foundation
import Alamofire


class AlamofireFetcherService{
    
    
    
    static func fetchAlbums(url:String,completion:@escaping(Albums)->()){
        
        guard let url = URL(string: url) else { return }
        AF.request(url).validate().responseJSON { (response) in
            switch response.result{
            
            case .success:
                let decoded = decodeJSON(type: Albums.self, from: response.data)
                guard let albums = decoded else { return }
                completion(albums)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    static func fetchPhotos(albumId:Int,completion:@escaping(Photos)->()){
        
        let urlString = "https://jsonplaceholder.typicode.com/photos?albumId=\(albumId)"
        guard let url = URL(string: urlString) else { return }
        AF.request(url).validate().responseJSON { (response) in
            switch response.result{
            
            case .success:
                let decoded = decodeJSON(type: Photos.self, from: response.data)
                guard let photos = decoded else { return }
                completion(photos)
            case .failure(let error):
                print(error)
            }
        }
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
    
    private static func decodeJSON<T: Decodable>(type: T.Type, from: Data?) -> T? {
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
