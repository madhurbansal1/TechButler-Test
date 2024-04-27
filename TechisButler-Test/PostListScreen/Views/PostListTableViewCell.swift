//
//  PostListTableViewCell.swift
//  TechisButler-Test
//
//  Created by madhur bansal on 27/04/24.
//

import UIKit

class PostListTableViewCell: UITableViewCell {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    static var identifier: String {
        return String(String(describing: self))
    }
    
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUp()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func setUp() {
        contentView.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 10
        containerView.clipsToBounds = true
        titleLabel.textColor = .black
        titleLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        titleLabel.numberOfLines = 0
    }
    
    func configure(data: Post) {
        titleLabel.text = data.title?.stringValue ?? ""
    }
}
