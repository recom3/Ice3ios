//
//  WebService.swift
//  snow3
//
//  Created by Jesus Campos on 23.07.24.
//

import Foundation

class WebService {
    
    // Function to send POST request with JSON payload
    func postRequest(urlString: String, jsonPayload: [String: Any], completion: @escaping (Result<Data, Error>) -> Void) {

        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 400, userInfo: nil)))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: jsonPayload, options: [])
            request.httpBody = jsonData
        } catch let error {
            completion(.failure(error))
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 500
                completion(.failure(NSError(domain: "Invalid response", code: statusCode, userInfo: nil)))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: 204, userInfo: nil)))
                return
            }
            
            // Print the response payload
            if let jsonResponse = try? JSONSerialization.jsonObject(with: data, options: []) {
                print("Received JSON response: \(jsonResponse)")
            } else if let responseString = String(data: data, encoding: .utf8) {
                print("Received response string: \(responseString)")
                UserDefaults.standard.set(responseString, forKey: "jwtRecom3")
            } else {
                print("Received raw data: \(data)")
            }
            
            completion(.success(data))
        }
        
        task.resume()
    }
}
