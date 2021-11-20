//
//  Tasks.swift
//  GoodList
//
//  Created by unthinkable-mac-0025 on 21/11/21.
//

import Foundation

enum Priority : Int{
    case high
    case medium
    case low
}

struct Task{
    let title : String
    let priority : Priority
}
