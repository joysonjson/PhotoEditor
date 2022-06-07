//
//  ViewController.swift
//  PhotoEditor
//
//  Created by Joyson P S on 07/06/22.
//

import UIKit
import QCropper

class ViewController: UIViewController {
    
    private lazy var imagePicker: ImagePicker = {
         let imagePicker = ImagePicker()
         imagePicker.delegate = self
         return imagePicker
     }()


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func openPhotoLibrary(_ sender: Any) {
        
        imagePicker.photoGalleryAsscessRequest()
    }
    
    @IBAction func openCameraAction(_ sender: Any) {
        imagePicker.cameraAsscessRequest()
    }
}


extension ViewController: ImagePickerDelegate {

    func imagePicker(_ imagePicker: ImagePicker, didSelect image: UIImage) {
         let cropper = ImageCropViewController(originalImage: image)
        cropper.delegate = self
        self.present(cropper, animated: true, completion: nil)
    }

    func cancelButtonDidClick(on imageView: ImagePicker) { imagePicker.dismiss() }
    func imagePicker(_ imagePicker: ImagePicker, grantedAccess: Bool,
                     to sourceType: UIImagePickerController.SourceType) {
        guard grantedAccess else { return }
        imagePicker.present(parent: self, sourceType: sourceType)
    }
}

extension ViewController: CropperViewControllerDelegate {
    func cropperDidConfirm(_ cropper: CropperViewController, state: CropperState?) {
        cropper.dismiss(animated: true, completion: nil)

//        if let state = state,
//            let image = cropper.originalImage.cropped(withCropperState: state) {
//            cropperState = state
//            imageView.image = image
//            print(cropper.isCurrentlyInInitialState)
//            print(image)
//        }
    }
}
