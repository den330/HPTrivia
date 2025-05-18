//
//  Gameplay.swift
//  HP Trivia
//
//  Created by yaxin on 2025-05-17.
//

import SwiftUI

struct Gameplay: View {
    @State private var movePointsToScore = false
    @State private var animateViewsIn: Bool = false
    @State private var animateCelebrationViewsIn: Bool = false
    @State private var hintWiggle = false
    @State private var scaleNextButton = false
    @State private var revealHint = false
    @State private var revealBook = false
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Image("hogwarts")
                    .resizable()
                    .frame(width: geo.size.width * 3, height: geo.size.height * 1.05)
                    .overlay(Rectangle().foregroundStyle(.black).opacity(0.8))
                VStack {
                    HStack {
                        // MARK: Controls
                        Button("End Game") {
                            dismiss()
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(.red.opacity(0.5))
                        Spacer()
                        Text("Score: 33")
                    }
                    .padding()
                    .padding(.vertical, 30)
                       
                    // MARK: Question
                    VStack {
                        if animateViewsIn {
                            Text("Who is Harry Potter?")
                                .font(.custom(Constants.hpFont, size: 50))
                                .multilineTextAlignment(.center)
                                .padding()
                                .transition(.opacity)
                        }
                    }
                    .animation(.easeInOut(duration: 2), value: animateViewsIn)
                    Spacer()
                    
                    // MARK: Hints
                    HStack {
                        VStack {
                            if animateViewsIn {
                                Image(systemName: "questionmark.app.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100)
                                    .foregroundStyle(.cyan)
                                    .rotationEffect(hintWiggle ? .degrees(-13) : .degrees(-17))
                                    .padding()
                                    .padding(.leading)
                                    .transition(.offset(x: -geo.size.width/2))
                                    .onAppear {
                                        withAnimation(.easeInOut(duration: 0.1).repeatCount(9, autoreverses: true).delay(5).repeatForever()) {
                                            hintWiggle = true
                                        }
                                    }
                                    .onTapGesture {
                                        withAnimation(.easeOut(duration: 2)) {
                                            revealHint = true
                                        }
                                    }
                                    .rotation3DEffect(.degrees(revealHint ? 1440 : 0), axis: (x: 0, y: 1, z: 0))
                                    .scaleEffect(revealHint ? 5 : 1)
                                    .opacity(revealHint ? 0 : 1)
                                    .offset(x: revealHint ? geo.size.width / 2 : 0)
                                    .overlay(
                                        Text("hint")
                                            .padding(.leading, 33)
                                            .minimumScaleFactor(0.5)
                                            .multilineTextAlignment(.center)
                                            .opacity(revealHint ? 1 : 0)
                                            .scaleEffect(revealHint ? 1.33 : 1)
                                    )
                            }
                        }
                        .animation(.easeInOut(duration: 1.5).delay(2), value: animateViewsIn)
                        Spacer()
                        VStack {
                            if animateViewsIn {
                                Image(systemName: "book.closed")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50)
                                    .foregroundStyle(.black)
                                    .frame(width: 100, height:100)
                                    .background(.cyan)
                                    .clipShape(.rect(cornerRadius: 20))
                                    .rotationEffect(hintWiggle ? .degrees(13) : .degrees(17))
                                    .padding()
                                    .padding(.trailing)
                                    .transition(.offset(x: geo.size.width/2))
                                    .onAppear {
                                        withAnimation(.easeInOut(duration: 0.1).repeatCount(9, autoreverses: true).delay(5).repeatForever()) {
                                            hintWiggle = true
                                        }
                                    }
                                    .onTapGesture {
                                        withAnimation(.easeOut(duration: 2)) {
                                            revealBook = true
                                        }
                                    }
                                    .rotation3DEffect(.degrees(revealBook ? 1440 : 0), axis: (x: 1, y: 1, z: 0))
                                    .scaleEffect(revealBook ? 5 : 1)
                                    .opacity(revealBook ? 0 : 1)
                                    .offset(x: revealBook ? -geo.size.width / 2 : 0)
                                    .overlay(
                                        Image("hp1")
                                            .resizable()
                                            .scaledToFit()
                                            .padding(.trailing, 33)
                                            .opacity(revealBook ? 1 : 0)
                                            .scaleEffect(revealBook ? 1.33 : 1)
                                    )
                            }
                        }
                        .animation(.easeInOut(duration: 1.5).delay(2), value: animateViewsIn)
                    }
                    .padding(.bottom)
                    // MARK: Answers
                    LazyVGrid(columns: [GridItem(), GridItem()]) {
                        ForEach(1..<5) { i in
                            VStack {
                                if animateViewsIn {
                                    Text("Answer \(i)")
                                        .minimumScaleFactor(0.5)
                                        .multilineTextAlignment(.center)
                                        .padding(10)
                                        .frame(width: geo.size.width / 2.15, height: 80)
                                        .background(.green.opacity(0.5))
                                        .clipShape(.rect(cornerRadius: 25))
                                        .transition(.scale
                                            .animation(.easeOut(duration: 1).delay(1.5))
                                        )
                                }
                            }
                        }
                    }
                    Spacer()
                }
                .frame(width: geo.size.width, height: geo.size.height)
                .foregroundStyle(.white)
                
                // MARK: Celebration
                VStack {
                    Spacer()
                    VStack {
                        if animateCelebrationViewsIn {
                            Text("5")
                                .font(.largeTitle)
                                .padding(.top, 50)
                                .transition(.offset(y: -geo.size.height / 4))
                                .offset(x: movePointsToScore ? geo.size.width / 2.3 : 0, y: movePointsToScore ? -geo.size.height / 13 : 0)
                                .opacity(movePointsToScore ? 0 : 1)
                                .onAppear {
                                    withAnimation(.easeInOut(duration: 1).delay(3)) {
                                        movePointsToScore = true
                                    }
                                }
                        }
                    }
                    .animation(.easeInOut(duration: 1).delay(2), value: animateCelebrationViewsIn)
                    Spacer()
                    VStack {
                        if animateCelebrationViewsIn {
                            Text("Brilliant!")
                                .font(.custom(Constants.hpFont, size: 100))
                                .transition(.scale.combined(with: .offset(y: -geo.size.height/2)))
                        }
                    }
                    .animation(.easeInOut(duration: 1).delay(2), value: animateCelebrationViewsIn)
                    Spacer()
                    if animateCelebrationViewsIn {
                        Text("Answer 1")
                            .minimumScaleFactor(0.5)
                            .multilineTextAlignment(.center)
                            .padding(10)
                            .frame(width: geo.size.width / 2.15, height: 80)
                            .background(.green.opacity(0.5))
                            .clipShape(.rect(cornerRadius: 25))
                            .scaleEffect(2)
                    }
                    Spacer()
                    Spacer()
                    VStack {
                        if animateCelebrationViewsIn {
                            Button("Next Level >") {
                                // TODO: reset level for next question
                            }
                            .transition(.offset(y: geo.size.height / 3))
                            .buttonStyle(.borderedProminent)
                            .tint(.blue.opacity(0.5))
                            .font(.largeTitle)
                            .scaleEffect(scaleNextButton ? 1.2 : 1)
                            .onAppear {
                                withAnimation(.easeInOut(duration: 1.3).repeatForever()){
                                    scaleNextButton.toggle()
                                }
                            }
                        }
                    }
                    .animation(.easeInOut(duration: 2.7).delay(2.7), value: animateCelebrationViewsIn)
                    Spacer()
                    Spacer()
                }
                .foregroundStyle(.white)

            }
            .frame(width: geo.size.width, height: geo.size.height)
        }
        .ignoresSafeArea()
        .onAppear {
            animateViewsIn = true
//            animateCelebrationViewsIn = true
        }
    }
}

#Preview {
    Gameplay()
}
