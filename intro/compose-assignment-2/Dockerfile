FROM drupal:9

# Install git and clean up cache
RUN apt-get update && \
    apt-get install -y git && \
    rm -rf /var/lib/apt/lists/*

# Set working directory for themes
WORKDIR /var/www/html/themes

# Create the 'bootstrap' directory first, then change ownership
RUN mkdir -p bootstrap && \
    chown -R www-data:www-data bootstrap

# Clone the bootstrap theme repository
RUN git clone --branch 8.x-4.x --single-branch --depth 1 https://git.drupalcode.org/project/bootstrap.git bootstrap

# Set the working directory back to the base HTML directory
WORKDIR /var/www/html
