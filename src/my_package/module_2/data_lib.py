from .. import PKG_INSTALL_PATH


def load_data():
    data_path = PKG_INSTALL_PATH / 'data'
    files = [file for file in data_path.iterdir() if file.is_file()]
    for file in data_path.iterdir():
        if file.is_file():
            with open(file, 'r') as fd:
                print(f"File: {file.name}\n\tContent: {fd.read()}")
