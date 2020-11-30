import java.io.ByteArrayInputStream
import kotlin.test.assertEquals

abstract class AocTest {
    protected abstract val day: Day

    protected fun testSample(sample: Array<String>, part1Solution: String) {
        assertEquals(part1Solution, day.part1(makeInput(sample)))
    }

    protected fun testInputFile(inputFileName: String, part1Solution: String) {
        assertEquals(part1Solution, day.part1(streamFromFile(inputFileName)))
    }

    protected fun testSample(sample: Array<String>, part1Solution: String, part2Solution: String) {
        testSample(sample, part1Solution)
        assertEquals(part2Solution, day.part2(makeInput(sample)))
    }

    protected fun testInputFile(inputFileName: String, part1Solution: String, part2Solution: String) {
        testInputFile(inputFileName, part1Solution)
        assertEquals(part2Solution, day.part2(streamFromFile(inputFileName)))
    }

    private fun makeInput(input: Array<String>): ByteArrayInputStream {
        val joinToString: String = input.joinToString(separator = "\n")
        return ByteArrayInputStream(joinToString.toByteArray())
    }

    protected fun streamFromFile(fileName: String) = this.javaClass.getResource(fileName).openStream()
}