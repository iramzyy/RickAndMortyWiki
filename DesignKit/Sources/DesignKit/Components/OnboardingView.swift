//
//  OnboardingView.swift
//  DesignKit
//
//  Created by Ahmed Ramzy on 27/09/2024.
//

import SwiftUI

public struct OnboardingPage: Identifiable {
    public let id = UUID()
    let title: String
    let subtitle: String
    let imageName: String
}

public struct OnboardingView: View {
    @State private var currentPage = 0
    public var pages: [OnboardingPage]
    
    public init(pages: [OnboardingPage]) {
        self.pages = pages
    }
    
    public var body: some View {
        VStack {
            TabView(selection: $currentPage) {
                ForEach(pages.indices, id: \.self) { index in
                    VStack {
                        Image(pages[index].imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: .infinity, height: 300)
                            .foregroundColor(.blue)
                        Spacer()
                        
                        Text(pages[index].title)
                            .font(.title)
                            .fontWeight(.bold)
                            .padding(.top)
                        
                        Text(pages[index].subtitle)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .padding(.horizontal)
                    }
                    .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
        }
        .padding(.bottom, 32)
    }
}
#Preview {
    OnboardingView(pages: [
        OnboardingPage(title: "Welcome", subtitle: "Discover amazing features", imageName: "star.fill"),
        OnboardingPage(title: "Explore", subtitle: "Find what you love", imageName: "magnifyingglass"),
        OnboardingPage(title: "Share", subtitle: "Connect with others", imageName: "square.and.arrow.up")
    ])
}
