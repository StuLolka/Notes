//
//  Cell.swift
//  Notes
//
//  Created by Сэнди Белка on 21.11.2020.
//

import UIKit

class Cell: UITableViewCell {
//    lazy private var heightText =
    
    private let name: UILabel = {
        let label = UILabel()
//        label.font = UIFont(name: "System", size: 20.0)
        label.font = .boldSystemFont(ofSize: 23.0)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Text Name Test"
        return label
    }()
    private let date: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont(name: "System", size: 15.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Text Date Test"
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addViews() {
        
        addSubview(name)
        addSubview(date)
        
        name.leftAnchor.constraint(equalTo: leftAnchor, constant: 15).isActive = true
        name.rightAnchor.constraint(equalTo: rightAnchor, constant: -5).isActive = true
        name.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        name.heightAnchor.constraint(equalToConstant: frame.height / 2 - -10).isActive = true
        
        date.leftAnchor.constraint(equalTo: leftAnchor, constant: 15).isActive = true
        date.rightAnchor.constraint(equalTo: rightAnchor, constant: -5).isActive = true
        date.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        date.heightAnchor.constraint(equalToConstant: frame.height / 2 - 10).isActive = true
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
