module TimingEvents
	class InvalidStateError < Exception; end
	class ImmutableSignalError < Exception; end

	class Signal
		def initialize(a)
			if a == :asserted or a == :reset
				@state = a
			else
				raise InvalidStateError
			end
		end

		def asserted?
			return @state == :asserted
		end

		def assert
			@state = :asserted
		end

		def reset
			@state = :reset
		end
	end

	class ImmutableSignal < Signal
		def assert
			raise ImmutableSignalError
		end

		def reset
			raise ImmutableSignalError
		end
	end

	class Process
		def initialize(condition)
			@thread = Thread.new {
				while true
					if condition.asserted?
						yield
					end
				end
			}
		end
		def kill
			@thread.kill
		end
	end

	class Ping < Signal
		def initialize(d, p)
			sleep d
			super(:asserted)
			@thread = Thread.new {
				while true
					sleep p
					assert
				end
			}
		end
		def kill
			@thread.kill
		end
	end

	class Clock < ImmutableSignal
		def initialize(d, h, l)
			sleep d
			super(:asserted)
			@thread = Thread.new {
				while true
					if asserted?
						sleep h
						@state = :reset
					else
						sleep l
						@state = :asserted
					end
				end
			}
		end
		def kill
			@thread.kill
		end
	end

	Always = ImmutableSignal.new(:asserted)
	Never = ImmutableSignal.new(:reset)
end
