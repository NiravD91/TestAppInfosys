//
//  ListDataSource.swift
//  Test
//
//  Created by Nirav on 17/04/20.
//  Copyright © 2020 Nirav. All rights reserved.
//

import Foundation
import UIKit

class GenericDataSource<T>: NSObject {
    var data: DynamicValue<[T]> = DynamicValue([])
}

class ListDataSource: GenericDataSource<RowsData>, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.value.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: IDENTIFIERS.CUSTOMCELLID,
                                                 for: indexPath) as? CustomTableViewCell

        let rows = self.data.value[indexPath.row]
        cell?.listRows = rows

        return cell!
    }
}
