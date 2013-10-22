#!/usr/bin/ruby


# Add a callback into this.

def reverse (sum)
	if sum == 0
		puts 'At the end!'
		return
	elsif sum % 3 == 0
		puts "Main thread " + sum.to_s + "\n"
		make_new_thread (sum) { |num_threads| 
			puts "created #{num_threads} threads...."
		}
		reverse (sum-1)
	else
		puts "Main thread " + sum.to_s + "\n"
		sleep Random.rand(3)
		reverse (sum-1)
	end	

end

def make_new_thread (sum, &block)
	total = num_threads = Random.rand(6)    # simulate new jobs coming in
	#puts "created #{num_threads} threads...."

	while (num_threads > 0)
		tt = Thread.new(num_threads) {  |threads|
			#sleep 0.5 + Random.rand(5)
			#puts "  Sub-thread " + sum.to_s + " - " + (sum * 0.25).to_s
			current_thread = threads
			sums = Random.rand(30000) * sum
			aggregate = 0
			while (sums > 0) 
				aggregate += sums
				sums -= 1
			end
			puts "   Sub-thread " + sum.to_s + "." + threads.to_s + " calculated: " + aggregate.to_s + "\n"

		}
		@thread_pool << tt
		num_threads -= 1
	end	
	yield total

end

@thread_pool = []
puts 'starting'
reverse 16
@thread_pool.each { |t|  t.join }
puts 'Completed'
