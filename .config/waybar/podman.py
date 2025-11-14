#!/usr/bin/env python3
# /// script
# requires-python = ">=3.13"
# dependencies = []
# ///
import argparse
import json
import subprocess
from dataclasses import dataclass


@dataclass
class Container:
    name: str
    port: str


def get_podman_containers() -> list[Container]:
    result = subprocess.run(
        ["podman", "ps", "--format", "json"],
        check=True,
        capture_output=True,
        text=True,
    )
    output = json.loads(result.stdout.strip())
    return [
        Container(
            name=container["Names"][0] if container["Names"] else "unknown",
            port=str(container["Ports"][0]["host_port"])
            if container["Ports"]
            else "N/A",
        )
        for container in output
    ]


@dataclass
class SwayResponse:
    text: str
    tooltip: str

    def to_json(self) -> str:
        return json.dumps(self.__dict__)


def main() -> None:
    parser = argparse.ArgumentParser(
        description="Waybar podman script",
    )
    parser.add_argument(
        "command",
        nargs="?",
        choices=["status", "info"],
        default="info",
        help="Command to execute",
    )
    parser.add_argument(
        "container_name",
        nargs="?",
        default="jellyfin",
        help="Name of the container (default: jellyfin)",
    )

    args = parser.parse_args()
    if args.command == "status":
        container_name = args.container_name
        podman_containers = get_podman_containers()
        container = next(
            (c for c in podman_containers if c.name == container_name), None
        )
        status_icon = {
            "running": "",
            "exited": "❌",
            "paused": "",
        }["running" if container else "exited"]
        text = f"{status_icon} {container_name}"
        tooltip = f"{status_icon} - localhost:8096"
        print(SwayResponse(text=text, tooltip=tooltip).to_json())
        return
    if args.command == "info":
        podman_containers = get_podman_containers()
        tooltip_lines = [
            f"{container.name} - localhost:{container.port}"
            for container in podman_containers
        ]
        text = f"󰡨 Podman ({len(podman_containers)})"
        tooltip = "\n".join(tooltip_lines) if tooltip_lines else "No running containers"
        print(SwayResponse(text=text, tooltip=tooltip).to_json())


if __name__ == "__main__":
    main()
