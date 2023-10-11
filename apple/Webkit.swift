import SwiftUI
import WebKit

struct WebViewContainer: UIViewRepresentable {
    let urlString: String
    @Binding var pageTitle: String
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.evaluateJavaScript("navigator.online") { (result, error) in
             //if let 
        }
        webView.navigationDelegate = context.coordinator
        webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        if (UIScreen.main.bounds.width > UIScreen.main.bounds.height) {
            //handle for desktop mode
        }else{
            //handle for mobile mode
        }
        webView.evaluateJavaScript("navigator.userAgent") { (result, error) in
            if let userAgent = result as? String {
                let customUserAgent = userAgent + " AltKit/0.1"
                webView.customUserAgent = customUserAgent
            }
        }
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            uiView.load(request)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, WKNavigationDelegate, ObservableObject {
        var parent: WebViewContainer
        
        init(_ parent: WebViewContainer) {
            self.parent = parent
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            self.parent.pageTitle = webView.title ?? "Untitled"
        }
        
        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            decisionHandler(.allow)
        }
    }
}

    
    
