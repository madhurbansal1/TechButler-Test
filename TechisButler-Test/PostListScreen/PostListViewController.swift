//
//  PostListViewController.swift
//  TechisButler-Test
//
//  Created by madhur bansal on 27/04/24.
//

import UIKit

class PostListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    private let viewModel = PostListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        viewModel.delegate = self
        Loader.instance.show()
        self.viewModel.getData()
    }

    private func setUp() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PostListTableViewCell.nib, forCellReuseIdentifier: PostListTableViewCell.identifier)
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        self.view.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
    }
}

extension PostListViewController: PostListVMDelegate {
    func getPosts(errorMessage: String) {
        DispatchQueue.main.async { [weak self] in
            Loader.instance.hide()
            guard errorMessage == "" else {
                let alert = UIAlertController(title: "ERROR", message: errorMessage, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default))
                self?.present(alert, animated: true)
                return
            }
            self?.tableView.reloadData()
        }
    }
}

extension PostListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.postArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PostListTableViewCell.identifier) as! PostListTableViewCell
        cell.configure(data: viewModel.postArr[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = PostDetailViewController(nibName: String(describing: PostDetailViewController.self), bundle: nil)
        vc.postData = viewModel.postArr[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard indexPath.row == (viewModel.postArr.count - 1) else {return}
        if viewModel.newPostCount != 0 && !viewModel.isApiCallInProgress {
            viewModel.userId = viewModel.userId + 1
            viewModel.getData()
        }
    }
}
