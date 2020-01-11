import json
import requests
import fileinput

btc = json.loads(requests.get('https://api.coindesk.com/v1/bpi/currentprice.json').content)


print("BTC: <${:.2f} | €{:.2f}>".format(
    float(btc['bpi']['USD']['rate'].replace(',', '')),
    float(btc['bpi']['EUR']['rate'].replace(',', ''))))


