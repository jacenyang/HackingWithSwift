//
//  ContentView.swift
//  Multiply
//
//  Created by Jason Yang on 17/07/21.
//

import SwiftUI

struct Question: Equatable {
    let text: String
    let answer: String
}

struct CardView: View {
    let question: Question
    
    @State private var userAnswer = ""
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.init(UIColor(red: 196/255, green: 144/255, blue: 228/255, alpha: 1)))
            VStack {
                Text(question.text)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color.init(UIColor(red: 249/255, green: 249/255, blue: 249/255, alpha: 1)))
                Spacer()
                Text(question.answer)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color.init(UIColor(red: 249/255, green: 249/255, blue: 249/255, alpha: 1)))
                Spacer()
                TextField("Enter your answer", text: $userAnswer, onCommit:  {
                    UIApplication.shared.endEditing()
                })
                .font(.title)
                .foregroundColor(Color.init(UIColor(red: 249/255, green: 249/255, blue: 249/255, alpha: 1)))
                .background(Color.init(UIColor(red: 246/255, green: 198/255, blue: 234/255, alpha: 1)))
                .cornerRadius(5)
                .keyboardType(.numberPad)
            }
            .frame(maxWidth: 250, maxHeight: 150, alignment: .center)
        }
        .frame(maxWidth: 300, maxHeight: 200, alignment: .center)
    }
}

struct GameView: View {
    @State var questions: [Question]
    @State private var currentQuestion = 0
    
    var body: some View {
        ZStack {
            Color.init(UIColor(red: 205/255, green: 240/255, blue: 234/255, alpha: 1))
        }
        .ignoresSafeArea()
        .navigationBarHidden(true)
    }
}

struct ContentView: View {
    @State private var multiplyUpTo = 6
    @State private var questionNumber = 0
    @State private var questions = [Question]()
    
    let questionNumbers = ["5", "10", "20", "All"]
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Multiply up to")) {
                    Stepper(value: $multiplyUpTo, in: 1...12, step: 1) {
                        Text("\(self.multiplyUpTo)")
                    }
                }
                
                Section(header: Text("Numbers of questions")) {
                    Picker("Question number", selection: $questionNumber) {
                        ForEach(0 ..< questionNumbers.count) {
                            Text(self.questionNumbers[$0])
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                NavigationLink(destination: GameView(questions: questions)) {
                    Button("Start") {
                        generateQuestion(multiplyUpTo: multiplyUpTo, questionNumbers: Int(questionNumbers[questionNumber]) ?? 0)
                    }
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
                }
            }
            .navigationTitle("Multiply")
        }
    }
    
    func generateQuestion(multiplyUpTo: Int, questionNumbers: Int) {
        for x in 1...multiplyUpTo {
            for y in 1...10 {
                questions.append(Question(text: "\(x) x \(y)", answer: "\(x * y)"))
            }
        }
        guard questionNumbers == 0 else {
            while questions.count > questionNumbers {
                let randomIndex = Int.random(in: 0..<questions.count)
                if questions.contains(questions[randomIndex]) {
                    questions.remove(at: randomIndex)
                }
            }
            return
        }
    }
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
