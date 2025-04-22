//
//  SplineWebView.swift
//  Finance
//
//  Created by Halil İbrahim Direktör on 6.04.2025.
//

import SwiftUI
import WebKit

struct SplineWebView: UIViewRepresentable {
    let splineURL: String

    func makeUIView(context: Context) -> WKWebView {
        let config = WKWebViewConfiguration()
        let webView = WKWebView(frame: .zero, configuration: config)

        let htmlString = """
        <!DOCTYPE html>
        <html lang="en">
        <head>
            <meta charset="UTF-8" />
            <meta name="viewport" content="width=device-width, initial-scale=1.0" />
            <script type="module" src="https://unpkg.com/@splinetool/viewer@1.9.82/build/spline-viewer.js"></script>
            <style>
                html, body {
                    margin: 0;
                    padding: 0;
                    background-color: transparent;
                    overflow: hidden;
                    height: 100%;
                }
            </style>
        </head>
        <body>
            <spline-viewer url="\(splineURL)" style="width:100vw; height:100vh;"></spline-viewer>
        </body>
        </html>
        """

        webView.isOpaque = false
        webView.backgroundColor = .clear
        webView.scrollView.backgroundColor = .clear
        webView.loadHTMLString(htmlString, baseURL: nil)
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {}
}
