//
//  CloudKitController.swift
//  BulletinBoard
//
//  Created by Timothy Rosenvall on 7/8/19.
//  Copyright © 2019 Timothy Rosenvall. All rights reserved.
//

import Foundation
import CloudKit

class CloudKitController {
    // Singleton/Shared Instance
    static let sharedInstance = CloudKitController()
    
    // Database Instances
    let publicDatabase = CKContainer.default().publicCloudDatabase
    
    // Mark: - CRUD
    // Create
    func saveRecordToCloudKit(record: CKRecord, database: CKDatabase, completion: @escaping (Bool) -> Void) {
        // Save the record passed in, complete with an optional error
        database.save(record) { (_, error) in
            // Error Handling
            if let error = error {
                print("Error in \(#function) :  \(error.localizedDescription) /n---/n \(error)")
                completion(false)
            }
            print(#function)
            completion(true)
        }
        
    }
    
    // Read
    func fetchRecordsOf(type: String, database: CKDatabase, completion: @escaping ([CKRecord]?, Error?) -> Void) {
        // Conditions of query, conditions to be return all found values
        let predicate = NSPredicate(value: true)
        // Defines the type we want to find, and applies our conditions.
        let query = CKQuery(recordType: type, predicate: predicate)
        // Perform query, complete with our optional records and error.
        database.perform(query, inZoneWith: nil) { (records, error) in
            if let error = error {
                print("Error in \(#function) :  \(error.localizedDescription) /n---/n \(error)")
                completion(nil, error)
            }
            if let records = records {
                completion(records, nil)
            }
        }
    }
    
    // Update
    
    // Delete
    
    
    
    
    
    
    
}
