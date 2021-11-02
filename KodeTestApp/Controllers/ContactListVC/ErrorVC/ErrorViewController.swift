//
//  ErrorViewController.swift
//  KodeTestApp
//
//  Created by Клим on 30.10.2021.
//

import UIKit

protocol AgainRequest {
    func needToReload()
}

class ErrorViewController: UIViewController {
    
    var reload: AgainRequest!

    @IBOutlet var backButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backButton.tintColor = .customPurple
        self.navigationItem.hidesBackButton = true
    }

    @IBAction func backButtonAction(_ sender: Any) {
        reload.needToReload()
        self.navigationController?.popViewController(animated: false)
    }
    
}
