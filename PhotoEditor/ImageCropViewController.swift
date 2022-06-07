//
//  ImageCropViewController.swift
//  PhotoEditor
//
//  Created by Joyson P S on 07/06/22.
//

import Foundation
import QCropper

class ImageCropViewController: CropperViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func resetToDefaultLayout() {
        super.resetToDefaultLayout()
        aspectRatioLocked = true
        setAspectRatioValue(1.2)
    }
}
