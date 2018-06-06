//
//  DateExtension.swift
//
//  Copyright © 2017. All rights reserved.
//

import Foundation

extension Date {
        
    func toString(dateFormat format: String) -> String{
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
        
    }
    
}
