//
//  Message.swift
//  BulletinBoard
//
//  Created by Timothy Rosenvall on 7/8/19.
//  Copyright © 2019 Timothy Rosenvall. All rights reserved.
//

import Foundation
import CloudKit

class Message {
    
    // Keys for CloudKit Storage
    static let typeKey = "Message"
    private let textKey = "Text"
    private let timestampKey = "Timestamp"
    
    // Class Properties
    let text: String
    let timestamp: Date
    
    var cloudKitRecord: CKRecord {
        // Define the record type
        let record = CKRecord(recordType: Message.typeKey)
        // Set your key value pairs
        record.setValue(text, forKey: textKey)
        record.setValue(timestamp, forKey: timestampKey)
        // Return the record
        return record
    }
    
    // Class initializer
    init(text: String, timestamp: Date = Date()) {
        self.text = text
        self.timestamp = timestamp
    }
    
    // Faiable initializer to pass in CKRecord
    init?(record: CKRecord) {
        // Guard against the keys and typecast the values as their specific type.
        guard let text = record[textKey] as? String,
            let timestamp = record[timestampKey] as? Date
            else {return nil}
        // Initialize our variables from the record.
        self.text = text
        self.timestamp = timestamp
    }
}
