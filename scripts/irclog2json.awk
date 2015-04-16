BEGIN {
  FS = " ";   # Field Separator
  RS = "\n";  # Record Separator (lines)
  OFS = " ";  # Output Field Separator
  ORS = "\n"; # Output Record Separator (lines)

  if (date == "") { date = "2009-09-07"; }
  if (counter == "") { counter = 0; }
  printf "{ \"date\": \"%s\"", date;
  printf ", \"log\": [\n";
}
END {
  # Output summary information
  printf "    { \"nick\": \"_\", \"time\": \"23:59\", \"message\": \"End of day!\"}\n";
  printf "  ]";
  printf ", \"message_count\": %i}", counter;
}

/\[[0-9]{2}:[0-9]{2}\] <([a-zA-Z0-9]*?)> .*/ {
  gsub(/[<>]/, "", $2);
  gsub(/[\[\]]/, "", $1);
  gsub(/"/, "\\\"", $0);
  printf "    { \"nick\": \"%s\"", $2;
  printf ", \"time\": \"%s\"", $1;
  printf ", \"message\": \"%s\" }, \n", $0;
  counter = counter + 1;
}
