//
//  Alphabet.swift
//  macroChallenge
//
//  Created by Barbara Argolo on 01/06/23.
//

import Foundation

struct Alphabet: CustomStringConvertible {
    
    let letters: [String]
    
    var description: String {
        return letters.joined()
    }
    
    
}
