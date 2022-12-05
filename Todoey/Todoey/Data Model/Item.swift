//
//  Item.swift
//  Todoey
//
//  Created by Дария Григорьева on 04.12.2022.
//

import UIKit

class Item: Codable {
    let title: String
    var done: Bool
    
    init(title: String, done: Bool = false) {
        self.title = title
        self.done = done
    }
}
