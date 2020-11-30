import org.junit.jupiter.api.Test

internal class Day00Test : AocTest() {
    override val day = Day00()

    @Test
    fun sample1() = testSample(
        arrayOf("1", "2"),
        "3",
        "2",
    )

    @Test
    fun sample2() = testSample(
        arrayOf("2", "3"),
        "5",
        "6",
    )

    @Test
    fun part1File() = testInputFile("/day00.txt", "10", "24")
}