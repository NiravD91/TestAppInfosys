//
//  File.swift
//  Test
//
//  Created by Nirav on 17/04/20.
//  Copyright © 2020 Nirav. All rights reserved.
//

import Foundation

enum ErrorResult: Error {
    case network(string: String)
    case parser(string: String)
    case custom(string: String)
}
