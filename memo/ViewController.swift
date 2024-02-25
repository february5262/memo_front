//
//  ViewController.swift
//  memo
//
//  Created by 조윤경 on 2024/02/03.
//

import UIKit

class ViewController: UIViewController {
    lazy var tableView = UITableView(frame: .zero, style: .insetGrouped)

    let data = [["Test 1-1","Test 1-2","Test 1-3","Test 1-4"],["Test 2-1","Test 2-2","Test 2-3"],["Test 3-1","Test 3-2"]]
    let header = ["Section 1","Section 2","Section 3"]

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        self.view.addSubview(self.tableView)
        self.tableView.dataSource = self

        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
        ])
        
        //cell reuse type indentifier
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
    }

}

extension ViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = UITableViewCell(style: .default, reuseIdentifier: .none)
//        cell.textLabel?.text = data[indexPath.section][indexPath.row]
//        return cell
//
        let cellWithIndexPath = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        cellWithIndexPath.textLabel?.text = data[indexPath.section][indexPath.row]
        return cellWithIndexPath
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return header.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return header[section]
    }
}

extension ViewController:UITableViewDelegate{
    
}
