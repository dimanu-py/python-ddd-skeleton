#!/usr/bin/env python
import sys
from pathlib import Path

from scripts.templates.incorrect_value_error_template import incorrect_value_type_error_template
from scripts.templates.required_value_error_template import required_value_error_template
from scripts.templates.string_value_object_template import string_value_object_template
from scripts.templates.uuid_template import uuid_template
from scripts.templates.value_object_template import value_object_template

TEMPLATES = {
	"value_object": value_object_template,
	"string_value_object": string_value_object_template,
	"uuid": uuid_template,
	"incorrect_value": incorrect_value_type_error_template,
	"required_value": required_value_error_template
}

def main() -> None:
	list_available_templates()
	template_name = input("Enter the name of the template you want to insert: ")
	ensure_template_exists(template_name)

	user_path = input("Enter the path where template should be created: ")
	folder_path = generate_folder_path(Path(user_path))
	write_content_at(folder_path, template_name)


def list_available_templates() -> None:
    print(f"Available templates: {', '.join(TEMPLATES.keys())}")


def ensure_template_exists(template_name: str) -> None:
	if template_name not in TEMPLATES:
		print(f"Error: Template '{template_name}' not found.")
		list_available_templates()
		sys.exit(1)


def write_content_at(folder_path: Path, template_name: str) -> None:
	file_name = f"{template_name.replace('_template', '')}.py"
	file_path = folder_path / file_name

	with open(file_path, "w") as file:
		file.write(TEMPLATES[template_name])
	print(f"Template {template_name} created at {file_path}")


def generate_folder_path(user_path: Path) -> Path:
	project_root = Path(__file__).resolve().parents[1]
	folder_path =  project_root / user_path
	folder_path.mkdir(parents=True, exist_ok=True)
	print(f"Folder created at: {folder_path}")
	return folder_path


if __name__ == "__main__":
	main()
