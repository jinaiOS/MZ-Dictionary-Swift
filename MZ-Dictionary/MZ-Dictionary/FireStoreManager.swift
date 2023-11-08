//
//  FireStoreManager.swift
//  MZ-Dictionary
//
//  Created by 김지은 on 2023/11/09.
//

import Foundation
import FirebaseFirestore

class FireStoreManager {
    static let shared = FireStoreManager()
    private let db = Firestore.firestore()
    
    func fetchNumberOfDoc() async -> (result: Int?, error: Error?) {
        let ref = db.collection("list")
        let countQuery = ref.count
        do {
            let snapshot = try await countQuery.getAggregation(source: .server)
            print(snapshot.count.intValue)
            return (snapshot.count.intValue, nil)
        } catch {
            print(error)
            return (nil, error)
        }
    }
    
    /// fetch list
    func fetchList(pageSize: Int, completion: @escaping ([ListModel]?) -> Void) {
        var dic: [[String:Any]] = [[:]]
        var value: [ListModel]?
        
        db.collection("list").limit(to: pageSize).getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
                completion(value) // 호출하는 쪽에 빈 배열 전달
                return
            }
            
            for document in querySnapshot!.documents {
                dic.append(document.data())
            }
            
            dic.remove(at: 0)
            value = self.dictionaryToObject(objectType: ListModel.self, dictionary: dic)
            completion(value) // 성공 시 이름 배열 전달
        }
    }
}
extension FireStoreManager {
    public enum StoreError: Error {
        case failedToFetch
        
        public var localizedDescription: String {
            switch self {
            case .failedToFetch:
                return "데이터 가져오기 실패"
            }
        }
    }
}
extension FireStoreManager {
    func dictionaryToObject<T:Decodable>(objectType:T.Type,dictionary:[[String:Any]]) -> [T]? {
        guard let dictionaries = try? JSONSerialization.data(withJSONObject: dictionary) else { return nil }
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let objects = try? decoder.decode([T].self, from: dictionaries) else { return nil }
        return objects
    }
    
    func dicToObject<T:Decodable>(objectType:T.Type,dictionary:[String:Any]) -> T? {
        guard let dictionaries = try? JSONSerialization.data(withJSONObject: dictionary) else { return nil }
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let objects = try? decoder.decode(T.self, from: dictionaries) else { return nil }
        return objects
    }
}
