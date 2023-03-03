//
//  ToDoListViewController.swift
//  ToDoListCleanSwift
//
//  Created by Dmitry Serebrov on 03.03.2023.
//

import Foundation
import UIKit
/// Протокол для вью контроллера
protocol IToDoListViewController {
	func render(viewModel: ViewModel)
}
/// Вью сцены списка задач
class ToDoListViewController: UITableViewController {
	private var router: Router?
	private var viewData: ViewModel = ViewModel(tasksBySections: [])
	private var interactor: IToDoListInteractor?

	/// Метод, который запускается сразу после того, как вью прогрузилось
	override func viewDidLoad() {
		super.viewDidLoad()
		self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
		setup()
		interactor?.showTasks()
	}

	private func setup() {
		let taskManager = OrderedTaskManager(taskManager: TaskManager())
		let repository: ITaskRepository = TaskRepositoryStub()
		taskManager.addTasks(tasks: repository.getTasks())
		let sections = SectionForTaskManagerAdapter(taskManager: taskManager)
		let worker = ToDoListWorker(sectionManager: sections)
		let presenter = ToDoListPresenter(viewController: self)
		interactor = ToDoListInteractor(worker: worker, presenter: presenter)
	}

	/// Метод, который возвращает количество секций
	override func numberOfSections(in tableView: UITableView) -> Int {
		viewData.tasksBySections.count
	}

	/// Метод, который возвращает названия секций
	override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		viewData.tasksBySections[section].title
	}

	/// Метод, который возвращает количество заданий в секции
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		let section = viewData.tasksBySections[section]
		return section.tasks.count
	}

	/// Метод, который определяет ,что нужно отобразить в каждой ячейке
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let tasks = viewData.tasksBySections[indexPath.section].tasks
		let taskData = tasks[indexPath.row]
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
		var contentConfiguration = cell.defaultContentConfiguration()

		switch taskData {
		case .importantTask(let task):
			let redText = [NSAttributedString.Key.foregroundColor: UIColor.red]
			let taskText = NSMutableAttributedString(string: "\(task.priority) ", attributes: redText )
			taskText.append(NSAttributedString(string: task.name))

			contentConfiguration.attributedText = taskText
			contentConfiguration.secondaryText = task.deadLine
			contentConfiguration.secondaryTextProperties.color = task.isOverdue ? .red : .black
			cell.accessoryType = task.isDone ? .checkmark : .none
		case .regularTask(let task):
			contentConfiguration.text = task.name
			cell.accessoryType = task.isDone ? .checkmark : .none
		}

		cell.tintColor = .red
		contentConfiguration.secondaryTextProperties.font = UIFont.systemFont(ofSize: 16)
		contentConfiguration.textProperties.font = UIFont.boldSystemFont(ofSize: 19)
		cell.contentConfiguration = contentConfiguration

		return cell
	}

	/// Метод, который отправляет запрос в интегратор после нажатия пользователя на ячейку
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		interactor?.didTaskSelected(at: indexPath)
	}
}

/// Расширение для протокола
extension ToDoListViewController: IToDoListViewController {

	/// Метод для отображения новых данных
	func render(viewModel: ViewModel) {
		self.viewData = viewModel
		tableView.reloadData()
	}
}
