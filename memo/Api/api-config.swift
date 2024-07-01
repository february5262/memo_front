import Foundation

// JSON 데이터를 매핑할 구조체를 정의합니다.
struct Memo: Codable {
    let id: Int?
    let content: String
    let timestamp: String
}

class APIClient {
    // 공통으로 사용할 GET 메서드를 정의합니다.
    private func performGetRequest<T: Codable>(url: URL, completion: @escaping (Result<[T], Error>) -> Void) {
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

    // 공통으로 사용할 POST 메서드를 정의합니다.
    private func performPostRequest<T: Codable>(url: URL, body: T, completion: @escaping (Result<T, Error>) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            request.httpBody = try JSONEncoder().encode(body)
        } catch let encodingError {
            completion(.failure(encodingError))
            return
        }
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let data = data {
                // 리턴되는 데이터를 콘솔에 출력
                if let jsonString = String(data: data, encoding: .utf8) {
                    print("Response JSON String: \(jsonString)")
                }
                
                do {
                    let jsonResponse = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(jsonResponse))
                } catch let jsonError {
                    print("Response JSON error: \(jsonError)")
                    completion(.failure(jsonError))
                }
            }
        }
        
        task.resume()
    }


    // 첫 번째 API 호출 (GET)
    func getMemo(completion: @escaping (Result<[Memo], Error>) -> Void) {
        if let url = URL(string: "http://localhost:3000/api/memo_content") {
            performGetRequest(url: url, completion: completion)
        }
    }

    // 두 번째 API 호출 (POST)
    func postMemo(body: Memo, completion: @escaping (Result<Memo, Error>) -> Void) {
        if let url = URL(string: "http://localhost:3000/api/memo_content") {
            performPostRequest(url: url, body: body, completion: completion)
        }
    }
}
