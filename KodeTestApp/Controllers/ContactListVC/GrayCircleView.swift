//
//  GrayCircleView.swift
//  KodeTestApp
//
//  Created by Клим on 02.11.2021.
//

import UIKit

class GrayCircleView: UIView {

    let spinnignCircle = CAShapeLayer()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        
        let rect = self.bounds
        let circlarPath = UIBezierPath(ovalIn: rect)
        
        spinnignCircle.path = circlarPath.cgPath
        spinnignCircle.fillColor = UIColor.clear.cgColor
        spinnignCircle.strokeColor = UIColor(red: 0.969, green: 0.969, blue: 0.973, alpha: 1).cgColor
        spinnignCircle.lineWidth = 4
        spinnignCircle.lineCap = .round
        
        self.layer.addSublayer(spinnignCircle)
    }
}
