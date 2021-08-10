//
//  UIViewController+ext.swift
//  RoletaApp_dh
//
//  Created by Bruna Drago on 08/08/21.
//

import UIKit

extension UIViewController {
    
    typealias AlertAction = (UIAlertAction) -> Void
    
    func showMessage(title: String = "", message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showMessageWithAction(title: String = "", message: String, actionTitle: String = "OK", action: @escaping AlertAction) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: actionTitle, style: .default, handler: action))
        alertController.view.tintColor = .systemBlue
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showCustomAlertWithActionOnMainThread(title: String, message: String, buttonTitle: String, completion: @escaping ()-> Void) {
        DispatchQueue.main.async {
            let alertVC = AlertViewController(title: title, message: message, buttonTitle: buttonTitle, buttonAction: completion)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
}
