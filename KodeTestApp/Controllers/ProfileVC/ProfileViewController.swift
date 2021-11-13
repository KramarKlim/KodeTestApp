//
//  ProfileViewController.swift
//  KodeTestApp
//
//  Created by Клим on 28.10.2021.
//

import UIKit

class ProfileViewController: UIViewController {
    
    //MARK: Public Property
    var model: ProfileModelProtocol!
    
    //MARK: IBOutlets
    @IBOutlet var profileImage: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var tagLabel: UILabel!
    @IBOutlet var professionLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var yearsLabel: UILabel!
    @IBOutlet var phoneButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    //MARK: IBAction
    @IBAction func backButtonAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: Private Methods
    private func setup() {
        setupImage()
        profileImage.layer.cornerRadius = profileImage.frame.size.height / 2
        nameLabel.text = model.getName()
        tagLabel.text = model.getTag()
        professionLabel.text = model.getProf()
        dateLabel.text = model.getDate()
        yearsLabel.text = model.getYears()
        phoneButton.setTitle(model.getNumber(), for: .normal)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    private func setupImage() {
        if model.getImage() == nil {
            profileImage.image = UIImage(named: "Goose")
        } else {
            profileImage.fetchImage(from: model.getImage()!)
        }
    }
    
    private func aler(title: String, titleSecond: String) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let number = UIAlertAction(title: title, style: .default) { _ in
            if let phoneCallURL = URL(string: "tel://\(titleSecond)") {
                let application:UIApplication = UIApplication.shared
                if (application.canOpenURL(phoneCallURL)) {
                    application.open(phoneCallURL, options: [:], completionHandler: nil)
                }
            }
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        cancel.setValue(UIColor.black, forKey: "titleTextColor")
        number.setValue(UIColor.black, forKey: "titleTextColor")
        alert.addAction(number)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: IBAction
    @IBAction func phoneButtonAction(_ sender: UIButton) {
        aler(title: model.getNumber(), titleSecond: model.numberToCall())
    }
}
