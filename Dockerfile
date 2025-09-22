FROM wordpress:latest
# Copy plugin from local dir to wordpress plugin dir
COPY ./wp-content/plugins/woocommerce/ /var/www/html/wp-content/plugins/woocommerce/

# Install necessary dependencies for WP-CLI
RUN apt-get update && apt-get install -y \
    curl \
    git \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# Download WP-CLI
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

# Make WP-CLI executable and move it to a directory in your PATH
RUN chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

# Verify WP-CLI installation
RUN wp --info

RUN wp plugin activate woocommerce  --allow-root --path=/var/www/html
