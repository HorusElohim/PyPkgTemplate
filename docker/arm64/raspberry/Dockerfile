FROM python:bullseye

# Set working dir
WORKDIR /app

# Copy my_package
COPY ./ /app/my_package

# Update pip
RUN  pip install --upgrade pip

# Install my_package
RUN cd /app/my_package && pip install . --use-feature=in-tree-build

# # Pass parameters to my_package_cli script
ENTRYPOINT [ "my_package_cli" ]
