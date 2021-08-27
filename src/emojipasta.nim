from emojipasta/utils import splitIntoBlocks, generateEmojis


proc emojify*(
    s: string,
    wordDelimiter: string = " ",
    maxEmojisPerBlock: int = 2,
): string =
    let blocks = splitIntoBlocks(s)

    for chunk in blocks:
        let emojis = generateEmojis(
            chunk = chunk,
            maxEmojisPerBlock = maxEmojisPerBlock,
        )
        if emojis != "":
            result &= wordDelimiter & emojis
        result &= chunk
