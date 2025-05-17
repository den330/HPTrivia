//
//  Instructions.swift
//  HP Trivia
//
//  Created by yaxin on 2025-05-16.
//

import SwiftUI

struct Instructions: View {
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        ZStack {
            InfoBackgroundImage()
            VStack {
                Image("appiconwithradius")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150)
                    .padding(.top)
                ScrollView {
                    Text("How to play")
                        .font(.largeTitle)
                        .padding()
                    VStack(alignment: .leading) {
                        Text("Welcome to HPTrivia, in this game you will be asked random questions from the HP books, and you must guess the right answer or you will lose points!😱")
                            .padding([.horizontal, .bottom])
                        Text("Each question is worth 5 points, but if you guess a wrong answer, you lose 1 point.")
                            .padding([.horizontal, .bottom])
                        Text("If you get stuck, there is an option to reveal a hint or reveal the book that answer the question, but be aware, using this option will reduce your points by 1 point each!")
                            .padding([.horizontal, .bottom])
                        Text("Selecting the right answer will receive full points and they will be added to total score")
                            .padding(.horizontal)
                    }
                    .font(.title3)
                    Text("Good luck")
                        .font(.title)
                }
                .foregroundStyle(.black)
                
                Button("Done") {
                    dismiss()
                }
                .doneButton()
            }
        }
    }
}

#Preview {
    Instructions()
}
