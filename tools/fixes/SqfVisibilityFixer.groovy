import groovy.io.FileType

File folder = args[0] as File
File log = 'result.log' as File
folder.mkdirs()

folder.traverse(type: FileType.FILES, nameFilter: ~/(?iu).*\.sqf/) {file ->
	File bak = new File("${file.absolutePath}.bak")
	bak.delete()
	bak.bytes = file.bytes
	def edited = false

	while (true) {
		def sb = new StringBuilder()
		def p = ['sqflint', file.absolutePath].execute()
		p.consumeProcessOutputStream(sb)
		p.waitFor()

		def found = false

		def out = (sb as String).readLines()
		if (out.find {it.matches(/^\[\d+,\d+]:error:.*/)} != null) {
			def logLine
			if (edited) {
				logLine = "File [$file.absolutePath], could not patch file, restoring original"
				file.bytes = bak.bytes
			} else logLine = "File [$file.absolutePath], skipping cause it contains errors"

			println(logLine)
			log << (logLine + '\n')
			break
		}

		out.each { l ->
			if (found) return
			def group = (l =~ /^\[(\d+),(\d+)]:warning:Local variable "(\w+)" assigned to an outer scope \(not private\)/)
			if (group.matches()) found = true
			else return

			//noinspection GroovyAssignabilityCheck
			int lineNum = group[0][1] as int
			//noinspection GroovyAssignabilityCheck
			int charPos = group[0][2] as int
			//noinspection GroovyAssignabilityCheck
			String varName = group[0][3] as String

			def toSkip = ['_x']
			if (varName in toSkip) {
				found = false
				return
			}

			def lines = file.readLines()
			lines[lineNum - 1] = new StringBuffer(lines[lineNum - 1]).insert(charPos, "private ") as String
			def logLine = "File [$file.absolutePath], inserting private at [$lineNum, $charPos]: ${lines[lineNum - 1].trim()}"
			println(logLine)
			log << (logLine + '\n')
			file.text = lines.join('\n').trim() + '\n'
			edited = true
		}

		if (!found) {
			break
		}
	}
	bak.delete()
}
