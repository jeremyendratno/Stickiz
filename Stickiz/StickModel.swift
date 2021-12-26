//
//  StickModel.swift
//  Stickiz
//
//  Created by Jeremy Endratno on 12/26/21.
//

import Foundation

struct StickModel {
    var id: UUID
    var name: String
    var created_at: Date
}

struct StickDataModel {
    var id: UUID
    var stick_id: UUID
    var name: String
    var value: String
    var created_at: Date
}
