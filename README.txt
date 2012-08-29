Simple little thing I've been playing with.

Best run on under JRuby. The GIL *WILL* play havok with everything.

I've not done any testing of timings etc.

TimingEvents::Signal and TimingEvents::Process are the building blocks of the project.

TimingEvents::ImmutableSignal cannot be changed by the user code.

TimingEvents::Clock(delay, hightime, lowtime) is a handy way of creating an ImmutableSignal which acts like a clock.

TimingEvents::Ping(delay, period) is a Signal which after delay will assert at the start of every period.

TimingEvents::Always and TimingEvents::Never are an ImmutableSignal asserted and reset respectively.

See the examples.
