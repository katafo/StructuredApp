//
//  DataProvider.swift
//
//  Copyright © 2018. All rights reserved.
//

import Foundation

class DataProvider<T: Any> {
    
    var data: [T] = []
    
    init(data: [T]) {
        self.data = data
    }
    
    func item(at indexPath: IndexPath) -> T {
        return data[indexPath.row]
    }
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfRows(in section: Int) -> Int {
        return data.count
    }
    
}
