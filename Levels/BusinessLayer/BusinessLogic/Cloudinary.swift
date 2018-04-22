//
//  Cloudinary.swift
//  Levels
//
//  Created by Shaun Bevan on 4/21/18.
//  Copyright © 2018 The SilverLogic. All rights reserved.
//

import Foundation
import Cloudinary

public typealias CLDURLCompletionHandler = (_ url: String?, _ error: NSError?) -> ()


final class Cloudinary {

    // MARK: - Private Instance Attributes For Cloudinary
    private let cloudName = "silverlogic"
    private let uploadPreset = "fwjbry4c"
    private let apiKey = "836934321119151"
    private let apiSecret = "5NZrpiRwCeGDmkgTmVenJQ2toj4"
    private let cloudinary: CLDCloudinary!

    init() {
        let config = CLDConfiguration(cloudName: cloudName, secure: true)
        cloudinary = CLDCloudinary(configuration: config)
    }


    // MARK: - Public Instance Methods
    func createUploader(_ data: Data, sandbags: Int, completion: @escaping CLDURLCompletionHandler) {
        cloudinary.createUploader().upload(data: data, uploadPreset: uploadPreset, progress: nil) { [weak self] (result, error) in
            guard let strongSelf = self else { return }
            if let error = error {
                completion(nil, error)
                return
            }
            guard let result = result,
                  let publicId = result.publicId,
                  let url = strongSelf.cloudinary.createUrl()
                .setTransformation(CLDTransformation()
                .setWidth(400).setHeight(600).setCrop(.fit).chain()
                .setOverlay("assets:Sandbag").setGravity("north_east").setX(5).setY(5).setWidth(50).setOpacity(85).setEffect("brightness:200").chain()
                .setOverlayWithLayer(CLDTextLayer().setFontFamily(fontFamily: "Arial").setFontSize(20).setText(text: String(sandbags))).setGravity("north_east").setX(20).setY(22).setColor("black").chain()
                .setOverlay("assets:AppIcon").setGravity("south").setX(5).setY(5).setWidth(75).setOpacity(60).chain())
                .generate(publicId) else {
                    completion(nil, error)
                    return
            }
            completion(url, nil)
        }
    }

    func createDownloader(_ url: String, completion: @escaping (_ image: UIImage?, _ error: NSError?) -> ()) {
        let downloader = cloudinary.createDownloader()
        downloader.fetchImage(url, nil) { (image, error) in
            guard let error = error else {
                completion(image, nil)
                return
            }
            completion(nil, error)
        }
    }
}

