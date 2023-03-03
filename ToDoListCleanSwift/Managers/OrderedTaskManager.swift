//
//  OrderedTaskManager.swift
//  ToDoListCleanSwift
//
//  Created by Dmitry Serebrov on 03.03.2023.
//

import Foundation
/// Предоставляет список заданий, отсортированных по приоритету.
final class OrderedTaskManager: ITaskManager {
	/// Переменная для отображения к главному таск менеджеру
	let taskManager: ITaskManager

	/// Инициализатор класса
	init(taskManager: ITaskManager) {
		self.taskManager = taskManager
	}

	/// Отдает список всех заданий
	public func allTasks() -> [Task] {
		sorted(tasks: taskManager.allTasks())
	}

	/// Отдает список выполненных заданий
	public func completedTasks() -> [Task] {
		sorted(tasks: taskManager.completedTasks())
	}

	/// Отдает список невыполненных заданий
	public func uncompletedTasks() -> [Task] {
		sorted(tasks: taskManager.uncompletedTasks())
	}

	/// Добавляет переданный массив заданий к списку заданий
	public func addTasks(tasks: [Task]) {
		taskManager.addTasks(tasks: tasks)
	}

	private func sorted(tasks: [Task]) -> [Task] {
		tasks.sorted {
			if let task0 = $0 as? ImportantTask, let task1 = $1 as? ImportantTask {
				return task0.taskPriority.rawValue > task1.taskPriority.rawValue
			}

			if $0 is ImportantTask, $1 is RegularTask {
				return true
			}

			if  $0 is RegularTask, $1 is ImportantTask {
				return false
			}

			return true
		}
	}
}
