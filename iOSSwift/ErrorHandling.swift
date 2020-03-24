enum LoginError: Error {
	case incompleteForm
	case invalidEmail
	case incorrectPasswordLength
}

@IBAction func loginButtonTapped(_ sender: UIButton) {
	do { 
		try login()
	} catch LoginError.incompleteForm {
		showAlert(message: "Please fill out both email & password fields")
	} catch LoginError.invalidEmail {
		// do something ...
	} catch LoginError.incorrectPasswordLength {
		// do something ... 
	} catch {
		// default catch error
	}
}

func login() throws {
	let email = emailTextField.text!
	let password = passwordTextField.text!

	if email.isEmpty || password.isEmpty {
		throw LoginError.incompleteForm
	}

	if !email.isValidEmail {
		throw LoginError.invalidEmail
	}

	if password.characters.count < 8 {
		throw LoginError.incorrectPasswordLength
	}
}