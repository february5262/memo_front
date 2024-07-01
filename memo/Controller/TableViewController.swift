import Foundation
import UIKit

class ListViewController: UIViewController {
    private let apiClient = APIClient()
    private var data: [Memo] = []
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    private var inputTextField: UITextField?

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
        apiClient.getMemo { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.data = response
                    self.tableView.reloadData()
                }
                print("Memo API Response: \(response)")
            case .failure(let error):
                print("Error fetching memo API: \(error.localizedDescription)")
            }
        }
    }

    private func postMemo(content: String) {
        let timestamp = Date().description // 현재 시간을 문자열로 사용
        let newMemo = Memo(id: 0, content: content, timestamp: timestamp) // Memo 객체 생성
        
        apiClient.postMemo(body: newMemo) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let response):
                print("Post Memo API Response: \(response)")
                DispatchQueue.main.async {
                    self.fetchDataFromAPI() // Fetch the updated data after posting
                    self.inputTextField?.text = "" // Clear the input field
                }
            case .failure(let error):
                print("Error posting memo API: \(error.localizedDescription)")
            }
        }
    }
}

extension ListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2 // One for input section and one for memo list
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1 // Input section
        } else {
            return data.count // Memo list section
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
            let textField = UITextField(frame: cell.contentView.bounds.insetBy(dx: 15, dy: 0))
            textField.placeholder = "Enter new memo"
            textField.delegate = self
            cell.contentView.addSubview(textField)
            inputTextField = textField
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
            let memo = data[indexPath.row]
            cell.textLabel?.text = memo.content // Assuming `content` is a property of your `Memo` type
            return cell
        }
    }
}

extension ListViewController: UITableViewDelegate {
    // Implement any delegate methods as needed
}

extension ListViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if let content = textField.text, !content.isEmpty {
            postMemo(content: content)
        }
        return true
    }
}
