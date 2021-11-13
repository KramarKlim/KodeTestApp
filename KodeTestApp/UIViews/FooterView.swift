//
//  FooterView.swift
//  KodeTestApp
//
//  Created by Клим on 05.11.2021.
//

import Foundation
import UIKit

class FooterView: UIView {
    let yearLabel: UILabel = {
        let label = UILabel()
        label.text = "2022"
        label.backgroundColor = .clear
        label.font = .systemFont(ofSize: 15.0)
        label.textColor = .lightGray
        return label
    }()
    
    let leftView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    let rightView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        leftView.frame = CGRect(x: 24, y: frame.midY, width: frame.width/5, height: 2)
        rightView.frame = CGRect(x: frame.maxX-105, y: frame.midY, width: frame.width/5, height: 2)
        yearLabel.frame = CGRect(x: frame.midX-20, y: frame.midY-10, width: 160, height: 20)
        self.addSubview(leftView)
        self.addSubview(rightView)
        self.addSubview(yearLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}


