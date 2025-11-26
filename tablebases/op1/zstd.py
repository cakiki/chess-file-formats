import zstandard

class Zstd:
    def decode(self, data):
        dctx = zstandard.ZstdDecompressor()
        return dctx.decompress(data)