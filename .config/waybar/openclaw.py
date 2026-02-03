#!/usr/bin/env python3
# /// script
# requires-python = ">=3.13"
# dependencies = []
# ///
import json
import subprocess
from dataclasses import dataclass


@dataclass
class WaybarResponse:
    text: str
    tooltip: str

    def to_json(self) -> str:
        return json.dumps(self.__dict__)


def is_service_active(service_name: str) -> bool:
    result = subprocess.run(
        ["systemctl", "--user", "is-active", service_name],
        capture_output=True,
        text=True,
    )
    return result.stdout.strip() == "active"


def main() -> None:
    service_name = "openclaw-gateway"
    url = "http://127.0.0.1:18789"

    is_running = is_service_active(service_name)
    if is_running:
        text = "🦞 OpenClaw "
        tooltip = f"OpenClaw Gateway\nStatus: Running\nURL: {url}"
    else:
        text = "🦞 OpenClaw (stopped) "
        tooltip = "OpenClaw Gateway\nStatus: Stopped"

    print(WaybarResponse(text=text, tooltip=tooltip).to_json())


if __name__ == "__main__":
    main()
