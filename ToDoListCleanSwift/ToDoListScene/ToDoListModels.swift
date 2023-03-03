//
//  ToDoListModels.swift
//  ToDoListCleanSwift
//
//  Created by Dmitry Serebrov on 03.03.2023.
//

import Foundation
/// Модели, необходимые для общения модулей
enum ToDoListModel {
	/// Метод, описывающий секцию
	struct Section {
		let title: String
		let tasks: [Task]
	}

	/// Структура, описывающая ответ интегратора
	struct Response {
		let tasksBySections: [Section]
	}

}

/// Структура, описывающая данные, которые отображаются во вью
struct ViewModel {
	/// Структура, описывающая секцию
	struct Section {
		let title: String
		let tasks: [Task]
	}

	/// Структура, описывающая задание
	enum Task {
		case regularTask(RegularTask)
		case importantTask(ImportantTask)
	}

	/// Структура, описывающая обычное задание
	struct RegularTask {
		let name: String
		let isDone: Bool
	}

	/// Структура, описывающая важное задание
	struct ImportantTask {
		let name: String
		let isDone: Bool
		let isOverdue: Bool
		let deadLine: String
		let priority: String
	}
	let tasksBySections: [Section]
}
