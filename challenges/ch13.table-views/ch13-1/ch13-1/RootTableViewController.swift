//
//  RootTableViewController.swift
//  ch13-1
//
//  Created by Matt Brown on 2/9/20.
//  Copyright © 2020 Matt Brown. All rights reserved.
//

import UIKit

class RootTableViewController: UITableViewController {
    
    private let messages = [
        Message(author: "Joe", content: "Hello World!"),
        Message(author: "Peter Piper", content: "Mr. Watson I presume"),
        Message(author: "Harry Housefield", content: "Once upon a time, in a land far far away"),
        Message(author: "Sir Roger Martin-Grayson III", content: "I cannot wait to see what happens next. I do hope they all lived happily ever after.")]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Messages"
        tableView.register(MessageCell.self, forCellReuseIdentifier: MessageCell.reuseIdentifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.cellLayoutMarginsFollowReadableWidth = true
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
        let cell = MessageCell(message: message)
        return cell
    }
}

