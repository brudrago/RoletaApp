//
//  List.swift
//  RoletaApp_dh
//
//  Created by Bruna Drago on 08/08/21.
//

import Foundation

struct List: Decodable {
    let totalValue: Double
    let historyAccountList: [ItemList]
}

struct ItemList: Decodable {
    let historyID: String
    let date: String
    let name: String
    let price: Double
    let iconImage: String
}

