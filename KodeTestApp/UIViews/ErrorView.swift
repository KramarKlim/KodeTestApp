//
//  ErrorView.swift
//  KodeTestApp
//
//  Created by Клим on 03.11.2021.
//

import UIKit

class ErrorView: UIView {
    
    let errorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.backgroundColor = .clear
        label.text = "Не могу обновить данные. \nПроверь соединение с интернетом."
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 13.0)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        errorLabel.frame = CGRect(x: 24, y: frame.midY-10, width: 327, height: 50)
        self.addSubview(errorLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
