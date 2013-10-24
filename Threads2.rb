#!/usr/bin/ruby



def reverse (counter)
	# Simulate a main thread which is counting down to 0

	if counter == 0
		puts 'At the end!'
		return
	elsif counter % 3 == 0			
		# Spawn some sub-threads, with a message callback
		puts "Main thread " + counter.to_s + "\n"
		make_new_thread (counter) do |num_threads| 
			puts "creating #{num_threads} threads...."
		end
		#  then do recursive call
		reverse (counter-1)
	else
		puts "Main thread " + counter.to_s + "\n"
		sleep Random.rand(3)	# simulate some work...
		reverse (counter-1)
	end	

end

def nice_print (num)
	# print out large numbers in an easier-to-read format
	str = num.to_s
	result = ""
	str.reverse.each_char.with_index(1) do |c, i| 
		result << c
		result << ',' if i % 3 == 0 and i < str.length
	end
	result.reverse
end


def make_new_thread (counter, &block)
	num_threads = Random.rand(6)    # simulate new jobs coming in, create a thread for each
	if Random.rand(4) == 1 
		num_threads += Random.rand(8) + 6   # simulate a big batch
		puts '!!! Big batch'
	end
	yield num_threads

	#  Create all threads
	while (num_threads > 0)
		tt = Thread.new(num_threads) do |threads|
			counters = Random.rand(30000) * counter  	# Simulate some decreasing amount of work to do

			aggregate = 0
			for i in 0..counters
				aggregate += counters
			end

			puts "   Sub-thread " + counter.to_s + "." + threads.to_s + " calculated: " + nice_print(aggregate) + "\n"
		end

		@thread_pool << tt		# Add this thread to the list of threads
		num_threads -= 1
	end	
end

@thread_pool = []
puts 'starting'
reverse 16
@thread_pool.each { |t|  t.join }    # Allow time for all threads to complete
puts 'Completed'
