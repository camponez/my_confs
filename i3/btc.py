"""BTC"""
import argparse
import json

import requests


def main(check: bool) -> None:
    """Main."""
    if check:
        with open('/home/eduardo/btc_price.json', 'r', encoding='utf8') as f_json:
            btc = json.loads(
                requests.get(
                    'https://api.coindesk.com/v1/bpi/currentprice.json',
                    timeout=30).content)
            j_file = json.load(f_json)

        j_file["BTC"]["EUR"] = btc['bpi']['EUR']['rate_float']
        j_file["BTC"]["USD"] = btc['bpi']['USD']['rate_float']

        with open('/home/eduardo/btc_price.json', 'w', encoding='utf8') as f_json:
            f_json.write(json.dumps(j_file))

    else:
        with open('/home/eduardo/btc_price.json', 'r', encoding='utf8') as f_json:
            j_file = json.load(f_json)
            print(
                f"BTC: <${j_file['BTC']['USD']:.2f} | €{j_file['BTC']['EUR']:.2f}>")


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "--check",
        action="store_true",
        help="Update the price",
        required=False)

    args = parser.parse_args()

    main(args.check)

# vim: tw=100 colorcolumn=100
