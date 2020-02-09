//
//  RootTableViewController.swift
//  ch13-2
//
//  Created by Matt Brown on 2/9/20.
//  Copyright © 2020 Matt Brown. All rights reserved.
//

import UIKit

class RootTableViewController: UITableViewController {
    
    private let book = Book(title: "Great Expectations",
                            author: "Charles Dickens",
                            text: [
                                "Chapter I",
                                """
        My father's family name being Pirrip, and my \
        Christian name Philip, my infant tongue could \
        make of both names nothing longer or more \
        explicit than Pip.
        """,
                                """
        So, I called myself Pip, and came to be called Pip.
        """,
                                """
        I give Pirrip as my father's family name, on the \
        authority of his tombstone and my sister,--Mrs. \
        Joe Gargery, who married the blacksmith.
        """,
                                """
        As I never saw my father or my mother, and never \
        saw any likeness of either of them (for their \
        days were long before the days of photographs), \
        my first fancies regarding what they were like \
        were unreasonably derived from their tombstones.
        """,
                                """
        The shape of the letters on my father's, gave me \
        an odd idea that he was a square, stout, dark man, \
        with curly black hair.
        """
        ])

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = book.title
        tableView.register(BookCell.self, forCellReuseIdentifier: BookCell.reuseIdentifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.cellLayoutMarginsFollowReadableWidth = true
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return book.text.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let bookLine = book.text[indexPath.row]
        let cell = BookCell(from: bookLine)
        return cell
    }
}

