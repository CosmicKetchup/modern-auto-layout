//
//  BookTableViewController.swift
//  chapter13a
//
//  Created by Matt Brown on 2/7/20.
//  Copyright © 2020 Matt Brown. All rights reserved.
//

import UIKit

final class BookTableViewController: UITableViewController {
    
    private var book: Book? {
        didSet {
            navigationItem.title = book?.title
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(LineCell.self, forCellReuseIdentifier: LineCell.reuseIdentifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        
        guard let bookUrl = Bundle.main.url(forResource: "Huckleberry", withExtension: "plist") else { fatalError() }
        book = Book(contentsOf: bookUrl)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return book?.text.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LineCell.reuseIdentifier, for: indexPath) as? LineCell else { fatalError() }
        cell.configure(line: indexPath.row + 1, text: book?.text[indexPath.row])
        return cell
    }
}
