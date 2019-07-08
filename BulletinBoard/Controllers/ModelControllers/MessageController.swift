//
//  MessageController.swift
//  BulletinBoard
//
//  Created by Timothy Rosenvall on 7/8/19.
//  Copyright © 2019 Timothy Rosenvall. All rights reserved.
//

import Foundation

class MessageController {
    // Shared Instance
    static let sharedInstance = MessageController()
    
    let messagesWereUpdatedNotification = Notification.Name("messagesWereUpdated")
    
    // Source of Truth
    var messages: [Message] = [] {
        didSet {
            // Post a notification
            NotificationCenter.default.post(name: messagesWereUpdatedNotification, object: nil)
        }
    }
    
    // Mark: - CRUD
    // Create
    func saveMessageRecord(_ text: String) {
        // Init the message
        let messageToSave = Message(text: text)
        // Select our database
        let database = CloudKitController.sharedInstance.publicDatabase
        
        CloudKitController.sharedInstance.saveRecordToCloudKit(record: messageToSave.cloudKitRecord, database: database) { (success) in
            if success {
                print("Successfully saved message to CloudKit")
                self.messages.append(messageToSave)
            }
        }
    }
    
    // Read
    func fetchMEssageRecords() {
        let database = CloudKitController.sharedInstance.publicDatabase
        CloudKitController.sharedInstance.fetchRecordsOf(type: Message.typeKey, database: database) { (records, error) in
            if let error = error {
                print("Error in \(#function) :  \(error.localizedDescription) /n---/n \(error)")
            }
            guard let foundRecords = records else { return }
            
//            // First way to do this
//            for record in foundRecords {
//                guard let newRecord = Message.init(record: record) else { return }
//                self.messages.append(newRecord)
//            }
            
            // Second Way to do this
            // Single Line For-In Loop, iterates through foundRecords, init Messages from the values that can init a Message, creating a new array from successes
            let messages = foundRecords.compactMap( {Message(record: $0)} )
            self.messages = messages
        }
    }
}
