//
//  ViewController.swift
//  ToDoListCleanSwift
//
//  Created by Dmitry Serebrov on 03.03.2023.
//

import UIKit
/// Протокол для вью контроллера
protocol ILoginViewController: AnyObject {
	func render(viewModel: LoginModels.ViewModel)
}

/// Вью логин сцены
class ViewController: UIViewController {

	private var interactor: ILoginInteractor?

	/// Аутлеты, связанные со сторибордом
	@IBOutlet weak var loginTextField: UITextField!
	@IBOutlet weak var passwordTextField: UITextField!
	@IBAction func loginPressed(_ sender: UIButton) {
		if let email = loginTextField.text, let password = passwordTextField.text {
			let request = LoginModels.Request(login: email, password: password)
			interactor?.login(request: request)
		}
	}

	/// Метод, который запускается сразу после того, как вью прогрузилось
	override func viewDidLoad() {
		super.viewDidLoad()
		let worker = LoginWorker()
		let presenter = LoginPresenter(viewController: self)
		interactor = LoginInteractor(worker: worker, presenter: presenter)
	}
}

/// Расширение для протокола
extension ViewController: ILoginViewController {
	/// Метод для отображения новых данных
	func render(viewModel: LoginModels.ViewModel) {

		let alert: UIAlertController

		if viewModel.success {
			alert = UIAlertController(
				title: "Success",
				message: viewModel.userName,
				preferredStyle: UIAlertController.Style.alert
			)

			let router = Router()
			router.routFromLoginToTodolist(viewController: self)
		} else {
			alert = UIAlertController(
				title: "Error",
				message: "",
				preferredStyle: UIAlertController.Style.alert
			)
		}

		let action = UIAlertAction(title: "Ok", style: .default)
		alert.addAction(action)
		present(alert, animated: true, completion: nil)
	}
}
