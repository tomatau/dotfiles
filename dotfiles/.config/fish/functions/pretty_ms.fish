function pretty_ms -a ms interval -d "Millisecond format for humans"
  set -l interval_ms
  set -l scale 1

  switch $interval
  case s
    set interval_ms 1000
  case m
    set interval_ms 60000
  case h
    set interval_ms 3600000
    set scale 2
  end

  math -s$scale "$ms/$interval_ms" | string replace -r '\\.?0*$' $interval
end
