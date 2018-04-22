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
                  let homeIconWidth = 50
                  let iconOffset = homeIconWidth + 5
                  let publicId = result.publicId,
                  let url = strongSelf.cloudinary.createUrl()
                .setTransformation(CLDTransformation()
                .setWidth(400).setHeight(600).setCrop(.fit).chain()
                .setOverlay("assets:AppIcon").setGravity("south").setX(5).setY(5).setWidth(75).setOpacity(60).chain())
                .setOverlay("assets:blue").setGravity("north_west").setFlags("relative").setWidth(1.0).setHeight(0.12).setOpacity(85).chain()
                .setOverlay("assets:Sandbag").setGravity("north_east").setX(5).setY(5).setWidth(75).setOpacity(85).chain()
                .setOverlayWithLayer(CLDTextLayer().setFontFamily(fontFamily: "Arial").setFontSize(30).setText(text: String(sandbags))).setGravity("north_east").setX(18).setY(30).setColor("black").chain()

                .setOverlay("assets:Entrance_Ways_Arrow").setGravity("north_west").setX(5).setY(10).setOpacity(85).chain()
                    .setOverlayWithLayer(CLDTextLayer().setFontFamily(fontFamily: "Arial").setFontSize(15).setText(text: String(sandbags))).setGravity("north_west").setX(8).setY(13).setColor("white").chain()
                    .setOverlayWithLayer(CLDTextLayer().setFontFamily(fontFamily: "Arial").setFontSize(15).setText(text: String(sandbags))).setGravity("north_west").setX(63).setY(13).setColor("white").chain()
                    .setOverlayWithLayer(CLDTextLayer().setFontFamily(fontFamily: "Arial").setFontSize(15).setText(text: String(sandbags))).setGravity("north_west").setX(115).setY(13).setColor("white").chain()
                    .setOverlayWithLayer(CLDTextLayer().setFontFamily(fontFamily: "Arial").setFontSize(15).setText(text: String(sandbags))).setGravity("north_west").setX(169).setY(13).setColor("white").chain()
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

