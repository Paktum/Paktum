if ! command -v npm &> /dev/null; then
    echo "npm is not installed. Please install npm before running this script."
    exit 1
fi

if ! command -v docsify &> /dev/null; then
    echo "docsify is not installed. Installing docsify..."
    npm install -g docsify-cli
fi

docsify serve docs