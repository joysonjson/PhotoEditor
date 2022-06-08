//
//  Extension.swift
//  PhotoEditor
//
//  Created by Joyson P S on 08/06/22.
//

import Foundation
import UIKit
extension UIViewController{
    func presentAlertWithTitle(title: String, message: String, options: [AlertOptions], completion: @escaping (AlertOptions) -> Void) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for (index, option) in options.enumerated() {
            alertController.addAction(UIAlertAction.init(title: option.rawValue, style: .default, handler: { (action) in
                completion(options[index])
            }))
        }
        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion: nil)

        }
    }

}
