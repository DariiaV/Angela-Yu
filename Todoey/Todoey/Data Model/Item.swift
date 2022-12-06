//
//  Item.swift
//  Todoey
//
//  Created by Дария Григорьева on 04.12.2022.
//

import UIKit

struct Item: Codable {
    let title: String
    var done: Bool = false
}
