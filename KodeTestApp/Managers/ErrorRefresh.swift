//
//  ErrorRefresh.swift
//  KodeTestApp
//
//  Created by Клим on 06.11.2021.
//

import Foundation
import UIKit

class ErrorRefresh {
    let window = UIApplication.shared.windows.last!
    let top = CGAffineTransform(translationX: 0, y: -300)
    let viewToShow = ErrorView(frame: CGRect(x: 0, y: 0, width: UIApplication.shared.windows.last!.frame.size.width, height: UIApplication.shared.windows.last!.frame.size.height / 9))

    
    func error() {
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(self.handleGesture(gesture:)))
        swipeUp.direction = .up
        window.addGestureRecognizer(swipeUp)
        viewToShow.backgroundColor = UIColor.red
        window.addSubview(viewToShow)
        Timer.scheduledTimer(withTimeInterval: 4, repeats: false) { (_) in
            UIWindow.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
                self.viewToShow.transform = self.top
            }, completion: nil)
        }
    }
    
    @objc func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
        if gesture.direction == UISwipeGestureRecognizer.Direction.up {
            UIWindow.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
                self.viewToShow.transform = self.top
            }, completion: nil)
        }
    }
}
