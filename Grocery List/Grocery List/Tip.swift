//
//  Tip.swift
//  Grocery List
//
//  Created by Hai Ng. on 14/3/26.
//

import Foundation
import TipKit

struct ButtonTip: Tip {
    var title: Text = Text("Essentila Foods")
    var message: Text? = Text("Add some everyday items to the shopping list.")
    var image: Image? = Image(systemName: "info.circle")
}
