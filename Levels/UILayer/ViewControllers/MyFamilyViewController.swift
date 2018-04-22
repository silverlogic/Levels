//
//  MyFamilyViewController.swift
//  Levels
//
//  Created by Emanuel  Guerrero on 4/22/18.
//  Copyright © 2018 The SilverLogic. All rights reserved.
//

import Presentr
import UIKit

final class MyFamilyViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var collectionView: UICollectionView!
    
    
    // MARK: - Private Instance Attributes
    private var familyTracker = FamilyTracker()
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}


// MARK: - IBActions
private extension MyFamilyViewController {
    @IBAction func addFamilyMemberTapped(sender: UIBarButtonItem) {
        showEnterName()
    }
    
    @IBAction func dismiss() {
        dismiss(animated: true, completion: nil)
    }
}


// MARK: - UICollectionViewDataSource
extension MyFamilyViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return familyTracker.familyMembersCount
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let familyMember = familyTracker.familyMember(at: indexPath.item) else {
            return UICollectionViewCell()
        }
        let cell: FamilyMemberCollectionViewCell = collectionView.dequeueCell(forIndexPath: indexPath)
        cell.configure(name: familyMember.name, isMissing: familyMember.isMissing, image: familyMember.image)
        return cell
    }
}


// MARK: - UICollectionViewDelegate
extension MyFamilyViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        guard let familyMember = familyTracker.familyMember(at: indexPath.item),
              let url = familyMember.imageUrl,
              let familyCell = cell as? FamilyMemberCollectionViewCell else { return }
        familyCell.setImageWithUrl(url)
    }
}


// MARK: - Private Instance Methods
private extension MyFamilyViewController {
    func setup() {
        collectionView.alpha = 0
        collectionView.dataSource = self
        collectionView.delegate = self
        showActivityIndicator()
        familyTracker.loadSavedFamilyMembers()
        .done { [weak self] in
            self?.collectionView.reloadData()
            self?.dismissActivityIndicator()
            self?.collectionView.animateShow()
        }
        .catch { (error) in
            print("Error loading family members: \(error)")
        }
    }
    
    func showEnterName() {
        let title = "Name"
        let subtitle = "Please enter the first name of your loved one"
        let attributes = [AlertTextFieldAttributes(
            placeholder: "First Name",
            isSecureTextEntry: false,
            keyboardType: .default,
            autocorrectionType: .no,
            autocapitalizationType: .none,
            spellCheckingType: .no,
            returnKeyType: .done
        )]
        showEditAlert(
            title: title,
            subtitle: subtitle,
            textFieldAttributes: attributes) { [weak self] (values) in
                let name = values["First Name"]!
                self?.showCamera(name: name)
        }
    }
    
    func showCamera(name: String) {
        CameraHandler.shared.showActionSheet(vc: self)
        CameraHandler.shared.imagePickedBlock = { [weak self] (image) in
            let progressView = UIStoryboard.loadProgressViewController()
            let presentr = Presentr(presentationType: .fullScreen)
            self?.customPresentViewController(presentr, viewController: progressView, animated: true) {
                self?.familyTracker.addNewFamilyMember(named: name, with: image)
                .done { (added) in
                    self?.collectionView.reloadData()
                    progressView.dismiss(animated: true, completion: nil)
                }
                .catch { (error) in
                    progressView.dismiss(animated: true, completion: nil)
                    print("Error adding family member: \(error)")
                }
            }
        }
    }
}
