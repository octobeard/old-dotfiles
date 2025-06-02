import sys
from urllib.parse import unquote, urlparse, parse_qs
import argparse

def decode_and_parse_url(file_path):
    try:
        # Read the file
        with open(file_path, 'r', encoding='utf-8') as file:
            encoded_url = file.read().strip()

        # Decode the URL
        decoded_url = unquote(encoded_url)

        # Parse the URL
        parsed_url = urlparse(decoded_url)
        base_url = f"{parsed_url.scheme}://{parsed_url.netloc}{parsed_url.path}"
        query_args = parse_qs(parsed_url.query)

        # Print results
        print("Base URL:")
        print(base_url)
        print("\nQuery Arguments:")
        for key, values in query_args.items():
            formatted_values = [
                value if len(value) <= 500 else "<omitted due to length>" for value in values
            ]
            print(f"{key}: {', '.join(formatted_values)}")
    except FileNotFoundError:
        print(f"Error: File '{file_path}' not found.")
    except Exception as e:
        print(f"An error occurred: {e}")

def main():
    parser = argparse.ArgumentParser(description="Decode and parse a URL from a file.")
    parser.add_argument("file", help="Path to the file containing the URL")
    args = parser.parse_args()

    decode_and_parse_url(args.file)

if __name__ == "__main__":
    main()
