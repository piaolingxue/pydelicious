def main():
    """
    Keep backtrace out of console on KeyboardInterrupt
    (wrap as much imports as possible)
    """

    try:
        import sys
        from pydelicious.tools.dlcs import main
        sys.exit(main(sys.argv[1:]))
    except KeyboardInterrupt:
        import sys
        print >>sys.stderr, "User interrupt"

