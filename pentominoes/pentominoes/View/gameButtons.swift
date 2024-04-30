//
//  gameButtons.swift
//  pentominoes
//
//  Created by Zak Young on 2/4/24.
//

import SwiftUI

struct gameButtons: View {
    var text: String
    var fun: () -> Void
    var color: Color
    var body: some View {
        Button(action: fun){
            Text(text)
                .foregroundStyle(color)
                .font(.title)
        }
    }
}

