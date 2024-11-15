<div align="center">
  <h1>⚡️ Instant Boilerplate for Python DDD SaaS ⚡️</h1>
  <strong>Start your Python project right away</strong>
</div>

<p align="center">
  <a href="#requirements">Requirements</a>&nbsp;&nbsp;•&nbsp;
  <a href="#folders">Folder Structure</a>&nbsp;&nbsp;•&nbsp;
  <a href="#use">How To Use</a>&nbsp;&nbsp;•&nbsp;
  <a href="#commands">Commands</a>&nbsp;&nbsp;•&nbsp;
  <a href="#packages">Dependencies</a>
</p>

## Resources

This template is inspired by pmareke repository. You can find his template in the link bellow:

[![Web](https://img.shields.io/badge/GitHub-pmareke-14a1f0?style=for-the-badge&logo=github&logoColor=white&labelColor=101010)](https://github.com/pmareke/fastapi-boilerplate)

<a name=requirements></a>
## Requirements

The project runs with [Python 3.12](https://www.python.org/downloads/release/python-3120/). 

The recommended way to install Python is using [pyenv](https://github.com/pyenv/pyenv) if you are on Linux or MacOS. Here is a summary of the steps,
but it's recommended to visit the documentation for more details.

<details><summary>Install Python with pyenv</summary>

1. Install pyenv:
    ```bash
    curl https://pyenv.run | bash
    ```

2. Set you bash profile to load pyenv. In my case I use fish:

    ```bash
    set -Ux PYENV_ROOT $HOME/.pyenv
    fish_add_path $PYENV_ROOT/bin
   ```
   
    Then, add the following line to `~/.config/fish/config.fish`:

    ```bash
    echo pyenv init - | source >> ~/.config/fish/config.fish
    ```
3. Install the selected Python version (you can see available version with `pyenv install --list`):
    ```bash
    pyenv install 3.12
    ```
4. Go to your project folder and select this Python version for the folder
    ```bash
    pyenv local 3.12
    ```
</details>

After installing _pyenv_ you only need to install the package manager, in this case I prefer
to use [pdm](https://github.com/pdm-project/pdm). Just need to run the following command on
your project folder:
    
```bash
pip install pdm
```

To install directly all dependencies, run:

```bash
make install
```

<a name=folders></a>
## Folder Structure

The project is structured following the [Clean Architecture](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html) principles
and [Domain Driven Design](https://medium.com/@jonathanloscalzo/domain-driven-design-principios-beneficios-y-elementos-primera-parte-aad90f30aa35).

<details><summary>Production Code</summary>

The production code goes inside the [`src`](./src) folder. Which is divided into two main folders:
- The [`contexts`](./src/contexts) folder will contain all the bounded contexts of the application:
    - Each [`bounded context`](./src/contexts/bounded_context) has the main business logic of a specific domain. 
    Inside each bounded context you will find one or more modules that represent a specific part of the domain. Each module is divided into 
    the following subfolders:
      - The [`domain`](src/contexts/bounded_context/aggregate/domain) folder contains the business rules, entities and value objects.
      - The [`application`](src/contexts/bounded_context/aggregate/application) folder contains use cases and handlers
      - The [`infra`](src/contexts/bounded_context/aggregate/infra) folder contains the implementation of the interfaces defined in the domain 
      for I/O operations like database, buses etc.
        - The [`shared`](src/contexts/bounded_context/aggregate/shared) folder contains code that is shared across multiple modules of the bounded context.
    - The [`shared`](src/contexts/shared) folder contains code that is shared across multiple bounded contexts.
- The [`delivery`](./src/delivery) folder contains the entry points of the application, these would be your API controllers, web frontend, 
mobile frontend, etc.

</details>

<details><summary>Tests</summary>

The [`tests`](./tests) folder follows a similar structure to the production code.
- The [`contexts`](./tests/contexts) folder contains the tests for the main business logic of the application. It follows the same structure
as the production code, separating the bounded contexts into different folders and modules. Each module will contain tests that represent the
following:
    - The [`domain`](tests/contexts/bounded_context/aggregate/domain) folder should contain mother objects and tests for the entities and value objects.
    - The [`application`](tests/contexts/bounded_context/aggregate/application) folder should contain tests for the use cases and handlers.
    - The [`infra`](tests/contexts/bounded_context/aggregate/infra) folder should contain tests for the implementation of the interfaces defined in the domain.
- The [`delivery`](./tests/delivery) folder should contain the acceptance or end-to-end tests.

</details>

<details><summary>Utilities</summary>

Inside [`scripts`](./scripts) folder you can put any script utility like hooks, pre-defined commands etc.

By default, you would find:
1. Scripts with git hooks inside the [`hooks`](./scripts/hooks) folder.
2. Scripts to run specific tests inside the [`test`](./scripts/test) folder.
3. Common scripts at the root of the [`scripts`](./scripts) folder.

</details>

<a name=use></a>
## How To Use

In order to use this template and start your project follow these steps:

1. From this template on GitHub click on the "Use this template" button and select "Create a new repository".
   This will open a new page where you can name your repository and select the visibility.
2. Clone your repository on you local machine
    ```bash
   git clone <your_repo_url>
   ```
3. Run the `make local-setup` command to be able to run the hooks inside [hooks](./scripts/hooks) folder.

> [!NOTE]
> If you want to ignore the hooks folder, you can remove it and just run `make install` command.

4. Rename the [source bounded context](./src/contexts) as well as [tests bounded context](./tests/contexts)
5. Happy coding

<a name=commands></a>
## Make Commands

The project leverages lots of actions to a [Makefile](./Makefile). The following commands are available by default:
- `test`: runs all the tests
- `unit`: detects changes on domain or application changes and runs the bounding context corresponding tests
- `all-unit`: runs all domain and application tests in all bounded contexts. **These tests must be marked as unit tests**
- `integration`: detects changes on infra and runs the bounding context corresponding tests
- `all-integration`: runs all infra tests in all bounded contexts. **These tests must be marked as integration tests**
- `acceptance`: runs all acceptance tests
- `coverage`: runs all the tests with coverage
- `local-setup`: sets up the local environment
- `install`: installs all dependencies
- `update`: updates dependencies
- `add-dep`: installs a new dependency. Asks for the dependency name and if it's a dev dependency or not.
- `check-typing`: runs static type checking with mypy
- `check-lint`: checks linting with ruff
- `lint`: lints the code with ruff
- `check-format`: check formats with ruff
- `format`: formats the code with ruff
- `pre-commit`: runs the pre-commit checks (check types, checks linting, checks format and runs all unit tests)
- `pre-push`: runs integration and acceptance tests
- `watch`: runs a watch session to run all the tests on file changes

<a name=packages></a>
## Default Dependencies

The project uses [pdm](https://github.com/pdm-project/pdm) as package manager. When you run the `make install` or `make local-setup` command,
it will install the following dependencies. You can check the versions in the [pyproject.toml](./pyproject.toml) file.

### Testing

- [pytest](https://docs.pytest.org/en/stable/): testing runner.
- [pytest-xdist](https://pypi.org/project/pytest-xdist/): pytest plugin to run the tests in parallel.
- [expects](https://pypi.org/project/expects/): an expressive assertion library for Python.
- [doublex](https://pypi.org/project/doublex/): a test doubles library for Python.
- [doublex-expects](https://pypi.org/project/doublex-expects/): a plugin for doublex that integrates with expects.

### Code style

- [mypy](https://github.com/python/mypy): a static type checker.
- [yapf](https://github.com/google/yapf): a Python formatter.
- [ruff](https://github.com/astral-sh/ruff): a Python linter and formatter.