//
//  UICollectionView + Reusable.swift
//
//  Copyright © 2018. All rights reserved.
//

import UIKit

extension UICollectionReusableView: Reusable {}

enum UICollectionElementKindSection {
    case header
    case footer
}

extension UICollectionView {
    
    // Register cell
    
    func register<T: UICollectionViewCell>(nib: T.Type, bundle: Bundle? = nil) {
        let nib = UINib(nibName: T.reuseIdentifier, bundle: bundle)
        register(nib, forCellWithReuseIdentifier: T.reuseIdentifier)
    }
    
    func register<T: UICollectionViewCell>(cellClass: T.Type) {
        register(T.self, forCellWithReuseIdentifier: T.reuseIdentifier)
    }
    
    // Register supplementary view
    
    func register<T: UICollectionReusableView>(nib: T.Type, elementKindSection: UICollectionElementKindSection, bundle: Bundle? = nil) {
       
        let kind = (elementKindSection == .header) ? UICollectionElementKindSectionHeader : UICollectionElementKindSectionFooter
        
        let nib = UINib(nibName: T.reuseIdentifier, bundle: bundle)
        register(nib, forSupplementaryViewOfKind: kind, withReuseIdentifier: T.reuseIdentifier)
        
    }
    
    func register<T: UICollectionReusableView>(viewClass: T.Type, elementKindSection: UICollectionElementKindSection) {
        
        let kind = (elementKindSection == .header) ? UICollectionElementKindSectionHeader : UICollectionElementKindSectionFooter

        register(T.self, forSupplementaryViewOfKind: kind, withReuseIdentifier: T.reuseIdentifier)
    }
    
    // Dequeue
    
    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {

        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }
        
        return cell
    }
    
    func dequeueReusableSupplementaryView<T: UICollectionReusableView>(elementKindSection: UICollectionElementKindSection, for indexPath: IndexPath) -> T {
        
        let kind = (elementKindSection == .header) ? UICollectionElementKindSectionHeader : UICollectionElementKindSectionFooter
        
        guard let cell = dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }
        
        return cell
    }

}
