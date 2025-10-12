//
//  DataFetcher.swift
//  Marketplace
//
//  Created by Jeffery Okoli on 03/10/2025.
//

import Foundation

enum URLBuildError: Error, LocalizedError {
    case badURLResponse(underlyingError: Error)
    case missingConfig
    case urlBuildFailed
    
    var errorDescription: String? {
        switch self {
        case .badURLResponse(underlyingError: let error):
            return "Failed to parse URL response: \(error.localizedDescription)"
        case .missingConfig:
            return "Missing API configuration"
        case .urlBuildFailed:
            return "Failed to build URL"
        }
    }
}


struct APIConfig: Decodable {
    let baseURL: String
    
    static let shared: APIConfig? = {
        do {
            return try loadConfiguration()
        } catch {
            print("Failed to load API config: \(error.localizedDescription)")
            return nil
        }
    }()
    
    
   private static func loadConfiguration() throws -> APIConfig {
       guard let url = Bundle.main.url(forResource: "APIConfig", withExtension: "json") else {
           throw URLBuildError.urlBuildFailed
       }
       
       
       do {
           let data = try Data(contentsOf: url)
           return try JSONDecoder().decode(APIConfig.self, from: data)
       } catch let error {
           throw URLBuildError.badURLResponse(underlyingError: error)
       }
    }
}

