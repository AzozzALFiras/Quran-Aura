import Foundation

class NetworkService {
    static let shared = NetworkService()
    
    private init() {}
    
    func fetchReciters(completion: @escaping (Result<[Reciter], Error>) -> Void) {
        guard let url = URL(string: "https://quran-aura.fahmly.com/api/v1/list.php") else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0)))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: 0)))
                return
            }
            
            do {
                let response = try JSONDecoder().decode(RecitersResponse.self, from: data)
                completion(.success(response.data))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func fetchSurahs(completion: @escaping (Result<[Surah], Error>) -> Void) {
        guard let url = URL(string: "https://quran-aura.fahmly.com/api/v1/souar.php") else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0)))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: 0)))
                return
            }
            
            do {
                let response = try JSONDecoder().decode(SurahsResponse.self, from: data)
                let surahs = response.data.map { Surah(name: $0.key, number: $0.value) }
                    .sorted { Int($0.number) ?? 0 < Int($1.number) ?? 0 }
                completion(.success(surahs))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}