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
    private var image: UIImage?
    var cropperState: CropperState?

    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var fileSizeLabel: UILabel!
    @IBOutlet weak var fileNameLabel: UILabel!
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
    
    @IBAction func editAction(_ sender: Any) {
        guard let image = image else {
            return
        }
        let cropper = ImageCropViewController(originalImage: image)
       cropper.delegate = self
       self.present(cropper, animated: true, completion: nil)
    }
}


extension ViewController: ImagePickerDelegate {

    func imagePicker(_ imagePicker: ImagePicker, didSelect image: UIImage,name: String, size: Float) {
        imagePicker.dismiss()
        self.image = image
        self.imageView.image = image
        self.fileNameLabel.text = "File Name: \t \(name)"
        self.fileSizeLabel.text = "File Size: \t \(String(describing: size)) MB"
        self.fileSizeLabel.isHidden = false
        self.fileNameLabel.isHidden = false
        self.editButton.isHidden = false
        self.imagePicker.dismiss()
        print("name",name)
        print("Size",size)
//         let cropper = ImageCropViewController(originalImage: image)
//        cropper.delegate = self
//        self.present(cropper, animated: true, completion: nil)
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
        
        if let state = state,
            let image = cropper.originalImage.cropped(withCropperState: state) {
            cropperState = state
            self.image = image
            imageView.image = image
        }
        cropper.dismiss(animated: true, completion: nil)

    }
}
