//
//  ViewController.swift
//  StuNotes(Test)
//
//  Created by Сэнди Белка on 23.11.2020.
//

import UIKit
import CoreData

final class ListNotesViewController: UIViewController {

    
    private let newView = UIView()
    private var isJustRun = true
    
    public let tableView = UITableView()
    lazy public var heightCell = (tableView.frame.height / 9) - 1
    
    lazy private var appDelegate = UIApplication.shared.delegate as! AppDelegate
    lazy public var context = appDelegate.persistentContainer.viewContext
    
    lazy public var controller = ListNotesController(context: context, view: view)
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        self.tableView.tableFooterView = UIView()
        setUpTableView()
    }
    
    //MARK: - viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        
        if isJustRun {
            controller.loadArray()
            isJustRun = false
        }
        
        tableView.reloadData()
        NoteArray.numberSelectedCell = -1
    }
    
    //MARK: - setUpTableView
    private func setUpTableView() {
        
        tableView.layer.borderWidth = 0.2
        tableView.layer.cornerRadius = 8
        tableView.layer.borderColor = CGColor(red: 0.474, green: 0.475, blue: 0.486, alpha: 1.0)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(Cell.self, forCellReuseIdentifier: "Cell")
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
    }
}
