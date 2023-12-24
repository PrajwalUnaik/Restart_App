//
//  OnBoardingView.swift
//  Restart
//
//  Created by Prajwal U on 24/12/23.
//

import SwiftUI

struct OnBoardingView: View {
    //MARK: Property
    
    
    
    @AppStorage("onboarding") var isOnBoardingViewActive : Bool = true
    
    @State private var buttonWidth: Double = UIScreen.main.bounds.width - 80
    @State private var buttonOffset: CGFloat = 0
    @State private var isAnimating: Bool = false
    @State private var imageOffset: CGSize = .zero
    @State private var indicatorOpacity: Double = 1.0
    @State private var textTitle: String = "Share."
    
    //MARK: BODY
    
    
    
    
    var body: some View {
        ZStack {
            Color("ColorBlue")
                .ignoresSafeArea(.all ,edges: .all)
            
            VStack(spacing: 20) {
                //HEADER
                Spacer()
                
                VStack(spacing: 0){
                    Text(textTitle)
                        .font(.system(size: 60))
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .transition(.opacity)
                        .id(textTitle)
                    Text("""
                    Its not how much we give but
                    how much we put into giving
                    """)
                    .font(.title3)
                    .fontWeight(.light)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 10)
                } //HEADER
                .opacity(isAnimating ? 1:0)
                .offset(y: isAnimating ? 0:-40)
                .animation(.bouncy(duration: 1.7),value : isAnimating)
                //CENTER
                
                ZStack {
                    ZStack{
                        Circle()
                            .stroke(.white .opacity(0.2),lineWidth: 40)
                            .frame(width: isAnimating ? 260:0,height: isAnimating ? 260:0, alignment: .center)
                            .blur(radius: isAnimating ? 0 : 10 )
                            .opacity(isAnimating ? 1 : 0)
                            .scaleEffect(isAnimating ? 1: 0.5)
                            .animation(.bouncy(duration: 1.5),value: isAnimating)
                        Circle()
                            .stroke(.white .opacity(0.2),lineWidth: 80)
                            .frame(width:isAnimating ? 260:0,height: isAnimating ? 260:0, alignment: .center)
                            .blur(radius: isAnimating ? 0 : 10 )
                            .opacity(isAnimating ? 1 : 0)
                            .scaleEffect(isAnimating ? 1: 0.5)
                            .animation(.bouncy(duration: 1.5),value: isAnimating)
                    }
                    //zstack
                    
                    Image("character-1")
                        .resizable()
                        .scaledToFit()
                    //.opacity(isAnimating ? 1: 0)
                        .animation(.bouncy(duration: 0.6), value: isAnimating)
                    
                }//end of center
                
                Spacer()
                
                ZStack{
                    
                    //Background
                    
                    Capsule()
                        .fill(Color .white.opacity(0.2))
                    Capsule()
                        .fill(Color .white.opacity(0.2))
                        .padding(8)
                    
                    //CALL to ACTION
                    Text("Get Started")
                        .font(.system(.title3, design: .rounded))
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .offset(x: 20)
                    
                    
                    
                    //CAPSULE(DYNAMIC)
                    
                    HStack{
                        Capsule().fill(Color("ColorRed"))
                            .frame(width: buttonOffset + 80)
                        Spacer()
                    }
                    
                    //CIRCLE(DRAGABLE)
                    
                    
                    HStack {
                        ZStack{
                            Circle()
                                .fill(Color("ColorRed"))
                            Circle()
                                .fill(.black.opacity(0.15))
                                .padding(8)
                            Image(systemName: "chevron.right.2")
                                .font(.system(size: 24,weight: .bold))
                        }
                        .foregroundColor(.white)
                        .frame(width: 80,height: 80,alignment: .center)
                        .offset(x:buttonOffset)
                        .gesture(
                            DragGesture()
                                .onChanged{gesture in
                                    if gesture.translation.width > 0 && buttonOffset <= buttonWidth - 80
                                    {
                                        buttonOffset = gesture.translation.width
                                    }
                                }
                                .onEnded{_ in
                                    
                                    withAnimation(Animation.easeOut(duration: 2))
                                    {
                                        if buttonOffset > buttonWidth/1.5
                                        {
                                            buttonOffset = buttonWidth - 80
                                            isOnBoardingViewActive = false
                                        }
                                        else{
                                            buttonOffset = 0}
                                    }
                                }
                        ) //GESTURE
                        Spacer()
                    } //:Hstack
                    
                    
                }.frame(width: buttonWidth ,  height: 80,alignment: .center)
                    .padding()
                    .opacity(isAnimating ? 1: 0)
                    .offset(y: isAnimating ? 0: 40)
                    .animation(.bouncy(duration: 1.7), value: isAnimating)
                
                //FOOTER
                
            } //:vStack
        } //:zStack
        .onAppear(perform: {
            isAnimating = true
        })
    }
    //MARK: Footer
}



//MARK: preview


#Preview {
    OnBoardingView()
}
