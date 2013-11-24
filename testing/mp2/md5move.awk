BEGIN {
  checkAt = 0
  filesAt = 0
  scanning = 0
}

/md5sums=\(/ {
  checkAt = NR
  scanning = 1
}

/source=\(/ {
  filesAt = NR
  scanning = 1
}

/)$/ {
  if (scanning) {
    if (checkAt > filesAt) {
      checkEnd = NR
    } else {
      filesEnd = NR
    }
    scanning = 0
  }
}

{
  lines[NR] = $0
}

END {
  for (i = 1; i <= NR; ++i) {
    if (checkAt <= i && i <= checkEnd) {
      continue
    }
    print lines[i]
    if (i == filesEnd) {
      for (j = checkAt; j <= checkEnd; ++j) {
        print lines[j]
      }
    }
  }
}