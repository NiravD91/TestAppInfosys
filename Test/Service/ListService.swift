//
//  ListService.swift
//  Test
//
//  Created by Nirav on 17/04/20.
//  Copyright © 2020 Nirav. All rights reserved.
//

import Foundation

protocol ListServiceProtocol: class {
    func fetchList(_ completion: @escaping ((Result<ListData, ErrorResult>) -> Void))
}

final class ListService: RequestHandler, ListServiceProtocol {

    static let shared = ListService()

    let endpoint = ENVIRONMENT.APIURL
    var task: URLSessionTask?

    func fetchList(_ completion: @escaping ((Result<ListData, ErrorResult>) -> Void)) {

        self.cancelFetch()

        task = RequestService().loadData(urlString: endpoint, completion: self.networkResult(completion: completion))
    }

    func cancelFetch() {

        if let task = task {
            task.cancel()
        }
        task = nil
    }
}
