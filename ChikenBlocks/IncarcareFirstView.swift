//
//  IncarcareFirstView.swift
//  ChikenBlocks
//
//  Created by Nicolae Chivriga on 09/03/2025.
//

import SwiftUI
import Lottie



struct IncarcareFirstView: View {
    @State var fromBeginToEnd: Bool = false
    @State var gominus: Bool = false
    var body: some View {
        ZStack {
            Image("imgebackirgi")
                .resizable()
                .ignoresSafeArea()
            
            Image("ourliog")
                .scaleEffect(fromBeginToEnd ? 1 : 0)
                .animation(Animation.bouncy.delay(1.5), value: fromBeginToEnd)
            
            NavigationLink("", destination: OicemeniufruView(), isActive: $gominus)
            VStack {
                HStack {
                    LottieView(animation: .named("curitusikimerg"))
                        .playing(loopMode: .loop)
                        .resizable()
                        .frame(width: 175, height: 175)
                        .offset(x: fromBeginToEnd ? UIScreen.main.bounds.width : 0)
                        .animation(Animation.linear(duration: 4.5), value: fromBeginToEnd)

                    
                    Spacer()
                }
            }
        }
        .adapteachdevice()
        .onAppear() {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                generator.notificationOccurred(.success)
            }
            self.fromBeginToEnd = true
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 4.5) {
                self.gominus = true
            }
        }
    }
}



let generator = UINotificationFeedbackGenerator()
