//
//  Data.swift
//  Test
//
//  Created by Nirav on 15/04/20.
//  Copyright © 2020 Nirav. All rights reserved.
//

import Foundation

struct RowsData: Codable {

    var title: String?
    var description: String?
    var imageHref: String?
}

struct ListData {

    let title: String
    let rows: [RowsData]
}

extension ListData: Parceable {

    static func parseObject(dictionary: [String: AnyObject]) -> Result<ListData, ErrorResult> {
        if let rows = dictionary["rows"] as? [Any],
            let title = dictionary["title"] as? String {

            let finalRows: [RowsData] = rows.compactMap({
                RowsData(title: ($0 as AnyObject).value,
                         description: ($0 as AnyObject).value,
                         imageHref: ($0 as AnyObject).value) })

            let conversion = ListData(title: title, rows: finalRows)

            return Result.success(conversion)
        } else {
            return Result.failure(ErrorResult.parser(string: "Unable to parse"))
        }
    }
}
