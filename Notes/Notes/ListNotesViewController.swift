//
//  TestViewController.swift
//  Notes
//
//  Created by Сэнди Белка on 21.11.2020.
//

import UIKit

class ListNotesViewController: UIViewController {
    
    private let tableView = UITableView()
    private let searchField = UITextField()
    private let loupe = UIImageView(image: UIImage(systemName: "magnifyingglass"))
    public var nameArray = ["Test1"]
    lazy private var heightCell = tableView.frame.height / 9

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        self.tableView.tableFooterView = UIView()
        setUpSearchField()
        setUpTableView()
        setUpLoup()
        setUpNav()
    }
    
    private func setUpNav() {
        
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 44))
        view.addSubview(navBar)

        let navItem = UINavigationItem()
        let doneItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .done, target: nil, action: #selector(addNotes))
        
        doneItem.tintColor = .black
        navItem.rightBarButtonItem = doneItem
        navBar.setItems([navItem], animated: false)
    }
    
    @objc func addNotes() {
        let vc = CreateNoteViewController()
//        let vc = TextViewController()
        vc.modalPresentationStyle = .formSheet
        self.present(vc, animated:true, completion:nil)
    }
    
    private func setUpLoup() {
        
        loupe.tintColor = .lightGray
        view.addSubview(loupe)
        loupe.translatesAutoresizingMaskIntoConstraints = false
        loupe.topAnchor.constraint(equalTo: view.topAnchor, constant: 60).isActive = true
        loupe.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        loupe.widthAnchor.constraint(equalToConstant: 25).isActive = true
        loupe.heightAnchor.constraint(equalToConstant: 29).isActive = true
    }

    private func setUpSearchField() {
        
        searchField.textColor = .black
        searchField.placeholder = " Search"
        view.addSubview(searchField)
        searchField.translatesAutoresizingMaskIntoConstraints = false
        searchField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 47).isActive = true
        searchField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        searchField.topAnchor.constraint(equalTo: view.topAnchor, constant: 55).isActive = true
        searchField.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
    
    private func setUpTableView() {
        
        tableView.layer.borderWidth = 0.2
        tableView.layer.cornerRadius = 8
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(Cell.self, forCellReuseIdentifier: "Cell")
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        tableView.topAnchor.constraint(equalTo: searchField.bottomAnchor, constant: 10).isActive = true
    }
}

extension ListNotesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? Cell {
            print("Please tell me you are here")
            cell.heightAnchor.constraint(equalToConstant: heightCell).isActive = true
            return cell
        }
        else {
            print("Please tell me you are ARE NOT here")
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            nameArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

