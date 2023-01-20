//
//  EditCards.swift
//  Flashzilla
//
//  Created by Orlando Moraes Martins on 20/01/23.
//

import SwiftUI

struct EditCards: View {
    @Environment(\.dismiss) var dismiss
    @State private var cards = [Card]()
    @State private var newPrompt = ""
    @State private var newAnswer = ""
    
    let savedKey = "Cards.json"
    
    var body: some View {
        NavigationView{
            List {
                Section ("Add new card") {
                    TextField("Promp", text: $newPrompt)
                    TextField("Answer", text: $newAnswer)
                    Button ("Add card", action: addCard)
                }
                
                Section {
                    ForEach(0..<cards.count,id: \.self) { index in
                        VStack(alignment: .leading) {
                            Text(cards[index].prompt)
                                .font(.headline)
                            
                            Text(cards[index].answer)
                                .font(.title)
                                .foregroundColor(.secondary)
                        }
                    }
                    .onDelete(perform: removeCards)
                }
            }
        }
        .navigationBarTitle("Add cards")
        .toolbar{
            Button("Done", action: done)
        }
        .listStyle(.grouped)
        .onAppear(perform: loadData)
    }
    
    func done() {
        dismiss()
    }
    
    func loadData(){
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        let url = documentsDirectory.appendingPathComponent(savedKey)
        
        guard let data = try? Data(contentsOf: url) else { return }
        
        do {
            cards = try JSONDecoder().decode([Card].self, from: data)
        } catch {
            print("Error decoding the file \(error.localizedDescription)")
            self.cards = []
        }
        
        
//        if let data = UserDefaults.standard.data(forKey: "Cards") {
//            if let decoded = try? JSONDecoder().decode([Card].self, from: data) {
//                cards = decoded
//            }
//        }
    }
    
    func saveData () {
        guard let data = try? JSONEncoder().encode(cards) else {
            return
        }
        
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        let fileURL = documentsDirectory.appendingPathComponent(savedKey)
        
        do {
            try data.write(to: fileURL)
        } catch {
            print("Can't save in directory \(error.localizedDescription)")
        }
    }
    
    func addCard() {
        let trimmedPrompt = newPrompt.trimmingCharacters(in: .whitespaces)
        let trimmedAnswer = newAnswer.trimmingCharacters(in: .whitespaces)
        self.newPrompt = ""
        self.newAnswer = ""
        
        guard trimmedPrompt.isEmpty == false && trimmedAnswer.isEmpty == false else { return }
        
        let card = Card(prompt: trimmedPrompt, answer: trimmedAnswer)
        cards.insert(card, at: 0)
        saveData()
    }
    
    func removeCards(at offsets: IndexSet) {
        cards.remove(atOffsets: offsets)
        saveData()
    }
}

struct EditCards_Previews: PreviewProvider {
    static var previews: some View {
        EditCards()
    }
}
