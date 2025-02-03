//
//  NetworkManager.swift
//  AbercrombieFitch
//
//  Created by Vijay Karthik Jeyaraj on 2/1/25.
//

import Foundation

enum Error: Swift.Error {
    case invalidURL
    case invalidData
    case invalidResponse
}

public class NetworkManager {
    
    func getData<T: Decodable>(url: String, type: T.Type) async throws -> T? {
        guard let url = URL(string: url) else {
            throw Error.invalidURL
        }
        // form url req with the above string
        let urlReq = URLRequest(url: url)
        
        do {
            // getting back data
            let (data, response) = try await URLSession.shared.data(for: urlReq)
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                throw Error.invalidResponse
            }
            
            let decodedJSONData = try JSONDecoder().decode(type, from: data)
            return decodedJSONData
            
        } catch {
            throw Error.invalidData
        }
        
    }
}

