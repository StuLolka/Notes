import UIKit

final class Cell: UITableViewCell {

    lazy var name: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 50)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var date: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 18.5)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    func set(name: String, date: String) {
        self.name.text = name
        self.date.text = date
    }
    
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
        name.bottomAnchor.constraint(equalTo: centerYAnchor).isActive = true
        name.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        
        date.leftAnchor.constraint(equalTo: leftAnchor, constant: 15).isActive = true
        date.rightAnchor.constraint(equalTo: rightAnchor, constant: -5).isActive = true
        date.topAnchor.constraint(equalTo: centerYAnchor, constant: 10).isActive = true
        date.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5).isActive = true
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
