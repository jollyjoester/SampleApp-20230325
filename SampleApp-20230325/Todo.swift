import Foundation

struct Todo: Hashable, Codable {
    let content: String
    let date: Date
}

extension Todo {
    static func getTodoListFromUserDefaults() -> [Todo] {
        if let data = UserDefaults.standard.object(forKey: "TodoList") as? Data,
           let todoList = try? JSONDecoder().decode([Todo].self, from: data) {
            return todoList
        } else {
            return []
        }
    }
    
    static func setTodoListToUserDefaults(_ todoList: [Todo]) {
        if let encoded = try? JSONEncoder().encode(todoList) {
            UserDefaults.standard.set(encoded, forKey: "TodoList")
        }
    }
}
