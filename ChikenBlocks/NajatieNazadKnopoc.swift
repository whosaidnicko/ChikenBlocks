//
//  NajatieNazadKnopoc.swift
//  ChikenBlocks
//
//  Created by Nicolae Chivriga on 09/03/2025.
//

import SwiftUI


struct NajatieNazadKnopoc: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        ZStack {
            Button {
                self.dismiss()
            } label: {
                Image("backbtn")
            }

        }
    }
}
