//
//  FilterTypeViewController.swift
//  KodeTestApp
//
//  Created by Клим on 28.10.2021.
//

import UIKit

class FilterTypeViewController: UIViewController, UISheetPresentationControllerDelegate {
    
    var model: FilterTypeModelProtocol!
    
    override var sheetPresentationController: UISheetPresentationController {
        presentationController as! UISheetPresentationController
    }
    
    @IBOutlet var wordButtom: UIButton!
    @IBOutlet var dateButton: UIButton!
    @IBOutlet var backButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        sheetPresentationController.delegate = self
        sheetPresentationController.selectedDetentIdentifier = .large
        sheetPresentationController.prefersGrabberVisible = true
        sheetPresentationController.detents = [.medium(), .large()]
    }


    @IBAction func backButtonAction(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func wordButtonAction(_ sender: UIButton) {
        wordButtom.setImage(UIImage(named: "Circle"), for: .normal)
        dateButton.setImage(UIImage(named: "Vector"), for: .normal)
    }
    
    @IBAction func dateButtonAction(_ sender: UIButton) {
        dateButton.setImage(UIImage(named: "Circle"), for: .normal)
        wordButtom.setImage(UIImage(named: "Vector"), for: .normal)
    }
    
}
