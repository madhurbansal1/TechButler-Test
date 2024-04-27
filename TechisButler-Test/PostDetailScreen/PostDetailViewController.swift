//
//  PostDetailViewController.swift
//  TechisButler-Test
//
//  Created by madhur bansal on 27/04/24.
//

import UIKit

class PostDetailViewController: UIViewController {
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    var postData: Post? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    private func setUp() {
        titleLabel.textColor = .black
        titleLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        titleLabel.numberOfLines = 0
        descLabel.textColor = .black
        descLabel.font = .systemFont(ofSize: 16)
        descLabel.numberOfLines = 0

        titleLabel.text = postData?.title?.stringValue ?? ""
        descLabel.text = postData?.body?.stringValue ?? ""
    }
}
