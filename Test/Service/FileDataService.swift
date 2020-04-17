//
//  FileDataService.swift
//  Test
//
//  Created by Nirav on 17/04/20.
//  Copyright © 2020 Nirav. All rights reserved.
//

import Foundation

final class FileDataService: ListServiceProtocol {

    static let shared = FileDataService()

    func fetchList(_ completion: @escaping ((Result<ListData, ErrorResult>) -> Void)) {

        guard let data = FileManager.readJson(forResource: "sample") else {
            completion(Result.failure(ErrorResult.custom(string: "No file or data")))
            return
        }

        ParserHelper.parse(data: data, completion: completion)
    }
}

extension FileManager {

    static func readJson(forResource fileName: String ) -> Data? {

        let bundle = Bundle(for: FileDataService.self)
        if let path = bundle.path(forResource: fileName, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                return data
            } catch {
                // handle error
            }
        }

        return nil
    }
}
