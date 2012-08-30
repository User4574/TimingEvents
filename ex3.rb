require 'TimingEvents'

s1 = TimingEvents::Signal.new(:asserted)
s2 = TimingEvents::VectorSignal.new

p1 = TimingEvents::Process.new(s1) do
	s2.vector = "4"
	s1.reset
	s2.assert
end
p2 = TimingEvents::Process.new(s2) do
	puts s2.vector
	s2.reset
end

sleep 1
[p1, p2].each do |proc|
	proc.kill
end
