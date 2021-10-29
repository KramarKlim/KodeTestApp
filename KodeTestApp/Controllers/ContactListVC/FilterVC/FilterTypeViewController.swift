//
//  FilterTypeViewController.swift
//  KodeTestApp
//
//  Created by Клим on 28.10.2021.
//

import UIKit

protocol SelectSortType {
    func didSelectType(type: SortType)
}

class FilterTypeViewController: UIViewController, UISheetPresentationControllerDelegate {
    
    var model: FilterTypeModelProtocol!
    
    var typeDelegate: SelectSortType!
    
    override var sheetPresentationController: UISheetPresentationController {
        presentationController as! UISheetPresentationController
    }
    
    @IBOutlet var wordButtom: UIButton!
    @IBOutlet var dateButton: UIButton!
    @IBOutlet var backButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }


    @IBAction func backButtonAction(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func wordButtonAction(_ sender: UIButton) {
        model.contacts = .word
        typeDelegate.didSelectType(type: .word)
        dismiss(animated: true)
    }
    
    @IBAction func dateButtonAction(_ sender: UIButton) {
        model.contacts = .date
        typeDelegate.didSelectType(type: .date)
        dismiss(animated: true)
    }
    
    private func setup() {
        view.backgroundColor = .white
        setupSheetPresentation()
        model.imageButton(word: wordButtom, date: dateButton)
    }
    
    private func setupSheetPresentation() {
        sheetPresentationController.delegate = self
        sheetPresentationController.selectedDetentIdentifier = .large
        sheetPresentationController.prefersGrabberVisible = true
        sheetPresentationController.detents = [.medium(), .large()]
    }
}
