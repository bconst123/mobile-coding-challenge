//
//  APIManager.swift
//  mobile-coding-challenge
//
//  Created by Bruno Augusto Constantino on 3/27/21.
//  Copyright © 2021 Bruno Augusto Constantino. All rights reserved.
//

import Foundation

class ApiManager {
    
    // MARK: - URL Properties
    private var urltocall = "https://api.unsplash.com/photos"
    private let clientCredentials = "bRw9dmrl2yrSvLlB8i_sT4LtsNwcr_GvvAuA4wHMbZU"
    
    func createArrayFromAPI(offset: Int,completion: @escaping (_ resulCal: [UnsplashModel]?, _ error: Error?) -> Void) {
        guard let finalURL = URL(string: urltocall+"?page=\(String(offset))") else {
            print("Error: Cannot create URL from string")
            return
        }
        var urlRequest = URLRequest(url: finalURL)
        urlRequest.httpMethod = "GET"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("v1", forHTTPHeaderField: "Accept-Version")
        urlRequest.addValue("Client-ID \(clientCredentials)", forHTTPHeaderField: "Authorization")
        
        
        let task = URLSession.shared.dataTask(with: urlRequest) {(data, _, error) in
            guard error == nil else {
                print("Error calling api")
                return completion(nil, error)
            }
            guard let responseData = data else {
                print("Data is nil")
                return completion(nil, error)
            }
            
            do{
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let resultCall = try decoder.decode([UnsplashModel].self, from: responseData)
                return completion(resultCall, nil)
            } catch let error{
                return completion(nil, error)
            }
            
        }
        task.resume()
    }
}
