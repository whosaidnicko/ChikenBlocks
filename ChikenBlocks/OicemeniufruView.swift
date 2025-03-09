//
//  OicemeniufruView.swift
//  ChikenBlocks
//
//  Created by Nicolae Chivriga on 09/03/2025.
//

import SwiftUI


struct OicemeniufruView: View {
    @State var animate: Bool = false
    var body: some View {
        ZStack {
            Image("imgebackirgi")
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                Image("ourliog")
                
                HStack(spacing: 25) {
                    NavigationLink {
                        PraviliushkiAperendo()
                    } label: {
                        Image("praviliuhibutoncik")
                    }
                    
                    NavigationLink {
                        VotOnaIgrulicika()
                    } label: {
                        Image("playbtn")
                    }

                    
                        .scaleEffect(self.animate ? 1 : 0.5)
                        .animation(Animation.bouncy(duration: 0.75).repeatForever(), value: animate)
                        .onAppear() {
                            animate = true
                        }
                    
                    NavigationLink {
                        GainuseleSetarcik()
                    } label: {
                        Image("setarileim")
                    }

                    
                    
                    
                }
            }
        }
        .navigationBarBackButtonHidden()
    }
}
