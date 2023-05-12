import SwiftUI

struct TodoInputView: View {
    
    @State private var text: String = ""
    @State private var date: Date = Date()
    
    var body: some View {
        VStack {
            Text("TODOを入力してください")
            TextField("TODO", text: $text)
            DatePicker("日付",
                       selection: $date,
                       displayedComponents: [.date]
            )
            Button(action: {
                guard !text.isEmpty else { return }
                
                var todoList = UserDefaults.standard.array(forKey: "TodoList") as? [Todo] ?? []
                
                let todo = Todo(content: text, date: date)
                todoList.append(todo)
                
                if let encoded = try? JSONEncoder().encode(todoList) {
                    UserDefaults.standard.set(encoded, forKey: "TodoList")
                }
            }, label: {
                Text("追加する")
            })
        }
        .padding()
    }
}

struct TodoInputView_Previews: PreviewProvider {
    static var previews: some View {
        TodoInputView()
    }
}
