DispatchQueue.main.async {
	self.tableView.reloadData()
}

DispatchQueue.global(qos: .background).async {
	// Code to run on background queue
}