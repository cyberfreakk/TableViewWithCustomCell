//
//  NetworkManager.swift
//  TableViewAssignment
//
//  Created by Arunesh Gupta on 08/10/23.
//

import Foundation
import UIKit

enum NetworkError: Error {
    case invalidUrl
    case invalidData
}

struct DataResource{
    
    func getData(with query: String, completion: ((SearchData?, Error?) -> Void)?) {
        let baseURL = "https://en.wikipedia.org/w/api.php?format=json&action=query&generator=search&gsrnamespace=0&gsrsearch=\(query)&gsrlimit=10&prop=pageimages|extracts&pilimit=max&exintro&explaintext&exsentences=1&exlimit=max"
        
        guard let url = URL(string: baseURL) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                completion?(nil, error)
                return
            }
            if let decodedResponse = try? JSONDecoder().decode(SearchData.self, from: data) {
                DispatchQueue.main.async {
                    completion?(decodedResponse, nil)
                }
            } else {
                completion?(nil, NetworkError.invalidData)
            }
        }
        dataTask.resume()
    }
}
