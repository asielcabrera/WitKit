//
//  File.swift
//  
//
//  Created by Asiel Cabrera Gonzalez on 12/6/21.
//

import Foundation
import WitKit


let wit = WitClient(token: "WPN3ODPI4GFIVSORXTIHE6UZ7YFVQJOB")
wit.message(.basic(text: "pon la temperatura en la dormitorio a 50 grados"), completion: { result in
    switch result {
    case .success(let data):
        print(data!)
    case .failure(let error):
        print("error: -- \(error.localizedDescription)")
    }
})




