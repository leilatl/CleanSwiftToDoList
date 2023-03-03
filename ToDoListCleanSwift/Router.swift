//
//  Router.swift
//  ToDoListCleanSwift
//
//  Created by Dmitry Serebrov on 03.03.2023.
//

import Foundation
import UIKit
/// Класс для переключения между вью
class Router {
	func routFromLoginToTodolist(viewController: ViewController) {
		let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
		let newViewController = storyBoard.instantiateViewController(
			withIdentifier: "ToDoListViewController") as? ToDoListViewController
		viewController.show(newViewController!, sender: nil)
	}
}
