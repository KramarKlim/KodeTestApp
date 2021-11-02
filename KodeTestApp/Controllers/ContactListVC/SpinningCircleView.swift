//
//  SpinningCircleView.swift
//  KodeTestApp
//
//  Created by Клим on 02.11.2021.
//

import UIKit

class SpinningCircleView: UIView {

    let spinnignCircle = CAShapeLayer()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        animate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        
        let rect = self.bounds
        let circlarPath = UIBezierPath(ovalIn: rect)
        
        spinnignCircle.path = circlarPath.cgPath
        spinnignCircle.fillColor = UIColor.clear.cgColor
        spinnignCircle.strokeColor = UIColor.customPurple.cgColor
        spinnignCircle.lineWidth = 4
        spinnignCircle.strokeEnd = 0.25
        spinnignCircle.lineCap = .round
        
        self.layer.addSublayer(spinnignCircle)
        
    }
    
    func animate() {
        UIView.animate(withDuration: 1, delay: 0, options: .curveLinear) {
            self.transform = CGAffineTransform(rotationAngle: .pi)
        } completion: { (completed) in
            UIView.animate(withDuration: 1, delay: 0, options: .curveLinear) {
                self.transform = CGAffineTransform(rotationAngle: 0)
            } completion: { (completed) in
                self.animate()
            }

        }

    }
}
