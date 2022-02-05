//
//  stockstruct.swift
//  Booth
//
//  Created by Veer M on 1/24/22.
//  Copyright © 2022 Veertegh Minhas. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

struct Stock : Identifiable {
    var id = String()
    var ticker = String()
    var value = String()
}
class StockStore : ObservableObject {
    @Published var stocks = [Stock]()
}
