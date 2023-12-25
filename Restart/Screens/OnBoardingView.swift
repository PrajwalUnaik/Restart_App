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
    
    let hapticfeedback = UINotificationFeedbackGenerator()
    
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
                    how much we put into giving.
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
                    }.offset(x: imageOffset.width * -1)
                        .blur(radius: abs(imageOffset.width/5))
                        .animation(.easeInOut(duration: 1),value: imageOffset)
                    //zstack
                    
                    Image("character-1")
                        .resizable()
                        .scaledToFit()
                    //.opacity(isAnimating ? 1: 0)
                        .animation(.bouncy(duration: 0.6), value: isAnimating)
                        .offset(x:imageOffset.width * 1.2, y: 0)
                        .rotationEffect(.degrees(Double(imageOffset.width/20)))
                        .gesture(
                            DragGesture()
                                .onChanged{ gesture in
                                    if abs(imageOffset.width) <= 150 {
                                        imageOffset = gesture.translation
                                        withAnimation(.linear(duration: 0.25)){
                                            indicatorOpacity = 0
                                            textTitle = "Give."
                                        }

                                    }
                                }
                                .onEnded{_ in
                                    imageOffset = .zero
                                    withAnimation(.linear(duration: 0.25))
                                    {
                                        indicatorOpacity = 1
                                        textTitle = "Share."
                                    }
                                }
                        )
                        .animation(.easeInOut(duration: 1), value: imageOffset)
                }//end of center
                
                .overlay(
                Image(systemName: "arrow.left.and.right.circle")
                    .font(.system(size: 44, weight: .ultraLight))
                    .foregroundColor(.white)
                    .offset(y:20)
                    .opacity(isAnimating ? 1:0)
                    .animation(.bouncy(duration: 1).delay(1.5), value: isAnimating)
                    .opacity(indicatorOpacity)
                ,alignment: .bottom
                )
                
                Spacer()
                
                ZStack{
                    
                    //Background
                    
                    Capsule()
                        .fill(Color .white.opacity(0.2))
                    Capsule()
                        .fill(Color .white.opacity(0.2))
                        .padding(8)
                    
                    //CALL to ACTION
                    Text("Get Started swipe")
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
                                            hapticfeedback.notificationOccurred(.success)
                                            playsound(sound: "chimeup", type: "mp3")
                                            buttonOffset = buttonWidth - 80
                                            isOnBoardingViewActive = false
                                        }
                                        else{
                                            hapticfeedback.notificationOccurred(.warning)
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
        .preferredColorScheme(.dark)
    }
    //MARK: Footer
}



//MARK: preview


#Preview {
    OnBoardingView()
}
