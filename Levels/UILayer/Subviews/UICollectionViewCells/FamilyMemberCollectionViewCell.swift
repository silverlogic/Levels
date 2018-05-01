//
//  FamilyMemberCollectionViewCell.swift
//  Levels
//
//  Created by Emanuel  Guerrero on 4/22/18.
//  Copyright © 2018 The SilverLogic. All rights reserved.
//

import UIKit

final class FamilyMemberCollectionViewCell: BaseCollectionViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var familyMemberImageView: CircleImageView!
    @IBOutlet private weak var familyMemberNameLabel: UILabel!
    @IBOutlet private weak var questionMarkImageView: UIImageView!
    
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        familyMemberImageView.layer.borderColor = UIColor.darkTeal.cgColor
        questionMarkImageView.isHidden = true
    }
}


// MARK: - Public Instance Methods
extension FamilyMemberCollectionViewCell {
    func configure(name: String, isMissing: Bool = false, image: UIImage?) {
        familyMemberNameLabel.text = name
        if isMissing {
            familyMemberImageView.layer.borderColor = UIColor.questionMarkRed.cgColor
            questionMarkImageView.isHidden = false
        }
        guard let demoImage = image else { return }
        familyMemberImageView.image = demoImage
        familyMemberImageView.alpha = 0.5
    }
}


// MARK: - ImageAccess
extension FamilyMemberCollectionViewCell: ImageAccess {
    func setImageWithUrl(_ url: URL) {
        familyMemberImageView.setImageWithUrl(url)
    }
    
    func cancelImageDownload() {
        familyMemberImageView.cancelImageDownload()
    }
}
