# smoke-blaze
Smoke tests in robot for demo blaze website.

## Description
This repository contains a set of smoke tests for the Demo Blaze website, implemented using the Robot Framework and the `robotframework-browser` library. The tests cover basic functionalities such as navigation, adding products to the cart, and placing orders, ensuring that critical features of the website are working as expected.

One signup test currently fails due bad use case of 200 response code for creating existing user.

Also there are two cases which are marked with `notready` tag, as the next and previous buttons aren't working as intended, but they are still included in the repository for future development and testing.
These notready tests can be run by removing the `--exclude notready` option from the command line when executing tests.

Tests do not include any sensitive data, and the user credentials used in tests are for demonstration purposes only.

## File structure
- `tests/`: Contains the Robot Framework test cases organized in subdirectories based on functionality (e.g., `auth`, `cart`, `home`).
- `resources/`: Contains Robot Framework resource files that define common keywords and variables used across multiple test cases.
- `requirements.txt`: Lists the Python dependencies required to run the tests, including `robotframework` and `robotframework-browser`.

## Prerequisites
- [Python™](https://www.python.org/downloads/) 3.8 or higher installed on your system.
- `pip` package manager available.
- [Node.js®](https://nodejs.org/en/download/) installed (required for `robotframework-browser`).

## Running tests

Below are simple instructions to run the Robot Framework tests from this repository either using a Python virtual environment (recommended) or without one.

### With a virtual environment (recommended)

- Create a venv (Windows PowerShell):

	```powershell
	python -m venv .venv
	.\.venv\Scripts\Activate.ps1
	pip install -r requirements.txt
    rfbrowser init
	```

- Create a venv (Windows CMD):

	```cmd
	python -m venv .venv
	.\.venv\Scripts\activate.bat
	pip install -r requirements.txt
    rfbrowser init
	```

- Run tests (examples):

	- Run all tests:

		```powershell
		robot .
		```

	- Run a single file (example):

		```powershell
		robot tests\cart\without_user.robot
		```

	- Run excluding a tag (example):

		```powershell
		robot --exclude notready .
		```

### Without a virtual environment

- Install dependencies for the current user (Windows PowerShell):

	```powershell
	pip install --user -r requirements.txt
    rfbrowser init
	```

- Then run tests as above, for example:

	```powershell
	robot tests\auth\login.robot
	```

### Notes

- The repository includes a `requirements.txt` file listing required packages. Installing these before running tests is recommended.
- Tests uses mostly `robotframework-browser`, so after installing requirements it is necessary to run `rfbrowser init` to set up the browser dependencies.
- If you use a different shell or OS, adjust the venv activation command accordingly (for example, `source .venv/bin/activate` on Unix-like systems).
