from pathlib import Path

def create_package_structure(base_dir: str, context: str, aggregate: str) -> None:
	"""Create the folder structure and __init__.py files for the given context and aggregate."""
	context_base_path = Path(base_dir, "contexts", context)
	aggregate_base_path = context_base_path / aggregate

	dirs_to_create = [
		context_base_path,
		aggregate_base_path,
		aggregate_base_path / "application",
		aggregate_base_path / "domain",
		aggregate_base_path / "infra",
	]

	for directory in dirs_to_create:
		directory.mkdir(parents=True, exist_ok=True)
		init_file = directory / "__init__.py"
		if not init_file.exists():
			init_file.touch()

def main() -> None:
	context = input("Enter the name of the bounded context: ").strip()
	aggregate = input("Enter the name of the new aggregate: ").strip()

	create_package_structure("src", context, aggregate)
	create_package_structure("tests", context, aggregate)

	print(f"Successfully created the aggregate '{aggregate}' under context '{context}'.")


if __name__ == "__main__":
	main()
