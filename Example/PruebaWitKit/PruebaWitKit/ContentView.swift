//
//  ContentView.swift
//  PruebaWitKit
//
//  Created by Asiel Cabrera Gonzalez on 12/9/21.
//

import SwiftUI
import WitKit

struct ContentView: View {
    
    @State var message: String = "hola"
    @State private var witMessage: WitMessage?
    var body: some View {
        VStack {
            VStack(alignment: .center, spacing: 15) {
                TextField(message, text: $message)
                    .padding()
                    .background(Color.black.opacity(0.5))
                    .cornerRadius(15)
                    
                Text(message)
                
            }.padding()
            Button {
                let wit = WitClient(token: "WPN3ODPI4GFIVSORXTIHE6UZ7YFVQJOB")
//                wit.message(.basic(text: message)) { result in
//                    switch result {
//
//                    case .failure(let error):
//                        print(error)
//                    case .success(let me):
//                        message = (me?.intents[0].name)!
//                    }
//                }
                
                let _: Future<WitMessage> = wit.messageAsync(.basic(text: message))
//                    .saved(in: DatabasePrueba<WitMessage>(witMessage: $witMessage))
                    .transformed { (data: WitMessage) in
                        if !data.intents.isEmpty {
                            message = data.intents[0].name
                        }
                        return data
                    }
                
            } label: {
                Text("Send")
            }

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


class DatabasePrueba<T: Decodable>: Database {
    
    var witMessage: Binding<T?>
    
    init(witMessage: Binding<T?>) {
        self.witMessage = witMessage
    }
    
    func save<T>(_ value: T, completion: @escaping () -> ()) where T : Decodable {
        print(value)
        completion()
    }
}
