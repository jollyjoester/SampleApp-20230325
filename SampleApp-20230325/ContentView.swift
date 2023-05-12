import SwiftUI

struct ContentView: View {
    @State private var isTodoInputViewPresented = false
    @State private var todoList: [Todo] = []
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                List(todoList, id: \.self) { todo in
                    let today = Date()
                    let todayString = stringFromDate(date: today)
                    
                    let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: Date())!
                    let tomorrowString = stringFromDate(date: tomorrow)
                    
                    let todoDateString = stringFromDate(date: todo.date)
                    
                    if todayString == todoDateString {
                        Section("今日") {
                            HStack {
                                Text(todo.content)
                                Text(stringFromDate(date: todo.date))
                            }
                        }
                    } else if tomorrowString == todoDateString {
                        Section("明日") {
                            HStack {
                                Text(todo.content)
                                Text(stringFromDate(date: todo.date))
                            }
                        }
                    }
                }
                let todoForWeek = todoList.filter {
                    let today = Date()
                    let weekDay =  Calendar.current.component(.weekday, from: today)
                    
                    let begining = Calendar.current.date(byAdding: .day, value: -(weekDay - 1), to: today)!
                    let end = Calendar.current.date(byAdding: .day, value: 7, to: begining)!
                    
                    if $0.date >= begining && $0.date <= end {
                        return true
                    } else {
                        return false
                    }
                }
                List(todoForWeek, id: \.self) { todo in
                    Text(todo.content)
                }
                Button(action: {
                    todoList = Todo.getTodoListFromUserDefaults()
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
