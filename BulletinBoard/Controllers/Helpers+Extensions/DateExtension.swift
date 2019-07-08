//
//  DateExtension.swift
//  BulletinBoard
//
//  Created by Timothy Rosenvall on 7/8/19.
//  Copyright © 2019 Timothy Rosenvall. All rights reserved.
//

import Foundation

extension Date {
    
    func formatDate () -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        
        return formatter.string(from: self)
    }
}
