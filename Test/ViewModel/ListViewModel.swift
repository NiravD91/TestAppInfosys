//
//  ListViewModel.swift
//  Test
//
//  Created by Nirav on 17/04/20.
//  Copyright © 2020 Nirav. All rights reserved.
//

import Foundation

struct ListViewModel {

    weak var dataSource: GenericDataSource<RowsData>?
    weak var service: ListServiceProtocol?

    var onErrorHandling: ((ErrorResult?) -> Void)?

    init(service: ListServiceProtocol = FileDataService.shared,
         dataSource: GenericDataSource<RowsData>?) {
        self.dataSource = dataSource
        self.service = service
    }

    func fetchRows() {

        guard let service = service else {
            onErrorHandling?(ErrorResult.custom(string: "Missing service"))
            return
        }

        service.fetchList { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let listData) :
                    self.dataSource?.data.value = listData.rows
                case .failure(let error) :
                    self.onErrorHandling?(error)
                }
            }
        }
    }
}
