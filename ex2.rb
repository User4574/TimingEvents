require 'TimingEvents'

s1 = TimingEvents::Signal.new(:asserted)
s2 = TimingEvents::Signal.new(:reset)

p1 = TimingEvents::Process.new(s1) do
	puts "Tick"
	s1.reset
	s2.assert
end
p2 = TimingEvents::Process.new(s2) do
	puts "Tock"
	sleep 1
	s2.reset
	s1.assert
end

sleep 3
[p1, p2].each do |proc|
	proc.kill
end
