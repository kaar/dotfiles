#!/usr/bin/env -S uv run --script
# /// script
# dependencies = [
#   "httpx"
# ]
# ///

from __future__ import annotations

import sys
import argparse
from datetime import date, timedelta, datetime

import httpx

API_URL = "https://mgrey.se/espot"
AREAS = ("SE1", "SE2", "SE3", "SE4")
BAR_CHAR = "\u2588"
MAX_BAR_WIDTH = 40
GREEN = "\033[32m"
RESET = "\033[0m"


def fetch_prices(day: date, area: str) -> list[dict[str, object]] | None:
    """Fetch hourly prices for a given date and area. Returns None if unavailable."""
    resp = httpx.get(API_URL, params={"format": "json", "date": day.isoformat()})
    if resp.status_code != 200:
        return None

    data = resp.json()
    area_data: list[dict[str, object]] | None = data.get(area)
    if not area_data:
        return None

    return area_data


def format_table(prices: list[dict[str, object]], day: date, area: str) -> str:
    """Format prices as a text table with bar chart."""
    lines: list[str] = []

    sek_prices = [float(str(p["price_sek"])) / 100 for p in prices]
    max_price = max(sek_prices) if sek_prices else 1.0

    now = datetime.now()

    day_label = ""
    today = date.today()
    if day == today:
        day_label = " (today)"
    elif day == today + timedelta(days=1):
        day_label = " (tomorrow)"

    lines.append(f"Electricity prices for {area} — {day.isoformat()}{day_label}")
    lines.append("")
    lines.append(f"{'Hour':<7} {'Kr/kWh':>8}  {'':}")

    is_today = day == date.today()
    current_hour = now.hour if is_today else -1

    for entry in prices:
        hour = int(str(entry["hour"]))
        price = float(str(entry["price_sek"])) / 100
        bar_len = int((price / max_price) * MAX_BAR_WIDTH) if max_price > 0 else 0
        bar = BAR_CHAR * bar_len
        line = f"{hour:02d}:00   {price:>7.2f}  {bar}"
        if hour == current_hour:
            line = f"{GREEN}{line}{RESET}"
        lines.append(line)

    avg = sum(sek_prices) / len(sek_prices) if sek_prices else 0
    lines.append("")
    lines.append(f"  Min: {min(sek_prices):.2f} Kr/kWh")
    lines.append(f"  Max: {max(sek_prices):.2f} Kr/kWh")
    lines.append(f"  Avg: {avg:.2f} Kr/kWh")

    return "\n".join(lines)


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description="Swedish day-ahead electricity prices")
    parser.add_argument("--area", choices=AREAS, default="SE3", help="Bidding area (default: SE3)")
    parser.add_argument("--date", dest="day", help="Date in YYYY-MM-DD format (default: tomorrow)")
    args = parser.parse_args(argv)

    area: str = args.area

    if args.day:
        try:
            day = date.fromisoformat(args.day)
        except ValueError:
            print(f"Invalid date: {args.day}", file=sys.stderr)  # noqa: T201
            return 1
    else:
        day = date.today() + timedelta(days=1)

    prices = fetch_prices(day, area)

    if prices is None and day != date.today():
        print(f"No prices available for {day.isoformat()} yet, showing today instead.\n", file=sys.stderr)  # noqa: T201
        day = date.today()
        prices = fetch_prices(day, area)

    if prices is None:
        print(f"No prices available for {area} on {day.isoformat()}.", file=sys.stderr)  # noqa: T201
        return 1

    print(format_table(prices, day, area))  # noqa: T201
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
