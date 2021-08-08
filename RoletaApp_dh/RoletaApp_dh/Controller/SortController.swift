//
//  SortController.swift
//  RoletaApp_dh
//
//  Created by Bruna Drago on 08/08/21.
//

import UIKit

protocol SortControllerDelegate: AnyObject {
    
    func showSortedUser(name: String)
    
    func removeNotSortedUser(indexPath: IndexPath)
}

class SortController {
    
    // MARK: - Private Properties
    
    private var users = [User]()
    private var canSelectUser: Bool = false
    private var sortedUser: User?
    
    private let imageNames = [Images.imageOne, Images.imageTwo,
                              Images.imageThree, Images.imageFour,
                              Images.imageFive]
    
    // MARK: - Public Properties
    
    var count: Int {
        users.isEmpty ? 1 : users.count
    }
    
    weak var delegate: SortControllerDelegate?
    
    // MARK: - Public Functions
    
    func addUser(_ name: String) {
        if name.isEmpty { return }
        
        guard let userImage = imageNames.randomElement() else { return }
        users.append(User(name: name, userImage: userImage ?? UIImage()))
    }
    
    func getUser(index: Int) -> User {
        return users[index]
    }
    
    func isEmpty() -> Bool {
        return users.isEmpty
    }
    
    func isButtonEnabled() -> Bool {
        users.count >= 2 ? true : false
    }
    
    func setCanSelectuser(_ newState: Bool) {
        canSelectUser = newState
    }
    
    func getCanSelectUser() -> Bool {
        return canSelectUser
    }
    
    func sortUserToPay() {
        self.sortedUser = self.users.randomElement()
        print(sortedUser?.name ?? "")
    }
    
    func checkUserSorted(indexPath: IndexPath) {
        if canSelectUser {
            if self.sortedUser === self.users[indexPath.row] {
                self.delegate?.showSortedUser(name: users[indexPath.row].name)
            } else {
                self.users.remove(at: indexPath.row)
                self.delegate?.removeNotSortedUser(indexPath: indexPath)
            }
        }
    }
    
    func removeAllUsers() {
        users.removeAll()
    }
    
    func proceedToCheckout() {
        
    }
    
}
