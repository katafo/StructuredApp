//
//  CollectionViewDataSource.swift
//
//  Copyright © 2018. All rights reserved.
//

import UIKit

class CollectionViewDataSource<Cell: UICollectionViewCell, Model: Any>: DataSource<Model>, UICollectionViewDataSource {
    
    var configureCell: ((Cell, Model) -> ())?
   
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataProvider.numberOfSections()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataProvider.numberOfRows(in: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath) as Cell
        let model = dataProvider.item(at: indexPath)
        if configureCell != nil { self.configureCell!(cell, model) }
        return cell
    }
    
}
