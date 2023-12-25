//
//  HomeView.swift
//  Restart
//
//  Created by Prajwal U on 24/12/23.
//

import SwiftUI

struct HomeView: View {
    @AppStorage("onboarding") var isOnBoardingViewActive : Bool = false
    @State private var isAnimating: Bool = false

    var body: some View {
        VStack(spacing: 20) {
            
            Spacer()
            
            ZStack{
                ZStack{
                    Circle()
                        .stroke(.gray
                            .opacity(0.1),lineWidth: 40)
                        .frame(width: 260,height: 260, alignment: .center)
                    Circle()
                        .stroke(.gray.opacity(0.1),lineWidth: 80)
                        .frame(width: 260,height: 260, alignment: .center)
                }.blur(radius: isAnimating ? 0 : 10 )
                    .opacity(isAnimating ? 1 : 0)
                    .scaleEffect(isAnimating ? 1: 0.5)
                    .animation(.bouncy(duration: 1.5),value: isAnimating)
                    .onAppear(perform: {
                        isAnimating = true
                    })
                
                Image("character-2")
                    .resizable()
                    .scaledToFit()
                    .padding()
                    .offset(y:isAnimating ? 35: -35)
                    .animation(.easeInOut(duration: 3).repeatForever(),value: isAnimating)
                
            }
            
            
            Text("Time that leads to mastery is dependant on our intensity of our focus").multilineTextAlignment(.center)
                .font(.title3)
                .fontWeight(.light)
                .frame(minWidth: 0, maxWidth: .infinity)
                .padding()
                .foregroundColor(.secondary)
            
            
         Spacer()
            Button(action: {
                //action
                withAnimation {
                    isOnBoardingViewActive = true
                    playsound(sound: "success", type: "m4a")
                    
                }
                print("Button is pressed -> Restart")
            }){
                Image(systemName: "arrow.triangle.2.circlepath.circle.fill")
                    .imageScale(.large)
                Text("Restart")
                    .font(.system(.title3,design: .rounded))
                    .fontWeight(.bold)
            }.buttonStyle(.borderedProminent)
                .buttonBorderShape(.capsule)
                .controlSize(.large)
            
        }
    }
}

#Preview {
    HomeView()
}
