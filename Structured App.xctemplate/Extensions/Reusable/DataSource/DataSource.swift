//
//  DataSource.swift
//
//  Copyright © 2018. All rights reserved.
//

import UIKit

class DataSource<Model: Any>: NSObject {

    var dataProvider: DataProvider<Model>
    
    init(dataProvider: DataProvider<Model>) {
        self.dataProvider = dataProvider
    }
    
}
