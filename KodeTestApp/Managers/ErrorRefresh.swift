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

    func error() {
        let viewToShow = ErrorView(frame: CGRect(x: 0, y: 0, width: window.frame.size.width, height: window.frame.size.height / 9))
        viewToShow.backgroundColor = UIColor.red
        window.addSubview(viewToShow)
        Timer.scheduledTimer(withTimeInterval: 4, repeats: false) { (_) in
            UIWindow.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
                viewToShow.transform = self.top
            }, completion: nil)
        }
    }
}
