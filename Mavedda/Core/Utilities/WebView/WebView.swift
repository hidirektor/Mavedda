//
//  WebView.swift
//  Finance
//
//  Created by Halil İbrahim Direktör on 2.04.2025.
//

import SwiftUI
import WebKit

struct WebView: View {
    var url: URL
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Spacer()
                Text(url.absoluteString)
                    .font(.subheadline)
                    .lineLimit(1)
                    .truncationMode(.middle)
                Spacer()

                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                }
            }
            .padding()
            .background(Color(.secondarySystemBackground))

            WebViewRepresentable(url: url)
                .edgesIgnoringSafeArea(.all)
        }
    }
}

struct WebViewRepresentable: UIViewRepresentable {
    var url: URL

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        let request = URLRequest(url: url)
        webView.load(request)
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {}
}
