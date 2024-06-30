//
//  TableViewController.swift
//  memo
//
//  Created by 조윤경 on 6/30/24.
//

import Foundation
import UIKit

class ListViewController: UIViewController {
    private let apiClient = APIClient()
    private var data: [memo.Memo] = []
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        fetchDataFromAPI()
    }

    private func setupTableView() {
        view.backgroundColor = .white
        view.addSubview(tableView)

        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
    }

    private func fetchDataFromAPI() {
        apiClient.fetchFirstApi { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.data = response
                    self.tableView.reloadData()
                }
                print("First API Response: \(response)")
            case .failure(let error):
                print("Error fetching first API: \(error.localizedDescription)")
            }
        }
    }
}

extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
                
        let memo = data[indexPath.row]
        cell.textLabel?.text = memo.content // Assuming `content` is a property of your `memo.Memo` type
        
        return cell
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1 // You can modify this if you want multiple sections
    }
}

extension ListViewController: UITableViewDelegate {
    // Implement any delegate methods as needed
}
