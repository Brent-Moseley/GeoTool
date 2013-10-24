#!/usr/bin/ruby



def reverse (sum)
	# Simulate a main thread which is counting down to 0

	if sum == 0
		puts 'At the end!'
		return
	elsif sum % 3 == 0			
		# Spawn some sub-threads, with a message callback
		puts "Main thread " + sum.to_s + "\n"
		make_new_thread (sum) { |num_threads| 
			puts "creating #{num_threads} threads...."
		}
		#  then do recursive call
		reverse (sum-1)
	else
		puts "Main thread " + sum.to_s + "\n"
		sleep Random.rand(3)	# simulate some work...
		reverse (sum-1)
	end	

end

def nice_print (num)
	# print out large numbers in an easier-to-read format
	str = num.to_s
	result = ""
	str.reverse.each_char.with_index(1) {|c, i| 
		result << c
		result << ',' if i % 3 == 0 and i < str.length
	}
	result.reverse
end


def make_new_thread (sum, &block)
	num_threads = Random.rand(6)    # simulate new jobs coming in, create a thread for each
	if Random.rand(4) == 1 
		num_threads += Random.rand(8) + 6   # simulate a big batch
		puts '!!! Big batch'
	end
	yield num_threads

	#  Create all threads
	while (num_threads > 0)
		tt = Thread.new(num_threads) do |threads|
			sums = Random.rand(30000) * sum  	# Simulate some decreasing amount of work to do

			aggregate = 0
			for i in 0..sums
				aggregate += sums
			end

			puts "   Sub-thread " + sum.to_s + "." + threads.to_s + " calculated: " + nice_print(aggregate) + "\n"
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
