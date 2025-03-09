//
//  GainuseleSetarcik.swift
//  ChikenBlocks
//
//  Created by Nicolae Chivriga on 09/03/2025.
//

import SwiftUI
import StoreKit

struct GainuseleSetarcik: View {
    var body: some View {
        ZStack {
            Image("imgebackirgi")
                .resizable()
                .ignoresSafeArea()
            
            Image("opteneagreaflerk")
                .resizable()
                .scaledToFit()
                .padding(15)
                .overlay {
                    VStack {
                        Button {
                            if let url = URL(string: "mailto:mulinkoroma@icloud.com") {
                                if UIApplication.shared.canOpenURL(url) {
                                    UIApplication.shared.open(url)
                                }
                            }
                        } label: {
                            Image("pustenkiiRectic")
                                .overlay {
                                    Text("CONTACT")
                                        .font(.system(size: 28, weight: .medium, design: .serif))
                                        .foregroundStyle(.black)
                                }
                        }

                   
                        Button {
                            if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
                                SKStoreReviewController.requestReview(in: scene)
                                generator.notificationOccurred(.success)
                               
                            }

                        } label: {
                            Image("pustenkiiRectic")
                                .overlay {
                                    Text("STARS")
                                        .font(.system(size: 28, weight: .medium, design: .serif))
                                        .foregroundStyle(.black)
                                }
                        }

                        
                    }
                }
            
        }
        .navigationBarBackButtonHidden()
        .navigationBarItems(leading: NajatieNazadKnopoc())
        .onAppear() {
            generator.notificationOccurred(.success)
        }
    }
}
extension View {
    func adapteachdevice() -> some View {
        self.modifier(ModibifierAdpation())
    }
}
