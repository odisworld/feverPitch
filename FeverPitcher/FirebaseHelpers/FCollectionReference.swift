//
//  FCollectionReference.swift
//  FeverPitcher
//
//  Created by Consultant on 25/08/2022.
//

import Foundation
import FirebaseFirestore


enum FCollectionReference: String {
    case User
    case Like
    case Match
    case Recent
    case Messages
    case Typing
}


func FirebaseReference(_ collectionReference: FCollectionReference) -> CollectionReference {
    
    return Firestore.firestore().collection(collectionReference.rawValue)
}
