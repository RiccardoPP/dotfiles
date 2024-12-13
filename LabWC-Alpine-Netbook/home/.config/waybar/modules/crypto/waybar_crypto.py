#!/usr/bin/env python3

import sys
import os
import requests
import json
import configparser
from decimal import Decimal

API_URL = "https://pro-api.coinmarketcap.com/v1/cryptocurrency/quotes/latest"
API_KEY_ENV = "COINMARKETCAP_API_KEY"
CONFIG_FILE = "config.ini"

MIN_PRECISION = 0


class WaybarCrypto(object):
    """
    WaybarCrypto parses a config file and processes API data.

    On success WaybarCrypto outputs the following structure to stdout:

    {
        "text": "",
        "tooltip": "Cryptocurrency metrics from Coinmarketcap:",
        "class": "crypto"
    }
    """

    def __init__(self, config_path: str):
        """
        Take config_path pointting to crypto.ini.

        Parses crypto.ini to self.config
        """
        self.config = self.__parse_config_path(config_path)

        if self.config is None:
            sys.exit(1)

    def __parse_config_path(self, config_path: str):
        """
        Load a given config file path and outputs error and returns None on failure.

        Returns:
        {
            "coins": [
                "eth": {
                    "icon": "",
                    "precision" 2
                },
                ...
            ],
            "currency": "eur",
            "currency_symbol": "€",
            "display_options: ["1y", "1h", ...],
            "api_key": "some_key"
        }
        """
        # Attempt to load crypto.ini configuration file
        config = configparser.ConfigParser(allow_no_value=True, interpolation=None)

        try:
            with open(config_path, "r", encoding="utf-8") as f:
                config.read_file(f)
        except Exception as e:
            print(
                f"Could not find/open config file ({config_path}). Does it exist?\n{e}",
                file=sys.stderr,
            )

            return None

        # Attempt to load API key from environment variable
        api_key = ""
        try:
            api_key = str(os.environ[API_KEY_ENV])
        except Exception:
            print(
                "No API key environment variable found. Defaulting to configuration file.",
                file=sys.stderr,
            )

        # Attempt to parse required fields of crypto.ini
        try:
            # Any section that isn't general, is a coin
            coin_names = [section for section in config.sections() if section != "general"]

            # Construct the coins dict
            coins = {}
            for coin_name in coin_names:
                price_precision = int(config[coin_name]["price_precision"])
                change_precision = int(config[coin_name]["change_precision"])
                volume_precision = int(config[coin_name]["volume_precision"])

                if type(price_precision) != int:
                    print(
                        f"Value price_precision must be an integer value for {coin_name}",
                        file=sys.stderr,
                    )

                    return None

                if type(change_precision) != int:
                    print(
                        f"Value change_precision must be an integer value for {coin_name}",
                        file=sys.stderr,
                    )

                    return None

                if type(volume_precision) != int:
                    print(
                        f"Value volume_precision must be an integer value for {coin_name}",
                        file=sys.stderr,
                    )

                    return None

                if price_precision < MIN_PRECISION:
                    print(
                        f"Value price_precision must be greater than {MIN_PRECISION} for {coin_name}",
                        file=sys.stderr,
                    )

                    return None

                if change_precision < MIN_PRECISION:
                    print(
                        f"Value change_precision must be greater than {MIN_PRECISION} for {coin_name}",
                        file=sys.stderr,
                    )

                    return None

                if volume_precision < MIN_PRECISION:
                    print(
                        f"Value volume_precision must be greater than {MIN_PRECISION} for {coin_name}",
                        file=sys.stderr,
                    )

                    return None

                coins[coin_name] = {
                    "icon": config[coin_name]["icon"],
                    "price_precision": price_precision,
                    "change_precision": change_precision,
                    "volume_precision": volume_precision,
                }

            # The fiat currency used in the trading pair
            currency = config["general"]["currency"].upper()
            currency_symbol = config["general"]["currency_symbol"]

            # Get a list of the chosen display options
            display_options = config["general"]["display"].split(",")

            # If API key environment variable didn't exists,
            # read from config file instead
            if not api_key:
                api_key = config["general"]["api_key"]

        except Exception as e:
            print(
                f"Could not parse required fields of the configuration file:\n{e}", file=sys.stderr
            )

            return None

        config_obj = {
            "coins": coins,
            "currency": currency,
            "currency_symbol": currency_symbol,
            "display_options": display_options,
            "api_key": api_key,
        }

        return config_obj

    def __get_coinmarketcap_latest(self):
        """
        Return output as shown at https://coinmarketcap.com/api/documentation/v1/#operation/getV1CryptocurrencyQuotesLatest.

        Or None on error
        """
        # Construct API query parameters
        params = {
            "convert": self.config["currency"].upper(),
            "symbol": ",".join(coin.upper() for coin in self.config["coins"]),
        }

        # Add the API key as the expected header field
        headers = {"X-CMC_PRO_API_KEY": self.config["api_key"]}

        # Request the chosen price pairs
        response = requests.get(API_URL, params=params, headers=headers, timeout=2)
        if response.status_code != 200:
            print(
                f"Coinmarketcap API returned non 200 response:\n{response.content}",
                file=sys.stderr,
            )
            return None

        try:
            api_json = response.json()
        except ValueError as e:
            print(f"Could not parse API response body as JSON:\n{e}", file=sys.stderr)
            return None

        return api_json

    def get_json(self) -> str:
        """
        Return Waybar compatible JSON string.

        Exits with failure code if an error occurs.
        """
        api_json = self.__get_coinmarketcap_latest()
        if api_json is None:
            sys.exit(1)

        currency = self.config["currency"]
        currency_symbol = self.config["currency_symbol"]
        display_options = self.config["display_options"]

        # Waybar prefers a json output with the following structure.
        output_obj = {
            "text": "",
            "tooltip": "Cryptocurrency metrics from Coinmarketcap:\n",
            "class": "crypto",
        }

        # For each coin, populate our output_obj
        # with a string according to the display_options
        for coin_name, coin_obj in self.config["coins"].items():
            icon = coin_obj["icon"]
            price_precision = coin_obj["price_precision"]
            volume_precision = coin_obj["volume_precision"]
            change_precision = coin_obj["change_precision"]

            # Extract the object relevant to our coin/currency pair
            pair_info = api_json["data"][coin_name.upper()]["quote"][currency]

            output = f"{icon} "

            # Shows price by default
            if "price" in display_options or not display_options:
                current_price = round(Decimal(pair_info["price"]), price_precision)
                output += f"[{current_price}{currency_symbol} "

            if "volume24h" in display_options:
                percentage_change = round(Decimal(pair_info["volume_24h"]), volume_precision)
                output += f"24hV:{currency_symbol}{percentage_change:+} "

            if "change1h" in display_options:
                percentage_change = round(
                    Decimal(pair_info["percent_change_1h"]), change_precision
                )
                output += f"1h:{percentage_change:+}% "

            if "change24h" in display_options:
                percentage_change = round(
                    Decimal(pair_info["percent_change_24h"]), change_precision
                )
                output += f"{percentage_change:+}%]  "

            if "change7d" in display_options:
                percentage_change = round(
                    Decimal(pair_info["percent_change_7d"]), change_precision
                )
                output += f"7d:{percentage_change:+}% "

            output_obj["text"] += output
            output_obj["tooltip"] += output

        return json.dumps((output_obj))


def main():
    # Get the absolute path of this script
    abs_dir = os.path.dirname(os.path.abspath(__file__))
    config_path = f"{abs_dir}/{CONFIG_FILE}"

    waybar_crypto = WaybarCrypto(config_path)
    waybar_json = waybar_crypto.get_json()

    # Write the output_obj dict as a json string to stdout
    sys.stdout.write(waybar_json)


if __name__ == "__main__":
    main()
