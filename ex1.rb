require 'TimingEvents'

c1 = TimingEvents::Ping.new(0, 1)
c2 = TimingEvents::Ping.new(0.3, 1)

p1 = TimingEvents::Process.new(c1) do
	puts "Tick"
	c1.reset
end
p2 = TimingEvents::Process.new(c2) do
	puts "Tock"
	c2.reset
end

sleep 3
[c1, c2, p1, p2].each do |proc|
	proc.kill
end
