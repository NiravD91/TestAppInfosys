//
//  ServerManager.swift
//  Test
//
//  Created by Nirav on 15/04/20.
//  Copyright © 2020 Nirav. All rights reserved.
//

import Foundation

class ServerManager {

    // MARK:- Calling of API Method Here....
    class func callApi(completion: @escaping (ListData?, Error?) -> Void) {
        let session = URLSession.shared
        let url = URL(string: "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json")!
        let task = session.dataTask(with: url, completionHandler: { data, response, error in
            guard let data = data else {
                return
            }
            
            if error != nil {
                return
            }
            
            do {
                let json = try JSONDecoder().decode(ListData.self, from: data )
                completion(json, nil)
            } catch {
                print("Error during JSON serialization: \(error.localizedDescription)")
                completion(nil, error)
            }
        })
        task.resume()
    }
}
