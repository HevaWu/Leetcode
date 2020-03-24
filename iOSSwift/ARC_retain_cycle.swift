class Person {
	let name: String
	var macbook: MacBook?

	init(name: String, macbook: MacBook? = nil) {
		self.name = name
		self.macbook = macbook
	}

	deinit {
		print("Person \(name) is being deinitialized")
	}
}

class MacBook {
	let name: String

	// use weak at here for avoiding reference cycle
	weak var owner: Person?

	init(name: String, owner: Person? = nil) {
		self.name = name
		self.owner = owner
	}

	deinit {
		print("MacBook named \(name) is being deinitialized")
	}
}

var person = Person(name: "P1")
var macbook = MacBook(name: "M1")

person.macbook = macBook
macbook.owner = person

person = nil
macbook = nil
