import streams, strutils

type
  RecordingTextWriter* = ref object of RootObj 
    outStream*: File
    recording*: string
    isClosed*: bool

proc newRecordingTextWriter*(filename: string): RecordingTextWriter =
  ## Creates a new RecordingTextWriter that writes to a file and records all output.
  result = RecordingTextWriter()
  result.outStream = open(filename, fmAppend)
  if result.outStream == nil:
      raise newException(IOError, "Could not open file: " & filename)
  result.recording = ""  
  result.isClosed = false

proc ensureOpen*(writer: RecordingTextWriter) =
    if writer.isClosed:
        raise newException(IOError, "Stream is closed")

proc write*(writer: RecordingTextWriter, data: cstring, len: int) =
  writer.ensureOpen()
  let strData = $data[0..<len]
  writer.outStream.write(strData)
  writer.recording.add(strData)

proc write*(writer: RecordingTextWriter, s: string) = 
  writer.ensureOpen()
  writer.outStream.write(s)
  writer.recording.add(s)

proc write*(writer: RecordingTextWriter, data: seq[byte]) =
    writer.ensureOpen()
    let strData = data.toOpenArray.cstring
    writer.outStream.write(strData)
    writer.recording.add(strData)

proc write*(writer: RecordingTextWriter, data: seq[char]) =
    writer.ensureOpen()
    let strData = data.join("")
    writer.outStream.write(strData)
    writer.recording.add(strData)

proc write*(writer: RecordingTextWriter, b: byte) =
    writer.ensureOpen()
    writer.outStream.write(b)
    writer.recording.add($b)

proc write*(writer: RecordingTextWriter, c: char) = 
  writer.ensureOpen()
  writer.outStream.write(c)
  writer.recording.add(c)

proc writeln*(writer: RecordingTextWriter, s: string) = 
  writer.ensureOpen()
  writer.write(s)
  writer.write("\n")

proc flush*(writer: RecordingTextWriter) =
    writer.ensureOpen()
    ## Flushes the output stream.
    writer.outStream.flush()

proc close*(writer: RecordingTextWriter) =
  ## Closes the output stream.
  writer.outStream.close()

  writer.isClosed = true

proc getRecording*(writer: RecordingTextWriter): string =
  ## Returns the recorded output.
  return writer.recording

proc clearRecording*(writer: RecordingTextWriter) =
  ## Clears the recorded output. 
  writer.recording = ""