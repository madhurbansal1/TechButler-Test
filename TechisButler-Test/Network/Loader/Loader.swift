//
//  Loader.swift
//  Sentor
//
//  Created by Madhvendra Singh on 29/09/22.
//

import UIKit

class Loader: UIView {
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    static let instance: Loader = {
        let bundle = Bundle(for: Loader.self)
        let nib = UINib(nibName: String(describing: Loader.self), bundle: bundle)
        let view = nib.instantiate(withOwner: nil, options: nil).first as! Loader

        return view
    }()

    func show() {
        if  let view = UIApplication.shared.windows.filter({$0.isKeyWindow}).first,
            !self.isDescendant(of: view) {
            view.addSubview(self)
            backgroundView.backgroundColor = .black.withAlphaComponent(0.6)
            activityIndicator.style = .large
            activityIndicator.color = .white
            activityIndicator.startAnimating()
            fill(view: self, parent: view)
        }
    }
    
    func hide() {
        self.activityIndicator.stopAnimating()
        self.removeFromSuperview()
    }
    
    private func fill(view: UIView, parent: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: view, attribute: .left, relatedBy: .equal, toItem: parent, attribute: .left, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: view, attribute: .right, relatedBy: .equal, toItem: parent, attribute: .right, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: view, attribute: .top, relatedBy: .equal, toItem: parent, attribute: .top, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: view, attribute: .bottom, relatedBy: .equal, toItem: parent, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
        parent.setNeedsLayout()
        parent.layoutIfNeeded()
    }
}
