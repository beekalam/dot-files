#!/usr/bin/env python3
import subprocess
import sys
import argparse
import socket

def resolve_system(domain: str, timeout: float) -> str | None:
    """Resolve via the system's own resolver."""
    try:
        return socket.gethostbyname(domain)
    except socket.gaierror:
        return None


def tor_resolve(domain, timeout=10.0):
    """Resolve a domain via Tor. Returns the IP string, or None on failure."""
    try:
        result = subprocess.run(
            ["/usr/bin/tor-resolve", domain],
            capture_output=True,
            text=True,
            timeout=timeout,
        )
    except FileNotFoundError:
        raise RuntimeError("tor-resolve not found. Install the 'tor' package.")
    except subprocess.TimeoutExpired:
        return None

    if result.returncode != 0:
        return None

    ip = result.stdout.strip()
    return ip or None


# Registry: add new resolvers here.
RESOLVERS = {
    "tor": tor_resolve,
    "system": resolve_system,
    # "system": resolve_system,   # ← future
    # "dnspython": resolve_dnspython,
}

DEFAULT_RESOLVER = "tor"


# --- Argument parsing ----------------------------------------------------

def parse_args(argv: list[str] | None = None) -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        prog="resolve.py",
        description="Resolve a domain using a configurable resolver.",
    )
    parser.add_argument(
        "-d", "--domain",
        required=True,
        help="domain name to resolve (e.g. example.com)",
    )
    parser.add_argument(
        "-t", "--timeout",
        type=float,
        default=10.0,
        metavar="SECONDS",
        help="timeout in seconds (default: 10)",
    )
    parser.add_argument(
        "-r", "--resolver",
        choices=sorted(RESOLVERS),
        default=DEFAULT_RESOLVER,
        help=f"resolver backend (default: {DEFAULT_RESOLVER})",
    )
    return parser.parse_args(argv)


# --- Main ----------------------------------------------------------------

def main(argv: list[str] | None = None) -> int:
    args = parse_args(argv)

    resolver = RESOLVERS[args.resolver]
    ip = resolver(args.domain, args.timeout)

    if ip is None:
        print(f"failed to resolve {args.domain} via {args.resolver}",
              file=sys.stderr)
        return 1

    print(ip)
    return 0


if __name__ == "__main__":
    sys.exit(main())
