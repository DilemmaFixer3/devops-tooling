# check-filename.sh

## File Naming Checker

This script enforces an **strict file naming convention** across a project directory structure to ensure consistency, prevent cross-platform issues, and maintain a high standard of code quality. It performs a recursive check on files with specific extensions, flagging any file that does not adhere to the strict, lowercase-only naming pattern.

## Strict Naming Rules Enforced

The script uses a precise regular expression defined by the `NAME_PATTERN="[a-z][a-z0-9_-]*[a-z0-9]\."` to validate filenames.

**A valid filename MUST adhere to all these rules:**

1. **Starts with lowercase:** Must begin with a lowercase letter (`[a-z]`). It **cannot** start with a digit (`[0-9]`), underscore (`_`), or dash (`-`).

2. **Lowercase only:** Must **NOT** contain any capital letters (`[A-Z]`) anywhere in the name.

3. **Allowed internal characters:** Can contain zero or more lowercase letters (`a-z`), digits (`0-9`), underscores (`_`), or dashes (`-`).

4. **Ends with alphanumeric:** Must end with a lowercase letter or a digit (`[a-z0-9]`) immediately before the file extension. **It cannot end with an underscore or a dash.**

### Supported File Extensions

The script only checks files matching one of the following case-sensitive extensions:

* `.py`

* `.txt`

* `.js`

* `.java`

* `.c`

## Usage

To run the quality check, simply execute the script and provide the target directory path as the only argument.

### Syntax

`./check-filename.sh <path_to_directory>`

### Example

To check the current directory (recursively):

`./check-filename.sh ./`

To check a specific project folder:

`./check-filename.sh ./my_project_repo`

## Configuration

The core validation logic is defined by the following variables at the top of the script:

| Variable | Description |
| ----- | ----- |
| `NAME_PATTERN` | The regex for the filename part (before the dot). Modify this to change the strictness of the naming convention. |
| `EXTENSIONS` | A pipe-separated string of extensions to check (e.g., \`py |
| `FILE_PATTERN` | The combination of `NAME_PATTERN` and `EXTENSIONS`. |

You can easily modify the `EXTENSIONS` variable to include or exclude file types based on your project needs.

## Exit Codes

The script provides clear exit codes for automation purposes:

* **`0` (Success):** All found files passed the quality check.

* **`1` (Failure/Error):** The quality check failed (one or more files had incorrect names) OR the provided directory path was invalid.