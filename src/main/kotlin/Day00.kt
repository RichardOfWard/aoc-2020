import java.io.InputStream

/**
 * A fake day to set up some infrastructure
 *
 * part 1 is to add, part 2 is to multiply
 */
class Day00 : Day {
    override fun part1(input: InputStream) =
        read(input)
            .reduce { acc, total -> acc + total }
            .toString()

    override fun part2(input: InputStream): String =
        read(input)
            .reduce { acc, total -> acc * total }
            .toString()

    private fun read(input: InputStream) = input
        .reader()
        .useLines { it.toList() }
        .map { it.toInt() }
}