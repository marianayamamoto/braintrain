//
//  ContentView.swift
//  BrainTrain
//
//  Created by Mariana Yamamoto on 8/31/21.
//

import SwiftUI

struct QuestionView: View {
    var imageName: String
    var shouldWin: Bool

    var body: some View {
        Text("App chooses:")
        Image(imageName)
                .renderingMode(.original)
                .resizable()
                .frame(width: 40, height: 40)
        Text("\(imageName)")
            .font(.title)
            .textCase(.uppercase)
            .foregroundColor(.blue)
        Text("You should: ")
        if shouldWin {
            Text("WIN")
                .foregroundColor(.green)
                .font(.largeTitle)

        } else {
            Text("LOSE")
                .foregroundColor(.red)
                .font(.largeTitle)

        }
    }
}
struct ContentView: View {
    let moves = ["rock", "paper", "scissors"]
    @State private var choice: Int = Int.random(in: 0...2)
    @State private var shouldWin: Bool = Bool.random()
    @State private var tries = 0
    @State private var score = 0
    @State private var attemptResult: Bool = false

    var body: some View {
        VStack {
            QuestionView(imageName: moves[choice], shouldWin: shouldWin)
            Divider()
            Text("You choose:")
            HStack {
                ForEach(0 ..< 3 ) { number in
                    Button(action: {
                        self.moveChosen(number)
                    }) {
                        Image(moves[number])
                            .renderingMode(.original)
                            .resizable()
                            .frame(width: 40, height: 40)
                            .clipShape(RoundedRectangle(cornerRadius: 5, style: .continuous))
                    }
                }
            }
            Divider()
            if tries > 0 {
                if attemptResult {
                    Text("RIGHT")
                        .foregroundColor(.green)
                        .font(.title)

                } else {
                    Text("WRONG")
                        .foregroundColor(.red)
                        .font(.title)

                }
            }
            Text("Attempts: \(self.tries)/10")
            if self.tries == 10 {
                Divider()
                Text("Your score is: \(score)")
            }
        }
    }

    func moveChosen(_ number: Int) {
        tries += 1
        let correctAnswerIndex = shouldWin ? choice + 1 : choice - 1
        let correctAnswer = moves[(correctAnswerIndex % moves.count + moves.count) % moves.count]

        attemptResult = moves[number] == correctAnswer
        if attemptResult {
            score += 1
        } else {
            score = score == 0 ? 0 : score - 1
        }
        if tries == 11 {
            tries = 0
        }
        shuffle()
    }

    func shuffle() {
        choice = Int.random(in: 0...2)
        shouldWin = Bool.random()
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
