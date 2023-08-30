//
//  Separator.swift
//  macroChallenge
//
//  Created by rebeca primo on 07/08/23.
//

import SwiftUI

struct Separator: View {
    var body: some View {
        Image("line")
            .padding(.bottom, 15)
            .padding(.top, 15)
    }
}

struct Separator_Previews: PreviewProvider {
    static var previews: some View {
        Separator()
    }
}
