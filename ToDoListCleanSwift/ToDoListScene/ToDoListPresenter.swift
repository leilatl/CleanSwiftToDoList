//
//  ToDoListPresenter.swift
//  ToDoListCleanSwift
//
//  Created by Dmitry Serebrov on 03.03.2023.
//

import Foundation
/// Протокол для презентера
protocol IToDoListPresenter {
	func present(responce: ToDoListModel.Response)
}

/// Класс презентер получает запрос от интерактора и передает данные во вью
class ToDoListPresenter: IToDoListPresenter {
	private weak var viewController: ToDoListViewController?

	/// Инициализатор класса
	init(viewController: ToDoListViewController?) {
		self.viewController = viewController
	}

	/// Метод, который передает данные во вью в готовом для презентации виде
	func present(responce: ToDoListModel.Response) {
		let viewModel = getViewDataFromResponse(response: responce)
		viewController?.render(viewModel: viewModel)
	}

	private func getViewDataFromResponse(response: ToDoListModel.Response) -> ViewModel {
		var sections = [ViewModel.Section]()

		for sectionResponse in response.tasksBySections {
			var tasks = [ViewModel.Task]()
			for task in sectionResponse.tasks {
				if let task = task as? ImportantTask {
					let result = ViewModel.ImportantTask(
						name: task.title,
						isDone: task.completed,
						isOverdue: task.deadLine < Date(),
						deadLine: "Deadline: \(task.deadLine)",
						priority: "\(task.taskPriority)"
					)
					tasks.append(.importantTask(result))
				} else {
					tasks.append(.regularTask(ViewModel.RegularTask(name: task.title, isDone: task.completed)))

				}
			}
			let sectionViewModel = ViewModel.Section(
				title: sectionResponse.title, tasks: tasks)
			sections.append(sectionViewModel)

		}

		return ViewModel(tasksBySections: sections)
	}
}
