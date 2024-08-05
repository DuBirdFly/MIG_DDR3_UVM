# vsim -c -do "do {do/run.do}" -l run.log
# vsim    -do "do {do/run.do}" -l run.log

vlib work
vmap work work

vlog -f filelist/vlog.f

puts "\n\n\n\n\n"

vsim -f filelist/vsim.f

view wave
view structure
view signals

run 0ns

do {do/wave.do}

run -all
