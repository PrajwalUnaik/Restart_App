//
//  ContentView.swift
//  Restart
//
//  Created by Prajwal U on 24/12/23.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("onboarding") var isOnBoardingViewActive : Bool = true
    
    var body: some View {
        ZStack{
            if isOnBoardingViewActive{
                OnBoardingView()
            }
            else{
                HomeView()
            }
        }
    }
}

#Preview {
    ContentView()
}
