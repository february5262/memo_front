//
//  File.swift
//  memo
//
//  Created by 조윤경 on 6/26/24.
//
import Foundation
import Foundation

// JSON 데이터를 매핑할 구조체를 정의합니다.
struct Memo: Codable {
    let id: Int
    let content: String
    let timestamp: String
}

struct ApiResponse2: Codable {
    let id: Int
    let name: String
}

class APIClient {
    // 공통으로 사용할 메서드를 정의합니다.
    private func performRequest<T: Codable>(url: URL, completion: @escaping (Result<[T], Error>) -> Void) {
        let session = URLSession.shared
        let request = URLRequest(url: url)
        
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let data = data {
                do {
                    let jsonResponse = try JSONDecoder().decode([T].self, from: data)
                    completion(.success(jsonResponse))
                } catch let jsonError {
                    completion(.failure(jsonError))
                }
            }
        }
        
        task.resume()
    }

    // 첫 번째 API 호출
    func fetchFirstApi(completion: @escaping (Result<[Memo], Error>) -> Void) {
        if let url = URL(string: "http://localhost:3000/api/memo_content") {
            performRequest(url: url, completion: completion)
        }
    }

    // 두 번째 API 호출
//    func fetchSecondApi(completion: @escaping (Result<ApiResponse2, Error>) -> Void) {
//        if let url = URL(string: "https://api.example.com/data2") {
//            performRequest(url: url, completion: completion)
//        }
//    }
}
