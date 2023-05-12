import SwiftUI

struct ContentView: View {
    @State private var isTodoInputViewPresented = false
    @State private var todoList: [Todo] = []
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                List(todoList, id: \.self) { todo in
                    HStack {
                        Text(todo.content)
                        Text(stringFromDate(date: todo.date))
                    }
                }
                Button(action: {
                    todoList = getTodoListFromUserDefaults()
                }, label: {
                    Text("更新")
                })
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isTodoInputViewPresented = true
                    }) {
                        Image(systemName: "plus")
                    }
                    .sheet(isPresented: $isTodoInputViewPresented) {
                        TodoInputView()
                    }
                }
            }
        }
    }
    
    private func stringFromDate(date: Date) -> String {
        let formatter: DateFormatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.dateFormat = "yyyy/MM/dd"
        return formatter.string(from: date)
    }
    
    private func getTodoListFromUserDefaults() -> [Todo] {
        if let data = UserDefaults.standard.object(forKey: "TodoList") as? Data,
           let todoList = try? JSONDecoder().decode([Todo].self, from: data) {
            return todoList
        } else {
            return []
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
