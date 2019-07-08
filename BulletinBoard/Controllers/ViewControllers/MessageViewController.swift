//
//  MessageViewController.swift
//  BulletinBoard
//
//  Created by Timothy Rosenvall on 7/8/19.
//  Copyright © 2019 Timothy Rosenvall. All rights reserved.
//

import UIKit

class MessageViewController: UIViewController {

    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector:
            #selector(updateViews), name: MessageController.sharedInstance.messagesWereUpdatedNotification , object: nil)
        MessageController.sharedInstance.fetchMEssageRecords()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: MessageController.sharedInstance.messagesWereUpdatedNotification, object: nil)
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        guard let text = messageTextField.text, !text.isEmpty else {return}
        MessageController.sharedInstance.saveMessageRecord(text)
        messageTextField.text = ""
    }
    
    @objc func updateViews() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension MessageViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageController.sharedInstance.messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath)
        let messages: [Message] = MessageController.sharedInstance.messages.reversed()
        let message = messages[indexPath.row]
        cell.textLabel?.text = message.text
        cell.detailTextLabel?.text = message.timestamp.formatDate()
        return cell
    }
}
