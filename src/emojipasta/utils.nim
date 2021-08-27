import os, re, json, random, strutils, sequtils

let
    BLOCK_REGEX* = re"\s*[^\s]*"
    TRIM_REGEX* = re"^\W*|\W*$"
    PATH_TO_MAPPINGS_FILE* = currentSourcePath() / "../../assets" / "emoji-mappings.json"
    EMOJI_MAPPINGS* = parseFile(PATH_TO_MAPPINGS_FILE)

proc splitIntoBlocks*(text: string): seq[string] =
    return toSeq(findAll(text, BLOCK_REGEX))

proc trimNonalphaChars*(text: string): string =
    return replace(text, TRIM_REGEX)

proc getAlphanumericPrefix*(text: string): string =
    return text[0 .. text.find(re"\w+")]

proc getMatchingEmojis*(trimmedBlock: string): seq[string] =
    let key = getAlphanumericPrefix(trimmedBlock.toLower())

    if EMOJI_MAPPINGS.contains(key):
        return EMOJI_MAPPINGS[key].to(seq[string])

    return @[]

proc rand*(x: int): int =
    randomize()
    return random.rand(x)

proc generateEmojis*(chunk: string, maxEmojisPerBlock: int): string =
    let trimmedBlock = trimNonalphaChars(chunk)
    let matchingEmojis = getMatchingEmojis(trimmedBlock)

    var emojis: string
    if matchingEmojis.len != 0:
        for i in 0 ..< rand(maxEmojisPerBlock):
            emojis &= matchingEmojis[rand(matchingEmojis.high)]

    return emojis
