class MacBook {
	var year: Int
	var color: String

	init(year: Int, color: String) {
		self.year = year
		self.color = color
	}
}

let myMacBook = MacBook(year: 2020, color: "Gray")
var anotherMacBook = myMacBook

anotherMacBook.color = "Green"

// myMacBook is also changed to `Green` this is because class is a reference type
print(myMacBook.color)
print(anotherMacBook.color)

struct iPhone {
	let number: Int
	let color: String
}

let myiPhone = iPhone(number: 7, color: "Black")
var anotheriPhone = myiPhone

anotheriPhone.color = "Rose Gold"

// these two have different color, because struct is a value type
print(myiPhone.color)
print(anotheriPhone.color)