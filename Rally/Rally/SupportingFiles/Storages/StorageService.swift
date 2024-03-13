import UIKit
import Foundation

final class StorageService {
    static let shared = StorageService()
    private init() {}
    
    func save(_ settingsModel: SettingsModel) {
        let data = try? JSONEncoder().encode(settingsModel)
        UserDefaults.standard.setValue(data, forKey: UR.DataKeys.settingsKey)
    }
    
    func saveUserRatings(_ user: User) throws {
        let fileManager = FileManager.default
        let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileURL = documentsDirectory.appendingPathComponent(UR.DataKeys.ratingsKey)
        if FileManager.default.fileExists(atPath: fileURL.path) {
            do {
                var dataUser = loadUserRatings()! as [User]
                if let index = dataUser.firstIndex(where: { $0.username == user.username }) {
                    dataUser[index] = user
                }
                let data = try? JSONEncoder().encode(dataUser)
                try data?.write(to: fileURL)
            } catch {
                print("Ошибка при добавлении данных: \(error)")
            }
        } else  {
            do {
                let users: [User] = [User(username: user.username, score: user.score, date: user.date, avatarImageKey: user.avatarImageKey)]
                let data = try? JSONEncoder().encode(users)
                try data?.write(to: fileURL)
            } catch {
                print("Ошибка при сохранении данных: \(error)")
            }
            
        }
    }
    
    func loadUserRatings() -> [User]? {
        let fileManager = FileManager.default
        let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileURL = documentsDirectory.appendingPathComponent(UR.DataKeys.ratingsKey)
        
        if fileManager.fileExists(atPath: fileURL.path) {
            do {
                let data = try Data(contentsOf: fileURL)
                let decoder = JSONDecoder()
                let loadedData = try decoder.decode([User].self, from: data)
                return loadedData as [User]
            } catch {
                print("Error: \(error)")
            }
        } else {
            return nil
        }
        return nil
    }

    
    func load() -> SettingsModel? {
        guard let data = UserDefaults.standard.value(forKey: UR.DataKeys.settingsKey) as? Data else {
            return nil
        }
        let user = try? JSONDecoder().decode(SettingsModel.self, from: data)
        return user
    }
    
    func saveImage(_ image: UIImage) throws -> String? {
        guard let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first,
              let data = image.jpegData(compressionQuality: 1.0) else { return nil }
        let name = UUID().uuidString
        let url = directory.appendingPathComponent(name)

        if FileManager.default.fileExists(atPath: url.path) {
            try FileManager.default.removeItem(atPath: url.path)
        }

        try data.write(to: url)
        return name
    }
    
    func loadImage(by name: String) -> UIImage? {
        guard let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }
        let url = directory.appendingPathComponent(name)
        return UIImage(contentsOfFile: url.path)
    }
    
    func clearAllFiles() {
        let fileManager = FileManager.default
            
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
            
        do {
            let fileName = try fileManager.contentsOfDirectory(atPath: paths)
                
            for file in fileName {
                let filePath = URL(fileURLWithPath: paths).appendingPathComponent(file).absoluteURL
                try fileManager.removeItem(at: filePath)
            }
        } catch let error {
            print(error)
        }
    }

}
