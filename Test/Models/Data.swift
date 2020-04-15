//
//  Data.swift
//  Test
//
//  Created by Nirav on 15/04/20.
//  Copyright © 2020 Nirav. All rights reserved.
//

import Foundation

struct ListData: Codable {
    
    let title: String?
    let rows: [RowsData]
    
    init(title: String?, rows: RowsData) {
        self.title = title
        self.rows = [rows]
    }
}

struct RowsData: Codable {
    
    var title: String?
    var description: String?
    var imageHref: String?
    
    init(title: String?, description: String?, imageHref: String?) {
        self.title = title
        self.description = description
        self.imageHref = imageHref
    }
}
