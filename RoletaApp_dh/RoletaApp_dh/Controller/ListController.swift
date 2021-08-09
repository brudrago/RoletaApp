//
//  ListController.swift
//  RoletaApp_dh
//
//  Created by Bruna Drago on 08/08/21.
//

import Foundation

protocol ListControllerDelegate: AnyObject {
    
    func fetchListSucceed()
}

class ListController {
    
    private var list: List?
    
    weak var delegate: ListControllerDelegate?
    
    var count: Int {
        return list?.historyAccountList.count ?? 0
    }
    
    func fetchList() {
        guard let url = Bundle.main.url(forResource: "Historico", withExtension: "json"),
                let data = try? Data(contentsOf: url) else { return }
        
        do {
            self.list = try JSONDecoder().decode(List.self, from: data)
            self.delegate?.fetchListSucceed()
        } catch {
            print("Erro JSON")
        }
    }
    
    func getTotalValue() -> String {
        return String(format: "%.2f", list?.totalValue ?? 0.0)
    }
    
    func getItemOrder(indexPath: IndexPath) -> ItemList? {
        return list?.historyAccountList[indexPath.row]
    }
    
}
