#!/usr/bin/env python3
"""
Capture DNS queries + responses with tshark.
Store: count, qtypes, clients, servers, and resolved IPs.
"""

import subprocess
import sys

# --- Config --------------------------------------------------------------
IFACE   = "any"
BPF     = "udp port 53"
DISPLAY = ""                 # no display filter — capture queries AND responses
FIELDS  = [
    "dns.flags.response",    # 0 = query, 1 = response
    "dns.qry.name",          # queried name (present in both)
    "dns.qry.type",          # numeric type
    "ip.src",
    "ip.dst",
    "dns.a",                 # IPv4 answer(s)
    "dns.aaaa",              # IPv6 answer(s)
]
SEP = "\t"
AGG = ","                    # intra-field separator for multi-value fields
# -------------------------------------------------------------------------

QTYPE = {
    1: "A", 2: "NS", 5: "CNAME", 6: "SOA", 12: "PTR",
    15: "MX", 16: "TXT", 28: "AAAA", 33: "SRV",
    65: "HTTPS", 255: "ANY",
}

def new_entry():
    return {
        "count":        0,       # number of queries seen
        "types":        set(),   # qtypes seen
        "clients":      set(),   # client IPs that asked
        "servers":      set(),   # DNS servers queried
        "resolved_ips": set(),   # all IPs the name resolved to
    }

def build_cmd():
    cmd = [
        "sudo", "tshark",
        "-i", IFACE,
        "-f", BPF,
        "-T", "fields",
        "-E", f"separator={SEP}",
        "-E", "occurrence=a",          # collect ALL occurrences of each field
        "-E", f"aggregator={AGG}",     # join multiple values with ","
        "-l",                          # line-buffered
    ]
    if DISPLAY:
        cmd += ["-Y", DISPLAY]
    for f in FIELDS:
        cmd += ["-e", f]
    return cmd

def run(queries: dict):
    cmd = build_cmd()
    print(f"[*] Running: {' '.join(cmd)}", file=sys.stderr)
    print("[*] Press Ctrl+C to stop.\n", file=sys.stderr)

    proc = subprocess.Popen(
        cmd,
        stdout=subprocess.PIPE,
        stderr=subprocess.DEVNULL,
        text=True,
        bufsize=1,
    )

    try:
        for line in proc.stdout:
            line = line.rstrip("\n")
            if not line:
                continue

            parts = line.split(SEP)
            while len(parts) < len(FIELDS):
                parts.append("")
            is_response, name, qtype_num, src, dst, a_rec, aaaa_rec = parts[:7]

            if not name:
                continue

            # Some fields may be comma-joined; take first value for name
            name = name.split(AGG)[0].rstrip(".")
            entry = queries.setdefault(name, new_entry())

            if is_response == "0":        # --- query ---
                qtype = QTYPE.get(int(qtype_num), qtype_num) if qtype_num.isdigit() else "?"
                entry["count"] += 1
                entry["types"].add(qtype)
                entry["clients"].add(src)
                entry["servers"].add(dst)
                print(f"Q  {name:<40} {qtype:<6} from {src} -> {dst}  (total: {entry['count']})")

            elif is_response == "1":      # --- response ---
                ips = set()
                if a_rec:
                    ips.update(x for x in a_rec.split(AGG) if x)
                if aaaa_rec:
                    ips.update(x for x in aaaa_rec.split(AGG) if x)
                if ips:
                    new = ips - entry["resolved_ips"]
                    entry["resolved_ips"].update(ips)
                    if new:
                        print(f"R  {name:<40} -> {sorted(new)}")

    except KeyboardInterrupt:
        print("\n[*] Interrupted by user.", file=sys.stderr)
    finally:
        proc.terminate()
        try:
            proc.wait(timeout=2)
        except subprocess.TimeoutExpired:
            proc.kill()

def main():
    queries = {}
    try:
        run(queries)
    except FileNotFoundError:
        print("[!] tshark not found. Install: sudo apt install tshark", file=sys.stderr)
        sys.exit(1)

    # --- Summary ---------------------------------------------------------
    print("\n=== Summary ===")
    if not queries:
        print("No data captured.")
        return

    printable = {
        name: {
            "count":        d["count"],
            "types":        sorted(d["types"]),
            "clients":      sorted(d["clients"]),
            "servers":      sorted(d["servers"]),
            "resolved_ips": sorted(d["resolved_ips"]),
        }
        for name, d in queries.items()
    }

    for name, d in sorted(printable.items(),
                          key=lambda kv: kv[1]["count"],
                          reverse=True):
        ips = ", ".join(d["resolved_ips"]) or "-"
        print(f"{name:<40} count={d['count']:<4} types={d['types']} ips=[{ips}]")

if __name__ == "__main__":
    main()