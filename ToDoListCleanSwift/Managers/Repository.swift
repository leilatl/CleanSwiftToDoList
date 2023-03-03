//
//  Repository.swift
//  ToDoListCleanSwift
//
//  Created by Dmitry Serebrov on 03.03.2023.
//

import Foundation
/// Шаблон проектирования репозиторий
protocol ITaskRepository {
	/// Отдает список готовых заданий
	func getTasks() -> [Task]
}

final class TaskRepositoryStub: ITaskRepository {
	/// Отдает список готовых заданий
	func getTasks() -> [Task] {
		[
			ImportantTask(title: "Do homework", taskPriority: .high),
			RegularTask(title: "Do Workout", completed: true),
			ImportantTask(title: "Write new tasks", taskPriority: .low),
			RegularTask(title: "Solve 3 algorithms"),
			ImportantTask(title: "Go shopping", taskPriority: .medium)
		]
	}
}
