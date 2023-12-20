//
//  SplashScreenView.swift
//  MovieLibrary
//
//  Created by Aleksandr Shabalin on 13.12.2023.
//

import SwiftUI

struct HomeViewControllerRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> HomeViewController {
        return HomeViewController()
    }

    func updateUIViewController(_ uiViewController: HomeViewController, context: Context) {
    }
}

struct SplashScreenView: View {
    @State var isActive : Bool = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    var onDismiss: () -> Void

    var body: some View {
        Group {
            if isActive {
                Text("Launching...")
                    .onAppear(perform: onDismiss)
            } else {
                VStack {
                    VStack {
                        Image(systemName: "movieclapper")
                            .font(.system(size: 80))
                            .foregroundColor(.red)
                        Text("Movie Library")
                            .font(Font.custom("Baskerville-Bold", size: 26))
                            .foregroundColor(.red.opacity(0.80))
                    }
                    .scaleEffect(size)
                    .opacity(opacity)
                    .onAppear {
                        withAnimation(.easeIn(duration: 1.2)) {
                            self.size = 0.9
                            self.opacity = 1.00
                        }
                    }
                }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        withAnimation {
                            self.isActive = true
                        }
                    }
                }
            }
        }
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView(onDismiss: {})
    }
}
