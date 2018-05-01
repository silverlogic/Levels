//
//  ShelterViewController.swift
//  Levels
//
//  Created by Shaun Bevan on 4/22/18.
//  Copyright © 2018 The SilverLogic. All rights reserved.
//

import UIKit
import AlertTransition

final class ShelterViewController: UIViewController, UINavigationControllerDelegate {


    // MARK: - Private Instance Attributes
    var wasRecognized: Bool = false
    var isFirstLoad: Bool = false
    let cloudinary = Cloudinary()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            imagePicker.allowsEditing = false
            present(imagePicker, animated: true, completion: nil)
        }
    }
}


// MARK: - Navigation
extension ShelterViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let controller = segue.destination as? ShelterResultsViewController else { return }
        controller.resultStatus = wasRecognized
        controller.at.transition = TrolleyTransition()
        present(controller, animated: true, completion: nil)
    }
}


// MARK: - UIImagePickerControllerDelegate
extension ShelterViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        cloudinary.submit(image: image)
        .then { url in
            return Kairos.recognizePerson(with: url)
        }
        .done { [weak self] (recognized) in
            picker.dismiss(animated: true, completion: nil)
            self?.showInfoAlert(title: "Success", subTitle: "Alice F. was found!")
            //            self?.performSegue(withIdentifier: UIStoryboardSegue.goToShelterResults, sender: self)
        }
        .catch { (error) in
            print(error)
            picker.dismiss(animated: true, completion: nil)
            self.showErrorAlert(title: "Error", subTitle: "No matches found.")
        }

    }
}
