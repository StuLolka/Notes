//
//  CreateNoteViewController.swift
//  Notes
//
//  Created by Сэнди Белка on 21.11.2020.
//

import UIKit

class CreateNoteViewController: UIViewController {

    private let textView = UITextView()
    private let fontName = "Arial"
    private let fontSize: CGFloat = 23.0
    public var defaultString = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        forTextView()
    }
    
    private func forTextView(){
        
        textView.delegate = self
        textView.font = UIFont.init(name: fontName, size: fontSize)
        view.addSubview(textView)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        textView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
        textView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        textView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
    }
    
}

extension CreateNoteViewController: UITextViewDelegate {
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
        defaultString = textView.text
        if let indexEnter = defaultString.firstIndex(of: "\n") {
            defaultString = String(defaultString.prefix(upTo: indexEnter))
            print(defaultString)
        }
    }
}
