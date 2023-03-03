//
//  Task.swift
//  ToDoListCleanSwift
//
//  Created by Dmitry Serebrov on 03.03.2023.
//

import Foundation
/// Класс, описывающий задание
class Task {
	/// Название и статус задания
	var title: String
	var completed = false

	/// Инициализатор класса
	init(title: String, completed: Bool = false) {
		self.title = title
		self.completed = completed
	}
}

/// Класс, описывающий обычное задание
final class RegularTask: Task { }

/// Класс, описывающий важное задание
final class ImportantTask: Task {
	/// Хранит виды приоритетности задач
	enum TaskPriority: Int {
		case low
		case medium
		case high
	}

	/// Дедлайн задачи
	var deadLine: Date {
		switch taskPriority {
		case .low:
			return Calendar.current.date(byAdding: .day, value: 3, to: Date())!
		case .medium:
			return Calendar.current.date(byAdding: .day, value: 2, to: Date())!
		case .high:
			return Calendar.current.date(byAdding: .day, value: 1, to: Date())!
		}
	}

	/// Приоритетность задачи
	var taskPriority: TaskPriority

	/// Инициализатор класса
	init(title: String, taskPriority: TaskPriority) {
		self.taskPriority = taskPriority
		super.init(title: title)
	}
}
