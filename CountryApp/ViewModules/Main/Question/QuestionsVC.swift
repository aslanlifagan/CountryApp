//
//  QuestionsVC.swift
//  CountryApp
//
//  Created by Fagan Aslanli on 05.01.23.
//

import UIKit
import WebKit

class QuestionsVC: BaseVC {

    lazy var navigation: MainNavigationBarView = {
        let nav = MainNavigationBarView()
        nav.title = "Questions"
        return nav
    }()
    
    private lazy var webView: WKWebView = {
        let jscript = "var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);"
        let userScript = WKUserScript(source: jscript, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        let wkUController = WKUserContentController()
        wkUController.addUserScript(userScript)
        
        let configuration = WKWebViewConfiguration()
        configuration.allowsInlineMediaPlayback = true
        configuration.userContentController = wkUController
        
        let webView = WKWebView(frame: .zero, configuration: configuration)
        webView.navigationDelegate = self
        return webView
    }()
    
    override func setupView() {
        super.setupView()
        view.addSubview(navigation)
        view.addSubview(webView)
        setupData()
    }
    override func setupLabels() {
        super.setupLabels()
    }
    
    override func setupAnchors() {
        super.setupAnchors()
        navigation.anchor(top: view.topAnchor,
                          leading: view.leadingAnchor,
                          trailing: view.trailingAnchor,
                          padding: .init(top: 0, leading: 0, trailing: 0),
                          size: .init(width: 0, height: 84))
        webView.anchor(top: navigation.bottomAnchor,
                       leading: view.leadingAnchor,
                       bottom: view.bottomAnchor,
                       trailing: view.trailingAnchor,
                       padding: .init(top: 0, leading: 0, bottom: 0, trailing: 0))
    }
    private func setupData() {
        let url = URL (string: "https://google.az")
        let request = URLRequest(url: url!)
        webView.load(request)
    }
}

extension QuestionsVC: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print(error.localizedDescription)
    }
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("Strat to load")

        if let url = webView.url?.absoluteString {
            if url.contains("speedtest") {
                print("yellen")
            }
            print("url = \(url)")
        }
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("finish to load")

        if let url = webView.url?.absoluteString{
            print("url = \(url)")
        }
    }
}
