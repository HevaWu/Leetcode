// protocol
// 1 to 1 communication pattern

protocol SelectionDelegate {
	func didTap(selection: UIImage, name: String, color: UIColor)
}

var delegate: SelectionDelegate?

delegate = self ...

// MARK: - Notification & Observer
// 1 to more communication pattern

// Notification 

NotificationCenter.default.post(name: Notification.Name(rawValue: "first"), object: nil)

// observer

NotificationCenter.default.addObserver(self, selector: #selector(Base.updateName(notification:)), name: Notification.Name(rawValue: "first"), object: nil)

deinit {
	NotificationCenter.default.removeObserver(self)
}