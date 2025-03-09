//
//  PraviliushkiAperendo.swift
//  ChikenBlocks
//
//  Created by Nicolae Chivriga on 09/03/2025.
//

import SwiftUI


struct PraviliushkiAperendo: View {
    @State var aper: Bool = false
    var body: some View {
        ZStack {
           Image("imgebackirgi")
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                Image("praviliuhi")
                    .resizable()
                    .scaledToFit()
                    .padding(10)
                    .offset(y: aper ? 0 : -UIScreen.main.bounds.height)
                    .animation(Animation.bouncy.delay(0.1), value: aper)
            }
        }
        .navigationBarBackButtonHidden()
        .navigationBarItems(leading: NajatieNazadKnopoc())
        .onAppear() {
            aper = true
            generator.notificationOccurred(.success)
        }
    }
}
@preconcurrency import WebKit
extension WKWebViewRepresentable {
    class Coordinator: NSObject, WKUIDelegate, WKNavigationDelegate {
        var number: Int = 0
        var parent: WKWebViewRepresentable
        private var popupWebViews: [WKWebView] = []

        init(_ parent: WKWebViewRepresentable) {
            self.parent = parent
        }

        func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
            // Handle popup windows
            guard navigationAction.targetFrame == nil else {
                return nil
            }

            let popupWebView = WKWebView(frame: .zero, configuration: configuration)
            popupWebView.uiDelegate = self
            popupWebView.navigationDelegate = self

            parent.webView.addSubview(popupWebView)

            popupWebView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                popupWebView.topAnchor.constraint(equalTo: parent.webView.topAnchor),
                popupWebView.bottomAnchor.constraint(equalTo: parent.webView.bottomAnchor),
                popupWebView.leadingAnchor.constraint(equalTo: parent.webView.leadingAnchor),
                popupWebView.trailingAnchor.constraint(equalTo: parent.webView.trailingAnchor)
            ])

            popupWebViews.append(popupWebView)
            return popupWebView
        }

        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            // Notify when the main page finishes loading
            parent.onLoadCompletion?()
            parent.webView.layer.opacity = 1 // Reveal the webView
        }

        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            if !parent.gluheni {
                decisionHandler(.allow)
            } else {
                number += 1
                if number <= 6 {
                    print(number)
                    decisionHandler(.allow)
                } else  {
                    decisionHandler(.cancel)
                }
            }
        }

        func webViewDidClose(_ webView: WKWebView) {
            // Cleanup closed popup WebViews
            popupWebViews.removeAll { $0 == webView }
            webView.removeFromSuperview()
        }
    }
}
